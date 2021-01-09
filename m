Content-Type: multipart/mixed; boundary="===============1453651467064817065=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 4/8] mptcp: add the incoming MP_PRIO support
Date: Fri, 08 Jan 2021 16:47:58 -0800
Message-ID: <20210109004802.341602-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210109004802.341602-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7298

--===============1453651467064817065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added the incoming MP_PRIO logic:

Added a flag named mp_prio in struct mptcp_options_received, to mark the
MP_PRIO is received, and save the priority value to struct
mptcp_options_received's backup member. Then invoke
mptcp_pm_mp_prio_received with the receiving subsocket and the backup
value.

In mptcp_pm_mp_prio_received, get the subflow context according the input
subsocket, and change the subflow's backup as the incoming priority value.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/options.c  | 15 +++++++++++++++
 net/mptcp/pm.c       |  8 ++++++++
 net/mptcp/protocol.h |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ef50a8628d77..adfa96dd991c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -282,6 +282,15 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
 =

+	case MPTCPOPT_MP_PRIO:
+		if (opsize !=3D TCPOLEN_MPTCP_PRIO)
+			break;
+
+		mp_opt->mp_prio =3D 1;
+		mp_opt->backup =3D *ptr++ & MPTCP_PRIO_BKUP;
+		pr_debug("MP_PRIO: prio=3D%d", mp_opt->backup);
+		break;
+
 	case MPTCPOPT_MP_FASTCLOSE:
 		if (opsize !=3D TCPOLEN_MPTCP_FASTCLOSE)
 			break;
@@ -313,6 +322,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
+	mp_opt->mp_prio =3D 0;
 =

 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
@@ -1022,6 +1032,11 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
 		mp_opt.rm_addr =3D 0;
 	}
 =

+	if (mp_opt.mp_prio) {
+		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
+		mp_opt.mp_prio =3D 0;
+	}
+
 	if (!mp_opt.dss)
 		return;
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index da2ed576f289..0a6ebd0642ec 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -207,6 +207,14 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,=
 u8 rm_id)
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+
+	pr_debug("subflow->backup=3D%d, bkup=3D%d\n", subflow->backup, bkup);
+	subflow->backup =3D bkup;
+}
+
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 21763e00d990..d6400ad2d615 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -88,6 +88,9 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+/* MPTCP MP_PRIO flags */
+#define MPTCP_PRIO_BKUP		BIT(0)
+
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
 #define MPTCP_NOSPACE		1
@@ -118,6 +121,7 @@ struct mptcp_options_received {
 		dss : 1,
 		add_addr : 1,
 		rm_addr : 1,
+		mp_prio : 1,
 		family : 4,
 		echo : 1,
 		backup : 1;
@@ -553,6 +557,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
-- =

2.30.0

--===============1453651467064817065==--
