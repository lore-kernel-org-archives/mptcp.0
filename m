Content-Type: multipart/mixed; boundary="===============8657323178832455864=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 1/2] mptcp: add a new sysctl
 add_addr_timeout
Date: Wed, 30 Sep 2020 16:50:43 +0800
Message-ID: <b45ed71e0659b4d9c368c4f3cc24cac83d1723c2.1601455568.git.geliangtang@gmail.com>
In-Reply-To: cover.1601455568.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6108

--===============8657323178832455864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new sysctl, named add_addr_timeout, to control the
timeout value (in seconds) of the ADD_ADDR retransmission.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/ctrl.c       | 14 ++++++++++++++
 net/mptcp/pm_netlink.c |  8 ++++++--
 net/mptcp/protocol.h   |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 54b888f94009..96ba616f59bf 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -18,6 +18,7 @@ struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 =

 	int mptcp_enabled;
+	unsigned int add_addr_timeout;
 };
 =

 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -30,6 +31,11 @@ int mptcp_is_enabled(struct net *net)
 	return mptcp_get_pernet(net)->mptcp_enabled;
 }
 =

+unsigned int mptcp_get_add_addr_timeout(struct net *net)
+{
+	return mptcp_get_pernet(net)->add_addr_timeout;
+}
+
 static struct ctl_table mptcp_sysctl_table[] =3D {
 	{
 		.procname =3D "enabled",
@@ -40,12 +46,19 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		 */
 		.proc_handler =3D proc_dointvec,
 	},
+	{
+		.procname =3D "add_addr_timeout",
+		.maxlen =3D sizeof(unsigned int),
+		.mode =3D 0644,
+		.proc_handler =3D proc_dointvec_jiffies,
+	},
 	{}
 };
 =

 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
+	pernet->add_addr_timeout =3D TCP_RTO_MAX;
 }
 =

 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pe=
rnet)
@@ -61,6 +74,7 @@ static int mptcp_pernet_new_table(struct net *net, struct=
 mptcp_pernet *pernet)
 	}
 =

 	table[0].data =3D &pernet->mptcp_enabled;
+	table[1].data =3D &pernet->add_addr_timeout;
 =

 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5a0e4d11bcc3..81ceef749e58 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -206,6 +206,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk =3D entry->sock;
 	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -232,7 +233,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 =

 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
+		sk_reset_timer(sk, timer,
+			       jiffies + mptcp_get_add_addr_timeout(net));
 =

 	spin_unlock_bh(&msk->pm.lock);
 =

@@ -264,6 +266,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 {
 	struct mptcp_pm_add_entry *add_entry =3D NULL;
 	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
 =

 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
@@ -279,7 +282,8 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 	add_entry->retrans_times =3D 0;
 =

 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer, jiffies + TCP_RTO_MAX);
+	sk_reset_timer(sk, &add_entry->add_timer,
+		       jiffies + mptcp_get_add_addr_timeout(net));
 =

 	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..95a2b5a0c728 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -361,6 +361,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 }
 =

 int mptcp_is_enabled(struct net *net);
+unsigned int mptcp_get_add_addr_timeout(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- =

2.26.2

--===============8657323178832455864==--
