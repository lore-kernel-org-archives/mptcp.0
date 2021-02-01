Content-Type: multipart/mixed; boundary="===============5742275490365665665=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 01/15] mptcp: use WRITE_ONCE for the
 pernet *_max
Date: Mon, 01 Feb 2021 15:09:06 -0800
Message-ID: <20210201230920.66027-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210201230920.66027-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7560

--===============5742275490365665665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch uses WRITE_ONCE() for all the pernet add_addr_signal_max,
add_addr_accept_max, local_addr_max and subflows_max fields in struct
pm_nl_pernet to avoid concurrency issues.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 83976b9ee99b..c429bd82313e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -572,6 +572,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_=
nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_addr_entry *cur;
+	unsigned int addr_max;
 	int ret =3D -EINVAL;
 =

 	spin_lock_bh(&pernet->lock);
@@ -614,10 +615,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
m_nl_pernet *pernet,
 	if (entry->addr.id > pernet->next_id)
 		pernet->next_id =3D entry->addr.id;
 =

-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
-		pernet->add_addr_signal_max++;
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-		pernet->local_addr_max++;
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		addr_max =3D pernet->add_addr_signal_max;
+		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
+	}
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		addr_max =3D pernet->local_addr_max;
+		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
+	}
 =

 	pernet->addrs++;
 	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
@@ -912,6 +917,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, s=
truct genl_info *info)
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	unsigned int addr_max;
 	int ret;
 =

 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
@@ -925,10 +931,14 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
-		pernet->add_addr_signal_max--;
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-		pernet->local_addr_max--;
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		addr_max =3D pernet->add_addr_signal_max;
+		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
+	}
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		addr_max =3D pernet->local_addr_max;
+		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
+	}
 =

 	pernet->addrs--;
 	list_del_rcu(&entry->list);
@@ -956,9 +966,9 @@ static void __flush_addrs(struct net *net, struct list_=
head *list)
 =

 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
-	pernet->add_addr_signal_max =3D 0;
-	pernet->add_addr_accept_max =3D 0;
-	pernet->local_addr_max =3D 0;
+	WRITE_ONCE(pernet->add_addr_signal_max, 0);
+	WRITE_ONCE(pernet->add_addr_accept_max, 0);
+	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs =3D 0;
 }
 =

-- =

2.30.0

--===============5742275490365665665==--
