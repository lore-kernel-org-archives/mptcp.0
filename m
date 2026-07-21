Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23A33689D
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784601687; cv=none; b=Ry5GwiPiSAh3vDgeC6qvmFydjoLcybH3nKV6MfpNijBS57BRC1HiLGS6b//9etglwldY3UOD+GGMouExmjmd7ZYy8qyVxfwCaRccXEyp8whmgqGQzuZlwJJpKTYj1+bp09Ca49DwxvTHExIxpbuuPb+iR/Ll5AnDrNZoRGDMfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784601687; c=relaxed/simple;
	bh=tGrff5MVv3in504xy/juPPPKg4F38UakVfYLlJPCyf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCd0spKw9cK5bXKf5+yoeBvqvBuolQ1UzkTyKoZ3ZpOelJELKXAFKQ7lZ2JJEUXRlNTOpPzeMakFLCLZ8lWKw1/Hac0m1gK5DsGPB2tFq/7WIL3UZt9fvxMh43/6GlJiN3/45jiCqW1CBIYXdkQRyTMhAlf6hd67sWma9gCL5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qAZrBtqb; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qAZrBtqb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784601684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixpkjtUO7RJBzXA9hxDfneNdqCBs+/C3Oz2Di+vOov0=;
	b=qAZrBtqbN3isLRDNVzT5gLXSqZS//eOvp9f8eqtlgjxft/HcWQelJc7A2c2hga9y5lR29I
	XjMvDh5vYBrDuvZ4diwzhF84N69kQJ8GZDmSHG3KX/eN5hCBsO6HSg4OOCHHExKQMzA4kk
	0WKEr0aFiSrBI+TS+39HBtUr1qnGywY=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/7] mptcp: reject sockopt requiring ssks' lock in BPF context
Date: Tue, 21 Jul 2026 10:40:59 +0800
Message-ID: <4a9a4167599802c1d22d2254c789c491c74a828e.1784601268.git.yangang@kylinos.cn>
In-Reply-To: <cover.1784601268.git.yangang@kylinos.cn>
References: <cover.1784601268.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Several MPTCP setsockopt handlers need to acquire the subflow lock
via lock_sock(ssk) to propagate settings to each subflow.  This lock
can sleep and is therefore not usable in BPF context where sleeping
is forbidden.

The short-term solution is to make any sockopt operation that requires
subflow-level lock fail with -EOPNOTSUPP when called from BPF context.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/sockopt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1665438269e5..195f9ca342fb 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -185,6 +185,9 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	if (ret)
 		return ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	switch (optname) {
 	case SO_KEEPALIVE:
 	case SO_DEBUG:
@@ -218,6 +221,9 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 	struct so_timestamping timestamping;
 	int ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	if (optlen == sizeof(timestamping)) {
 		if (copy_from_sockptr(&timestamping, optval,
 				      sizeof(timestamping)))
@@ -265,6 +271,9 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	sockptr_t kopt;
 	int ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	if (optlen < sizeof(ling))
 		return -EINVAL;
 
@@ -598,6 +607,9 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	bool cap_net_admin;
 	int ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	if (optlen < 1)
 		return -EINVAL;
 
@@ -639,6 +651,9 @@ static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk,
 	struct mptcp_subflow_context *subflow;
 	int err = 0;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ret;
@@ -662,6 +677,9 @@ static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -682,6 +700,9 @@ static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -749,6 +770,9 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	struct sock *sk = (struct sock *)msk;
 	int err, val;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
 
 	if (err != 0)
@@ -1610,6 +1634,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	if (sk->sk_protocol == IPPROTO_TCP)
 		return -EINVAL;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		cap = sk->sk_rcvbuf >> 1;
 	else
-- 
2.43.0

