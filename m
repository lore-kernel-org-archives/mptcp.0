Content-Type: multipart/mixed; boundary="===============3848408501861726916=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix locking in mptcp_disconnect()
Date: Thu, 14 Jan 2021 16:37:37 +0100
Message-ID: <f818e82b58a556feeb71dcccc8bf1c87aafc6175.1610638176.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7374

--===============3848408501861726916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tcp_disconnect() expects the caller acquires the sock lock,
but mptcp_disconnect() is not doing that. Add the missing
required lock.

Reported-by: Eric Dumazet <eric.dumazet(a)gmail.com>
Fixes: 76e2a55d1625 ("mptcp: better msk-level shutdown.")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 81faeff8f3bb..f998a077c7dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2646,8 +2646,13 @@ static int mptcp_disconnect(struct sock *sk, int fla=
gs)
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	__mptcp_flush_join_list(msk);
-	mptcp_for_each_subflow(msk, subflow)
-		tcp_disconnect(mptcp_subflow_tcp_sock(subflow), flags);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+		tcp_disconnect(ssk, flags);
+		release_sock(ssk);
+	}
 	return 0;
 }
 =

-- =

2.26.2

--===============3848408501861726916==--
