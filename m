Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5786215077
	for <mptcp@lists.linux.dev>; Sun, 30 Nov 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764473987; cv=none; b=CiwEDlOv0wbFCWNvg1UMratO5U9C3r4wPf1Xa1wkd9cuwLQiGdOGZNaLf6SkQk3BGsJEw3ZDknAmQWF5cNytmDPnjv3cA1sI7Jg/+ojZw8ir6ZKbl9u7E4+Sp6ojGHhtW04kRf9STQouxQUQeASNOQtw8nZgI1K2vIUZCwxUll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764473987; c=relaxed/simple;
	bh=OiwOJbJBk6q9IvkjJfVDWx3vC+KZVz4tRUwq8fXUKO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/t6d+GudcE0Oxf0ShkwzwzCApusL0986mxN+GddWL0xO5ojgN4YVbHNN8/sT/p5Wg/3b7TAuX9EPK1Rb115CS4zqy1X1JAypn9ZL39GolV3Dl+px69QirL+0qMWwKZ1U2CEg0FrTqnh3WFHVnoSDyYS9/KQdUghUYTkwBp4TUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id EA9AC8B2A36; Sun, 30 Nov 2025 11:23:15 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: stable@vger.kernel.org,
	mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.1.y v1 1/2] mptcp: disallow MPTCP subflows from sockmap
Date: Sun, 30 Nov 2025 11:23:02 +0800
Message-ID: <20251130032303.324510-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130032303.324510-1-jiayuan.chen@linux.dev>
References: <20251130032303.324510-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sockmap feature allows bpf syscall from userspace, or based on bpf
sockops, replacing the sk_prot of sockets during protocol stack processing
with sockmap's custom read/write interfaces.
'''
tcp_rcv_state_process()
  subflow_syn_recv_sock()
    tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
      bpf_skops_established       <== sockops
        bpf_sock_map_update(sk)   <== call bpf helper
          tcp_bpf_update_proto()  <== update sk_prot
'''
Consider two scenarios:

1. When the server has MPTCP enabled and the client also requests MPTCP,
   the sk passed to the BPF program is a subflow sk. Since subflows only
   handle partial data, replacing their sk_prot is meaningless and will
   cause traffic disruption.

2. When the server has MPTCP enabled but the client sends a TCP SYN
   without MPTCP, subflow_syn_recv_sock() performs a fallback on the
   subflow, replacing the subflow sk's sk_prot with the native sk_prot.
   '''
   subflow_ulp_fallback()
    subflow_drop_ctx()
      mptcp_subflow_ops_undo_override()
   '''
   Subsequently, accept::mptcp_stream_accept::mptcp_fallback_tcp_ops()
   converts the subflow to plain TCP.

For the first case, we should prevent it from being combined with sockmap
by setting sk_prot->psock_update_sk_prot to NULL, which will be blocked by
sockmap's own flow.

For the second case, since subflow_syn_recv_sock() has already restored
sk_prot to native tcp_prot/tcpv6_prot, no further action is needed.

Fixes: d2f77c53342e ("mptcp: check for plain TCP sock at accept time")
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/subflow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2159b5f9988f..c922bbb12bd8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1936,6 +1936,10 @@ void __init mptcp_subflow_init(void)
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
+#ifdef CONFIG_BPF_SYSCALL
+	/* Disable sockmap processing for subflows */
+	tcp_prot_override.psock_update_sk_prot = NULL;
+#endif
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	subflow_request_sock_ipv6_ops = tcp_request_sock_ipv6_ops;
@@ -1957,6 +1961,10 @@ void __init mptcp_subflow_init(void)
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
+#ifdef CONFIG_BPF_SYSCALL
+	/* Disable sockmap processing for subflows */
+	tcpv6_prot_override.psock_update_sk_prot = NULL;
+#endif
 #endif
 
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
-- 
2.43.0

