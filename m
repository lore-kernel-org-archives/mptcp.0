Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C43D9DD2
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936680; cv=none; b=Jc1qXjdc/ZY3dyO8D5XNgOb3o2/Rs6dS5K0v9hBv0WcujHPVQjmAKnLK6cVV0pC2hLxstCZg61u02SIrFM+cECahduh+UZe8hNAkU2ZoM+laijWWHCnZ1813DXx8Ds893tgyEO5hmgTWIIuzRgLoJ4CDPy42MpfvEggIO5LASOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936680; c=relaxed/simple;
	bh=/E57Gpbzun/m6JAQ1XiUqbjnB4YSwessf+nkWuQXmo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJRC1QT7G0B35UIYUcVfIINm6cDNP+1lyHYWjRq78x+g2D2iZeiixpYZgkiob3Aj5zn7YrYmwy/zAYgT2p00xhmYmHn3HcPDHt9YyI5aU4ITOs5bq5s8Vzp7D+fc/YDC2Ya8h/zFQ52MZieQW2oYzMzB0F1ZjVrnkO6JzlTtDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sdMYYArp; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sdMYYArp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783936676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkgVb/K4XgPRTf13nRhq2eu+KontUaZPqXLgsM+nYHE=;
	b=sdMYYArpBaT0hmC7r3JIjCwqxilb+6ccnZWvErwiSgj8xabSHaQAKX+LfrX6KSUmF0xUBC
	gjEgpmyks6zi31j8VXbCjyaWvbSmeVvOYjHq0qW3EVlU88hh5zGiV7e5CvYMsFAP7MgX5p
	IsBYp1nqdO7xpStMWpVYutKH+89QWlI=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 4/5] mptcp: add TCP_CONNECT_CB sock_ops hook
Date: Mon, 13 Jul 2026 17:57:34 +0800
Message-ID: <20260713095735.1222033-5-gang.yan@linux.dev>
In-Reply-To: <20260713095735.1222033-1-gang.yan@linux.dev>
References: <20260713095735.1222033-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch adds a helper named 'mptcp_call_bpf' like tcp_call_bpf.
Invoke the new helper from mptcp_connect() with
BPF_SOCK_OPS_TCP_CONNECT_CB, placed after the subflow lock is acquired
and before tcp_connect(). At this point the msk lock is held by
__inet_stream_connect(), mirroring the placement of TCP_CONNECT_CB in
tcp_v4_connect()/tcp_v6_connect().

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c |  6 ++++++
 net/mptcp/protocol.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..837bb76e5c2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4149,6 +4149,12 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (!msk->fastopening)
 		lock_sock(ssk);
 
+	/* Notify cgroup BPF on the msk before initiating the subflow connect.
+	 * Mirrors BPF_SOCK_OPS_TCP_CONNECT_CB; msk lock is held by the
+	 * caller (__inet_stream_connect) and ssk is held before.
+	 */
+	mptcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
+
 	/* the following mirrors closely a very small chunk of code from
 	 * __inet_stream_connect()
 	 */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..b4640ba83a8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1374,4 +1374,34 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
 static inline void mptcp_join_cookie_init(void) {}
 #endif
 
+#ifdef CONFIG_BPF_JIT
+static inline int mptcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+{
+	struct bpf_sock_ops_kern sock_ops;
+	int ret;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+
+	if (sk_fullsock(sk)) {
+		sock_ops.is_fullsock = 1;
+		sock_ops.is_locked_tcp_sock = 1;
+		sock_owned_by_me(sk);
+	}
+
+	sock_ops.sk = sk;
+	sock_ops.op = op;
+
+	if (nargs > 0)
+		memcpy(sock_ops.args, args, nargs * sizeof(*args));
+
+	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	return ret == 0 ? sock_ops.reply : -1;
+}
+#else
+static inline int mptcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+{
+	return -1;
+}
+#endif
+
 #endif /* __MPTCP_PROTOCOL_H */
-- 
2.43.0

