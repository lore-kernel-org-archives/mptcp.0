Content-Type: multipart/mixed; boundary="===============1934735245214439713=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH MPTCP 4/5] mptcp: parse and act on incoming FASTCLOSE
 option
Date: Thu, 05 Nov 2020 18:01:25 +0100
Message-ID: <20201105170126.5627-5-fw@strlen.de>
In-Reply-To: 20201105170126.5627-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6572

--===============1934735245214439713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add parsing of FASTCLOSE option.
If provided key matches the local one, worker gets scheduled and
closes (tcp resets) all subflows.  The MPTCP socket moves to closed state.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/protocol.c | 32 ++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  4 ++++
 3 files changed, 52 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 785a9f4e7da8..0a940687f738 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -281,6 +281,15 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		mp_opt->rm_id =3D *ptr++;
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
+	case MPTCPOPT_MP_FASTCLOSE:
+		if (opsize !=3D TCPOLEN_MPTCP_FASTCLOSE)
+			break;
+
+		ptr +=3D 2;
+		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
+		ptr +=3D 8;
+		mp_opt->fastclose =3D 1;
+		break;
 	case MPTCPOPT_RST:
 		if (opsize !=3D TCPOLEN_MPTCP_RST)
 			break;
@@ -309,6 +318,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->mp_join =3D 0;
 	mp_opt->add_addr =3D 0;
 	mp_opt->ahmac =3D 0;
+	mp_opt->fastclose =3D 0;
 	mp_opt->port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
@@ -954,6 +964,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
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
index 71e556540161..7e9705943813 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1849,6 +1849,35 @@ static bool mptcp_check_close_timeout(const struct s=
ock *sk)
 	return true;
 }
 =

+static noinline void mptcp_check_fastclose(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+
+	if (likely(!READ_ONCE(msk->rcv_fastclose)))
+		return;
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(tcp_sk);
+		subflow->reset_transient =3D 0;
+		subflow->reset_reason =3D MPTCP_RST_EMPTCP;
+		mptcp_subflow_reset(tcp_sk);
+		release_sock(tcp_sk);
+	}
+
+	sk =3D (struct sock *)msk;
+
+	inet_sk_state_store(sk, TCP_CLOSE);
+	sk->sk_shutdown =3D SHUTDOWN_MASK;
+	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+	set_bit(MPTCP_DATA_READY, &msk->flags);
+
+	sk->sk_state_change(sk);
+	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_HUP);
+}
+
 static void mptcp_worker(struct work_struct *work)
 {
 	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
@@ -1871,6 +1900,9 @@ static void mptcp_worker(struct work_struct *work)
 		__mptcp_close_subflow(msk);
 =

 	__mptcp_move_skbs(msk);
+
+	mptcp_check_fastclose(msk);
+
 	if (mptcp_send_head(sk))
 		mptcp_push_pending(sk, 0);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8a247e50d326..d4c99e091cb9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -24,6 +24,7 @@
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
 #define OPTION_MPTCP_RST	BIT(9)
+#define OPTION_MPTCP_FASTCLOSE	BIT(10)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -59,6 +60,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
 #define TCPOLEN_MPTCP_PORT_LEN		2
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_FASTCLOSE		12
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
@@ -122,6 +124,7 @@ struct mptcp_options_received {
 	u16	data_len;
 	u16	mp_capable : 1,
 		mp_join : 1,
+		fastclose : 1,
 		reset : 1,
 		dss : 1,
 		add_addr : 1,
@@ -240,6 +243,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	spinlock_t	join_list_lock;
 	struct work_struct work;
-- =

2.26.2

--===============1934735245214439713==--
