Content-Type: multipart/mixed; boundary="===============4152348841253504407=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-net PATCH] mptcp: fix security context on server
 socket
Date: Tue, 15 Dec 2020 12:44:13 +0100
Message-ID: <bb4733e0-bf4a-6c83-e3c9-4a67a0f7313f@tessares.net>
In-Reply-To: 3a0d657c067957c1dc18310c63179fade8f9a563.1607704071.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7173

--===============4152348841253504407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 11/12/2020 17:28, Paolo Abeni wrote:
> Currently MPTCP is not propagating the security context
> from the ingress request socket to newly created msk
> at clone time.
> =

> Address the issue invoking the missing security helper.

Thank you for this fix! Now in our tree!

- 43befa4d4bfd: mptcp: fix security context on server socket
- Results: d73b2c933a85..e1e3f281c849

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4152348841253504407==--
