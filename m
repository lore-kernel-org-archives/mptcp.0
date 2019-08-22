Content-Type: multipart/mixed; boundary="===============7108697889746204308=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH] mptcp: extends interim path manager
Date: Thu, 22 Aug 2019 15:19:43 +0200
Message-ID: <17d0a5dddb69889affd14ac77fdbe8f278ddac77.1566479918.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1664

--===============7108697889746204308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is on top of "mptcp: Implement interim path manager" and extends
the infrastructure there so that local address is configurable per ns
via sysctl.
Additionally use the local address, if available, in pm_create_subflow()
to bind the subflow locally.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/ctrl.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm.c   | 33 ++++++++++++++++++++----
 2 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 8d9f15f02369..7507fbc72338 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -18,6 +18,7 @@ struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 =

 	int mptcp_enabled;
+	struct inetpeer_addr local_addr;
 };
 =

 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -30,6 +31,61 @@ int mptcp_is_enabled(struct net *net)
 	return mptcp_get_pernet(net)->mptcp_enabled;
 }
 =

+#define MAX_IPV6_STRLEN 40
+
+struct inetpeer_addr *pm_local_addr(struct net *net)
+{
+	return &mptcp_get_pernet(net)->local_addr;
+}
+
+static int proc_mptcp_parse_addr(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos)
+{
+	struct inetpeer_addr *addr =3D (struct inetpeer_addr *)table->data;
+	char buf[MAX_IPV6_STRLEN];
+	struct ctl_table dummy;
+	int ret;
+
+	if (!write) {
+		if (addr->family =3D=3D AF_INET)
+			sprintf(buf, "%pI4", &addr->a4.addr);
+		else if (addr->family =3D=3D AF_INET6)
+			sprintf(buf, "%pI6", &addr->a6);
+		else
+			buf[0] =3D 0;
+	}
+
+	memset(&dummy, 0, sizeof(dummy));
+	dummy.data =3D buf;
+	dummy.procname =3D table->procname;
+	dummy.maxlen =3D table->maxlen;
+	dummy.mode =3D table->mode;
+	ret =3D proc_dostring(&dummy, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (write) {
+		unsigned a, b, c, d;
+
+		if (sscanf(buf, "%u.%u.%u.%u", &a, &b, &c, &d) && a < 256 &&
+		    b < 256 && c < 256 && d < 256) {
+			addr->family =3D AF_INET;
+			addr->a4.addr =3D htonl((a << 24) + (b << 16) + (c << 8)
+					      + d);
+		} else if (sscanf(buf, "%x:%x:%x:%x", &a, &b, &c, &d) =3D=3D 4) {
+			addr->family =3D AF_INET6;
+			addr->a6.s6_addr32[0] =3D a;
+			addr->a6.s6_addr32[1] =3D b;
+			addr->a6.s6_addr32[2] =3D c;
+			addr->a6.s6_addr32[3] =3D d;
+		} else {
+			addr->family =3D 0;
+		}
+	}
+	return 0;
+}
+
 static struct ctl_table mptcp_sysctl_table[] =3D {
 	{
 		.procname =3D "enabled",
@@ -40,6 +96,15 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		 */
 		.proc_handler =3D proc_dointvec,
 	},
+	{
+		.procname =3D "local_addr",
+		.maxlen =3D MAX_IPV6_STRLEN,
+		.mode =3D 0644,
+		/* users with CAP_NET_ADMIN or root (not and) can change thi
+		 * value, same as other sysctl or the 'net' tree.
+		 */
+		.proc_handler =3D proc_mptcp_parse_addr,
+	},
 	{}
 };
 =

@@ -56,6 +121,7 @@ static int mptcp_pernet_new_table(struct net *net, struc=
t mptcp_pernet *pernet)
 	}
 =

 	table[0].data =3D &pernet->mptcp_enabled;
+	table[1].data =3D &pernet->local_addr;
 =

 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d43d05511e69..fc709d310580 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,6 +12,8 @@ struct workqueue_struct *mptcp_wq;
 static void announce_addr_worker(struct work_struct *work);
 static void create_subflow_worker(struct work_struct *work);
 =

+struct inetpeer_addr *pm_local_addr(struct net *net);
+
 /* path manager command handlers */
 =

 int pm_announce_addr(u32 token, sa_family_t family, u8 local_id,
@@ -73,7 +75,10 @@ int pm_create_subflow(u32 token, u8 remote_id)
 =

 	local.sin_family =3D AF_INET;
 	local.sin_port =3D 0;
-	local.sin_addr.s_addr =3D INADDR_ANY;
+	if (msk->pm.local_valid && msk->pm.local_family =3D=3D AF_INET)
+		local.sin_addr.s_addr =3D htonl(msk->pm.local_addr.s_addr);
+	else
+		local.sin_addr.s_addr =3D INADDR_ANY;
 =

 	remote.sin_family =3D msk->pm.remote_family;
 	remote.sin_port =3D htons(msk->dport);
@@ -210,20 +215,38 @@ void pm_init(void)
 		panic("Failed to allocate workqueue");
 }
 =

+static struct mptcp_sock *mptcp_sk_from_pm(struct mptcp_pm_data *pm)
+{
+	return container_of(pm, struct mptcp_sock, pm);
+}
+
 static void announce_addr_worker(struct work_struct *work)
 {
 	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
 						addr_work);
-	struct in_addr addr;
+	struct mptcp_sock *msk =3D mptcp_sk_from_pm(pm);
+	struct inetpeer_addr *addr;
+	struct in_addr in_addr;
+
+	addr =3D pm_local_addr(sock_net(&msk->sk.icsk_inet.sk));
+	if (addr->family !=3D AF_INET)
+		return;
 =

-	/* @@ hard-code address to announce here... */
-	pm_announce_addr(pm->token, AF_INET, 1, &addr);
+	in_addr.s_addr =3D addr->a4.addr;
+	pm_announce_addr(pm->token, addr->family, 1, &in_addr);
 }
 =

 static void create_subflow_worker(struct work_struct *work)
 {
 	struct mptcp_pm_data *pm =3D container_of(work, struct mptcp_pm_data,
 						subflow_work);
-
+	struct mptcp_sock *msk =3D mptcp_sk_from_pm(pm);
+	struct inetpeer_addr *addr;
+
+	addr =3D pm_local_addr(sock_net(&msk->sk.icsk_inet.sk));
+	msk->pm.local_valid =3D addr->family !=3D 0;
+	msk->pm.local_id =3D 1;
+	msk->pm.local_family =3D addr->family;
+	msk->pm.local_addr.s_addr =3D addr->a4.addr;
 	pm_create_subflow(pm->token, pm->remote_id);
 }
-- =

2.21.0


--===============7108697889746204308==--
