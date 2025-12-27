# PGP Digital Timestamper timestamped archive

The [PGP Digital Timestamper](https://stamper.itconsult.co.uk/) is an
important digital timestamping service provided since 1995 by Matthew
Richardson and his [I.T. Consultancy Limited](https://www.itconsult.co.uk/).

NOTE 2025-12-24: The system has seen a [major update end of
2025](https://stamper.itconsult.co.uk/changes2025.html), as a kind of 30th
anniversary gift. Although this documentation has been updated, some parts
still refer to the old version.

It is still useful today, even though the interface is limited to asynchronous
email communication, which makes it hard to use in many automated processes.

However, trust is waning through lack of independently verifiable publication
(see below for an explanation). Therefore, this is an attempt to resume easily
accessible publication and add cross-timestamping capability.

## Semantics of a digital timestamp

A digital timestamp is an independent and/or official confirmation of the fact
that the timestamp's requestor did have knowledge of, or a copy of a piece of
data which is timestamped. This implies that a document with particular
contents did exist at this time and an indeterminate time before the timestamp.

Assuming the timestamp is only done on a strong [cryptographic
hash](https://en.wikipedia.org/wiki/Cryptographic_hash_function) of the data,
which is the norm in digital timestamping, the timestamp implies only the
existence of the hash, which looks like a short, random string. The practical
value of such a timestamp *alone* is close to zero. However, if *a document can
be shown which has this exact hash*, the tuple of document and timestamp can be
taken as evidence that also the document existed at that time.

## Abuse potential

### Minor

Minor forms of abuse include:
- Refusing service, i.e., not providing a stamp at all,
- providing an invalid stamp, i.e., one which will fail for technical reasons,
- providing a stamp for the future.

All three can easily be detected by the requestor at the time (s)he issues the
request and should therefore not appear in any trustworthy record.

At first glance, it might seem that the third one, the future timestamp, might
even be desirable for the requestor, so there might be an incentive for a
requestor to bribe or otherwise convince the timestamper to issue a future
timestamp. However, the semantics of a timestamp only say that the contents
did exist or were known at a particular point in time.

As a consequence, the timestamp implies that the data was created before the
timestamp and not after. It does not imply *how long* before the data came
into existence. And it only weakly implies that a copy of the data was
still around, especially, if only a hash has been timestamped.

### Major

But by far the biggest potential for abuse from a timestamping service is
backstamping, i.e., providing a timestamp *now* which claims to have been
issued sometime in the —possibly distant— past.

As a result, a corrupt timestamper "assures" that a particular document existed
earlier than it was created. This allows false claims of prior art or to mask
unauthorized modifications.

## Gaining trust

A timestamping service can gain its trust through multiple means, including
- trust in the operator,
- trust in the process,
- trust from transparency and public reviewability, and
- trust through an independent binding (e.g., cross-timestamping).

The [PGP Timestamper's trust](http://stamper.itconsult.co.uk/stamper/)
can be derived from the following sources:
- The operator: [Matthew Richardson claims](http://www.itconsult.co.uk) to be
  independent because he is not dependent on any vendors. (This only partly
  applies to timestamping trust.)
- Transparency: Publication of the timestamping activity.

Publication happens in three ways:
- Mailing it to a mailing list to which anyone can subscribe and thus become
  part of the distributed publication network.
- Publishing it on its web site for anyone to retrieve.
- Publishing weekly digests to the `comp.security.pgp`
  [Newsgroup](https://en.wikipedia.org/wiki/Usenet_newsgroup) (previously
  to `comp.security.pgp.announce`).

## Why archive the PGP Digital Timestamper files?

* Usenet is losing traction and accessability,
* the web site is under the same control as the timestamping service itself,
* it is unclear who subscribes to the mailing list, and
* how someone might get at the data collected by indentent users through the
  mailing list.

Therefore, there is a clear need for an independent, easily accessible source
of the publication data.

## Why timestamp the PGP Digital Timestamper files?

The service has been in operation since 1995 and -- until the 2025 upgrade -- used the
technology from that time. This includes algorithms and key lengths considered
state of the art at that time. However, a quarter of a century is a very long
time for cryptography research and several discoveries have been made.

For example, the keys used to verify the accuracy of the archive files (and
thus to prevent adding/replacing signatures later) are only protected by
1024 bit [RSA](https://en.wikipedia.org/wiki/RSA) keys, which is considered
weak. (Even though the hash function, [MD5](https://en.wikipedia.org/wiki/MD5),
is considered broken,
[it seems that this is hard to exploit in this case.](./MD5.md))

Therefore, an independent assurance that the files have not been tampered with
seems appropriate. The easiest way is to use a separate timestamping system or
network, in this case, `zeitgitter`.

# Archive format

The data in this archive is taken from

- [`www.itconsult.co.uk`](https://www.itconsult.co.uk/)
  ([local](./www.itconsult.co.uk/); introduction of the service and its
  operator for 30 years, Matthew Richardson.
- [`stamper.itconsult.co.uk`](https://stamper.itconsult.co.uk/)
  ([local](./stamper.itconsult.co.uk/); description of stamper operation,
  retrieved 2025-12-24) and
- [`stamper.itconsult.co.uk/stamper-files/`](https://stamper.itconsult.co.uk/stamper-files/stamper-files/)
  ([local](./stamper.itconsult.co.uk/stamper-files/); the actual
  signatures published, updated daily),

reflecting the actual contents of those two sites.

## Content accuracy

The content is archived *as-is*, with the following two normalizations applied:
- Line ends have been normalized, so they will be checked out as your operating
  system's native end-of-line sequence.
- The trailing ^Z (0x2a, the legacy CP/M and MS-DOS end-of-file character) in
  all the signature files has been trimmed.

Neither of these modifications affect the accuracy or verifiability of the
signatures.

In the name of resource efficiency, especially on the stamper web server, only
content which is expected to have changed is automatically downloaded.
- New files in the directory with the yearly, weekly, and daily summaries are
  picked up automatically, together with the changed index files.
- The current yearly summary (and on January 1st, the previous year's summary)
  are also checked for changes (a daily summary line will be added and the file
  re-signed every day).

Anything else will have to be done manually. Please let me know if the
automated process has missed any change.

## Signature verification

- To verify the old (up to 2025) signatures,
  you need an OpenPGP implementation with backward
  compatibility to PGP 2.x, for example [GnuPG
  1.x](https://www.gnupg.org/download/) with the `--pgp2` option. On a
  Debian/Ubuntu system, this can be installed using `apt install gnupg1`.
- Import the public keys with
  `gpg1 --pgp2 --import ./stamper.itconsult.co.uk/keys/stamper-keys-from-1995.asc`.
- Verify any annual file with `gpg1 --pgp2 --verify <file>.txt`

New (2025+) signatures can be verified using modern `pgp`, no special handling
required ([all keys are documented
here](https://stamper.itconsult.co.uk/keys.html))

## File structure

All file names used below are relative to `stamper.itconsult.co.uk/stamper-files/`.

- `sig<year>.txt`: Clearsigned list of tupes of the hightest sequence number
  created by that time, with the time being the second part of the tuple
  (`YYYY/MM/DD HH:MM` format).
- `daily/<date>.txt` (with date in `YYYYMMDD` format): Signed ZIP archive of
  all the signatures created on that day.
- `weekly/wk<year><month><week-in-month>.txt`: Clearsigned list of the seven
  daily signatures over the daily files.
