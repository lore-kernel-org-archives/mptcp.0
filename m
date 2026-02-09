Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E091E2614
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627889; cv=none; b=Rwv58jxMAnaZd4nFI5h3LuvjrruRDgkSXjWjFZSHtBZhgwW01qX8/63XFcwlwQWVdwDASf1tZgJ/xVMZlIINZ07Bm/V7e6YKEZmKSVp0hGvKOEGyw9tDNh2FUbrb2uDdjBKIrWe8cDK31/QhV8kRMLfHXRjHKnkWqqjqpZsMh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627889; c=relaxed/simple;
	bh=msTmMdgnansMzaF2pXFWh0VsBnWmaH/aXZ7Xvpfv9uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoM3QbQvnE6eLJxdGZYQQJrWdjHp/DcRfzyMOJ3WSiNOBNvC2ZJqIl9FRR3G1i2dO1qmokdU8Ip031cchSEEz3o7ZA/KCo8UMiZSE3bPye0Zdcac6VBHyvrnIRjNPVM9qkg2MRM8XiTXqWAJH+hpF6vgz1Fq+9eKXBX86KTnZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcNGi58L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcNGi58L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D87C19424;
	Mon,  9 Feb 2026 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627889;
	bh=msTmMdgnansMzaF2pXFWh0VsBnWmaH/aXZ7Xvpfv9uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcNGi58LSWD43KYtq++vU/0dvlckfe+UR9Rv2q6LGS0SJIHe8htE3QQISAnnsPkci
	 bqL1NK/xBwkgCVSMcF3nPSYMjlaxag/xtCwpkye3bPgTDBhlhGrz1IT8sII3hyuSYO
	 G5JfVO8ev1c+tslWTQr1Ik96zz2zkXIFz3GVycgPsO8oK0YBsaClRGLNKnpIDwuRZf
	 bk3qD+4HAdHbTVn8Kl3e62NO3t9Cb2eKU9HJDnU2UnAyBdB8j+xpCCdUy16v0ar7EI
	 UNr8lhfCUTV9rb5zN5f8H1QJi+nZF0ovjKmVGf0x58EsadLVP1At3KY8qQp2NWCCQl
	 0EjrwjzCFX/IA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 6/7] mptcp: add sock_set_syncnt
Date: Mon,  9 Feb 2026 17:04:21 +0800
Message-ID: <b64447014d9f07e0fbf989df4a5b342b3c8710cb.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a dedicated MPTCP helper, sock_set_syncnt, which sets
the SYN retransmission count on the first subflow socket and applies it to
the host side in the 'NVMe over MPTCP' implementation.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c |  2 ++
 include/net/mptcp.h     |  7 +++++++
 net/mptcp/protocol.c    | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6188e01b85db..ac1b21e3578d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1807,6 +1807,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
+	sk_is_msk(queue->sock->sk) ?
+	mptcp_sock_set_syncnt(queue->sock->sk, 1) :
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
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
index 5aa11062230e..bb9ccfa840f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3838,6 +3838,25 @@ void mptcp_sock_set_reuseaddr(struct sock *sk)
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

