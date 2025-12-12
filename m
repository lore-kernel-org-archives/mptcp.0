Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884A7261E
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506456; cv=none; b=IOoAnee9OI6CGNpuzSI6g+olSfCebSzlbdJHKazyn7qnKFA51VZHc/ziu47ZZorM4589bcvb6cGNLieg8YCCS4m8r2D4TzO3O0vao+V407VOaXfEqLsMe9v2DV2wF7QLAa2jELDs0x0qydd9s12jtS9YGB2bmpr3AB2TYc2xSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506456; c=relaxed/simple;
	bh=ls47YC+lfCmfLAXQU+GID+bhSte7qT9N4Ef6qxZksI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnolgoMYhHqFRuscZWtKC7iS4+SUVG3ja2gtx3R4/iTb62BHKbWcN1f9xGWvmQ5mj0sD29gSuGYth0O1Cf5KpgfuKknCTHCqbCcMUt/DLg9KsAsbdG9osutHVYo4K2bLbc2CU9g6gdIXiPmQg2HdTmnx3XajuVDOHTfR+icAPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8IOS7Kh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8IOS7Kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C4EC113D0;
	Fri, 12 Dec 2025 02:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506455;
	bh=ls47YC+lfCmfLAXQU+GID+bhSte7qT9N4Ef6qxZksI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8IOS7KhvvgJFh9o5jEim8sc2zfz2CNDbH/JvQDr+1BoePIpmvLKsCWzSepHypYkL
	 kxsM7kF5WIYMdtyodDA/voHH4J4FRZeX2+bAT5o3DleywUdnqLtz8wSH/Qafho4yE5
	 MZAkQB6Qg79x1Pn860Oa6eFd+Y5Sc9QxtyZtVwjd0tTXKHZsu8IsBZfeN0F8gO5dmo
	 Nm3ni+yt/AXl1cOW9/t6RqoiYHuIYf3wtZAnBLiq7ccYBozfEaGRGugVxtOIdWHvDp
	 V4YNlsQB9xCAqxYr8b1u31O3RGVW4xamL0OOBGAI6f9gKSSNkrea/Os4T5a0SoT3W2
	 F3sCCmgOiy83A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 05/10] tls: switch to mptcp_recv_skb
Date: Fri, 12 Dec 2025 10:27:15 +0800
Message-ID: <19c737895c462fd53849197f1c19b00e93c12bb5.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, corresponding MPTCP-specific
helper mptcp_recv_skb() has been exported into net/mptcp.h.

TLS implementation switches between the respective TCP and MPTCP helpers
based on the detected protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  | 7 +++++++
 net/mptcp/protocol.c | 2 +-
 net/tls/tls_strp.c   | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index cdb726865486..3fe60818cada 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -258,6 +258,8 @@ void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 unsigned int mptcp_inq(const struct sock *sk);
 
 int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
+
+struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off);
 #else
 
 static inline void mptcp_init(void)
@@ -360,6 +362,11 @@ static inline int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 {
 	return 0;
 }
+
+static inline struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+{
+	return NULL;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index feac59a92b32..92141e87ed25 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4340,7 +4340,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
+struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb;
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 0639130b8d5e..3bddb871d90b 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -468,7 +468,9 @@ static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 	struct sk_buff *first;
 	u32 offset;
 
-	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
+	first = sk_is_msk(strp->sk) ?
+		mptcp_recv_skb(strp->sk, &offset) :
+		tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
 	if (WARN_ON_ONCE(!first))
 		return;
 
-- 
2.51.0

