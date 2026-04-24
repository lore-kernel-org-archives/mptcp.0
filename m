Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADB38B7C4
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027148; cv=none; b=rUxFHMQldQ1fBjVgSrdTvAZMQ8WcXfRLCapSwsR8YRA+Of13/qnhKGCstES8drqIGU5eCYr+LqiV05mFl36TI4SDiIacJBZqqi5mDoM6LF0sjqX7dYcjaAT4opP+W9mLDKRoXPZFsWqSqFfUOIeuiWNivc7xM0f6+jSR8UegUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027148; c=relaxed/simple;
	bh=LXrRTTvOvKuOZAqDo3RHueQZ8wr9t9UJr2f0b48KETE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxgMAQgYZ5n/S0N/LY/I/i+Ecp3KhsvYyJgB/YUSuxjWXLHGk+ZMosQBf083j6bO+Ql/DGtg0AIk7mSkDfmWgUnbEgInKYgO0N7LDvwsUDEAQl3+t01L0xwrW1MQ0/0Yu7P2tbG6Zb/ZChFQhHA1RR6Aa3TiCkltK5iJb8akM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDvBwa8Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDvBwa8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31826C2BCB4;
	Fri, 24 Apr 2026 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027147;
	bh=LXrRTTvOvKuOZAqDo3RHueQZ8wr9t9UJr2f0b48KETE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UDvBwa8YHC3/bBS1/rTwDaHIAFnfSSMXQRwk3U3HjdbgQ6rCDJ102x58xvl5Qaipw
	 AeDKx2DL6GuJJt3IrHH454ZxbRHJQGeyAPRj+9+jdpHIlM7uFnlGV4x32nXyKx/CgA
	 LR/EPP0QXpy0mDL5yuY7Dml9EbL39aMt3a85CbzmZpLvLIno2oWW7l6Dhm7SO1LNWo
	 fuTTqLO0tzazYECbQV+wALyakHJM2PtZChTwpSnvD7VijEnLCkdWCaJybugTr6VbJj
	 Rg//XivFfdO2i7OADDMTUyOCcxWdVsLpG5NxRA7zFDWC5iNUhnus+e4DKVJGDHxmda
	 9ahf9/LMRTehQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 07/15] mptcp: update ulp getsockopt for tls support
Date: Fri, 24 Apr 2026 18:38:31 +0800
Message-ID: <d6e76a8bd97d62ebd09e8c158beecb715c04f3e3.1777026753.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777026753.git.tanggeliang@kylinos.cn>
References: <cover.1777026753.git.tanggeliang@kylinos.cn>
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
index 8ae79c5036d1..442c3cae0fa7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4489,6 +4489,27 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
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
@@ -4598,20 +4619,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
index 79db15903e7a..11e071b0994e 100644
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
2.53.0

