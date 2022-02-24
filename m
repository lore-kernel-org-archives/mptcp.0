Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C219E7A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:50:25 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nNGNr-0005J7-Na; Thu, 24 Feb 2022 16:50:23 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 2/4] tcp: add mptcp join demultiplex hooks
Date: Thu, 24 Feb 2022 16:50:08 +0100
Message-Id: <20220224155010.23676-3-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155010.23676-1-fw@strlen.de>
References: <20220224155010.23676-1-fw@strlen.de>
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

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h | 12 ++++++++++++
 net/ipv4/tcp_ipv4.c |  7 +++++++
 net/ipv6/tcp_ipv6.c |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..b914e63afc13 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -197,6 +197,11 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 
 	return htonl(0u);
 }
+
+static inline struct sock *mptcp_handle_join4(struct sk_buff *skb)
+{
+	return NULL;
+}
 #else
 
 static inline void mptcp_init(void)
@@ -274,14 +279,21 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 }
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
+static inline struct sock *mptcp_handle_join4(struct sk_buff *skb) { return NULL; }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcpv6_init(void);
 void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
+
+static inline struct sock *mptcp_handle_join6(struct sk_buff *skb)
+{
+	return NULL;
+}
 #elif IS_ENABLED(CONFIG_IPV6)
 static inline int mptcpv6_init(void) { return 0; }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
+static inline struct sock *mptcp_handle_join6(struct sk_buff *skb) { return NULL; }
 #endif
 
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d42824aedc36..feb779d1fd21 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2155,6 +2155,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
+	sk = mptcp_handle_join4(skb);
+	if (sk)
+		goto process;
+
 	tcp_v4_fill_cb(skb, iph, th);
 
 	if (tcp_checksum_complete(skb)) {
@@ -2201,6 +2205,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 							iph->daddr, th->dest,
 							inet_iif(skb),
 							sdif);
+		if (!sk2)
+			sk2 = mptcp_handle_join4(skb);
+
 		if (sk2) {
 			inet_twsk_deschedule_put(inet_twsk(sk));
 			sk = sk2;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 749de8529c83..2f7a621aa24d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1800,6 +1800,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
+	sk = mptcp_handle_join6(skb);
+	if (sk)
+		goto process;
+
 	tcp_v6_fill_cb(skb, hdr, th);
 
 	if (tcp_checksum_complete(skb)) {
@@ -1849,6 +1853,9 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 					    ntohs(th->dest),
 					    tcp_v6_iif_l3_slave(skb),
 					    sdif);
+		if (!sk2)
+			sk2 = mptcp_handle_join6(skb);
+
 		if (sk2) {
 			struct inet_timewait_sock *tw = inet_twsk(sk);
 			inet_twsk_deschedule_put(tw);
-- 
2.34.1

