Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745937701C
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355824; cv=none; b=PkK6xrVneV1hbB1KvJpf/y+LkaHfHzVoZJFOa0JFAVVVan1hp2+2h2bBcyTZ0MQZVHD2YNwcNUCfemIPaAHgkZaTKXCJLB4505pJDvjg3CtTbnbKeTr8NDjurWBfLeeFoTM1JfvG2Umr0cijaHJ1CG44XUg0UwD8u/Mj0kw8oiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355824; c=relaxed/simple;
	bh=PRsRtQMbqPSJTuLPkh6J0qJ8JmoMlCxZRynscVYYKZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzDHaq2gM4poytw5NTPwdsvOPPno05QL3DaKPrdYJyAxKKnbpu2uSHIGxKQrXqQ/ER0xpoK9x82N4kd8IWRkLi1rDFO9rCAK3eWGjT2YPrMlVoKz2aUyhxDN3rz+W8QZt003iZVcHV85oIxbO504ix/pfpe2YlkT8tU1vx/nAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSENQgBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSENQgBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CEE1F00A3C;
	Thu, 21 May 2026 09:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355822;
	bh=yeBAIObCCD0rLzFh95LhJ65L8e7GY3s3EbDpIRbF86c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RSENQgBB2t6R556Kno+4MEPJonca7VcCP4/dHJFIdV48+BFvi+CJhxDX5ppJFlrLf
	 Q42NNL7H5fqrJ+JD5bSd84PA41ENcmkSTHeTgRvTfEMryN42hX6mfx95IIwhxCVm2V
	 j/gga6imeHwamq7+g11vlRuqeYpnSnt2C2tfC3pbaI9Qtibmoc7UL7bj0J9vy7RZuO
	 qmqS4NpE2j9uhz4qBJvyoZ3531tv4YvQek4bYOz34Rzy5dTg+HLkaAhmPW1D0EoVrV
	 vy6mjYGeig14yQW/w5phRKRJCGsdUUUAF6GD4Eu48SWtvUZByFf1D+CPNxYFwaBG36
	 K76AtY04JMwHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 07/15] mptcp: update ulp getsockopt for tls support
Date: Thu, 21 May 2026 17:29:45 +0800
Message-ID: <f0f4f3df67c9eaa7741f8b4f8991aaa06e27cdbd.1779355169.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779355169.git.tanggeliang@kylinos.cn>
References: <cover.1779355169.git.tanggeliang@kylinos.cn>
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
index 8a6807082672..0026b6798b2f 100644
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
index bdad459e6605..8e41ce029985 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4486,6 +4486,27 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
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
@@ -4595,20 +4616,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
index 87b5796d0135..ee1e71c178fa 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1403,6 +1403,23 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
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
@@ -1410,6 +1427,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.53.0

