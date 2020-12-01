Content-Type: multipart/mixed; boundary="===============2029359198654782010=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] mptcp: add the address ID
 assignment bitmap
Date: Tue, 01 Dec 2020 19:58:13 +0800
Message-ID: <effcae3f6ede9a3c612a0a90c7793232417de2a0.1606823692.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6999

--===============2029359198654782010==
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

Test:

 # pm_nl_ctl add 10.0.0.1
 # pm_nl_ctl add 10.0.0.2
 # pm_nl_ctl add 10.0.0.3 id 100
 # pm_nl_ctl add 10.0.0.4
 # pm_nl_ctl add 10.0.0.5 id 254
 # pm_nl_ctl add 10.0.0.6
 # pm_nl_ctl add 10.0.0.7
 # pm_nl_ctl add 10.0.0.8
 # pm_nl_ctl dump
 id 1 flags  10.0.0.1
 id 2 flags  10.0.0.2
 id 3 flags  10.0.0.7
 id 4 flags  10.0.0.8
 id 100 flags  10.0.0.3
 id 101 flags  10.0.0.4
 id 254 flags  10.0.0.5
 id 255 flags  10.0.0.6

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/117
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 63 +++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 54c6b6359144..0463a6b38633 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -37,6 +37,9 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 =

+#define MAX_ADDR_ID		255
+#define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, 8 * sizeof(long))
+
 struct pm_nl_pernet {
 	/* protects pernet updates */
 	spinlock_t		lock;
@@ -47,6 +50,7 @@ struct pm_nl_pernet {
 	unsigned int		local_addr_max;
 	unsigned int		subflows_max;
 	unsigned int		next_id;
+	unsigned long		id_bitmap[BITMAP_SZ];
 };
 =

 #define MPTCP_PM_ADDR_MAX	8
@@ -548,10 +552,12 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
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
@@ -568,7 +574,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm=
_nl_pernet *pernet,
 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 		pernet->local_addr_max++;
 =

-	entry->addr.id =3D pernet->next_id++;
+	if (!entry->addr.id) {
+		entry->addr.id =3D find_next_zero_bit(pernet->id_bitmap,
+						    MAX_ADDR_ID + 1,
+						    pernet->next_id);
+	}
+	__set_bit(entry->addr.id, pernet->id_bitmap);
+	if (entry->addr.id > pernet->next_id)
+		pernet->next_id =3D entry->addr.id;
 	pernet->addrs++;
 	list_add_tail_rcu(&entry->list, &pernet->local_addr_list);
 	ret =3D entry->addr.id;
@@ -941,6 +954,7 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, s=
truct genl_info *info)
 =

 	pernet->addrs--;
 	list_del_rcu(&entry->list);
+	__clear_bit(entry->addr.id, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 =

 	mptcp_nl_remove_subflow_and_signal_addr(sock_net(skb->sk), &entry->addr);
@@ -978,6 +992,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb=
, struct genl_info *info)
 	spin_lock_bh(&pernet->lock);
 	list_splice_init(&pernet->local_addr_list, &free_list);
 	__reset_counters(pernet);
+	pernet->next_id =3D 1;
+	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
 	__flush_addrs(sock_net(skb->sk), &free_list);
 	return 0;
@@ -1076,35 +1092,37 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff *=
msg,
 				   struct netlink_callback *cb)
 {
 	struct net *net =3D sock_net(msg->sk);
-	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
-	int id =3D cb->args[0];
-	void *hdr;
+	int id;
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
+	for (id =3D 0; id < MAX_ADDR_ID + 1; id++) {
+		if (test_bit(id, pernet->id_bitmap)) {
+			struct mptcp_pm_addr_entry *entry;
+			void *hdr;
+
+			entry =3D __lookup_addr_by_id(pernet, id);
+			if (!entry)
+				break;
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
+			genlmsg_end(msg, hdr);
 		}
-
-		id =3D entry->addr.id;
-		genlmsg_end(msg, hdr);
 	}
 	spin_unlock_bh(&pernet->lock);
 =

-	cb->args[0] =3D id;
 	return msg->len;
 }
 =

@@ -1234,6 +1252,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
 	__reset_counters(pernet);
 	pernet->next_id =3D 1;
+	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_lock_init(&pernet->lock);
 	return 0;
 }
-- =

2.26.2

--===============2029359198654782010==--
