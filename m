Content-Type: multipart/mixed; boundary="===============8248221296074058074=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 2/5] mptcp: skip connecting the
 connected address
Date: Wed, 24 Feb 2021 11:56:55 +0800
Message-ID: <f9f1b135e3d23ea0432e219446efdf0e8b062b5f.1614138509.git.geliangtang@gmail.com>
In-Reply-To: 21d743ca1bee501e0515d23896c16c87d929c3f4.1614138509.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7929

--===============8248221296074058074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper named lookup_subflow_by_daddr to find
whether the destination address is in the msk's conn_list.

In mptcp_pm_nl_add_addr_received, use lookup_subflow_by_daddr to check
whether the announced address is already connected. If it is, skip
connecting this address and send out the echo.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2441b23e2021..659757439e11 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -140,6 +140,24 @@ static bool lookup_subflow_by_saddr(const struct list_=
head *list,
 	return false;
 }
 =

+static bool lookup_subflow_by_daddr(const struct list_head *list,
+				    struct mptcp_addr_info *daddr)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_addr_info cur;
+	struct sock_common *skc;
+
+	list_for_each_entry(subflow, list, node) {
+		skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+
+		remote_address(skc, &cur);
+		if (addresses_equal(&cur, daddr, daddr->port))
+			return true;
+	}
+
+	return false;
+}
+
 static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     struct mptcp_sock *msk)
@@ -475,6 +493,10 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp=
_sock *msk)
 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, add_addr_accept_max,
 		 msk->pm.remote.family);
+
+	if (lookup_subflow_by_daddr(&msk->conn_list, &msk->pm.remote))
+		goto add_addr_echo;
+
 	msk->pm.add_addr_accepted++;
 	msk->pm.subflows++;
 	if (msk->pm.add_addr_accepted >=3D add_addr_accept_max ||
@@ -494,6 +516,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	__mptcp_subflow_connect(sk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 =

+add_addr_echo:
 	mptcp_pm_announce_addr(msk, &msk->pm.remote, true);
 	mptcp_pm_nl_add_addr_send_ack(msk);
 }
-- =

2.29.2

--===============8248221296074058074==--
