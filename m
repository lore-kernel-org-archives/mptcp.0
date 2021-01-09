Content-Type: multipart/mixed; boundary="===============0471947758513909263=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 5/8] mptcp: add set_flags command in PM
 netlink
Date: Fri, 08 Jan 2021 16:47:59 -0800
Message-ID: <20210109004802.341602-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210109004802.341602-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7293

--===============0471947758513909263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added a new command MPTCP_PM_CMD_SET_FLAGS in PM netlink:

In mptcp_nl_cmd_set_flags, parse the input address, get the backup value
according to whether the address's FLAG_BACKUP flag is set from the
user-space. Then check whether this address had been added in the local
address list. If it had been, then call mptcp_nl_addr_backup to deal with
this address.

In mptcp_nl_addr_backup, traverse all the existing msk sockets to find
the relevant sockets, and call mptcp_pm_nl_mp_prio_send_ack to send out
a MP_PRIO ACK packet.

Finally in mptcp_nl_cmd_set_flags, set or clear the address's FLAG_BACKUP
flag.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 65 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 9762660df741..3674a451a18c 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -82,6 +82,7 @@ enum {
 	MPTCP_PM_CMD_FLUSH_ADDRS,
 	MPTCP_PM_CMD_SET_LIMITS,
 	MPTCP_PM_CMD_GET_LIMITS,
+	MPTCP_PM_CMD_SET_FLAGS,
 =

 	__MPTCP_PM_CMD_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf0d13c85a68..8f80099f1657 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1164,6 +1164,66 @@ mptcp_nl_cmd_get_limits(struct sk_buff *skb, struct =
genl_info *info)
 	return -EMSGSIZE;
 }
 =

+static int mptcp_nl_addr_backup(struct net *net,
+				struct mptcp_addr_info *addr,
+				u8 bkup)
+{
+	long s_slot =3D 0, s_num =3D 0;
+	struct mptcp_sock *msk;
+	int ret =3D -EINVAL;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		if (list_empty(&msk->conn_list))
+			goto next;
+
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
+		ret =3D mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return ret;
+}
+
+static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *i=
nfo)
+{
+	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct pm_nl_pernet *pernet =3D genl_info_pm_nl(info);
+	struct mptcp_pm_addr_entry addr, *entry;
+	struct net *net =3D sock_net(skb->sk);
+	u8 bkup =3D 0;
+	int ret;
+
+	ret =3D mptcp_pm_parse_addr(attr, info, true, &addr);
+	if (ret < 0)
+		return ret;
+
+	if (addr.addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+		bkup =3D 1;
+
+	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, &addr.addr, true)) {
+			ret =3D mptcp_nl_addr_backup(net, &entry->addr, bkup);
+			if (ret)
+				return ret;
+
+			if (bkup)
+				entry->addr.flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->addr.flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+
+	return 0;
+}
+
 static const struct genl_small_ops mptcp_pm_ops[] =3D {
 	{
 		.cmd    =3D MPTCP_PM_CMD_ADD_ADDR,
@@ -1194,6 +1254,11 @@ static const struct genl_small_ops mptcp_pm_ops[] =
=3D {
 		.cmd    =3D MPTCP_PM_CMD_GET_LIMITS,
 		.doit   =3D mptcp_nl_cmd_get_limits,
 	},
+	{
+		.cmd    =3D MPTCP_PM_CMD_SET_FLAGS,
+		.doit   =3D mptcp_nl_cmd_set_flags,
+		.flags  =3D GENL_ADMIN_PERM,
+	},
 };
 =

 static struct genl_family mptcp_genl_family __ro_after_init =3D {
-- =

2.30.0

--===============0471947758513909263==--
