Content-Type: multipart/mixed; boundary="===============2818875745488089143=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: add the address ID
 assignment bitmap
Date: Tue, 08 Dec 2020 21:42:29 +0800
Message-ID: <672af235a6ac38fef0ac1f3117ce888678480321.1607434427.git.geliangtang@gmail.com>
In-Reply-To: cover.1607434427.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7075

--===============2818875745488089143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the address ID set by the netlink PM from user-space is
overridden by the kernel. This patch added the address ID assignment
bitmap to allow user-space to set the address ID.

Use a per netns bitmask id_bitmap (256 bits) to keep track of in-use IDs.
And use next_id to keep track of the highest ID currently in use. If the
user-space provides an ID at endpoint creation time, try to use it. If
already in use, endpoint creation fails. Otherwise pick the first ID
available after the highest currently in use, with wrap-around.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 65 ++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a6d983d80576..e7cafca2d42e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -36,6 +36,9 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 =

+#define MAX_ADDR_ID		255
+#define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
+
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -46,6 +49,7 @@ struct pm_nl_pernet {
 	unsigned int		local_addr_max;
 	unsigned int		subflows_max;
 	unsigned int		next_id;
+	unsigned long		id_bitmap[BITMAP_SZ];
 };
 =

 #define MPTCP_PM_ADDR_MAX	8
@@ -524,10 +528,12 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
m_nl_pernet *pernet,
 	/* to keep the code simple, don't do IDR-like allocation for address ID,
 	 * just bail when we exceed limits
 	 */
-	if (pernet->next_id > 255)
-		goto out;
+	if (pernet->next_id =3D=3D MAX_ADDR_ID)
+		pernet->next_id =3D 1;
 	if (pernet->addrs >=3D MPTCP_PM_ADDR_MAX)
 		goto out;
+	if (test_bit(entry->addr.id, pernet->id_bitmap))
+		goto out;
 =

 	/* do not insert duplicate address, differentiate on port only
 	 * singled addresses
@@ -544,7 +550,19 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm=
_nl_pernet *pernet,
 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 		pernet->local_addr_max++;
 =

-	entry->addr.id =3D pernet->next_id++;
+	if (!entry->addr.id) {
+find_next:
+		entry->addr.id =3D find_next_zero_bit(pernet->id_bitmap,
+						    MAX_ADDR_ID + 1,
+						    pernet->next_id);
+		if (entry->addr.id <=3D 0 || entry->addr.id > MAX_ADDR_ID) {
+			pernet->next_id =3D 1;
+			goto find_next;
+		}
+	}
+	__set_bit(entry->addr.id, pernet->id_bitmap);
+	if (entry->addr.id > pernet->next_id)
+		pernet->next_id =3D entry->addr.id;
 	pernet->addrs++;
 	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
 	ret =3D entry->addr.id;
@@ -857,6 +875,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, s=
truct genl_info *info)
 =

 	pernet->addrs--;
 	list_del_rcu(&entry->list);
+	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 =

 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
@@ -894,6 +913,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb=
, struct genl_info *info)
 	spin_lock_bh(&pernet->lock);
 	list_splice_init(&pernet->local_addr_list, &free_list);
 	__reset_counters(pernet);
+	pernet->next_id =3D 1;
+	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
 	__flush_addrs(sock_net(skb->sk), &free_list);
 	return 0;
@@ -994,27 +1015,34 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff *m=
sg,
 	struct pm_nl_pernet *pernet;
 	int id =3D cb->args[0];
 	void *hdr;
+	int i;
 =

 	pernet =3D net_generic(net, pm_nl_pernet_id);
 =

 	spin_lock_bh(&pernet->lock);
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (entry->addr.id <=3D id)
-			continue;
-
-		hdr =3D genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-		if (!hdr)
-			break;
+	for (i =3D id; i < MAX_ADDR_ID + 1; i++) {
+		if (test_bit(i, pernet->id_bitmap)) {
+			entry =3D __lookup_addr_by_id(pernet, i);
+			if (!entry)
+				break;
+
+			if (entry->addr.id <=3D id)
+				continue;
+
+			hdr =3D genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+			if (!hdr)
+				break;
+
+			if (mptcp_nl_fill_addr(msg, entry) < 0) {
+				genlmsg_cancel(msg, hdr);
+				break;
+			}
 =

-		if (mptcp_nl_fill_addr(msg, entry) < 0) {
-			genlmsg_cancel(msg, hdr);
-			break;
+			id =3D entry->addr.id;
+			genlmsg_end(msg, hdr);
 		}
-
-		id =3D entry->addr.id;
-		genlmsg_end(msg, hdr);
 	}
 	spin_unlock_bh(&pernet->lock);
 =

@@ -1148,6 +1176,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	__reset_counters(pernet);
 	pernet->next_id =3D 1;
+	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_lock_init(&pernet->lock);
 	return 0;
 }
-- =

2.26.2

--===============2818875745488089143==--
