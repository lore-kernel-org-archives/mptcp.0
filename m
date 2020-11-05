Content-Type: multipart/mixed; boundary="===============6133285279138501031=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH mptcp-next 2/6] mptcp: add the incoming
 MP_PRIO support
Date: Thu, 05 Nov 2020 18:50:19 +0800
Message-ID: <8d79f5c026f70bd840665e4055b460d28e89cbc6.1604572610.git.geliangtang@gmail.com>
In-Reply-To: df907f4fe8264ea382706c6cdb0b2c7bc0044426.1604572610.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6559

--===============6133285279138501031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the incoming MP_PRIO logic:

Added a flag named mp_prio in mptcp_options_received, to mark the MP_PRIO
is received, and save the priority value to the new prio_bkup field.
Then invoke mptcp_pm_mp_prio_received with the receiving subsocket and
the prio_bkup value.

In mptcp_pm_mp_prio_received, find the subflow according the subsocket,
and change the subflow's backup as the incoming priority value.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/pm.c       | 10 ++++++++++
 net/mptcp/protocol.h |  6 ++++++
 3 files changed, 32 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b74e6ab2d605..affbadb77faf 100644
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
+		mp_opt->prio_bkup =3D *ptr++ & MPTCP_PRIO_BKUP;
+		pr_debug("MP_PRIO: prio=3D%d", mp_opt->prio_bkup);
+		break;
+
 	default:
 		break;
 	}
@@ -302,6 +311,8 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
+	mp_opt->mp_prio =3D 0;
+	mp_opt->prio_bkup =3D 0;
 =

 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
@@ -997,6 +1008,11 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		mp_opt.rm_addr =3D 0;
 	}
 =

+	if (mp_opt.mp_prio) {
+		mptcp_pm_mp_prio_received(sk, mp_opt.prio_bkup);
+		mp_opt.mp_prio =3D 0;
+	}
+
 	if (!mp_opt.dss)
 		return;
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e63e14f4cf2a..a4dc4aa39ad8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -188,6 +188,16 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,=
 u8 rm_id)
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_mp_prio_received(struct sock *sk, u8 prio_bkup)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
+
+	spin_lock_bh(&msk->pm.lock);
+	subflow->backup =3D prio_bkup;
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a8ed1de1cb05..871b73046de0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -87,6 +87,9 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+/* MPTCP MP_PRIO flags */
+#define MPTCP_PRIO_BKUP		BIT(0)
+
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
 #define MPTCP_NOSPACE		1
@@ -115,6 +118,7 @@ struct mptcp_options_received {
 		dss : 1,
 		add_addr : 1,
 		rm_addr : 1,
+		mp_prio : 1,
 		family : 4,
 		echo : 1,
 		backup : 1;
@@ -140,6 +144,7 @@ struct mptcp_options_received {
 	};
 	u64	ahmac;
 	u16	port;
+	u8	prio_bkup;
 };
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
@@ -519,6 +524,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
+void mptcp_pm_mp_prio_received(struct sock *sk, u8 prio_bkup);
 void mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *addr,
 			       u8 prio_bkup);
-- =

2.26.2

--===============6133285279138501031==--
