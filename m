Content-Type: multipart/mixed; boundary="===============1272877957855384404=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] sendmsg: fix pending issues.
Date: Mon, 02 Dec 2019 13:57:18 +0100
Message-ID: <b995fb4b-fb96-dd8d-b27e-dd9bcdd66194@tessares.net>
In-Reply-To: cover.1575281285.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2737

--===============1272877957855384404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 02/12/2019 11:24, Paolo Abeni wrote:
> This is just a rebase of the initial RFC post.

Thank you for the rebase!

> The patch 1 should be inserted just after "tcp: clean ext on tx recycle"
> =

> The patches 2 and 3 have explicit individual squash-to tags, but will cas=
ue a
> lot of conflicts, the uneasy ones to solve are on patch
> "mptcp: rework mptcp_sendmsg_frag to accept optional dfrag"
> =

> A tree rebased with the above patches applied is available at:
> =

> https://github.com/pabeni/mptcp/tree/sendmsg_fix_2

I hope you don't mind if I don't use your branch directly. I was going =

to apply Mat's data-FIN patch. And look at the code on your branch in =

case of conflicts.

Or I can re-create the tree now using your branch if you prefer. If some =

fixes are needed, they can be done in follow-up patches (if any). I only =

have to re-apply Davide's patch from this morning, that's easy to do.

WDYT?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1272877957855384404==--
