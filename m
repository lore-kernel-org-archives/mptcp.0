Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90C2D239B
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342693; cv=none; b=VVWc2ZvtnSdTr8+5YyG4DoY8djumyheRlWjB3ZtErSSGHRpXUGAopwLz9XiFgOdhTf3zK3qRVPmzBJkqdhJxy/QoxfWRR6c39iRn6KbdzKrAK8gNRHGIgRz45VNLWyl6BnHZo6k4pQPBxl5KKMwxa4wq5mbX6KXXAW1x35TWXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342693; c=relaxed/simple;
	bh=9gqY/a/t3cgf+qUGFp5v6NHGkd9JXj5rvQDmdYxUHVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYSWVOKll2UmzR13X2wVt4Vh6hyHpuYCoXPtj3ZycirL1xO482OBj+V4XmxVB1g9AbAwfzIl1EbunzqMfpzdjrlFDjclVXtF5XfWoNvyDAOxws1bAVhWboa3f5myvPgFps1A6ubMneNXFQWFVomI1cR0FWKQL+KMmxQppKcieVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 11B918B2A0D; Wed,  5 Nov 2025 19:38:09 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 2/3] net,mptcp: fix proto fallback detection with BPF
Date: Wed,  5 Nov 2025 19:36:08 +0800
Message-ID: <20251105113625.148900-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105113625.148900-1-jiayuan.chen@linux.dev>
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sockmap feature allows bpf syscall from userspace, or based
on bpf sockops, replacing the sk_prot of sockets during protocol stack
processing with sockmap's custom read/write interfaces.
'''
tcp_rcv_state_process()
  syn_recv_sock()/subflow_syn_recv_sock()
    tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
      bpf_skops_established       <== sockops
        bpf_sock_map_update(sk)   <== call bpf helper
          tcp_bpf_update_proto()  <== update sk_prot
'''

When the server has MPTCP enabled but the client sends a TCP SYN
without MPTCP, subflow_syn_recv_sock() performs a fallback on the
subflow, replacing the subflow sk's sk_prot with the native sk_prot.
'''
subflow_syn_recv_sock()
  subflow_ulp_fallback()
    subflow_drop_ctx()
      mptcp_subflow_ops_undo_override()
'''

Then, this subflow can be normally used by sockmap, which replaces the
native sk_prot with sockmap's custom sk_prot. The issue occurs when the
user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
Here, it uses sk->sk_prot to compare with the native sk_prot, but this
is incorrect when sockmap is used, as we may incorrectly set
sk->sk_socket->ops.

This fix uses the more generic sk_family for the comparison instead.

Additionally, this also prevents a WARNING from occurring:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 \
mptcp_stream_accept+0x34c/0x380
Modules linked in:
RIP: 0010:mptcp_stream_accept+0x34c/0x380
RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
PKRU: 55555554
Call Trace:
 <TASK>
 do_accept+0xeb/0x190
 ? __x64_sys_pselect6+0x61/0x80
 ? _raw_spin_unlock+0x12/0x30
 ? alloc_fd+0x11e/0x190
 __sys_accept4+0x8c/0x100
 __x64_sys_accept+0x1f/0x30
 x64_sys_call+0x202f/0x20f0
 do_syscall_64+0x72/0x9a0
 ? switch_fpu_return+0x60/0xf0
 ? irqentry_exit_to_user_mode+0xdb/0x1e0
 ? irqentry_exit+0x3f/0x50
 ? clear_bhb_loop+0x50/0xa0
 ? clear_bhb_loop+0x50/0xa0
 ? clear_bhb_loop+0x50/0xa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
---[ end trace 0000000000000000 ]---

result from ./scripts/decode_stacktrace.sh:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept \
(net-next/net/mptcp/protocol.c:4005)
Modules linked in:
...

PKRU: 55555554
Call Trace:
<TASK>
do_accept (net-next/net/socket.c:1989)
__sys_accept4 (net-next/net/socket.c:2028 net-next/net/socket.c:2057)
__x64_sys_accept (net-next/net/socket.c:2067)
x64_sys_call (net-next/arch/x86/entry/syscall_64.c:41)
do_syscall_64 (net-next/arch/x86/entry/syscall_64.c:63 \
net-next/arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (net-next/arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f87ac92b83d

---[ end trace 0000000000000000 ]---

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4cd5df01446e..b5e5e130b158 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -61,11 +61,13 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
+	unsigned short family = READ_ONCE(sk->sk_family);
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (sk->sk_prot == &tcpv6_prot)
+	if (family == AF_INET6)
 		return &inet6_stream_ops;
 #endif
-	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	WARN_ON_ONCE(family != AF_INET);
 	return &inet_stream_ops;
 }
 
-- 
2.43.0

