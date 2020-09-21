Content-Type: multipart/mixed; boundary="===============6999106892226249451=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash-to: "mptcp: retransmit
 ADD_ADDR when timeout v5"
Date: Mon, 21 Sep 2020 20:16:49 +0800
Message-ID: <2d76ae315befc6be09e25e17a5640c53189e293c.1600690408.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5962

--===============6999106892226249451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Improving patch "mptcp: retransmit ADD_ADDR when timeout" v5 as Paolo
suggested. No commit message needs to update.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6fad2cc4cf5d..5a0e4d11bcc3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -191,16 +191,14 @@ static struct mptcp_pm_add_entry *
 lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 			  struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry, *ret =3D NULL;
+	struct mptcp_pm_add_entry *entry;
 =

 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (addresses_equal(&entry->addr, addr, false)) {
-			ret =3D entry;
-			break;
-		}
+		if (addresses_equal(&entry->addr, addr, false))
+			return entry;
 	}
 =

-	return ret;
+	return NULL;
 }
 =

 static void mptcp_pm_add_timer(struct timer_list *timer)
@@ -214,7 +212,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!msk)
 		return;
 =

-	if (sk->sk_state =3D=3D TCP_CLOSE)
+	if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
 		return;
 =

 	if (!entry->addr.id)
@@ -251,6 +249,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 =

 	spin_lock_bh(&msk->pm.lock);
 	entry =3D lookup_anno_list_by_saddr(msk, addr);
+	if (entry)
+		entry->retrans_times =3D ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 =

 	if (entry)
-- =

2.26.2

--===============6999106892226249451==--
