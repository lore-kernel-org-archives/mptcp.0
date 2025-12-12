Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B00280325
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506454; cv=none; b=J0j/aSDZn4VHPzLOPLP4y6QyYE2HK31kOxvf3v2vf6O3eIeeSCjuuGdO5iiip75/boHYbkLZrlDOX6J02fyST2kEZwiBeianfEA0Dy2ncTGapVxU3bIARU6F6Q/KOq4h0mb7y4jGw6A/TES6ZgtfhFicUcfiLqmlAJ7LVU99DEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506454; c=relaxed/simple;
	bh=30WZMJrW/MDsMp6d1QZIUgVuLiZyeCvfaCRlhJzlCOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egHEWgBNlXG4ibvOm5wCD7Zgj18CGFyTWkF6H7kA4WktOznoGaDxe/HfOK/sdfEakU0AnpVDzjKPsbMFhVO2VmB1cuiVogSJBdSKi5jQJnznAm0XMtpkbNetCkAY6NYEjedi9Ibb6i4MrzwigWn/bdWahur+UdPRZXIgvkTTUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpsg/iil; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpsg/iil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8AEC113D0;
	Fri, 12 Dec 2025 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506453;
	bh=30WZMJrW/MDsMp6d1QZIUgVuLiZyeCvfaCRlhJzlCOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpsg/iil1vsvzJoHl++UrWtv07Cv7KO2NFCNfP6SAq5RRem2JkGOraKVpAEx4QAW4
	 JnJ53GwWyBIjRpt2t4Q1vUQwr05MX273kyUziWsX0Quo3TmC3mejMGkhPZ8HuLbG+J
	 JOxanR69vF9+vb80tt1vwFZZnf8n8kxvm0btcelAQyunSyYwljz75f0rzpHqZ5f27w
	 ORYYToHcqGg3lXI+eSIFGr/gfUQ6hn+Kb5xT//plX0ycBa7G5d4DE2xwQSUYMxrGXX
	 uWtd1/AiTdipOyaQyc/mLnvY0Bmb2CJFQBTPTBiT3AlBeJ8a56Etzfn6ufuSlivvWV
	 nYz5i3xMTvoZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 04/10] tls: switch to mptcp_sendmsg_locked
Date: Fri, 12 Dec 2025 10:27:14 +0800
Message-ID: <cdbbb7feddc199b39f31c8f74b8f3933fb964ee4.1765505775.git.tanggeliang@kylinos.cn>
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
helper mptcp_sendmsg_locked() has been exported into net/mptcp.h.

TLS implementation switches between the respective TCP and MPTCP helpers
based on the detected protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  8 ++++++++
 net/mptcp/protocol.c | 16 ++++++++++++----
 net/tls/tls_main.c   |  4 +++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4c8e483fcc4b..cdb726865486 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -256,6 +256,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 
 unsigned int mptcp_inq(const struct sock *sk);
+
+int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len);
 #else
 
 static inline void mptcp_init(void)
@@ -352,6 +354,12 @@ static inline unsigned int mptcp_inq(const struct sock *sk)
 {
 	return 0;
 }
+
+static inline int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg,
+				       size_t len)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 82a3b3c70ad1..feac59a92b32 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1884,7 +1884,7 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
-static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
@@ -1895,8 +1895,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	/* silently ignore everything else */
 	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
 
-	lock_sock(sk);
-
 	mptcp_rps_record_subflows(msk);
 
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
@@ -2004,7 +2002,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		__mptcp_push_pending(sk, msg->msg_flags);
 
 out:
-	release_sock(sk);
 	return copied;
 
 do_error:
@@ -2015,6 +2012,17 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
+{
+	int ret;
+
+	lock_sock(sk);
+	ret = mptcp_sendmsg_locked(sk, msg, len);
+	release_sock(sk);
+
+	return ret;
+}
+
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
 static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 56ce0bc8317b..18c767b7388d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -194,7 +194,9 @@ int tls_push_sg(struct sock *sk,
 		bvec_set_page(&bvec, p, size, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
 
-		ret = tcp_sendmsg_locked(sk, &msg, size);
+		ret = sk_is_msk(sk) ?
+		      mptcp_sendmsg_locked(sk, &msg, size) :
+		      tcp_sendmsg_locked(sk, &msg, size);
 
 		if (ret != size) {
 			if (ret > 0) {
-- 
2.51.0

