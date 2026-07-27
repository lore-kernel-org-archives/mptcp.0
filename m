Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C84363C48
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119395; cv=none; b=BXVznBqORBzNi25AsLdCdXpmckrOLYBUa7hFpPhj+az/5Yw/mT7oly4kS5rdkSR+lAyt99dnhTCvIbEypJCvdNsYTHmVNfrc9yN4ZTfGGvGOuFxpgS0U7hdRu2KJcg2oC+98IOf5BdnB0CZEiSZx0DJFO5EXsMm9uY6cNP2iYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119395; c=relaxed/simple;
	bh=u9rOxdo46iYB47A/63iPa4+zqlamizywuT2wExIeXdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DamSbSKl2iC2oorw/srqYsw4En1scC+9A6wdyNvbbUN81CgqTG/elz+VhJkqWav5sQ0CV7i6LrY4Wrrz+vW5SszNP5ugCieZpTCWFyH6S66UPbBNmxanaJFAeNco9Khzjq37vXpJFUyFDyD22H0qkLEJXsF8EYYC3bT35v9kIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tWW/jA4E; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tWW/jA4E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsBoRQaC3WCt4CgwfpkF2/eFkbf4253syltUQVweLlI=;
	b=tWW/jA4EPUMQKYrIJMnIMuhzQWN86YY/+oOjZtcTEQsOXtCHsaeXgdUvHv0Rg51PLsvbkW
	C+CTys8EIJSSfkd+m1Ii+RtJA9KHcCOs8NgUvqeh5YLQWC33aWXSvvtC5D0QQyqqWYUAgM
	DOhgjXXqPZW3okRpPOQFqKXoV5bLYZU=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 6/7] mptcp: add TCP_CONNECT_CB sock_ops hook
Date: Mon, 27 Jul 2026 10:28:48 +0800
Message-ID: <20260727022849.20923-7-gang.yan@linux.dev>
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
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

'bpf_sock_ops_cb_flags_set' can be called via msk, so using sk_is_tcp()
to avoid this issue.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/core/filter.c    |  3 +++
 net/mptcp/protocol.c |  6 ++++++
 net/mptcp/protocol.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 18e650bf7393..2f9778181279 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6097,6 +6097,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
+	if (!sk_is_tcp(sk))
+		return -EOPNOTSUPP;
+
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
 
 	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
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
index da40c6f3705f..e862310b2f81 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1374,4 +1374,33 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
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

