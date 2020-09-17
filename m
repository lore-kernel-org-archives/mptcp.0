Content-Type: multipart/mixed; boundary="===============6336808111270628744=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash-to: "mptcp: remove addr and
 subflow in PM netlink v9" Part 2
Date: Thu, 17 Sep 2020 13:12:09 +0800
Message-ID: <5f006df48114968c8919cfd35424821e53b26b15.1600319465.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5905

--===============6336808111270628744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixed BUG in mptcp_pm_free_anno_list(), mptcp_pm_free_anno_list
may be called when PM has not been inited. Then we'll get the "NULL pointer
dereference" BUG. This patch added a flag to mark whether PM has been
inited.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/90
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_netlink.c | 3 +++
 net/mptcp/protocol.h   | 1 +
 3 files changed, 5 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ca88422e774..60e9a0d2ba1d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -243,6 +243,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	INIT_LIST_HEAD(&msk->pm.anno_list);
 =

 	mptcp_pm_nl_data_init(msk);
+	WRITE_ONCE(msk->pm.inited, true);
 }
 =

 void __init mptcp_pm_init(void)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8780d618a05a..9afd66adffe2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -214,6 +214,9 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 =

 	pr_debug("msk=3D%p\n", msk);
 =

+	if (!READ_ONCE(msk->pm.inited))
+		return;
+
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry_safe(entry, tmp, &msk->pm.anno_list, list) {
 		list_del(&entry->list);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db1e5de2fee7..a33ec4eae071 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -171,6 +171,7 @@ struct mptcp_pm_data {
 	bool		accept_addr;
 	bool		accept_subflow;
 	bool		add_addr_echo;
+	bool		inited;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
-- =

2.17.1

--===============6336808111270628744==--
