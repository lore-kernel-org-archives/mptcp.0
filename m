Content-Type: multipart/mixed; boundary="===============2346910895927446090=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] mptcp: provide subflow aware release
 function
Date: Mon, 15 Feb 2021 20:16:27 +0100
Message-ID: <f6b4f009-55bc-7f2f-0f74-c400459982ab@tessares.net>
In-Reply-To: 20210215153623.7406-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7812

--===============2346910895927446090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 15/02/2021 16:36, Florian Westphal wrote:
> mptcp re-used inet(6)_release, so the subflow sockets are ignored.
> Need to invoke ip(v6)_mc_drop_socket function to ensure mcast join
> resources get free'd.
> =

> Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operat=
ions")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/110
> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for the patch and the review!

Just applied in our tree with Paolo's ACK:

- aee946a79980: mptcp: provide subflow aware release function
- Results: 1de5e73fbb6c..9344b5c5d36e

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2346910895927446090==--
