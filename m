Content-Type: multipart/mixed; boundary="===============4720840949835916573=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 24th of October 2019
Date: Sat, 26 Oct 2019 10:52:56 +0000
Message-ID: <d07eef2e-66dc-4f0b-8c40-12700fe01cc9@localhost>
In-Reply-To: 8f862de7f6e61bbc5239c041fcc9777312bba2cf.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2338

--===============4720840949835916573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo,
 =

Sat Oct 26 11:59:07 GMT+02:00 2019 Paolo Abeni :
 =

> On Fri, 2019-10-25 at 17:20 +0200, Matthieu Baerts wrote:
> =

>> Hi Paolo,
>> =

>> On 25/10/2019 09:53, Matthieu Baerts wrote:
 =

[...]
 =

>> So far, I *think* the establishment of the connection is OK (SYN, =

>> SYN+ACK, ACK) but not after: it seems the first data packet has bad =

>> options. I would need to look more to understand why.
>> =

> =

> Do you see connection/test failures, or is just the wireshark dissector
> output? Note that wireshark can't currently correctly dissect mptcp v1
> MP_CAPABLE ACK option with data_len and/or checksum - it's a wireshark
> bug/missing feature
 =

The transfer blocks then it fallbacks to TCP but with some errors because i=
t doesn't finish properly.
 =

If I remember well, I saw this:
 =

 o SYN (A->B): only the first four octets (Length =3D 4).
 =

 o SYN/ACK (B->A): B's Key for this connection (Length =3D 12).
 =

 o ACK (no data) (A->B): A's Key followed by B's Key (Length =3D 20).
 =

 o ACK (with first data) (A->B): A's Key followed by B's Key followed
 by Data-Level Length, and optional Checksum (Length =3D 22 or 24).
 =

But then B sends an MP_FAIL I think.
 =

Cheers,
Matt

--===============4720840949835916573==--
