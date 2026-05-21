Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F933372ECE
	for <mptcp@lists.linux.dev>; Thu, 21 May 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355822; cv=none; b=S7vH9bzS8dOZTbpBq5Ad3ImiQuijet49OnWNSsog+9kfy8/7CT6PI5G9oegbBnJN4de/v3hirgLy4M/4BUCjancEFQZNa72ik3mycSeTIgk3apHfbC78PbPCr5mFUwlnNZHlNbKEPbC0OAoWaCYPk2cIHxVizYQoHTXZL23bvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355822; c=relaxed/simple;
	bh=hrtN9uQddVM0lcmO9wc2o6AU3IK9pMQ70Z6iH5TPITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxJ9016VWBpSHL1g610jFCIY1KneqlV6N5AfR7p4dnml2kQuafc6oTlp/rbbDvHgdqe4iP0Xazw2jBvfGv9iWthHXyHH4SPaP7bH8338qo7IiwxByvWjHyIsDbjLiKC48xbDFFMq0onvnwVcpmWAf1v6CDL1IDur4cjCS1NrBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2afZhzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2afZhzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FD1F000E9;
	Thu, 21 May 2026 09:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355821;
	bh=NkVnihIy31dIAYz2JOSqK3T3ETJqUTTxorUyuRboKN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2afZhzDdiZT9BIcFHZQkwAb/5Pjn1ryJNuVTeaG7CaJaTZRJUuQ6fUwoJJ06jdVC
	 JoCGOsD85uHUk7zhGp4zq5agLJItmOJeGHvwRNndSg8qzcTBvXmOVceg4IZT4J4BVv
	 3xdkIffOf8S33lIdy6SrjKxldgSP6KdZoKlSe4nAQeQ0mNKUdC2vxRVuSs1paDPuzH
	 pmhJcuN5yFOYCFKUxDI5LNP3iOzB/sAlrsBve1mxY5Oz/UCfYLgjGFXykokwVnnhiB
	 rf9/5oxNFH5EIgkRvaN/9Vla0nvwxXgXxz5kJZqQO4opBTvUVDwofVTOa55Zp1p38T
	 9uik8hTqhzmoA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v19 06/15] tls: disable device offload for mptcp sockets
Date: Thu, 21 May 2026 17:29:44 +0800
Message-ID: <0cc056536f7c3686926bc5a99d3306bf7ab52529.1779355169.git.tanggeliang@kylinos.cn>
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

MPTCP TLS hardware offload is not yet implemented. Return -EOPNOTSUPP
when attempting to enable device offload on MPTCP sockets.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 741aef09bfd3..06f45edffb5f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1074,6 +1074,9 @@ int tls_set_device_offload(struct sock *sk)
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
 
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
@@ -1196,6 +1199,9 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-- 
2.53.0

