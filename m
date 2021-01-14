Content-Type: multipart/mixed; boundary="===============6982338583027921850=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/5] mptcp: add
 mptcp_pm_should_add_signal_send_ack helper
Date: Thu, 14 Jan 2021 13:40:19 +0800
Message-ID: <05676dcdd1fe45f8776a5a605930c87a264edff7.1610602400.git.geliangtang@gmail.com>
In-Reply-To: cover.1610602400.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7369

--===============6982338583027921850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper function named
mptcp_pm_should_add_signal_send_ack, in it put together all the
mptcp_addr_signal_status which need to send out a dedicated ADD_ADDR
packet.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    | 3 +--
 net/mptcp/pm.c         | 3 +--
 net/mptcp/pm_netlink.c | 3 +--
 net/mptcp/protocol.h   | 6 ++++++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 331d460d82fa..0c55795a8692 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -611,8 +611,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	bool port;
 	int len;
 =

-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk)) &&
+	if (mptcp_pm_should_add_signal_send_ack(msk) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions =3D 0;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 01a846b25771..c22a43b20323 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -191,8 +191,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 =

 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
-	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
-	    !mptcp_pm_should_add_signal_port(msk))
+	if (!mptcp_pm_should_add_signal_send_ack(msk))
 		return;
 =

 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5a6d4753fba8..ed4231efa822 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -493,8 +493,7 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 {
 	struct mptcp_subflow_context *subflow;
 =

-	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
-	    !mptcp_pm_should_add_signal_port(msk))
+	if (!mptcp_pm_should_add_signal_send_ack(msk))
 		return;
 =

 	__mptcp_flush_join_list(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93afa4c1dd76..adcc3a81c8af 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -618,6 +618,12 @@ static inline bool mptcp_pm_should_rm_signal(struct mp=
tcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 =

+static inline bool mptcp_pm_should_add_signal_send_ack(struct mptcp_sock *=
msk)
+{
+	return mptcp_pm_should_add_signal_ipv6(msk) ||
+	       mptcp_pm_should_add_signal_port(msk);
+}
+
 static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool =
port)
 {
 	u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
-- =

2.29.2

--===============6982338583027921850==--
