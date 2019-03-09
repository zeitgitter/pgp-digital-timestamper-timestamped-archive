# PGP Digital Timestamper timestamped archive

The [PGP Digital Timestamper](http://www.itconsult.co.uk/stamper.htm) is an
important digital timestamping service provided since 1995 by Matthew
Richardson and his [I.T. Consultancy Limited](http://www.itconsult.co.uk/).

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
value of such a timestamp alone is close to zero. However, if *a document can be
shown which has this exact hash*, the tuple of document and timestamp can be
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

## Gaining trust

A timestamping service can gain its trust through multiple means, including
- trust in the operator,
- trust in the process,
- trust from transparency and public reviewability, and
- trust through an independent binding (e.g., cross-timestamping).

The [PGP Timestamper's trust](http://www.itconsult.co.uk/stamper/stampinf.htm)
can be derived from the following sources:
- The operator: [Matthew Richardson claims](http://www.itconsult.co.uk) to be
  independent because he is not dependent on any vendors. (This only partly
  applies to timestamping trust.)
- Transparency: Publication of the timestamping activity.

Publication happens in three ways:
- Mailing it to a mailing list to which anyone can subscribe and thus become
  part of the distributed publication network.
- Publishing it on his web site.
- Publishing weekly digests to the `comp.security.pgp.announce`
  [Newsgroup](https://en.wikipedia.org/wiki/Usenet_newsgroup).

However, the latter Newsgroup seems to have been eliminated at some unknown
time. Therefore, this repository serves as a replacement publication venue and
will also be timestamped by the `igitt` timestamping network.
