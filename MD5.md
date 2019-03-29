# Use of MD5 for digital timestamping

The cryptographic hash used as part of the timestamping signature process is
[MD5](https://en.wikipedia.org/wiki/MD5), for which a pair of
different (document) inputs with the same hash result (a so-called
[collision](https://en.wikipedia.org/wiki/Collision_attack))
can be found in [under a second on a typical
computer.](https://en.wikipedia.org/wiki/MD5#Collision_vulnerabilities))

This is the death toll for a hash function. However, when carefully used, it
seems that with what is currently known, this weakness is not exploitable
in timestamping.

## Properties of the MD5 collisions

The sub-second algorithm is able to find collisions with a few bit changes
in a 128-byte random-looking block. Other attacks can change almost anything,
given that there are more 700 bytes of random-looking data involved, but
require much more computation time.

What all attacks have in common, is that they require at least one 64-byte MD5
block of random-looking data, which will include many characters outside the
ASCII printable space, essentially being fully binary data.

## How to exploit the MD5 weakness

To practically exploit this weakness, we therefore need a file format that has 

1. have space for the actual data to be hashed (and thus signed/timestamped),
2. plus at least one aligned 64-byte block of data which can be randomly chosen
   without breaking the file format or otherwise cause suspicion.

Timestamping files longer than 64 bytes which can include random binary data
are therefore vulnerable to MD5 collisions. This includes most file formats,
including images, PDFs, Office documents, executable files, and certificates.

## Collision-safe contents

Contents with at most 64 bytes or contents entirely restricted to the ASCII
printable set are not prone to collisions. Even though it is true now, this may
change in the future.

Notable examples of contents where it is currently infeasible to find
collisions include human-readable plain text.

Most interesting for our case are SHA-1, SHA-256, and SHA-3 hashes, which in
their hex-encoded form are *both* not long enough *and* have a very limited
character set.

# Conclusions

When you submit a document to the PGP Digital Timestamper *and* you want to
ensure that nobody can later claim that you had a second file up your sleeves
with a colliding hash, *do not* submit the file itself or and MD5 hash of the
file to any timestamping service, but *instead do* submit a SHA-256 or SHA-3
hash, whenever possible.

If your application (e.g., [`git`](https://git-scm.org)) only supports SHA-1,
you may be fine as well, especially if you have been using [Hardened
SHA-1](https://shattered.io/) for at least one of the generation or
verification steps.

Hardened [SHA-1](https://en.wikipedia.org/wiki/SHA-1) is compatible to SHA-1
except for all practical purposes, but does not allow the construction of
collisions. As `git` has been using Hardened SHA-1 for many years and is
verifying the hash on every import, one can assume `git` is not vulnerable to
collisons today.
