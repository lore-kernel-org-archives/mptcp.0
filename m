Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664F248F47
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767519325; cv=none; b=prHfnVLq4CPI/wSIPjY5HdQCQMdDsE2pGYOyY5yAuO694QW2xEp+SeUcLg9LT+coqbOAoHKMJkP9er6MtOLfHBU/2ddR0YVkEReb9+w6X4aV5yWBfDCMg8NgS8j/TohFm64eCYB84Pwq8uj3SObzlTu78k+SE5B12FdQAFkXfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767519325; c=relaxed/simple;
	bh=iQjqsr6LyciaGbmny8udIYflydJoVM/BTsfKQtq23gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDyFFqihCi/vlPevkgjxD9q90X8eLaGtRWBCogIBdecQXBh7V7WPSbwPvFf8eK1Cxp4Drb9246aij9m6ptgrMqFpSuZOqb8RMdAyFtwC72xpru0gqj2Fip4RfD7raBW6HfAHnSQ90yKYZQ537tAWbTa1dVECA66TGcECnixXpds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irII4EL2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irII4EL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28807C4CEF7;
	Sun,  4 Jan 2026 09:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767519324;
	bh=iQjqsr6LyciaGbmny8udIYflydJoVM/BTsfKQtq23gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irII4EL2p8/Yy1Or5/BVmFcjD6IUbQvguzk+0cZ6UvTn8lDa4B0cjer2Gettipvnf
	 rgw1Co+soUUfN/Sej2KeIjrsitRPt5S9XKY7d1zDspEjlCqy6RFPVAcfOAUqFFQXta
	 SctWNjGlYRCQnKL7GLQ1AYBDIm7yWySnDPEp0NGpFJvCzJ4xspPnKIMv5etT7X0zc1
	 9Hts/vwjZS9pHS/oIJwr6Y0JRYoV+yWsNjVJHPxRujnhx2NZwGIILAHiPvmc6Z+tsG
	 WPRB7EBX5o3HT7k0s0InLaxjsgUAMdknb6t0OuNIyoJb3TzKzEi6JTmo8AiaYokd9e
	 Q67CW0sQjkUxg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 04/10] tcp: extract sock_get_ulp helper
Date: Sun,  4 Jan 2026 17:35:05 +0800
Message-ID: <2e3f1bec789ab1685d4ffc41609b95adb770e2ff.1767518836.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767518836.git.tanggeliang@kylinos.cn>
References: <cover.1767518836.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the TCP_ULP getsockopt operation into a tcp_sock_get_ulp() helper
so that it can also be used in MPTCP.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 36 ++++++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..6f0becc26402 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -644,6 +644,7 @@ void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40ad9656dc9e..1ba5794574c7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4438,6 +4438,27 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	return stats;
 }
 
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	int len;
+
+	if (copy_from_sockptr(&len, optlen, sizeof(int)))
+		return -EFAULT;
+	len = min_t(unsigned int, len, TCP_ULP_NAME_MAX);
+	if (!icsk->icsk_ulp_ops) {
+		len = 0;
+		if (copy_to_sockptr(optlen, &len, sizeof(int)))
+			return -EFAULT;
+		return 0;
+	}
+	if (copy_to_sockptr(optlen, &len, sizeof(int)))
+		return -EFAULT;
+	if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
+		return -EFAULT;
+	return 0;
+}
+
 int do_tcp_getsockopt(struct sock *sk, int level,
 		      int optname, sockptr_t optval, sockptr_t optlen)
 {
@@ -4547,20 +4568,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		return 0;
 
 	case TCP_ULP:
-		if (copy_from_sockptr(&len, optlen, sizeof(int)))
-			return -EFAULT;
-		len = min_t(unsigned int, len, TCP_ULP_NAME_MAX);
-		if (!icsk->icsk_ulp_ops) {
-			len = 0;
-			if (copy_to_sockptr(optlen, &len, sizeof(int)))
-				return -EFAULT;
-			return 0;
-		}
-		if (copy_to_sockptr(optlen, &len, sizeof(int)))
-			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ulp_ops->name, len))
-			return -EFAULT;
-		return 0;
+		return tcp_sock_get_ulp(sk, optval, optlen);
 
 	case TCP_FASTOPEN_KEY: {
 		u64 key[TCP_FASTOPEN_KEY_BUF_LENGTH / sizeof(u64)];
-- 
2.51.0

