Content-Type: multipart/mixed; boundary="===============1839150353388106857=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/6] mptcp: use _fast lock version in
 __mptcp_move_skbs
Date: Fri, 30 Oct 2020 15:45:02 -0700
Message-ID: <20201030224506.108377-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201030224506.108377-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6493

--===============1839150353388106857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

The function is short and won't sleep, so this can use the _fast version.

Acked-by: Paolo Abeni <pabeni(a)redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e010ef7585bf..f5bacfc55006 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1493,13 +1493,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *ms=
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

2.29.2

--===============1839150353388106857==--
