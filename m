Content-Type: multipart/mixed; boundary="===============7404501108496357163=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 4/4] Squash-to: "subflow: place further subflows on
 new 'join_list'"
Date: Fri, 20 Mar 2020 01:59:49 +0100
Message-ID: <218cd71f592f50520e02e0b24dbc62e366af42fc.1584665521.git.pabeni@redhat.com>
In-Reply-To: cover.1584665520.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4012

--===============7404501108496357163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to flush the join list even at shutdown time, or
bad things will happen

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4eae5a0bf54c..e183a3b8fa87 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1771,6 +1771,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
+		__mptcp_flush_join_list(msk);
 		list_for_each_entry(subflow, &msk->conn_list, node) {
 			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -1852,6 +1853,7 @@ static int mptcp_shutdown(struct socket *sock, int ho=
w)
 			sock->state =3D SS_CONNECTED;
 	}
 =

+	__mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
 =

-- =

2.21.1

--===============7404501108496357163==--
