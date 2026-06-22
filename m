Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513222425B;
	Mon, 22 Jun 2026 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125123; cv=none; b=kHMN/p7Ydj9wVmzUpxZlRe1sVufT7ZoJelDU3agPSuthIQ2SQ2P7H5WaIJJgTEoVzXvvkV2PZKNyOCLw1CZiud1X5zenTPfumOpaX0XAYEFMx/1guR32j3sS4pFvfdzRIvMdv3zifslXrza1w074se61EMis8/NRgF5GV6ODtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125123; c=relaxed/simple;
	bh=N/6VknjjXpbN1MD/FqnHTdAkw9Tm/5ZBaUYYE2rQ+nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTTz4SS6Yem6UhwiNU3RCx2ccwnSQRd3ew2TLhO11B8G5W9PBNpJHtRvlQjr+DnTq7SLTCT09nYxxCDj9XHGvHIUFdYJbD8WbuhzWt0FCYMEI18JMQaXjL5bFqKlmKduJiyrozZE3YmG3MM0cs9SJGzkK0n3P6VKrpOFX4Otj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O26V+GNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O26V+GNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B4A1F00A3A;
	Mon, 22 Jun 2026 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125122;
	bh=3nAMPLkbHtZkUggX5mvXpgfHri8dhjwekxzXl9N1Kro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O26V+GNvu+PIgRGPM32bn7o4/c2iFMNS4z7TvamYqFbZihAaJmEmi+Rvgy+bi+V5s
	 b8APqHraU69Dl+lJBCjGCclv9JVF6WHf8YleaUWYOHe58YeZFTbmGk3M5NuhqBml1o
	 xdiWLIaknxSMbqDjigFDKNCq/CQSEC4MObc29DyoErQ4TvMLoDdc6oWlrNhdpmBtsz
	 8SkpMEZHeDYalk+Do/00cmGYGF7ERt2IUIchZSeSEItS1lhJjd3R63bk/D6f1sISyI
	 gaOFkEUhu4IHn9n1IIuTnHCiIkNCm+SP9UPSqlcWT4Yh/WJiWwcKU6UwwbkgcvxBNi
	 5z/gprzQhPQmw==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 12/17] tls: add mptcp support for sk_poll
Date: Mon, 22 Jun 2026 18:43:32 +0800
Message-ID: <57bd0d017b79b2dd63ae71ed071dc946a00b63a2.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The tls_sk_poll() function currently uses tcp_poll() unconditionally
to obtain the base poll mask, which works only for TCP. This prevents
TLS over MPTCP from working correctly with poll().

Make the poll function protocol-aware by selecting the appropriate
poll function based on sk->sk_protocol. For TCP it calls tcp_poll(),
for MPTCP it calls mptcp_poll() (guarded by CONFIG_MPTCP). Any other
protocol returns 0.

Also export mptcp_poll() symbol so that the TLS module can use it.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  9 +++++++++
 net/mptcp/protocol.c |  5 +++--
 net/tls/tls_main.c   | 17 ++++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ba2257986b13..b0a172c38891 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -239,6 +239,9 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+__poll_t mptcp_poll(struct file *file, struct socket *sock,
+		    struct poll_table_struct *wait);
 #else
 
 static inline void mptcp_init(void)
@@ -316,6 +319,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline __poll_t mptcp_poll(struct file *file, struct socket *sock,
+				  struct poll_table_struct *wait)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f4cd7a6e5770..169bd468f212 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4446,8 +4446,8 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	return 0;
 }
 
-static __poll_t mptcp_poll(struct file *file, struct socket *sock,
-			   struct poll_table_struct *wait)
+__poll_t mptcp_poll(struct file *file, struct socket *sock,
+		    struct poll_table_struct *wait)
 {
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
@@ -4494,6 +4494,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
+EXPORT_SYMBOL_GPL(mptcp_poll);
 
 static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 170ccbb9d36d..fa9fda3480da 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -416,6 +416,21 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 		tls_ctx_free(sk, ctx);
 }
 
+static __poll_t tls_proto_poll(struct file *file, struct socket *sock,
+			       struct poll_table_struct *wait)
+{
+	switch (sock->sk->sk_protocol) {
+	case IPPROTO_TCP:
+		return tcp_poll(file, sock, wait);
+#ifdef CONFIG_MPTCP
+	case IPPROTO_MPTCP:
+		return mptcp_poll(file, sock, wait);
+#endif
+	default:
+		return 0;
+	}
+}
+
 static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 			    struct poll_table_struct *wait)
 {
@@ -426,7 +441,7 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	mask = tls_proto_poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
-- 
2.53.0

