Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B633067C
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053277; cv=none; b=BFnxxc1lKfJo5fTfxcSAL3q+kXHwm89+/mml20HXrgbHKvepaTG0KYFn0Si614D6hYqKkdSnezuGejHhZS/98nEVdF79GXC0rDtkGynwNHBzRNaF2oMg1lJrUnhKE4JPaDT3AO4dSlgDcPjZ3UGGHN9r72IFdQdy8k3DTf2MGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053277; c=relaxed/simple;
	bh=2tNQdD1kXfIsy4s4UFB9qunJ7bSr3lm/j3H96tIJnLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjTkVgseOfTk2EqSA74nLdICe2MdMuWnyJZb7+Fp+TPBTLiZIBU0xjMOEPjrVjrrMwsytHwtebJ1hrEldz+vnp6YexpWeQQJNbu09rnXTXVITXf1sevs0xP6SDySbhfVf0ehnjuqq3UCtBJUZ5X4g/+3dcWFrTeRaBK7IVXOROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jukfZACi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jukfZACi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8425D1F00898;
	Fri, 29 May 2026 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053275;
	bh=/+VUjgRwlW8blQRoopxGUb+8YI6yAg4UUKp5tj2bSSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jukfZACicN8I0p8cD7e7bd7XQKf5qF/zS2eN6E8gioJ01VuEVD/c9FD8G7YR+jhOW
	 441pSEZDmFSMCzWdWcVOmpScdWnnqviou8si5QWWCh1M9nqATel0ycOmKW7o3ukduK
	 MVeOzxTre+kjSywv9duiKx0cBoEca8kYUJVDvqsQY2a7BGFLEfPX/xmrhKvxF9Dsoc
	 hxuua1rAMzOYHAb2eVa0PMYPBz7HoDORMIk+k0fjswdC1s2rUK+JB07pgsmobLJt3g
	 BH2h2ZRDl+PkdMnL17CsdXwnqH8i6eeYqcj0Bs4pFp1F1cLoOLNfeBOncb4GJAYrYY
	 gsBMEo4TR/R2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v22 11/20] mptcp: update ulp getsockopt for tls support
Date: Fri, 29 May 2026 19:13:53 +0800
Message-ID: <6bbf75e80cf5a8ff65fdd97a8918e7906037a3c4.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Export tcp_sock_get_ulp() helper and use it in MPTCP to get the ULP name
of the MPTCP socket itself, replacing the previous approach that returned
the ULP of the first subflow via mptcp_getsockopt_first_sf_only().

Add mptcp_getsockopt_tcp_ulp() which acquires the socket lock before
calling the helper, ensuring safe access to icsk_ulp_ops.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/linux/tcp.h |  2 ++
 net/ipv4/tcp.c      |  4 ++--
 net/mptcp/sockopt.c | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 8a6807082672..662a7de907e6 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -653,6 +653,8 @@ void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
 int tcp_sock_set_user_timeout(struct sock *sk, int val);
 int tcp_sock_set_maxseg(struct sock *sk, int val);
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval,
+		     sockptr_t optlen);
 
 static inline bool dst_tcp_usec_ts(const struct dst_entry *dst)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 413807e1be75..ed9f8c27ace1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4486,8 +4486,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	return stats;
 }
 
-static int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval,
-			    sockptr_t optlen)
+int tcp_sock_get_ulp(struct sock *sk, sockptr_t optval,
+		     sockptr_t optlen)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	int len;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..b7eccade1f90 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1408,6 +1408,25 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_tcp_ulp(struct sock *sk,
+				    char __user *optval,
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
+	ret = tcp_sock_get_ulp(sk, USER_SOCKPTR(optval),
+			       USER_SOCKPTR(optlen));
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1415,6 +1434,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.53.0

