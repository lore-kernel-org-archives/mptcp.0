Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FC525F
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679654093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9GO2VWaT72JtcXIy+uf6+7swMpN5pG/GDYGi+BER5k=;
	b=RcpYx5FgZ+XSotq8vUU3dtmvA6dnROHyzbH/ZRSJKyk3atUi3tBsuCE0gNLGKv2pJnYj5Q
	J6RuQMzNfLx89pYGNkLLMJiFPA0+eDBpm2Np3sdgB4Z6/m2AubIiizw8dMXJp+L5uQtH3n
	kNmdEslo9sDjDpssXPlDySFbbF9Z0JA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-gYWev4_FPtO4w8OtxiGt0A-1; Fri, 24 Mar 2023 06:34:52 -0400
X-MC-Unique: gYWev4_FPtO4w8OtxiGt0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5E4088904E
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:34:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75F302166B2B
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:34:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] mptcp: stricter state check in mptcp_worker
Date: Fri, 24 Mar 2023 11:34:39 +0100
Message-Id: <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
In-Reply-To: <9aa2681941d55c2ae198167c86c3d0b8ecfbf551.1679654040.git.pabeni@redhat.com>
References: <9aa2681941d55c2ae198167c86c3d0b8ecfbf551.1679654040.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As reported by Christpher, the mptcp protocol can run the
worker when the relevant msk socket is in an unexpected state:

connect()
// incoming reset + fastclose
// the mptcp worker is scheduled
mptcp_disconnect()
// msk is now CLOSED
listen()
mptcp_worker()

Leading to the following splat:

divide error: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 21 Comm: kworker/1:0 Not tainted 6.3.0-rc1-gde5e8fd0123c #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:__tcp_select_window+0x22c/0x4b0 net/ipv4/tcp_output.c:3018
RSP: 0018:ffffc900000b3c98 EFLAGS: 00010293
RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8214ce97 RDI: 0000000000000004
RBP: 000000000000ffd7 R08: 0000000000000004 R09: 0000000000010000
R10: 000000000000ffd7 R11: ffff888005afa148 R12: 000000000000ffd7
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000405270 CR3: 000000003011e006 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tcp_select_window net/ipv4/tcp_output.c:262 [inline]
 __tcp_transmit_skb+0x356/0x1280 net/ipv4/tcp_output.c:1345
 tcp_transmit_skb net/ipv4/tcp_output.c:1417 [inline]
 tcp_send_active_reset+0x13e/0x320 net/ipv4/tcp_output.c:3459
 mptcp_check_fastclose net/mptcp/protocol.c:2530 [inline]
 mptcp_worker+0x6c7/0x800 net/mptcp/protocol.c:2705
 process_one_work+0x3bd/0x950 kernel/workqueue.c:2390
 worker_thread+0x5b/0x610 kernel/workqueue.c:2537
 kthread+0x138/0x170 kernel/kthread.c:376
 ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
 </TASK>

This change address the issue explicitly checking for bad states
before running the mptcp worker.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/374
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a8add6aa74c..1116a64d072e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2697,7 +2697,7 @@ static void mptcp_worker(struct work_struct *work)
 
 	lock_sock(sk);
 	state = sk->sk_state;
-	if (unlikely(state == TCP_CLOSE))
+	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
 	mptcp_check_data_fin_ack(sk);
-- 
2.39.2

