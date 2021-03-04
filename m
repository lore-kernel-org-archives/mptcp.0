Content-Type: multipart/mixed; boundary="===============7013653184910667442=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 2/9] mptcp: put subflow sock on connect error
Date: Thu, 04 Mar 2021 13:32:09 -0800
Message-ID: <20210304213216.205472-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8029

--===============7013653184910667442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

mptcp_add_pending_subflow() performs a sock_hold() on the subflow,
then adds the subflow to the join list.

Without a sock_put the subflow sk won't be freed in case connect() fails.

unreferenced object 0xffff88810c03b100 (size 3000):
[..]
    sk_prot_alloc.isra.0+0x2f/0x110
    sk_alloc+0x5d/0xc20
    inet6_create+0x2b7/0xd30
    __sock_create+0x17f/0x410
    mptcp_subflow_create_socket+0xff/0x9c0
    __mptcp_subflow_connect+0x1da/0xaf0
    mptcp_pm_nl_work+0x6e0/0x1120
    mptcp_worker+0x508/0x9a0

Fixes: 5b950ff4331ddda ("mptcp: link MPC subflow into msk only after accept=
")
Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1fbcab257e6..41695e26c374 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1297,6 +1297,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	spin_lock_bh(&msk->join_list_lock);
 	list_del(&subflow->node);
 	spin_unlock_bh(&msk->join_list_lock);
+	sock_put(mptcp_subflow_tcp_sock(subflow));
 =

 failed:
 	subflow->disposable =3D 1;
-- =

2.30.1

--===============7013653184910667442==--
