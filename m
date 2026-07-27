Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421A7360EE9
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785119391; cv=none; b=Wg5kt47js5mO9QLKVlGUrltjizjQCf0I5jBaYAN8Rvr2gBsMmpU2pbD2YnbnVnr3qkoOnmWsirYIJrkt0GnjtK7jzSg4jMJ6P1tnQs8eGoWO7fvWIpDhLmpjw8qo/YSIul6ekIbL8DisBqraTkG/QtRT3FbziML0vh+LLayG8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785119391; c=relaxed/simple;
	bh=tJkyxLLJ+g5eKbA9bWMGE4y8rJtBbk3XgCzOd6gD/ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYTu8NW0YDOEDXFWeD6pzO5UXNMv1+ggCpGyDHWIWosCoNB6nRw3vvfuOcjLvmBWkWtvc1DDrt7b3BQS/dQ8X5vUy0eh8Y++4U+Mheh044xID0kyGLe0GEKMC5xJ6q84HG53Oy0AY636aMIHzlURv4+4Yr7XvCkODLDRFdiPaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4fL+40J; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4fL+40J"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785119388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ekYWi+TaHQEFUzP9wIijBLXy9R1D1C5MmPLPZ+Eoriw=;
	b=I4fL+40J5lKx3XyAxMme3GtLeMlXkiQJBQWU6vTYXS6vjkHYc5MlyCYoEycWq4Av5neBvo
	Zvf83+aMnrNz/D7DMYveozvlaadzTKclWF8q804sNWOupj+o6ZZCaYXZMXCv8CpaKQU3Nn
	LhkFp/s2POSho1Do+NOjNuvF8oTk3xU=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/7] mptcp: reject sockopt requiring ssks' lock in BPF context
Date: Mon, 27 Jul 2026 10:28:46 +0800
Message-ID: <20260727022849.20923-5-gang.yan@linux.dev>
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
index f00d85809c52..a26758a82150 100644
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
@@ -1632,6 +1656,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
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

