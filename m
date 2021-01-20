Content-Type: multipart/mixed; boundary="===============0418835005693184575=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next 1/5] mptcp: split __mptcp_close_ssk
 helper
Date: Wed, 20 Jan 2021 16:43:33 +0100
Message-ID: <20210120154337.27997-2-fw@strlen.de>
In-Reply-To: 20210120154337.27997-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7454

--===============0418835005693184575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for subflow close events:

When mptcp connection is torn down its enough to send the mptcp socket
close notification rather than a subflow close event for all of the
subflows followed by the mptcp close event.

This splits the helper: mptcp_close_ssk() will emit the close
notification, __mptcp_close_ssk will not.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.c   | 12 +++++++++---
 net/mptcp/protocol.h   |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 03cb22c5a546..e2f40985b450 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -596,7 +596,7 @@ static void mptcp_pm_nl_rm_addr_received(struct mptcp_s=
ock *msk)
 =

 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, how);
-		__mptcp_close_ssk(sk, ssk, subflow);
+		mptcp_close_ssk(sk, ssk, subflow);
 		spin_lock_bh(&msk->pm.lock);
 =

 		msk->pm.add_addr_accepted--;
@@ -666,7 +666,7 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock =
*msk, u8 rm_id)
 =

 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, how);
-		__mptcp_close_ssk(sk, ssk, subflow);
+		mptcp_close_ssk(sk, ssk, subflow);
 		spin_lock_bh(&msk->pm.lock);
 =

 		msk->pm.local_addr_used--;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e9ad8cb5268b..52ab2ae3d51d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2114,8 +2114,8 @@ static struct sock *mptcp_subflow_get_retrans(const s=
truct mptcp_sock *msk)
  * so we need to use tcp_close() after detaching them from the mptcp
  * parent socket.
  */
-void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-		       struct mptcp_subflow_context *subflow)
+static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+			      struct mptcp_subflow_context *subflow)
 {
 	list_del(&subflow->node);
 =

@@ -2147,6 +2147,12 @@ void __mptcp_close_ssk(struct sock *sk, struct sock =
*ssk,
 	sock_put(ssk);
 }
 =

+void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+		     struct mptcp_subflow_context *subflow)
+{
+	__mptcp_close_ssk(sk, ssk, subflow);
+}
+
 static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
 {
 	return 0;
@@ -2164,7 +2170,7 @@ static void __mptcp_close_subflow(struct mptcp_sock *=
msk)
 		if (inet_sk_state_load(ssk) !=3D TCP_CLOSE)
 			continue;
 =

-		__mptcp_close_ssk((struct sock *)msk, ssk, subflow);
+		mptcp_close_ssk((struct sock *)msk, ssk, subflow);
 	}
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 98b0169ab531..2b8f90f523c7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -538,8 +538,8 @@ void mptcp_subflow_fully_established(struct mptcp_subfl=
ow_context *subflow,
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
-void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
-		       struct mptcp_subflow_context *subflow);
+void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
+		     struct mptcp_subflow_context *subflow);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
-- =

2.26.2

--===============0418835005693184575==--
