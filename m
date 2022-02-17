Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368A291C
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 14:25:57 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nKhjI-0004Ds-3j; Thu, 17 Feb 2022 15:25:56 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2 3/5] tcp: add mptcp join demultiplex hooks
Date: Thu, 17 Feb 2022 15:25:36 +0100
Message-Id: <20220217142538.7849-4-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217142538.7849-1-fw@strlen.de>
References: <20220217142538.7849-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split from the next patch to make core tcp changes more obvious:
add a dummy function that gets called after tcp socket demux came up
empty.

This will be used by mptcp to check if a tcp syn contains an mptcp
join option with a valid token (connection id).

If so, a hidden pernet mptcp listener socket is returned and packet
resumes normally.

This patch series does not cover timewait sockets so far.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h | 5 +++++
 net/ipv4/tcp_ipv4.c | 4 ++++
 net/ipv6/tcp_ipv6.c | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..5ee422b56902 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -197,6 +197,10 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 
 	return htonl(0u);
 }
+static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb)
+{
+	return NULL;
+}
 #else
 
 static inline void mptcp_init(void)
@@ -274,6 +278,7 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 }
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
+static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb) { return NULL; }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6873f46fc8ba..6e6675a09443 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2140,6 +2140,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
+	sk = mptcp_handle_join(AF_INET, skb);
+	if (sk)
+		goto process;
+
 	tcp_v4_fill_cb(skb, iph, th);
 
 	if (tcp_checksum_complete(skb)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0c648bf07f39..788040db8e9e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1782,6 +1782,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
+	sk = mptcp_handle_join(AF_INET6, skb);
+	if (sk)
+		goto process;
+
 	tcp_v6_fill_cb(skb, hdr, th);
 
 	if (tcp_checksum_complete(skb)) {
-- 
2.34.1

