Content-Type: multipart/mixed; boundary="===============2129364873675198628=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: tcp: Check for filled TCP option space
 before SACK
Date: Mon, 16 Dec 2019 14:05:26 +0100
Message-ID: <3cf172bb-fd16-5934-6160-21436c2b4669@tessares.net>
In-Reply-To: 7ad85d0d66f3dcbebbd9d2ee6896cfedd1620812.1576499809.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3077

--===============2129364873675198628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/12/2019 13:37, Paolo Abeni wrote:
> Less invasive checks, so that the number of branchs when hitting
> the sack code path decreses compared to the current vanilla tree.
> --
> Some addictional check in tcp_established_options() is needed, otherwise
> the tcp header will be corrupted when mptcp_established_options() fully
> consumes the TCP option space. This condition can be reached without
> MPTCP, so not sure if the result patch is still worthy for -net ?!?


Thank you for the patch!

It looks good to me!

I guess we will need to update the commit message for "tcp: Check for =

filled TCP option space before SACK" :)

Cheers,
Matth
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2129364873675198628==--
