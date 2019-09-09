Content-Type: multipart/mixed; boundary="===============6617026989939802143=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 3/6] mptcp: add mptcp_should_wake_parent
Date: Mon, 09 Sep 2019 17:53:15 +0200
Message-ID: <20190909155317.31119-4-fw@strlen.de>
In-Reply-To: 20190909155317.31119-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1802

--===============6617026989939802143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function is never called at this time, because mptcp_poll() places
the task on the subflow poll list, instead of the mptcp socket one.

Will be changed in the followup patch.

Note that this adds quite some code duplication, more code
sharing with recv path is needed here.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  | 13 ++++--
 3 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3eecd9ae0c77..071260f4f0b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -393,6 +393,105 @@ static bool mptcp_discard_one_skb(struct sock *sk)
 	return tcp_read_sock(sk, &rd, mptcp_flush_actor) >=3D 0;
 }
 =

+bool mptcp_must_wake_parent(struct subflow_context *subflow)
+{
+	struct socket *socket =3D mptcp_subflow_tcp_socket(subflow);
+	struct sock *sk =3D subflow->conn;
+	struct sock *ssk =3D socket->sk;
+	struct mptcp_sock *msk;
+	int state;
+
+	state =3D inet_sk_state_load(sk);
+	msk =3D mptcp_sk(sk);
+	if (state !=3D TCP_ESTABLISHED)
+		return true;
+
+	sock_owned_by_me((const struct sock *)ssk);
+
+	for (;;) {
+		enum mapping_status status;
+		size_t discard_len =3D 0;
+		u64 ack_seq, old_ack;
+		int bytes_read;
+		u32 ssn;
+
+		state =3D inet_sk_state_load(ssk);
+		status =3D mptcp_get_mapping(ssk);
+		switch (status) {
+		case MAPPING_ADDED:
+			break;
+		case MAPPING_MISSING:
+			if (!subflow->map_valid) {
+				if (mptcp_discard_one_skb(ssk))
+					continue;
+
+				return true;
+			}
+			/* fall through */
+		case MAPPING_EMPTY:
+			if (state =3D=3D TCP_ESTABLISHED)
+				return false;
+
+			/* The fact that one subflow is closing should NOT result
+			 * in a wakeup.  However, we need this for now so EOF can
+			 * be signalled.  We should instead check if the logical
+			 * mptcp connection state has changed.
+			 */
+			return true;
+		case MAPPING_DATA_FIN:
+			return true;
+		}
+
+		ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+		old_ack =3D READ_ONCE(msk->ack_seq);
+
+		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
+			/* Mapping covers data later in the subflow stream */
+			discard_len =3D subflow->map_subflow_seq - ssn;
+		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
+						  subflow->map_data_len)))) {
+			/* Mapping ends earlier in the subflow stream.
+			 * Invalidate the mapping and try again.
+			 */
+			subflow->map_valid =3D 0;
+			continue;
+		} else {
+			ack_seq =3D get_mapped_dsn(subflow);
+
+			if (before64(ack_seq, old_ack)) {
+				/* Mapping covers data already received,
+				 * discard data in the current mapping
+				 * and invalidate the map
+				 */
+				u64 map_end_dsn =3D subflow->map_seq +
+					subflow->map_data_len;
+				discard_len =3D min(map_end_dsn - ack_seq,
+						  old_ack - ack_seq);
+			}
+		}
+
+		if (discard_len) {
+			struct mptcp_read_arg arg =3D {
+				.msg =3D NULL,
+			};
+			read_descriptor_t desc =3D {
+				.count =3D discard_len,
+				.arg.data =3D &arg,
+			};
+
+			bytes_read =3D tcp_read_sock(ssk, &desc,
+						   mptcp_read_actor);
+			if (bytes_read < 0)
+				break;
+			else if (bytes_read =3D=3D discard_len)
+				continue;
+		}
+		break;
+	}
+
+	return true;
+}
+
 static void mptcp_wait_data(struct sock *sk, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd7b3b107fe0..58015d4e25be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -228,6 +228,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 =

 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
+bool mptcp_must_wake_parent(struct subflow_context *ctx);
 =

 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5635e4c73e15..99886d07c26d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -304,18 +304,23 @@ static void subflow_data_ready(struct sock *sk)
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 	struct sock *parent =3D subflow->conn;
 =

-	pr_debug("sk=3D%p", sk);
 	subflow->tcp_sk_data_ready(sk);
 =

 	if (parent) {
-		pr_debug("parent=3D%p", parent);
+		struct socket_wq *wq;
 =

 		smp_mb__before_atomic();
 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
 		smp_mb__after_atomic();
 =

-		parent->sk_data_ready(parent);
-	}
+		rcu_read_lock();
+		wq =3D rcu_dereference(parent->sk_wq);
+		if (skwq_has_sleeper(wq) &&
+		    mptcp_must_wake_parent(subflow)) {
+			wake_up_interruptible_all(&wq->wait);
+		}
+		rcu_read_unlock();
+       }
 }
 =

 static void subflow_write_space(struct sock *sk)
-- =

2.21.0


--===============6617026989939802143==--
