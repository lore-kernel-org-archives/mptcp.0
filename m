Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46C70
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 10:23:18 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1lebA5-0001Q2-Eg; Thu, 06 May 2021 12:23:17 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 6/8] tcp: export timestamp helpers for mptcp
Date: Thu,  6 May 2021 12:22:41 +0200
Message-Id: <20210506102243.2390-7-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506102243.2390-1-fw@strlen.de>
References: <20210506102243.2390-1-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP is builtin, so no need to add EXPORT_SYMBOL()s.

It will be used to support SO_TIMESTAMP(NS) ancillary
messages in the mptcp receive path.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/tcp.h |  4 ++++
 net/ipv4/tcp.c    | 10 ++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d05193cb0d99..e668f1bf780d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -412,6 +412,10 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 		int flags, int *addr_len);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
+void tcp_update_recv_tstamps(struct sk_buff *skb,
+			     struct scm_timestamping_internal *tss);
+void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
+			struct scm_timestamping_internal *tss);
 void tcp_data_ready(struct sock *sk);
 #ifdef CONFIG_MMU
 int tcp_mmap(struct file *file, struct socket *sock,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e14fd0c50c10..ad18c3ab1e17 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1738,8 +1738,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_set_rcvlowat);
 
-static void tcp_update_recv_tstamps(struct sk_buff *skb,
-				    struct scm_timestamping_internal *tss)
+void tcp_update_recv_tstamps(struct sk_buff *skb,
+			     struct scm_timestamping_internal *tss)
 {
 	if (skb->tstamp)
 		tss->ts[0] = ktime_to_timespec64(skb->tstamp);
@@ -2024,8 +2024,6 @@ static int tcp_zerocopy_vm_insert_batch(struct vm_area_struct *vma,
 }
 
 #define TCP_VALID_ZC_MSG_FLAGS   (TCP_CMSG_TS)
-static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
-			       struct scm_timestamping_internal *tss);
 static void tcp_zc_finalize_rx_tstamp(struct sock *sk,
 				      struct tcp_zerocopy_receive *zc,
 				      struct scm_timestamping_internal *tss)
@@ -2196,8 +2194,8 @@ static int tcp_zerocopy_receive(struct sock *sk,
 #endif
 
 /* Similar to __sock_recv_timestamp, but does not require an skb */
-static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
-			       struct scm_timestamping_internal *tss)
+void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
+			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	bool has_timestamping = false;
-- 
2.26.3

