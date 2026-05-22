Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1603B8D4A
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441179; cv=none; b=LnII+8U6//X0vklnVjduVAxZh/8unJ+I7mSF5YIpyqUFN+gFK+1JJkp+49KSxmJJwWSaDSh63wMUSZQmiTrOVrzvFP0MSUGDukEG3y0UcTqT1r8MUY4/3O+fUkyQ2Xey3w/IKWB/kIOzRksHd5PshUZtLVTSJ5bFhL+5fpnAGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441179; c=relaxed/simple;
	bh=8pitMe/5QeL1Rp7IWy3xILIitsGuPhE1AXG0p3kP9mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7a8pvbmy2BaAxIu8DG0tX1d3rZ1FHt+I0Xc8/rkl0FxY81zI+ILVuCtmZr+PS54n/YGM79Vz1KmggUCsUIo0OajVV7TH3GoDOx/D3gDT9j0+VQHkI2u4LPnPtM5KCfze+ZYhPMR8MJeSi0sdN8KmhDsyh9iNIGrvNS626bEw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f7e6aDCn; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f7e6aDCn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779441175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CMHPPv9g5SSBKyhU5d8PEpw3R9cxKQHSb/jNK37qX4=;
	b=f7e6aDCn/5btxM+YSm0RgCCRji7C289hriNoLy/A8zFs+J095X9aOTupodt3DS3S5ZQiqt
	WdpZFnHeT+SRzP/UfZubpIjgG1RPlaKwo+FGAzNm58aYyfHaGfwVEmRWlk9WGiym4ThXhE
	8KyHmZYbfMDJSiQt36/oiZ+gIOqEfWU=
From: Gang Yan <gang.yan@linux.dev>
Date: Fri, 22 May 2026 17:12:34 +0800
Subject: [PATCH mptcp-next v5 4/6] mptcp: reject sockopt requiring ssks'
 lock in BPF context
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
In-Reply-To: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>, pabeni@redhat.com
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
index 3a5cd3023e59..622a8de36567 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -179,6 +179,9 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	if (ret)
 		return ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	switch (optname) {
 	case SO_KEEPALIVE:
 	case SO_DEBUG:
@@ -212,6 +215,9 @@ static int mptcp_setsockopt_sol_socket_timestamping(struct mptcp_sock *msk,
 	struct so_timestamping timestamping;
 	int ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	if (optlen == sizeof(timestamping)) {
 		if (copy_from_sockptr(&timestamping, optval,
 				      sizeof(timestamping)))
@@ -255,6 +261,9 @@ static int mptcp_setsockopt_sol_socket_linger(struct mptcp_sock *msk, sockptr_t
 	sockptr_t kopt;
 	int ret;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	if (optlen < sizeof(ling))
 		return -EINVAL;
 
@@ -600,6 +609,9 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 
 	cap_net_admin = sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	ret = 0;
 	sockopt_lock_sock(sk);
 	sockopt_seq_inc(msk);
@@ -629,6 +641,9 @@ static int __mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
 	struct mptcp_subflow_context *subflow;
 	int err = 0;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		int ret;
@@ -652,6 +667,9 @@ static int __mptcp_setsockopt_sol_tcp_cork(struct mptcp_sock *msk, int val)
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	sockopt_seq_inc(msk);
 	msk->cork = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -672,6 +690,9 @@ static int __mptcp_setsockopt_sol_tcp_nodelay(struct mptcp_sock *msk, int val)
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	sockopt_seq_inc(msk);
 	msk->nodelay = !!val;
 	mptcp_for_each_subflow(msk, subflow) {
@@ -739,6 +760,9 @@ static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
 	struct sock *sk = (struct sock *)msk;
 	int err, val;
 
+	if (has_current_bpf_ctx())
+		return -EOPNOTSUPP;
+
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
 
 	if (err != 0)
@@ -1642,6 +1666,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
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

