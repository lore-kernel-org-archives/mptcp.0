Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB6264A97
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971593; cv=none; b=jErF+ekYnSgbQtIwmnQPuaFBkCxnS1He2hUF3DB6Tt8ReTCeu1f1ip/NWUldtVLLncbSx/giLQ7TebmHbzHTpXhInuB9Ts765PBtows2iKeA3hPn0g1JfikUe3aLHH4p1T5tOrCn7HZrzYp5cgnoY4GXA6Af0EgrRGz3oylWrx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971593; c=relaxed/simple;
	bh=bO6B+1SluKm3Fw4taOXgPM5SMlFY5aRwgTQ1l1lJoCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUe+6Zx4dUf4C2jrlujYWAeSQywCYTXfLmoZJ2HHBxL8dq3ENO6NRjbSMY1nVFyJiceE4WDD8aXBGSY6zuxbo+wuoSQxi14w5366ElfvcYhUx3Ln2PBfiMu8YTC/Al1OG5DPZzw20jmZTAfLkAusbNjG0qnX+1FOr78q9X6kAuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APMrcSCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APMrcSCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACFA1F00898;
	Tue,  9 Jun 2026 02:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971591;
	bh=O3IyzByKGZyq1ImxFokF6iMKoQ4GCf3i+PH0uhmv9pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APMrcSCuFqptwjz5Yc2y8mzksl37cr1dWKAYqT4Hkl5k9dfaD3UKwUNkwHzHhp2K6
	 Ub975pWTaJLbR9yW0srs5ZomINdjUcDxpd8zSk6pp+jyngyuj35XocrQtImx+fBAkX
	 VPYx/illT2o8sgFxWdsxLSR7/sHTrjQehdvM31wS4His0qd0HnHWEeYl6wKFqDOaHP
	 g7Nxt4DvxTngEgl5J2O00ZrPufsktSREzhvuXzTyj21mw+P3ngvo3P0DgnBBZCHrLN
	 pfp+tijPmQXcFXdeCTjqZZtiG3quc4g1ORpFHjw4QO24hIqVGhYrhjF1KDBWrE9USh
	 GY9hVPShS74mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v25 13/22] mptcp: implement ulp getsockopt for tls support
Date: Tue,  9 Jun 2026 10:18:39 +0800
Message-ID: <ad33553bf44ad3e3f1280fd16bfb8bb57038ea33.1780970284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_getsockopt_tcp_ulp() to handle TCP_ULP getsockopt on MPTCP
sockets. The helper reads the user length once, checks for negative
value, takes the socket lock, caps the length to TCP_ULP_NAME_MAX, and
copies the ULP name (or sets the length to zero if no ULP is attached)
to userspace. The lock ensures safe access to icsk->icsk_ulp_ops.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..cc45491cd3b2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1408,6 +1408,39 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_getsockopt_tcp_ulp(struct sock *sk,
+				    char __user *optval,
+				    int __user *optlen)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	int ret = 0, len;
+
+	if (copy_from_sockptr(&len, USER_SOCKPTR(optlen), sizeof(int)))
+		return -EFAULT;
+
+	if (len < 0)
+		return -EINVAL;
+
+	lock_sock(sk);
+	len = min_t(unsigned int, len, TCP_ULP_NAME_MAX);
+	if (!icsk->icsk_ulp_ops) {
+		len = 0;
+		if (copy_to_sockptr(USER_SOCKPTR(optlen), &len, sizeof(int)))
+			ret = -EFAULT;
+		goto out;
+	}
+	if (copy_to_sockptr(USER_SOCKPTR(optlen), &len, sizeof(int))) {
+		ret = -EFAULT;
+		goto out;
+	}
+	if (copy_to_sockptr(USER_SOCKPTR(optval), icsk->icsk_ulp_ops->name,
+			    len))
+		ret = -EFAULT;
+out:
+	release_sock(sk);
+	return ret;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1415,6 +1448,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case TCP_ULP:
+		return mptcp_getsockopt_tcp_ulp(sk, optval, optlen);
 	case TCP_CONGESTION:
 	case TCP_INFO:
 	case TCP_CC_INFO:
-- 
2.43.0

