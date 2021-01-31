Content-Type: multipart/mixed; boundary="===============5053696731222865097=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: use
 WRITE_ONCE/READ_ONCE for the pernet *_max"
Date: Sun, 31 Jan 2021 08:52:24 +0800
Message-ID: <3dae331b8fe7af727433d1d0eb0043538747f92e.1612053047.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7542

--===============5053696731222865097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As Jakub suggested, drop all the READ_ONCEs in the original patch.

And the commit message needs to be updated too:

-

Subject: mptcp: use WRITE_ONCE for the pernet *_max

This patch uses WRITE_ONCE() for all the pernet add_addr_signal_max,
add_addr_accept_max, local_addr_max and subflows_max fields in struct
pm_nl_pernet to avoid concurrency issues.

-

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7d6081d9a1db..c429bd82313e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -616,11 +616,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
m_nl_pernet *pernet,
 		pernet->next_id =3D entry->addr.id;
 =

 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
+		addr_max =3D pernet->add_addr_signal_max;
 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
 	}
 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max =3D READ_ONCE(pernet->local_addr_max);
+		addr_max =3D pernet->local_addr_max;
 		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
 	}
 =

@@ -932,11 +932,11 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb,=
 struct genl_info *info)
 		return -EINVAL;
 	}
 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max =3D READ_ONCE(pernet->add_addr_signal_max);
+		addr_max =3D pernet->add_addr_signal_max;
 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
 	}
 	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
-		addr_max =3D READ_ONCE(pernet->local_addr_max);
+		addr_max =3D pernet->local_addr_max;
 		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
 	}
 =

@@ -1140,12 +1140,12 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, struct=
 genl_info *info)
 	int ret;
 =

 	spin_lock_bh(&pernet->lock);
-	rcv_addrs =3D READ_ONCE(pernet->add_addr_accept_max);
+	rcv_addrs =3D pernet->add_addr_accept_max;
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_RCV_ADD_ADDRS, &rcv_addrs);
 	if (ret)
 		goto unlock;
 =

-	subflows =3D READ_ONCE(pernet->subflows_max);
+	subflows =3D pernet->subflows_max;
 	ret =3D parse_limit(info, MPTCP_PM_ATTR_SUBFLOWS, &subflows);
 	if (ret)
 		goto unlock;
-- =

2.29.2

--===============5053696731222865097==--
