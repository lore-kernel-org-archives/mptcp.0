Content-Type: multipart/mixed; boundary="===============6681408992108000265=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 04/10] Re-factor and fixes for
 crypto_hmac_sha1()
Date: Mon, 12 Aug 2019 21:35:55 +0200
Message-ID: <1f685364-07b3-7334-439b-51d65fb0c6cf@tessares.net>
In-Reply-To: 20190807224434.2829-5-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1619

--===============6681408992108000265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Mat, Paolo,

On 08/08/2019 00:44, Peter Krystad wrote:
> Re-factor to use parameters specific to MPTCP use case similar to
> crypto_key_sha1() and get rid of var args. Also fix endianness issues.
> =

> squash to: Add key generation and token tree
> and: Add handling of incoming MP_JOIN requests

Thank you for the patch and the reviews!

- bc31e4f64971: part 1: "squashed" in "mptcp: Add key generation and
token tree"
- f282f6b36b49: part 2: "squahsed" in "mptcp: Add handling of incoming
MP_JOIN requests"
- f7938dd15948..009b132dc29d: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6681408992108000265==--
