Content-Type: multipart/mixed; boundary="===============2780533523916934352=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/2] mptcp: reserve the MAX_ADDR_ID
 assignment
Date: Sat, 06 Feb 2021 00:32:11 +0800
Message-ID: <f53c88ba2f0661b7af4fac6e0b6f5b70a686a650.1612542562.git.geliangtang@gmail.com>
In-Reply-To: cover.1612542562.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7648

--===============2780533523916934352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reserve the MAX_ADDR_ID assignment in the address IDs bitmap, leave it to
mark the end of valid IDs in the removing addresses array.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4810c31bc4d..7b919c72a406 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1295,6 +1295,7 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *s=
kb, struct genl_info *info)
 	__reset_counters(pernet);
 	pernet->next_id =3D 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
+	__set_bit(MAX_ADDR_ID, pernet->id_bitmap);
 	spin_unlock_bh(&pernet->lock);
 =

 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
@@ -1881,6 +1882,7 @@ static int __net_init pm_nl_init_net(struct net *net)
 	__reset_counters(pernet);
 	pernet->next_id =3D 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
+	__set_bit(MAX_ADDR_ID, pernet->id_bitmap);
 	spin_lock_init(&pernet->lock);
 	return 0;
 }
-- =

2.29.2

--===============2780533523916934352==--
