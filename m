Content-Type: multipart/mixed; boundary="===============6707930024340213747=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: move msk state update to
 subflow_syn_recv_sock()
Date: Mon, 16 Mar 2020 15:57:53 +0100
Message-ID: <ca414f55f4c74190bc419815f6ac7c61313bac2a.1584370498.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3949

--===============6707930024340213747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After commit 58b09919626b ("mptcp: create msk early"), the
msk socket is already available at subflow_syn_recv_sock()
time. Let's move there the state update, to mirror more
closely the first subflow state.

The above will also help multiple subflow supports.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
The idea is send this one to net-next asap, [well] before =

part 3
---
 net/mptcp/protocol.c | 9 +++------
 net/mptcp/subflow.c  | 2 ++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 04c3caed92df..e959104832ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -861,6 +861,9 @@ struct sock *mptcp_sk_clone(const struct sock *sk, stru=
ct request_sock *req)
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
 	}
+
+	/* will be fully established after successful MPC subflow creation */
+	inet_sk_state_store(nsk, TCP_SYN_RECV);
 	bh_unlock_sock(nsk);
 =

 	/* keep a single reference */
@@ -916,10 +919,6 @@ static struct sock *mptcp_accept(struct sock *sk, int =
flags, int *err,
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
 =

-		/* will be fully established at mptcp_stream_accept()
-		 * completion.
-		 */
-		inet_sk_state_store(new_mptcp_sock, TCP_SYN_RECV);
 		bh_unlock_sock(new_mptcp_sock);
 		local_bh_enable();
 	}
@@ -1256,8 +1255,6 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 			if (!ssk->sk_socket)
 				mptcp_sock_graft(ssk, newsock);
 		}
-
-		inet_sk_state_store(newsock->sk, TCP_ESTABLISHED);
 	}
 =

 	sock_put(ssock->sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8434c7f5f712..052d72a1d3a2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -234,6 +234,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
+			inet_sk_state_store((struct sock *)new_msk,
+					    TCP_ESTABLISHED);
 			ctx->conn =3D new_msk;
 			new_msk =3D NULL;
 		}
-- =

2.21.1

--===============6707930024340213747==--
