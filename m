Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F117A300
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375202; cv=none; b=ss9OaEFtK7gCPJQabyCxOgjW7axuVcSlD9rXdP+O73FG8jZcdoha/zw0m5Qo48PwERVkAS19lgRWbPnpqX6v8PxiSuAihaJj25J9SPz3jvFp1CQYoY4i2j0I5hXEaxtl+VLLlVkcUVqrDNga0IpamVLkaUcfY2+Kxe6ds/lu6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375202; c=relaxed/simple;
	bh=+ZWitJQ36qz37QpYbpOlNA2mRboYOnrPwRBY58VwNJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahw4btqqz5wLxyvlqD1h2nFsmlER3+5Af0uXpStajjtBhUEZaSqVIpLIcaZMduxIoIL00EfFnJigbhqbtFZyux142iWBArQ0PAw97I5ZmmQBcDwmsWq+3R4hkDZz9zyVW2IWl+ychMWM01e2BeXwPOTP0808sYHlEa8ejo76ijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl7XRFGf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl7XRFGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2CBC19423;
	Fri, 13 Mar 2026 04:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375202;
	bh=+ZWitJQ36qz37QpYbpOlNA2mRboYOnrPwRBY58VwNJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gl7XRFGf3DRBq1PxoLp3mioR1shGZL43qR85cvXDY3iWYdAPo1fOXwaDzhxoHbcvt
	 +2p9X+/34dI+ko5gLo8KJQ069gRUSYIpadq7QY6BdsCEPXTAFlmTGoFf3pNdep+O4c
	 mZFrRYZqMZ1KxptlUSDTW4oVJQT8BLN3RiswJYQDYOfl0Tqy1fymLCDJyZYjxWoHRX
	 TLKJZlzNxP2IIB0mOGGuHfoHhJ7YZlheODy/R8FPUSJ9C9bHjIVLGRuIoIhJgbzw0k
	 2tJ83pRp+650JBUWLy1QLR23eZwnw5Q35096zav6/+3rZUrc7ivl7VmBkfbBtKLpuh
	 jtiCidK1yaZyQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 5/7] mptcp: add sock_set_syncnt
Date: Fri, 13 Mar 2026 12:12:49 +0800
Message-ID: <7cd0862447c2d36dc844f94b7a09a8e31f6edcd2.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a dedicated MPTCP helper, sock_set_syncnt, which sets
the SYN retransmission count on the first subflow socket and it will be
applied to the host side in the 'NVMe over MPTCP' implementation.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  7 +++++++
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 63b64b7699e3..d6bb67a55f24 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -248,6 +248,8 @@ void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 void mptcp_sock_set_nodelay(struct sock *sk);
 
 void mptcp_sock_set_reuseaddr(struct sock *sk);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -343,6 +345,11 @@ static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired)
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
 
 static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
+
+static inline int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb923c4fabd1..961f11a24277 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3834,6 +3834,25 @@ void mptcp_sock_set_reuseaddr(struct sock *sk)
 }
 EXPORT_SYMBOL(mptcp_sock_set_reuseaddr);
 
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	ssk = __mptcp_nmpc_sk(msk);
+	if (IS_ERR(ssk))
+		goto unlock;
+	WRITE_ONCE(inet_csk(ssk)->icsk_syn_retries, val);
+unlock:
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_sock_set_syncnt);
+
 bool mptcp_finish_join(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-- 
2.53.0

