Content-Type: multipart/mixed; boundary="===============1504014240819013411=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] subflow: process pending data on state changes,
 too
Date: Thu, 12 Dec 2019 22:52:39 +0100
Message-ID: <aa8178be-fca0-45b8-72b6-da5fa2d809e6@tessares.net>
In-Reply-To: 62b2f929fdf3c17a05a5dd6ec632aba00e69c5d7.1575992767.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2895

--===============1504014240819013411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 10/12/2019 16:48, Paolo Abeni wrote:
> Otherwise we can miss the data carried by the data fin.
> An alternative solution would calling __subflow_state_change
> on the parent socket only when we process the data fin in
> mptcp_subflow_data_available.
> =

> Currently, on the squashed tree, we have sporadic data stream
> corrution near EoS, triggered by the lossy self-tests every a
> few iteration.
> =

> This change addresses them.

Thank you for the patch and the suggestion!

@Paolo: I didn't see this patch was already in your branch :)
I added the patch and removed it in the TopGit tree.

- a3f47d5cab03..d2dba972de89: result is empty, normal

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1504014240819013411==--
