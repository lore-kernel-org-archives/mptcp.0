Content-Type: multipart/mixed; boundary="===============6096323947137992146=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/3] mptcp: parse and act on incoming
 FASTCLOSE option
Date: Wed, 25 Nov 2020 18:49:56 +0100
Message-ID: <20201125174956.9222-4-fw@strlen.de>
In-Reply-To: 20201125174956.9222-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6934

--===============6096323947137992146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

parse the MPTCP FASTCLOSE subtype.

If provided key matches the local one, schedule the work queue to close
(with tcp reset) all subflows.

The MPTCP socket moves to closed state immediately.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  | 15 +++++++++++++++
 net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 52 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d1b4c5d208a9..6088fc80db75 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -281,7 +281,15 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		mp_opt->rm_id =3D *ptr++;
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
+	case MPTCPOPT_MP_FASTCLOSE:
+		if (opsize !=3D TCPOLEN_MPTCP_FASTCLOSE)
+			break;
 =

+		ptr +=3D 2;
+		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
+		ptr +=3D 8;
+		mp_opt->fastclose =3D 1;
+		break;
 	default:
 		break;
 	}
@@ -299,6 +307,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_join =3D 0;
 	mp_opt->add_addr =3D 0;
 	mp_opt->ahmac =3D 0;
+	mp_opt->fastclose =3D 0;
 	mp_opt->port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
@@ -937,6 +946,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb)
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 =

+	if (mp_opt.fastclose &&
+	    msk->local_key =3D=3D mp_opt.rcvr_key) {
+		WRITE_ONCE(msk->rcv_fastclose, true);
+		mptcp_schedule_work((struct sock *)msk);
+	}
+
 	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
 		struct mptcp_addr_info addr;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d7875e20f8e7..f6d9a3e4cb33 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2209,6 +2209,36 @@ static bool mptcp_check_close_timeout(const struct s=
ock *sk)
 	return true;
 }
 =

+static void mptcp_check_fastclose(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+
+	if (likely(!READ_ONCE(msk->rcv_fastclose)))
+		return;
+
+	mptcp_token_destroy(msk);
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(tcp_sk);
+		if (tcp_sk->sk_state !=3D TCP_CLOSE) {
+			tcp_send_active_reset(tcp_sk, GFP_ATOMIC);
+			tcp_set_state(tcp_sk, TCP_CLOSE);
+		}
+		release_sock(tcp_sk);
+	}
+
+	inet_sk_state_store(sk, TCP_CLOSE);
+	sk->sk_shutdown =3D SHUTDOWN_MASK;
+	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+	set_bit(MPTCP_DATA_READY, &msk->flags);
+	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
+
+	mptcp_close_wake_up(sk);
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -2225,6 +2255,9 @@ static void mptcp_worker(struct work_struct *work)
 =

 	mptcp_check_data_fin_ack(sk);
 	__mptcp_flush_join_list(msk);
+
+	mptcp_check_fastclose(msk);
+
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(msk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5db6e721fcf..6617cb376795 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -23,6 +23,7 @@
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
+#define OPTION_MPTCP_FASTCLOSE	BIT(9)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -59,6 +60,7 @@
 #define TCPOLEN_MPTCP_PORT_LEN		4
 #define TCPOLEN_MPTCP_ADD_ADDR_HMAC	8
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_FASTCLOSE		12
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
@@ -111,6 +113,7 @@ struct mptcp_options_received {
 	u16	data_len;
 	u16	mp_capable : 1,
 		mp_join : 1,
+		fastclose : 1,
 		dss : 1,
 		add_addr : 1,
 		rm_addr : 1,
@@ -237,6 +240,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	spinlock_t	join_list_lock;
 	struct sock	*ack_hint;
-- =

2.26.2

--===============6096323947137992146==--
