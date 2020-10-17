Content-Type: multipart/mixed; boundary="===============6198636113317055369=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: skip to next candidate if
 subflow has unacked data
Date: Sat, 17 Oct 2020 09:31:28 +0200
Message-ID: <ebdcdfae-24a1-df45-e3df-83c4d511cce8@tessares.net>
In-Reply-To: 20201001081406.4548-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6337

--===============6198636113317055369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 01/10/2020 10:14, Florian Westphal wrote:
> In case a subflow path is blocked, MPTCP-level retransmit may not take
> place anymore because such subflow is likely to have unacked data left
> in its write queue.
> =

> Ignore subflows that have experienced loss and test next candidate.

Thank you for the patch and the review!

Just applied with Mat's Reviewed-by.

- 15321713bc1f: mptcp: skip to next candidate if subflow has unacked data
- Results: 3fd01a5ab17b..0e70ef7be280

Tests and export will be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6198636113317055369==--
