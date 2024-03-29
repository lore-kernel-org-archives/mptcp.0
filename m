Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB53B2A6
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738266; cv=none; b=kM7DSJ2B3M9+ai9N6P9C4ifaCbTHTg0FMUWKcigsr4Gf13ZH6PtuWK1jiFujW+3uWULpmd1G8TGjVh/cqkUyanKXbTEco/T4Ct40pwHAZmw88+2bgxvMJfMtUT76P2Ny+hd5f8f6wK8Dw9lfJaGHgrCWK7FInc8LlteP0VIZ5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738266; c=relaxed/simple;
	bh=tcqWZa7vAgYqVfEKtTYMRoETyY0uk7xPdEJmlLmv2hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrjcArYBZHLPx+kJ6TGoqnimZ9gZWQ7NePdgg5abgiufJO5cVnmRILDZLC5RLm+WweR2d7D5XL8/kr/5WJ88gQJi2ab3P2ovv3OOl8IF5NYbuhYZXZ1wF382vN8Mhj/Z51ZBKBg3S4uWZxyVvud9tH0O/y7KzsTIc007vlV8kvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghM3w2lS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghM3w2lS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711738262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W8dzUgdlpUNa2rUoysoERPwae2lgTaSmib26erqINq0=;
	b=ghM3w2lS81wu6/kpZCwXP9t7E3npAAH+xxa19N7SXEKK/Pm3S3xegMM+a46hWo+MjgAlFj
	FrQN8LS73bCN4abqd5NWiOcowsQ0osBj601Svl/KaQMrmWGWJ3yCdd1o5+7skSIX9PBSAQ
	Xio8IXTECXZsXkjBLA8y4ZBGc3XPscI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-ZTgBXhmTOfGzXh-REwQkxw-1; Fri,
 29 Mar 2024 14:50:58 -0400
X-MC-Unique: ZTgBXhmTOfGzXh-REwQkxw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D3992804803;
	Fri, 29 Mar 2024 18:50:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9A48492BC8;
	Fri, 29 Mar 2024 18:50:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net] mptcp: prevent BPF accessing lowat from a subflow socket.
Date: Fri, 29 Mar 2024 19:50:36 +0100
Message-ID: <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Alexei reported the following splat:

 WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430 subflow_data_ready+0x147/0x1c0
 Modules linked in: dummy bpf_testmod(O) [last unloaded: bpf_test_no_cfi(O)]
 CPU: 32 PID: 3276 Comm: test_progs Tainted: GO       6.8.0-12873-g2c43c33bfd23
 Call Trace:
  <TASK>
  mptcp_set_rcvlowat+0x79/0x1d0
  sk_setsockopt+0x6c0/0x1540
  __bpf_setsockopt+0x6f/0x90
  bpf_sock_ops_setsockopt+0x3c/0x90
  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x132
  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
  tcp_connect+0x879/0x1160
  tcp_v6_connect+0x50c/0x870
  mptcp_connect+0x129/0x280
  __inet_stream_connect+0xce/0x370
  inet_stream_connect+0x36/0x50
  bpf_trampoline_6442491565+0x49/0xef
  inet_stream_connect+0x5/0x50
  __sys_connect+0x63/0x90
  __x64_sys_connect+0x14/0x20

The root cause of the issue is that bpf allows accessing mptcp-level
proto_ops from a tcp subflow scope.

Fix the issue detecting the problematic call and preventing any action.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/482
Fixes: 5684ab1a0eff ("mptcp: give rcvlowat some love")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dcd1c76d2a3b..73fdf423de44 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1493,6 +1493,10 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	struct mptcp_subflow_context *subflow;
 	int space, cap;
 
+	/* bpf can land here with a wrong sk type */
+	if (sk->sk_protocol == IPPROTO_TCP)
+		return -EINVAL;
+
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		cap = sk->sk_rcvbuf >> 1;
 	else
-- 
2.43.2

