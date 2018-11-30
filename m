Content-Type: multipart/mixed; boundary="===============7847453252145604456=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/5] mptcp: Remove IPv6 duplicated address detection
Date: Thu, 29 Nov 2018 17:05:12 -0800
Message-ID: <20181130010514.18251-4-cpaasch@apple.com>
In-Reply-To: 20181130010514.18251-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 848

--===============7847453252145604456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It causes us to take a refcnt on the address and actually periodically
schedule a timer until eventually the address gets either marked as
confirmed or removed.

It causes regressions in the Android test-suite.

This patch simply removes the duplicate address detection. That way,
when we get an IPv6-address we use it right away. Also, if the address
turns out to be duplicate on the link (which is really a cornercase
scenario), it will be removed and our subflow will be destroyed. I don't
think that's a big deal.

I don't suggest to backport this patch as it's more of a design-change
than a bugfix.

Github-issue: https://github.com/multipath-tcp/mptcp/issues/293

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 8e3743b348121ac66aba0df3074aba12c40591c2)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_fullmesh.c | 65 +-----------------------------------------=
----
 1 file changed, 1 insertion(+), 64 deletions(-)

diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index e699c0e89224..23f42a06cc70 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -1122,69 +1122,9 @@ static struct notifier_block mptcp_pm_inetaddr_notif=
ier =3D {
 =

 #if IS_ENABLED(CONFIG_IPV6)
 =

-/* IPV6-related address/interface watchers */
-struct mptcp_dad_data {
-	struct timer_list timer;
-	struct inet6_ifaddr *ifa;
-};
-
-static void dad_callback(struct timer_list *t);
 static int inet6_addr_event(struct notifier_block *this, unsigned long eve=
nt,
 			    void *ptr);
 =

-static bool ipv6_dad_finished(const struct inet6_ifaddr *ifa)
-{
-	return !(ifa->flags & IFA_F_TENTATIVE) ||
-	       ifa->state > INET6_IFADDR_STATE_DAD;
-}
-
-static void dad_init_timer(struct mptcp_dad_data *data,
-			   struct inet6_ifaddr *ifa)
-{
-	data->ifa =3D ifa;
-	if (ifa->idev->cnf.rtr_solicit_delay)
-		data->timer.expires =3D jiffies + ifa->idev->cnf.rtr_solicit_delay;
-	else
-		data->timer.expires =3D jiffies + (HZ/10);
-}
-
-static void dad_callback(struct timer_list *t)
-{
-	struct mptcp_dad_data *data =3D from_timer(data, t, timer);
-
-	/* DAD failed or IP brought down? */
-	if (data->ifa->state =3D=3D INET6_IFADDR_STATE_ERRDAD ||
-	    data->ifa->state =3D=3D INET6_IFADDR_STATE_DEAD)
-		goto exit;
-
-	if (!ipv6_dad_finished(data->ifa)) {
-		dad_init_timer(data, data->ifa);
-		add_timer(&data->timer);
-		return;
-	}
-
-	inet6_addr_event(NULL, NETDEV_UP, data->ifa);
-
-exit:
-	in6_ifa_put(data->ifa);
-	kfree(data);
-}
-
-static inline void dad_setup_timer(struct inet6_ifaddr *ifa)
-{
-	struct mptcp_dad_data *data;
-
-	data =3D kmalloc(sizeof(*data), GFP_ATOMIC);
-
-	if (!data)
-		return;
-
-	timer_setup(&data->timer, dad_callback, 0);
-	dad_init_timer(data, ifa);
-	add_timer(&data->timer);
-	in6_ifa_hold(ifa);
-}
-
 static void addr6_event_handler(const struct inet6_ifaddr *ifa, unsigned l=
ong event,
 				struct net *net)
 {
@@ -1233,10 +1173,7 @@ static int inet6_addr_event(struct notifier_block *t=
his, unsigned long event,
 	      event =3D=3D NETDEV_CHANGE))
 		return NOTIFY_DONE;
 =

-	if (!ipv6_dad_finished(ifa6))
-		dad_setup_timer(ifa6);
-	else
-		addr6_event_handler(ifa6, event, net);
+	addr6_event_handler(ifa6, event, net);
 =

 	return NOTIFY_DONE;
 }
-- =

2.16.2


--===============7847453252145604456==--
