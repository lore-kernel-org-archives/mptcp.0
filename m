Content-Type: multipart/mixed; boundary="===============5823952144409949991=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 7/9] mptcp: parse and act on incoming
 FASTCLOSE option
Date: Thu, 10 Dec 2020 14:25:04 -0800
Message-ID: <20201210222506.222251-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201210222506.222251-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7134

--===============5823952144409949991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

parse the MPTCP FASTCLOSE subtype.

If provided key matches the local one, schedule the work queue to close
(with tcp reset) all subflows.

The MPTCP socket moves to closed state immediately.

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  | 17 +++++++++++++++++
 net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 54 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ca60d9da3ef..5e7d7755d1a6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -282,6 +282,16 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
 =

+	case MPTCPOPT_MP_FASTCLOSE:
+		if (opsize !=3D TCPOLEN_MPTCP_FASTCLOSE)
+			break;
+
+		ptr +=3D 2;
+		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
+		ptr +=3D 8;
+		mp_opt->fastclose =3D 1;
+		break;
+
 	default:
 		break;
 	}
@@ -299,6 +309,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_join =3D 0;
 	mp_opt->add_addr =3D 0;
 	mp_opt->ahmac =3D 0;
+	mp_opt->fastclose =3D 0;
 	mp_opt->port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
@@ -942,6 +953,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
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
index 2540d82742ac..cb8b7adf218a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2217,6 +2217,36 @@ static bool mptcp_check_close_timeout(const struct s=
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
@@ -2233,6 +2263,9 @@ static void mptcp_worker(struct work_struct *work)
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
index a5bc9599ae5c..7cf9d110b85f 100644
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
@@ -58,6 +59,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
 #define TCPOLEN_MPTCP_PORT_LEN		4
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_FASTCLOSE		12
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
@@ -110,6 +112,7 @@ struct mptcp_options_received {
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

2.29.2

--===============5823952144409949991==--
