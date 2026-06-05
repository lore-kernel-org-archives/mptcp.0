Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D153BCD14
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622663; cv=none; b=kQI8h/7I49S2POBvVDqt+Ul7BrIT0khjLEnWp3W8iidO3S3uWWiHwlByV85qIlaabl9GSyX1vkTV9LxpB1jLstVPpF7Tf6no2sYeyOf0wzzbuH2dIzEpM3SQ2ASFHhPonrzPDDQ3cnTj33dxPY4P2Xa29CXCRbmsswYXFM/ZYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622663; c=relaxed/simple;
	bh=EZRqF6eE9zEwYBVGPqqRDvTyGjmL25NcAp2roqLcPNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3iecQaKrTVHdNcpsOr+16HEf1M2OqfxmYwK45d0yNXnopw1pC+ck0Ant3rpnbLRvTDicEc5fUhwbbqvnmB3mXowO0v0bbx4jslVHWo3jfh0wiDfyD6SekbwyWWcMVGXOQNY8tY28c7Ko8/53fLhZj/UWHaOWSidd9OmNIhmjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezJG8XPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezJG8XPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD871F0089A;
	Fri,  5 Jun 2026 01:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622656;
	bh=jw+BUPncgkSN+kg2iVhsourrdt2Sz8wQXostv6EkgbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ezJG8XPkKjYZNyYIiRyEJA0MexWAc/D9f9JqPUpQzILnOoQoFwekFZzqIkT0a137l
	 WqcjDrszuz7YP4ZoMBUh1JzFvtQ20kQNeG/95tMN2TG06g7tbUXktpVjBC74fxKgXN
	 SpiiOMteJGPH88tRQtAxszIEv/zLBb/H3Mqk9JZEeNbtE1kkIVqWcVcZuObQkhRCfo
	 kTXgvhI+91ok/5iDpejbz/3X3/siHuJq2uNbe5hNY1dg9B4QG84yLciA5k0HaHAZGJ
	 5+QUt/IJ9iPdybEzM2V8IIBwW+LJaIXATXyLqfLiQLxm0VPSTjY54lvvCI72PESyON
	 rfE1IXbyNymuA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 09/18] mptcp: implement ulp getsockopt for tls support
Date: Fri,  5 Jun 2026 09:22:49 +0800
Message-ID: <efd94348674a721d13068d74112f0d17cd10a490.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
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

