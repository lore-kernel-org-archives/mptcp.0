Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C2336881
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683562; cv=none; b=Ji3QkXXqJ0u1GO3EtjPH1ZhXbXmROld9hVzigDk/GJBRbSO4WBG4hmHDWwaRnaenAosmligpImbpBo9T/Kch5nY9iLig3nt/QAtrMH7uvU2I9ZJMcCfyEfC1sNivL//RpzAkP32E2cXohCgsbD+Kt7swbGF9wGdwLCZ4XWcdxPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683562; c=relaxed/simple;
	bh=uzsJa1Bqh20LQFOb4ZEawv08Hyzu04LYsaqJeWOJVmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoEd96HwkURwVifwYGS4i+uccZiooNfRdXOw0UN9p1LRnmZXQSo4vJzggm8ISMYDO98iHsIhPWR103ACm2hAHvw5f6wmpZeCc/cOiwsfcgzF4gpcRF4a3FYMCGOuSO3teGt19kqMDW1Rn8/J4OdJISbraS1X/mQrDFz3phfeffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh2oi6YP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh2oi6YP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D04C116C6;
	Thu,  5 Mar 2026 04:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683562;
	bh=uzsJa1Bqh20LQFOb4ZEawv08Hyzu04LYsaqJeWOJVmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zh2oi6YPHbhU4kZJQ/zpvS8OdV+Z1ppLi1h+tgVLfJpME+zt64Gp2kjftNU1WJmON
	 gSqPZVij1800NSMA8qf0mX0jCR+qLUc7CzAv817z4k7yDCw5WyjuAmvlYUpFQYrfg7
	 jggvw9agOSlGQm4wD2XNd4TxVaMtgIrqHvZ/65lUgApEP31Qczsmxvg7NaZibeYuA8
	 vm/CKo5qq+1vKhVpHkjyEJhR2TdAKA00XG9XoWsLkvTmSUNTvBOvAsLZxexAXdfm0/
	 W0j7XIbJ97TEYBWq2gecm/b8ikXEstz7ooXWHRDAowc14ZFYT5OkC3cTvShw//4QWz
	 wE/HwkpBC9SFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 6/8] mptcp: add sock_set_syncnt
Date: Thu,  5 Mar 2026 12:05:24 +0800
Message-ID: <76939d6c3a650ef72430649a480e700ba0049f24.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
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
index dc5b3ecdd885..8ead932e7999 100644
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
index 61f4eba02b37..bc507b6e91e7 100644
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

