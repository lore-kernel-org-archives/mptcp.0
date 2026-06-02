Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185C362120
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367602; cv=none; b=fi000w7qBZ6/SD4k8w6Uj7+lRg0pImG1xln7x6P6R3Aht1Ch7sVksV+gwrHgIg6jUcB9uDYAizd3mN2SeMJoN1zJBEqVFbmNOg2ati/JcVVxe3R2XRpPNW+4lMEvptQxNsBwanosQCZO7bvWkkSQIupx9Bu0Abyo9bdd8aPxEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367602; c=relaxed/simple;
	bh=EZRqF6eE9zEwYBVGPqqRDvTyGjmL25NcAp2roqLcPNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFRMwwjCPCWwcv+/KayL1rJ1m79AgjFZkm7GEGz6+iGFfMb3iwqwsJUuceEE/6Q2r5EzcEGxFSscc1Kq3+EAowR6B4Rld2aeOyDjPjJnUevu+I7yR59ZnfiI/b3PB4Biz1LDCV/ie30tI5DYLCuIzQPN93J8UjbbcGt35yIRIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVfz3Dw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVfz3Dw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99C81F00898;
	Tue,  2 Jun 2026 02:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367601;
	bh=jw+BUPncgkSN+kg2iVhsourrdt2Sz8wQXostv6EkgbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kVfz3Dw+FTldw5qIddOqOBeV86NRsE1TQNYcxWICnBIFLMWrn7bKNqJRgyuz/8LS2
	 F+CJyIBnP2EQAsWQKZgCawWjfusFRix+GTeFTf7EEuA1ElLgwUVCsmpodPgd/+6i1r
	 g1Ap3pWe9LHT4xkyZp3QbbrKc/+yQ13l3Cvq/xpCmXJgGOn9juJbIvXCiTmgNCd0oC
	 ON7MMTJboYfHx1fcyPg/1rYkHUUBW7S8scBtJQbDitAzIa7gdkuC1/Z/nUCuqsJUbb
	 ILvWp3RD/nV93Hf1Mm83f5hIk00cZxrHWFHt7YFO5wnsdhkd/tng2DZwP9t7T6TpAg
	 jmjT1t1T7Nafg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 07/16] mptcp: implement ulp getsockopt for tls support
Date: Tue,  2 Jun 2026 10:32:48 +0800
Message-ID: <2e60d214719247d2e0919d25006f0cc16fa76029.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
2.53.0

