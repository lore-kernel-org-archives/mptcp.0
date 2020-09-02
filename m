Content-Type: multipart/mixed; boundary="===============5914606513549029328=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: use _fast lock version in
 __mptcp_move_skbs
Date: Wed, 02 Sep 2020 16:37:50 +0200
Message-ID: <20200902143750.28478-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 5697

--===============5914606513549029328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function is short and won't sleep, so this can use the _fast version.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3b621a99c8c5..0c2b506d17de 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1472,13 +1472,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
k)
 	__mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
+		bool slowpath;
 =

 		if (!ssk)
 			break;
 =

-		lock_sock(ssk);
+		slowpath =3D lock_sock_fast(ssk);
 		done =3D __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-		release_sock(ssk);
+		unlock_sock_fast(ssk, slowpath);
 	} while (!done);
 =

 	if (mptcp_ofo_queue(msk) || moved > 0) {
-- =

2.26.2

--===============5914606513549029328==--
