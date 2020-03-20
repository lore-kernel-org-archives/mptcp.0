Content-Type: multipart/mixed; boundary="===============3243615759995743395=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 3/4] Squash-to: "mptcp: Add handling of incoming
 MP_JOIN requests"
Date: Fri, 20 Mar 2020 01:59:48 +0100
Message-ID: <baccb85f2f000485c97c4c83eec3326c8836e3c0.1584665521.git.pabeni@redhat.com>
In-Reply-To: cover.1584665520.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4011

--===============3243615759995743395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix race between mptcp_finish_join() and mptcp_stream_accept()

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 804c33d00177..a9a7fac6fb5a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1118,13 +1118,15 @@ bool mptcp_finish_join(struct sock *sk)
 	if (inet_sk_state_load(parent) !=3D TCP_ESTABLISHED)
 		return false;
 =

+	if (!msk->pm.server_side)
+		return true;
+
+	/* passive connection, attach to msk socket */
 	parent_sock =3D READ_ONCE(parent->sk_socket);
-	if (parent_sock && !sk->sk_socket) {
-		/* passive connection, attach to msk socket */
+	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);
-		return mptcp_pm_allow_new_subflow(msk);
-	}
-	return true;
+
+	return mptcp_pm_allow_new_subflow(msk);
 }
 =

 bool mptcp_sk_is_subflow(const struct sock *sk)
-- =

2.21.1

--===============3243615759995743395==--
