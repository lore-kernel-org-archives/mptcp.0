Content-Type: multipart/mixed; boundary="===============0978431920788085458=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: fix state tracking for fallback socket
Date: Wed, 18 Nov 2020 11:29:32 +0100
Message-ID: <5e32dd08-6455-0768-63c7-ef9b2cae933e@tessares.net>
In-Reply-To: b584969e2e46bbc4c1672659737d1d65a09cb36b.1605638677.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6769

--===============0978431920788085458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 17/11/2020 19:47, Paolo Abeni wrote:
> We need to cope with some more state transition for
> fallback sockets, or could still end-up moving to TCP_CLOSE
> too early and avoid spooling some pending data

Thank you for the patch and the review! Just applied at the beginning of =

the tree with Mat's Reviewed-by tag and s/stats/state/.

- 5ef936b1a75b: mptcp: fix state tracking for fallback socket
- Results: b7962fd61dfc..9d1f3055c580

Tests + exports are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0978431920788085458==--
