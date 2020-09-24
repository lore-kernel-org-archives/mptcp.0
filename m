Content-Type: multipart/mixed; boundary="===============4745410044682425793=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/4] tcp: move selected mptcp helpers to
 tcp.h/mptcp.h
Date: Thu, 24 Sep 2020 16:35:03 +0200
Message-ID: <20200924143505.27641-3-fw@strlen.de>
In-Reply-To: 20200924143505.27641-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6026

--===============4745410044682425793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be needed to fill in the MPTCP reset option from tcp_ipv4/ipv6.c.

It would make more sense to place mptcp_option() in mptcp.h, but
TCPOPT_MPTCP is defined in tcp.h, and mptcp.h is included from tcp.h,
not the other way around.  Placing the helper in mptcp.h thus results
in a build failure because TCPOPT_MPTCP is not defined.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/mptcp.h  | 10 ++++++++++
 include/net/tcp.h    |  5 +++++
 net/mptcp/protocol.h | 11 -----------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6e706d838e4e..5f5062580e0e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -68,6 +68,11 @@ static inline bool sk_is_mptcp(const struct sock *sk)
 	return tcp_sk(sk)->is_mptcp;
 }
 =

+static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
+{
+	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
+}
+
 static inline bool rsk_is_mptcp(const struct request_sock *req)
 {
 	return tcp_rsk(req)->is_mptcp;
@@ -153,6 +158,11 @@ static inline void mptcp_init(void)
 {
 }
 =

+static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
+{
+	return NULL;
+}
+
 static inline bool sk_is_mptcp(const struct sock *sk)
 {
 	return false;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 852f0d71dd40..ea8c134802e8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2406,4 +2406,9 @@ static inline u64 tcp_transmit_time(const struct sock=
 *sk)
 	return 0;
 }
 =

+static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
+{
+	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
+		     ((nib & 0xF) << 8) | field);
+}
 #endif	/* _TCP_H */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..e8c873c66182 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -130,12 +130,6 @@ struct mptcp_options_received {
 	u16	port;
 };
 =

-static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
-{
-	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
-		     ((nib & 0xF) << 8) | field);
-}
-
 struct mptcp_addr_info {
 	sa_family_t		family;
 	__be16			port;
@@ -486,11 +480,6 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *m=
sk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 =

-static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
-{
-	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
-}
-
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
 	return (__s64)(seq1 - seq2) < 0;
-- =

2.26.2

--===============4745410044682425793==--
