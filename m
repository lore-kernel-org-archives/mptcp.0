Content-Type: multipart/mixed; boundary="===============6913628847452897909=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] ADD_ADDR HMAC ambiguity
Date: Wed, 20 May 2020 09:40:23 -0700
Message-ID: <20200520164023.GH45434@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 4437

--===============6913628847452897909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Todd Malsbary from Intel is looking at the HMAC-support for ADD_ADDR in
RFC8684. And it appears that there can be an ambiguity on how to interpret
the truncation.

We want to clarify this and make sure all implementations,... are on the
same page with the intention of the RFC:

RFC8684, Section 3.4.1 says:
" The Truncated HMAC parameter present in this option is the rightmost
  64 bits of an HMAC, negotiated and calculated in the same way as for
  MP_JOIN as described in Section 3.2. "

Now, in Section 3.2 it mentions:
" This specification defines that HMAC as defined in [RFC2104] is used,
  along with the SHA-256 hash algorithm [RFC6234], and that the output
  is truncated to the leftmost 160 bits (20 octets). "


One can read these in two different ways:

In Section 3.4.1, the truncation to the rightmost 64 bits is based on the
full 256-bit HMAC-output or whether it is rather the 64 rightmost bits of
the leftmost 160bits (the ones mentioned in Section 3.2).


Can we clarify which of the two options is the correct one?



I personally interpret it as "right most 64 bits of the 256-bit HMAC-output=
".



Thanks,
Christoph

--===============6913628847452897909==--
