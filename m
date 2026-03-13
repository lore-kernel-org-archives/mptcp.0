Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A12F5A34
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366207; cv=none; b=W6nyHXtOjv3InVSfrbxbUIho+50AnOCimz3xpcfGldZsQAvwY7vv47nK4h03ppg3nxNUyct5d2UmFCO+NMS+QukJ23e6vCxST25x3iPbMvq0KdDSLtGRk2uOfOVWyBBCQuF0RQ2D44cAAcdan5SajSGN4FOOIyzFD/6SB74Gpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366207; c=relaxed/simple;
	bh=VqtC2nHB/FD4IihVVuPM2Gu6f59yiNCOfOu1IMYHtxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oErKiKBaew2qtP+7b2YSe72RcTzCoyIKnxTzLCEGVaYUZKsOgC7Dw0ukcPSjNpbMu2/zmjmnewYkMsM+z2IIRHyRCGDSOuP0hEge4I73e+21WhCc86tc1hGwiMNtm7G0bN+DtW8rf3o3F9640UVYIRsRKb2JkS+JTpKRlyNlppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYY0/16r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYY0/16r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE01C116C6;
	Fri, 13 Mar 2026 01:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366206;
	bh=VqtC2nHB/FD4IihVVuPM2Gu6f59yiNCOfOu1IMYHtxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYY0/16r47AeU3aBjQG6LnLuDXgMz/owPs25pLuZxSd5hwfXJ7WohNWT6yJ4bXGwO
	 PkODGxanfpH1dEYN5ltY3yp14T9VkBpHqsIBES0/NYBEqr9C4rrKgk543GNbh7bLAV
	 rIcbqd3QqQJYgH7bpyc0oX5aDyy9YQl+tl26m1ROeRucaOWNnQXX4gJMQu9g9gpUA/
	 +qiesIykQLRGmGizAgVfKh3InXDBBIJVD2Lf6NIwHK6a+Qzc8GgkkUb3ZSJQKEOmVB
	 YmuXueyMcpHjFAWjcbE3/qeVRaZZooVJdLG9XpEtVh5Brvio5m9g0fzd0pOmaSe+iP
	 zDGUk3to30B4Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 07/10] mptcp: update ULP getsockopt
Date: Fri, 13 Mar 2026 09:42:49 +0800
Message-ID: <f7eff92572a249450939d43e4bd6d29ad07c61c5.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sockopt.c | 12 ++++++++++++
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index c44cf9ae8d16..2e673f7b10ef 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -643,6 +643,7 @@ void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval, sockptr_t optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 400f84f193a3..63b576eebae6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4494,6 +4494,27 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
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
@@ -4603,20 +4624,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
index de90a2897d2d..a6230f7910fd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1393,6 +1393,17 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_tcp_ulp(struct sock *sk, char __user *optval,
+				    int __user *optlen)
+{
+	int ret;
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
@@ -1400,6 +1411,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.53.0

