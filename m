Content-Type: multipart/mixed; boundary="===============1803444528836885372=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 1/5] mptcp: use
 WRITE_ONCE/READ_ONCE for the pernet *_max
Date: Wed, 06 Jan 2021 14:30:05 +0800
Message-ID: <13304f3214923004ef0f75f3e413eb6c637edf5e.1609914325.git.geliangtang@gmail.com>
In-Reply-To: cover.1609914325.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7272

--===============1803444528836885372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch used WRITE_ONCE() and READ_ONCE for all the pernet
add_addr_signal_max, add_addr_accept_max, local_addr_max and
subflows_max fields in struct pm_nl_pernet.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cc99410aca89..6ee44ea318f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -573,6 +573,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_=
nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_pm_addr_entry *cur;
+	unsigned int addr_max;
 	int ret =3D -EINVAL;
 =

 	spin_lock_bh(&pernet->lock);
@@ -615,10 +616,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
m_nl_pernet *pernet,
 	if (entry->addr.id > pernet->next_id)
 		pernet->next_id =3D entry->addr.id;
 =

-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
-		pernet->add_addr_signal_max++;
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-		pernet->local_addr_max++;
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
+		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
+	}
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		addr_max =3D READ_ONCE(pernet->local_addr_max);
+		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
+	}
 =

 	pernet->addrs++;
 	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
@@ -913,6 +918,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, s=
truct genl_info *info)
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	unsigned int addr_max;
 	int ret;
 =

 	ret =3D mptcp_pm_parse_addr(attr, info, false, &addr);
@@ -926,10 +932,14 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
-		pernet->add_addr_signal_max--;
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-		pernet->local_addr_max--;
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
+		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
+	}
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+		addr_max =3D READ_ONCE(pernet->local_addr_max);
+		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
+	}
 =

 	pernet->addrs--;
 	list_del_rcu(&entry->list);
@@ -957,9 +967,9 @@ static void __flush_addrs(struct net *net, struct list_=
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

@@ -1131,12 +1141,12 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct=
 genl_info *info)
 	int ret;
 =

 	spin_lock_bh(&pernet->lock);
-	rcv_addrs =3D pernet->add_addr_accept_max;
+	rcv_addrs =3D READ_ONCE(pernet->add_addr_accept_max);
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
 		goto unlock;
 =

-	subflows =3D pernet->subflows_max;
+	subflows =3D READ_ONCE(pernet->subflows_max);
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
 	if (ret)
 		goto unlock;
-- =

2.29.2

--===============1803444528836885372==--
