Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6F43F0A7
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060966; cv=none; b=TWOVRNPyYiUTS69ecELLQAVn7IWliqU7VoAhYZEFBmezllgtPi4Gdpr30npOVh9kKD7uNSwo6vLcMW8oq7mYULZpjhSv0+0I7nUjb+eOe4+a3tkoa7i5QhrvExIIkofE5HMktvHx/fQhhrvcXIIcHzYNAChj5EchZiN9GaeW1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060966; c=relaxed/simple;
	bh=xBz/1HomzZi1xkneY+MYlJTusdVa4kphXZ8RVh3kkPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOBg4bgGdWhZ+7+q1MGCqhx2mBdnMW3hXNPOJfMX6SXpi+1Utw/stM9MLu17C8U8Dp+ZN8UYc19zL+e/+YDgnejaMfbdLGXGFc7dCj8XDJF2AwkwxwUcS45uLcFcyJOqe6fJQzF5oA2CGPFVAEZj3u13ZwPPdG3wCLE3krTVUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWuu9nar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWuu9nar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CA81F000C5;
	Thu, 15 Oct 2026 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060965;
	bh=1lqA5IWbmJYAFcnC+QyK0kEawrNiswlVLmX7kOn2vlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWuu9narrHyo3+b4+BBAiuSNmdhX8YSFUkkw5zR5rTI2VE7Gs0Ikkm5lWctsRzq6t
	 MavRWEZEaLObDwP6/2WrWyijJ+1e/2jxOXkGbntkG5fXkFEVSRJWUWHJ6n34QnLMi4
	 Wfy40STf5NSxQ7IiDLY1tmOGSoCL8CZDz92YJp73jKd2bSjY7rfKWcltJ7Erbxsv4f
	 9o2eHWbLA6+2lA3Wh3/o1PkOmLByfom8TYtJhFqhT1Ai5DDDmmLjAA34xXMQAY2jb9
	 dLeqKDFqjsZWdbvnIR1UVhxm5DJBm7GDPA9K7VEeqUwzKGWT9AAdqKoPs45IrXTiLG
	 hBChO4atrKBPw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: give MPTCP sockets a distinct lockdep class
Date: Thu, 15 Oct 2026 18:42:36 +0800
Message-ID: <23c5f34fa80bff87b4c49981b1ab19d13bf7f136.1792060837.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792060837.git.tanggeliang@kylinos.cn>
References: <cover.1792060837.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP sockets and their subflows share the same k-sk_lock-AF_INET
lockdep class. When both are kernel sockets, lockdep flags every path
that holds the MPTCP socket lock and then locks a subflow (setsockopt,
connect, bind, worker send-ack) as "possible recursive locking".

Reclassify the MPTCP socket lock in mptcp_init_sock() to use a distinct
lock class (sk_lock-AF_INET-MPTCP for IPv4, sk_lock-AF_INET6-MPTCP for
IPv6). This approach is similar to nvme-tcp and avoids the need to
reclassify each subflow socket individually.

The implementation is based on nvme_tcp_reclassify_socket() from
drivers/nvme/host/tcp.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 60cbd91be632..e63896a60595 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -56,6 +56,41 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions) = {
 };
 static struct net_device *mptcp_napi_dev;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/* distinct lockdep class for MPTCP sockets */
+static struct lock_class_key mptcp_sk_key[2];
+static struct lock_class_key mptcp_slock_key[2];
+
+static void mptcp_reclassify_socket(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
+		return;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET-MPTCP",
+					      &mptcp_slock_key[0],
+					      "sk_lock-AF_INET-MPTCP",
+					      &mptcp_sk_key[0]);
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6:
+		sock_lock_init_class_and_name(sk, "slock-AF_INET6-MPTCP",
+					      &mptcp_slock_key[1],
+					      "sk_lock-AF_INET6-MPTCP",
+					      &mptcp_sk_key[1]);
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+#else
+static void mptcp_reclassify_socket(struct socket *sock) { }
+#endif
+
 /* Returns end sequence number of the receiver's advertised window */
 u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
@@ -3292,6 +3327,8 @@ static int mptcp_init_sock(struct sock *sk)
 	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
 	sk->sk_write_space = sk_stream_write_space;
 
+	mptcp_reclassify_socket(sk->sk_socket);
+
 	return 0;
 }
 
-- 
2.55.0

