Content-Type: multipart/mixed; boundary="===============0451305294099312733=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/5] mptcp: add a new sysctl
 add_addr_urgent
Date: Thu, 14 Jan 2021 13:40:21 +0800
Message-ID: <eb180a799e3650fae10aa3ed9afafb7dc13ddae4.1610602400.git.geliangtang@gmail.com>
In-Reply-To: 7e16f6bc56bb1f0fb9f6253ee67f1f74832f1cce.1610602400.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7371

--===============0451305294099312733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new sysctl named add_addr_urgent, to control whether
the ADD_ADDR suboption can be sent out immediately in only one round trip.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
index 6af0196c4297..d7984701e411 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -24,3 +24,11 @@ add_addr_timeout - INTEGER (seconds)
 	sysctl.
 =

 	Default: 120
+
+add_addr_urgent - INTEGER
+	Control whether the ADD_ADDR suboption can be sent out immediately
+	in only one round trip.
+
+	The default value is zero. This is a per-namespace sysctl.
+
+	Default: 0
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..b0af5ff52136 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ struct mptcp_pernet {
 =

 	int mptcp_enabled;
 	unsigned int add_addr_timeout;
+	int add_addr_urgent;
 };
 =

 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_timeout;
 }
 =

+bool mptcp_get_add_addr_urgent(struct net *net)
+{
+	return mptcp_get_pernet(net)->add_addr_urgent;
+}
+
 static struct ctl_table mptcp_sysctl_table[] =3D {
 	{
 		.procname =3D "enabled",
@@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.mode =3D 0644,
 		.proc_handler =3D proc_dointvec_jiffies,
 	},
+	{
+		.procname =3D "add_addr_urgent",
+		.maxlen =3D sizeof(int),
+		.mode =3D 0644,
+		.proc_handler =3D proc_dointvec,
+	},
 	{}
 };
 =

@@ -59,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet=
 *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
 	pernet->add_addr_timeout =3D TCP_RTO_MAX;
+	pernet->add_addr_urgent =3D 0;
 }
 =

 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pe=
rnet)
@@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct=
 mptcp_pernet *pernet)
 =

 	table[0].data =3D &pernet->mptcp_enabled;
 	table[1].data =3D &pernet->add_addr_timeout;
+	table[2].data =3D &pernet->add_addr_urgent;
 =

 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index adcc3a81c8af..030e352bd2d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -461,6 +461,7 @@ static inline void mptcp_add_pending_subflow(struct mpt=
cp_sock *msk,
 =

 int mptcp_is_enabled(struct net *net);
 unsigned int mptcp_get_add_addr_timeout(struct net *net);
+bool mptcp_get_add_addr_urgent(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- =

2.29.2

--===============0451305294099312733==--
