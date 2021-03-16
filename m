Content-Type: multipart/mixed; boundary="===============6593392765877014528=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/3] mptcp: send ack for rm_addr
Date: Tue, 16 Mar 2021 13:27:10 +0800
Message-ID: <b6c36865d72a9fc55d3a926ebdbfad6b95390cea.1615871979.git.geliangtang@gmail.com>
In-Reply-To: bd3fe0dc32c12fab55403f7ec122ebdd35fb0625.1615871979.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8164

--===============6593392765877014528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the sending ACK conditions for the ADD_ADDR, send an
ACK packet for RM_ADDR too.

In mptcp_pm_remove_addr, invoke mptcp_pm_nl_add_addr_send_ack to send
the ACK packet.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.h   |  1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 966942d1013f..efa7deb96139 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -53,6 +53,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const st=
ruct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx =3D *rm_list;
 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
+	mptcp_pm_nl_add_addr_send_ack(msk);
 	return 0;
 }
 =

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cd99f6b9df93..eab8014179d1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -56,8 +56,6 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 =

-static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
-
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
 {
@@ -524,14 +522,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptc=
p_sock *msk)
 	mptcp_pm_nl_add_addr_send_ack(msk);
 }
 =

-static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
+void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 =

 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
 =

-	if (!mptcp_pm_should_add_signal(msk))
+	if (!mptcp_pm_should_add_signal(msk) &&
+	    !mptcp_pm_should_rm_signal(msk))
 		return;
 =

 	__mptcp_flush_join_list(msk);
@@ -540,7 +539,8 @@ static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_=
sock *msk)
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

 		spin_unlock_bh(&msk->pm.lock);
-		pr_debug("send ack for add_addr%s%s",
+		pr_debug("send ack for %s%s%s",
+			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr",
 			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
 			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0e301ae56b0..34fddb1fcd1e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -667,6 +667,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
-- =

2.30.2

--===============6593392765877014528==--
