Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2973337B97
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127449; cv=none; b=BsGxVSxW2T4KTBOCm0Wa1dSnHQDktev+a8JBc5adzNAFvHM18GlSh9Mkf9INi3iIYv+wghQTagOz/1tBuv0e31kt1lQdMz4RqWTPBUT3dnHp/p7xfkYuOLOpSrlJhBj80QiFkmdGewVVrrdiU1gHK6Id+sp3UygQIAnP8acNp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127449; c=relaxed/simple;
	bh=md2W6E8hUS9PSeCFZeer557QYxVMsIiNkuHALsVaBms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZjaaj7WPByh82JUamzI4jfbGIg/5RMZ4XY0M4iWDqNCZweCl+3bjpL+jeQ6znVytv6SeyDDOn9MXTtqSeDrF3BYl2cmO5ymT053tQY45+EJ6b6F4CivngrPHz+koocoFPE3uDWg8XJFz+BzSoxOJyZva8JGIrdilZglm7/zeE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpLH8o5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpLH8o5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF361F00893;
	Sat, 30 May 2026 07:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127448;
	bh=dh/9vtk0h6W+FRIK8g0S0seuCc09OIrdlemifKpOjUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LpLH8o5hkIVJhBrv6VOUXgGuNCp42oOJPw/65f/EUBst7C/fG5Z2NbTHqYqFMTmXx
	 2v/eSKgSuYUZz9DJxA1Gz6wNOTTQum8VdAE0ujBZc6EaLzcqPf+23QQfttivh6aieD
	 h6hvMd1tgisWZ+XJlPYmk8YZWUc9smQsYxnqTHhrFMSZHIJtKYLCuLVkLevrVWAhor
	 RDbzA/b0rvFO7ThUpWjZGc3qBedFJ6i9muxYbXPYY9gGAxWa3z7+EC2LfXFPoWb//S
	 0SAQyBSNlUleTUVBM/ySC8PIQOm7ZzkPx+1bGtkjBKhjk+OQ045kWUupDEZVd4UYdF
	 SITWCVpAlFibA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/5] tcp: add socket lock to TCP_ULP getsockopt safely
Date: Sat, 30 May 2026 15:50:10 +0800
Message-ID: <e212d4ab9b48976c108716223bed9150d49e7783.1780127277.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780127277.git.tanggeliang@kylinos.cn>
References: <cover.1780127277.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When handling TCP_ULP getsockopt, do_tcp_getsockopt() accesses
icsk->icsk_ulp_ops without holding the socket lock. A concurrent
connect(AF_UNSPEC) (or other operation that calls tcp_cleanup_ulp())
can set icsk_ulp_ops to NULL and release the module reference.
If this occurs between the NULL check and the dereference of ->name,
the kernel may access a NULL pointer or a stale pointer, leading to
a crash or use-after-free.

Extract the TCP_ULP getsockopt logic into a helper tcp_sock_get_ulp()
and wrap the call with lock_sock()/release_sock() to ensure the ULP
operation is protected against concurrent modification.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a058f350a759..c01f97d5dfe8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4481,6 +4481,28 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	return stats;
 }
 
+static int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval,
+			    sockptr_t optlen)
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
@@ -4589,22 +4611,14 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 			return -EFAULT;
 		return 0;
 
-	case TCP_ULP:
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
+	case TCP_ULP: {
+		int err;
 
+		lock_sock(sk);
+		err = tcp_sock_get_ulp(sk, optval, optlen);
+		release_sock(sk);
+		return err;
+	}
 	case TCP_FASTOPEN_KEY: {
 		u64 key[TCP_FASTOPEN_KEY_BUF_LENGTH / sizeof(u64)];
 		unsigned int key_len;
-- 
2.53.0

