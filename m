Content-Type: multipart/mixed; boundary="===============2397887654976704023=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 8/9] mptcp: pm: simplify
 select_local_address()
Date: Thu, 10 Dec 2020 14:25:05 -0800
Message-ID: <20201210222506.222251-9-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201210222506.222251-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7136

--===============2397887654976704023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

There is no need to unconditionally acquire the join list
lock, we can simply splice the join list into the subflow
list and traverse only the latter.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9cc4eefaf080..a6d983d80576 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -135,7 +135,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
 =

 	rcu_read_lock();
-	spin_lock_bh(&msk->join_list_lock);
+	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
@@ -144,13 +144,11 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
 		 * pending join
 		 */
 		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
-		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    !lookup_subflow_by_saddr(&msk->join_list, &entry->addr)) {
+		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
 			ret =3D entry;
 			break;
 		}
 	}
-	spin_unlock_bh(&msk->join_list_lock);
 	rcu_read_unlock();
 	return ret;
 }
-- =

2.29.2

--===============2397887654976704023==--
