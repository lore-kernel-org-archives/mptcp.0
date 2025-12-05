Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0131DD86
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928774; cv=none; b=KNjVKbqyODFtJ4Y7H5c7JxPxJcFVQO2OVMxSi6o++ic6oGDjoSrfWnJCNCrMIK1NuwWvg115mYqe6VlPva6IgiFMImhvo2ImaPqWqATzhWb5Y5zLF161yGc6QmbwKMHjyfPMB6f4OJ0PY5bsZH1LA8fX3iTWdk1aF3YHk9oG/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928774; c=relaxed/simple;
	bh=crXI+tQ2RkoDjptHGVO9YQSgQSndTYHU75i1FvWRjX8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rlmc5bW6+hD7VPmvWMX3dkFhQVyH0n5UjOho+hegWKDkL57XqmIHth8QDjLzeE2ROpr4NF+5Ylxu4EZFhu4gO7SIvSSI5m2G6QPGAOYG5t4sVcrhqmtX5gA/1HPlWIt6Mv0RJiSfG/fatBvE2NWp28xpMxe6gv8E5WGpIDmNuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejdy7boe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejdy7boe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764928760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hQKXkpLtHJKGW8r0u5Jmzd7mS+sAu7yJDxxTPMGyjA=;
	b=ejdy7boecRwTkRxWF3P3arIg/wq/u+8BwCMzJPihY8H6ge6HhhOQ/5uJTt+6+5QOdOcRAz
	txP83eRsV7S0WIMFsqwdzKb+Mx8Eqz/lFXCJK9Ya0s5TMw6KS5Oz86RlFi6AEC++p5K2lp
	akiiOKBZxAXyRVuQR1/vu9eqEjFcXog=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-WwNEC5-bPNWDMD-nqSRMxw-1; Fri,
 05 Dec 2025 04:59:19 -0500
X-MC-Unique: WwNEC5-bPNWDMD-nqSRMxw-1
X-Mimecast-MFC-AGG-ID: WwNEC5-bPNWDMD-nqSRMxw_1764928758
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A567195608F
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 09:59:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAFF63011A84
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 09:59:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 2/2] mptcp: ensure context reset on disconnect()
Date: Fri,  5 Dec 2025 10:58:43 +0100
Message-ID: <84e58b8d3665b7d363807fd53369ae0dfde0ad12.1764928598.git.pabeni@redhat.com>
In-Reply-To: <cover.1764928598.git.pabeni@redhat.com>
References: <cover.1764928598.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lN1LU2TYpRdC_Ccw0ZC-LzgZIPrqHN5Cwx_gWAKUpVM_1764928758
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the blamed commit below, if the MPC subflow is already in TCP_CLOSE
status or has fallback to TCP at mptcp_disconnect() time,
mptcp_do_fastclose() skips setting the `send_fastclose flag` and the later
__mptcp_close_ssk() does not reset anymore the related subflow context.

Any later connection will be created with both the `request_mptcp` flag
and the msk-level fallback status off (it is unconditionally cleared at
MPTCP disconnect time), leading to a warning in subflow_data_ready():

 WARNING: CPU: 26 PID: 8996 at net/mptcp/subflow.c:1519 subflow_data_ready (net/mptcp/subflow.c:1519 (discriminator 13))
 Modules linked in:
 CPU: 26 UID: 0 PID: 8996 Comm: syz.22.39 Not tainted 6.18.0-rc7-05427-g11fc074f6c36 #1 PREEMPT(voluntary)
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 RIP: 0010:subflow_data_ready (net/mptcp/subflow.c:1519 (discriminator 13))
 Code: 90 0f 0b 90 90 e9 04 fe ff ff e8 b7 1e f5 fe 89 ee bf 07 00 00 00 e8 db 19 f5 fe 83 fd 07 0f 84 35 ff ff ff e8 9d 1e f5 fe 90 <0f> 0b 90 e9 27 ff ff ff e8 8f 1e f5 fe 4c 89 e7 48 89 de e8 14 09
 RSP: 0018:ffffc9002646fb30 EFLAGS: 00010293
 RAX: 0000000000000000 RBX: ffff88813b218000 RCX: ffffffff825c8435
 RDX: ffff8881300b3580 RSI: ffffffff825c8443 RDI: 0000000000000005
 RBP: 000000000000000b R08: ffffffff825c8435 R09: 000000000000000b
 R10: 0000000000000005 R11: 0000000000000007 R12: ffff888131ac0000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 FS:  00007f88330af6c0(0000) GS:ffff888a93dd2000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f88330aefe8 CR3: 000000010ff59000 CR4: 0000000000350ef0
 Call Trace:
  <TASK>
  tcp_data_ready (net/ipv4/tcp_input.c:5356)
  tcp_data_queue (net/ipv4/tcp_input.c:5445)
  tcp_rcv_state_process (net/ipv4/tcp_input.c:7165)
  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1955)
  __release_sock (include/net/sock.h:1158 (discriminator 6) net/core/sock.c:3180 (discriminator 6))
  release_sock (net/core/sock.c:3737)
  mptcp_sendmsg (net/mptcp/protocol.c:1763 net/mptcp/protocol.c:1857)
  inet_sendmsg (net/ipv4/af_inet.c:853 (discriminator 7))
  __sys_sendto (net/socket.c:727 (discriminator 15) net/socket.c:742 (discriminator 15) net/socket.c:2244 (discriminator 15))
  __x64_sys_sendto (net/socket.c:2247)
  do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 RIP: 0033:0x7f883326702d

Address the issue setting an explicit `fastclosing` flag at
fastclose time, and checking such flag
subflows after mptcp_do_fastclose().

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++++---
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e484c6391b48..6c02835b6d60 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2467,10 +2467,10 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
  */
 static void __mptcp_subflow_disconnect(struct sock *ssk,
 				       struct mptcp_subflow_context *subflow,
-				       unsigned int flags)
+				       bool fastclosing)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    subflow->send_fastclose) {
+	    fastclosing) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2538,7 +2538,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
 		release_sock(ssk);
 
 		goto out;
@@ -2881,6 +2881,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 
 	mptcp_set_state(sk, TCP_CLOSE);
 	mptcp_backlog_purge(sk);
+	msk->fastclosing = 1;
 
 	/* Explicitly send the fastclose reset as need */
 	if (__mptcp_check_fallback(msk))
@@ -3415,6 +3416,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_sent = 0;
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
+	msk->fastclosing = 0;
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 41d80df1ba3e..d0b3834e98b8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -321,7 +321,8 @@ struct mptcp_sock {
 			fastopening:1,
 			in_accept_queue:1,
 			free_first:1,
-			rcvspace_init:1;
+			rcvspace_init:1,
+			fastclosing:1;
 	u32		notsent_lowat;
 	int		keepalive_cnt;
 	int		keepalive_idle;
-- 
2.52.0

