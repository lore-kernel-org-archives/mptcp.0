Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7A3E0C47
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936676; cv=none; b=HxCro6TQ7se2O2hjslKJoVYrDPJMf01/co2HRFvQ6/kSb3mO2dYFerfggUJtKS01IvD3MQrD4T0OpUT+VcbD0lGF/RC+uI2G7O2OV4SKFgLLtQZGVhOSc27My/FeiE57E9fC3z6LdGG6D+5QG2e+iv40JXNdRUFa0z0rk+1j7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936676; c=relaxed/simple;
	bh=HVcG9CldcxWcR6Ql48cgvWxWNDxiemxroA0Yq0N/5Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8CnsWJxLJRwAJruw9ulGFGb/kWwn0LGanwU8MGbo0OtsW7AoM0QFVs/hSYXLPkocWfL4YnMY8IBTK90DNERkIomQqvGHFQGFLUvc08dNjB3+oukKKp1mThrE7yNgDZ8Lmb/FAnnG/MdTYbIW4KjGY94SicuqmDqd+GY8B+cPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dy7Z9ak8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dy7Z9ak8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783936671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9luSEQqUECsWU+rFMRKjYKT1Q/m4yCWjKsNKT9WZm54=;
	b=dy7Z9ak8V/xF5sysF60g0zppfNowTWEu83xB1A5Fa8W5r0p4iJFRDGcqs/XVG5wYd99zmW
	moHvpWfQnC7tP2QvNhISAfMespnH3KoCDjvB4rOqz1d6Zbw+9izoLFDFuLPAcvxnsmMsjo
	VeRN9VqFiblWID9flhg7lFglFQd7BQE=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 2/5] mptcp: reject sockopt requiring ssks' lock in BPF context
Date: Mon, 13 Jul 2026 17:57:32 +0800
Message-ID: <20260713095735.1222033-3-gang.yan@linux.dev>
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
index 342aec7f9086..0c391247eb4c 100644
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
 
@@ -639,6 +651,9 @@ static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
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
@@ -1654,6 +1678,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	if (space <= sk->sk_rcvbuf)
 		return 0;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	/* propagate the rcvbuf changes to all the subflows */
 	WRITE_ONCE(sk->sk_rcvbuf, space);
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
-- 
2.43.0

