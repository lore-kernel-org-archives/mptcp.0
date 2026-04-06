Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89A318EF6
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478011; cv=none; b=uajQEeVsVjuEn+ibG2wh8TJAm+mKnMoqr3t3zV8ZkJf1EBm7Pe0HKNFO0Bodpl9tj6nS1psqcfZYPHDREL2POkg6GdkkF7FWVkoJ34xv5xy/mgs+9n4EU3KqZ+TbzB8t3LLQwAqqaG3Dq2YKRQveiGGfX+zN3kU0gWXOHCuAWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478011; c=relaxed/simple;
	bh=jkRGq64Rf3n+mGcXg3lE8TykyXEweiZS76DCihu4OZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cneTvqRpb6rwO+d114yHFBEqqWC/GJR1x7/Z/AmXhmj7gmiDaH8k1nuDS8P+xMURizxhYrnhJkROsug8bwfLmrqLS8E+N1+vKw3y5EGZg2nbBAtbgJTNe38aleNT4h2ohrtfJvbgYezhvRVYXI+szZbQTKCKtTTJuRjBb0o+6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm+8Q+f9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm+8Q+f9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA727C19425;
	Mon,  6 Apr 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775478011;
	bh=jkRGq64Rf3n+mGcXg3lE8TykyXEweiZS76DCihu4OZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qm+8Q+f9Wa6ivfAj/0a8rt1yLkla2/O6+PRQjKBj74g/V2HUqTKPffjRqOz6VBIhw
	 RJbQ2Et6XxCh5Zl0GjA8gPL4zFV/ZH2md/hlG+sS6dC9/a5p4Jzndz2ww10g7MigfK
	 kp28IJzFjQM28vWGHWAF4JPOSKAFOjWrjTIu3Ba05yoHPhgSj0zn/RsV1rgs/rZEHg
	 uyby6wuE3MVYgypmNNHTFcz4yprmDo7sH5uSUUcQBiVT5/XDwUPyxfKhkAq5KGaOMQ
	 79bvLticwWfAsSD2UQDZa39ZSMvw0OcFdxR8UYbWubDIFhTtJhjxz+Xk4z1kvF1PQZ
	 Z+MKEKX42dIMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 07/15] mptcp: update ulp getsockopt for tls support
Date: Mon,  6 Apr 2026 20:18:47 +0800
Message-ID: <7a0590d4080526199545a59005ee0aa1b6478a3a.1775476921.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch extracts TCP_ULP getsockopt operation into a tcp_sock_get_ulp()
helper so that it can also be used in MPTCP.

TCP_ULP was obtained by calling mptcp_getsockopt_first_sf_only() to get
ULP of the first subflow. Now that the mechanism has changed, a new helper
mptcp_getsockopt_tcp_ulp() is added to get ULP of msk.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  1 +
 net/ipv4/tcp.c      | 36 ++++++++++++++++++++++--------------
 net/mptcp/sockopt.c | 18 ++++++++++++++++++
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6982f10e826b..2bb1cbd3eeab 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -653,6 +653,7 @@ void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4b8cf7ca2695..c3c6cd6ee95a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4473,6 +4473,27 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
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
@@ -4582,20 +4603,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index de90a2897d2d..59742c956154 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1393,6 +1393,23 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_tcp_ulp(struct sock *sk, char __user *optval,
+				    int __user *optlen)
+{
+	int ret, len;
+
+	if (copy_from_sockptr(&len, USER_SOCKPTR(optlen), sizeof(int)))
+		return -EFAULT;
+
+	if (len < 0)
+		return -EINVAL;
+
+	lock_sock(sk);
+	ret = tcp_sock_get_ulp(sk, USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1400,6 +1417,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.51.0

