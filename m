Content-Type: multipart/mixed; boundary="===============7473121211243795486=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/5] mptcp: add the outgoing MP_PRIO
 support
Date: Fri, 20 Nov 2020 15:07:50 +0800
Message-ID: <7332a3bc559027718fd59c9786a513202839a814.1605855783.git.geliangtang@gmail.com>
In-Reply-To: cover.1605855783.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6863

--===============7473121211243795486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the outgoing MP_PRIO logic:

In mptcp_pm_mp_prio_send_ack, find the related subflow and subsocket
according to the input parameter addr. Save the input priority value to
suflow's backup, and reschedule mptcp_worker. Then set subflow's
send_mp_prio flag to true, and save the input priority value to suflow's
request_bkup. Finally, send out a pure ACK on the related subsocket.

In mptcp_established_options_mp_prio, check whether the subflow's
send_mp_prio is set. If it is, this is the packet for send MP_PRIO. So
save subflow->request_bkup value to mptcp_out_options's backup, and
change the option type to OPTION_MPTCP_PRIO.

In mptcp_write_options, sent out the MP_PRIO suboption with
mptcp_out_options's backup value.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c | 39 +++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h   |  6 ++++++
 3 files changed, 85 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9db824b1ed33..e52eda8c1a18 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -666,6 +666,28 @@ static bool mptcp_established_options_rm_addr(struct s=
ock *sk,
 	return true;
 }
 =

+static bool mptcp_established_options_mp_prio(struct sock *sk,
+					      unsigned int *size,
+					      unsigned int remaining,
+					      struct mptcp_out_options *opts)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	if (!subflow->send_mp_prio)
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_PRIO)
+		return false;
+
+	*size =3D TCPOLEN_MPTCP_PRIO;
+	opts->suboptions |=3D OPTION_MPTCP_PRIO;
+	opts->backup =3D subflow->request_bkup;
+
+	pr_debug("prio=3D%d", opts->backup);
+
+	return true;
+}
+
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
@@ -708,6 +730,12 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
 		ret =3D true;
 	}
 =

+	if (mptcp_established_options_mp_prio(sk, &opt_size, remaining, opts)) {
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
+		ret =3D true;
+	}
+
 	return ret;
 }
 =

@@ -1145,6 +1173,18 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 				      0, opts->rm_id);
 	}
 =

+	if (OPTION_MPTCP_PRIO & opts->suboptions) {
+		const struct sock *ssk =3D (const struct sock *)tp;
+		struct mptcp_subflow_context *subflow;
+
+		subflow =3D mptcp_subflow_ctx(ssk);
+		subflow->send_mp_prio =3D 0;
+
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
+				      TCPOLEN_MPTCP_PRIO,
+				      opts->backup, TCPOPT_NOP);
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0e7c8a64604f..dd48af3c5ed5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -513,6 +513,45 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *=
msk)
 	}
 }
 =

+void mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *addr,
+				  u8 bkup)
+{
+	struct mptcp_subflow_context *subflow;
+
+	pr_debug("bkup=3D%d", bkup);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
+		struct sock *sk =3D (struct sock *)msk;
+		struct mptcp_addr_info local;
+
+		local_address((struct sock_common *)ssk, &local);
+		if (!addresses_equal(&local, addr, false))
+			continue;
+
+		if (subflow->backup =3D=3D bkup) {
+			pr_warn("backup error");
+			return;
+		}
+
+		subflow->backup =3D bkup;
+		mptcp_schedule_work(sk);
+
+		subflow->send_mp_prio =3D 1;
+		subflow->request_bkup =3D bkup;
+
+		spin_unlock_bh(&msk->pm.lock);
+		pr_debug("send ack for mp_prio");
+		lock_sock(ssk);
+		tcp_send_ack(ssk);
+		release_sock(ssk);
+		spin_lock_bh(&msk->pm.lock);
+
+		break;
+	}
+}
+
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 737c7c30eadd..99de1f13915d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -23,6 +23,7 @@
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
+#define OPTION_MPTCP_PRIO	BIT(9)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -59,6 +60,7 @@
 #define TCPOLEN_MPTCP_PORT_LEN		4
 #define TCPOLEN_MPTCP_ADD_ADDR_HMAC	8
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_PRIO		4
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
@@ -394,6 +396,7 @@ struct mptcp_subflow_context {
 		map_valid : 1,
 		mpc_map : 1,
 		backup : 1,
+		send_mp_prio : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -552,6 +555,9 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *addr,
+				  u8 bkup);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock=
 *sk);
 struct mptcp_pm_add_entry *
-- =

2.26.2

--===============7473121211243795486==--
