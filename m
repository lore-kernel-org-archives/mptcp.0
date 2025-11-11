Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B729C351
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841004; cv=none; b=uZ7k2Sx/h4zw9krBP9/+PiK8JbB3nZ9QtFD4oS6lWt68eHBO03Df9uLeK+DsOoiikYWSjT63lOBrb3pnaE/sWXhYgG9KYwKu03TtE1IwsteC93n6zUfdBX9JR5Qo/4lAMa63PlKDfdh1rlrroJ1fHBRiNTptq8lrU4fBSXnmAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841004; c=relaxed/simple;
	bh=BwaPEPKBu6JIttaWcSoREJXmjWr1DuPtD5egFo6qy/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZg1ETYXnuMqjhMm0cRxT3TBn5v4KKpZxifu0KLRkXbDjb3p6V4mqxVn+vRF9J02bNIySSdr84SE1bpqffgxbqbwxRhxsH/xkp2ZUXtard1ATCOKomnXts0WJe/PgHYxMOc+i6m+vt2FhwB+U5Z84HnsaXk4z0bxzrMPRAVwqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id C708F8B2A0C; Tue, 11 Nov 2025 14:03:13 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v5 1/3] mptcp: disallow MPTCP subflows from sockmap
Date: Tue, 11 Nov 2025 14:02:50 +0800
Message-ID: <20251111060307.194196-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111060307.194196-1-jiayuan.chen@linux.dev>
References: <20251111060307.194196-1-jiayuan.chen@linux.dev>
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

Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing connections")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8325890a322..af707ce0f624 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2144,6 +2144,10 @@ void __init mptcp_subflow_init(void)
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
 	tcp_prot_override.diag_destroy = tcp_abort_override;
+#ifdef CONFIG_BPF_SYSCALL
+	/* Disable sockmap processing for subflows */
+	tcp_prot_override.psock_update_sk_prot = NULL;
+#endif
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	/* In struct mptcp_subflow_request_sock, we assume the TCP request sock
@@ -2180,6 +2184,10 @@ void __init mptcp_subflow_init(void)
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
 	tcpv6_prot_override.diag_destroy = tcp_abort_override;
+#ifdef CONFIG_BPF_SYSCALL
+	/* Disable sockmap processing for subflows */
+	tcpv6_prot_override.psock_update_sk_prot = NULL;
+#endif
 #endif
 
 	mptcp_diag_subflow_init(&subflow_ulp_ops);
-- 
2.43.0

