Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB20174421
	for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189982; cv=none; b=VFzKYV4JW8MIhqWyV9eDkyWkIKj8iW+4WsqVW45bcNHQwi8lB0+B6w0LBp0qglJGajsHLqJc6fdNoy/GBKYlL4MM2FNGjzRd+MmoKrorjf1qc+qqCF6LoGapJhUr9qqR9sqGOraloGndOW5pjL3OcYK1hDpH0LIGblcO0TFq7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189982; c=relaxed/simple;
	bh=tGZ9keSRLnpJMAJJZne0eebTF/OhtIg1HAD6okbuEZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjtMCNDkwUmyzPO8i/cAo36Ixy0m+jQqDKPcGEGlkFiXEb6eqGJD7eCo7tMU/WdMkXiw9SdWdZa5/hk1QhyftIMuRXjO4h1HrXiP7SLRIKgKUXcjRwkNPrjvODcRhO2FX1478tG2qSCgRxf9O30n0oNR2IILcQG2aOy2He1ciGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGikU/8c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGikU/8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713189979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tuaQhQsZpbuueQISQ/ql1RBy0aO+JqcMdxf/9oMoJC4=;
	b=ZGikU/8crc46xZDsJUqYxJlTu7WAF6JFadwuakzMrR3lAKrx5qjLpE6FSPr47oOlKu2Yac
	vPAYclG+yXR6ZvOWMLWFKZFEjAgAqb3cuLZOpWjxVKLqUd6XzTuBW5Dcn/k4PjTnXuI8L7
	OE+KnIOvnQd1eu1l1aszmRn4tlzrkyI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-qQv2z-etNceNPhE1MmCO_w-1; Mon, 15 Apr 2024 10:06:13 -0400
X-MC-Unique: qQv2z-etNceNPhE1MmCO_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B36EA8011AF;
	Mon, 15 Apr 2024 14:06:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 147AA2BA;
	Mon, 15 Apr 2024 14:06:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net v2] mptcp: ensure snd_una is properly initialized on connect
Date: Mon, 15 Apr 2024 16:05:39 +0200
Message-ID: <864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Christoph reported a splat hinting at a corrupted snd_una:

WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
Modules linked in:
CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
 mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
 __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
 mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
 process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
 kthread+0x121/0x170 kernel/kthread.c:388
 ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

When fallback to TCP happens early on client socket, and the mptcp
worker (dumbly) tries mptcp-level re-injection, the snd_una is
not yet initialized, and the worker tries to use it to clean-up
the send buffer.

Address the issue always initializing snd_una for active sockets
at establish .

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - moved the initialization at established time (Mat)
 - dropped debug code wrongly landed in v1
 - added fixes tag

@Christoph: could you please add also the following chunk, for debug
purpouse?

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e1b15d76442..46fd84697495 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1002,8 +1002,12 @@ static void __mptcp_clean_una(struct sock *sk)

                if (unlikely(dfrag == msk->first_pending)) {
                        /* in recovery mode can see ack after the current snd head */
-                       if (WARN_ON_ONCE(!msk->recovery))
+                       if (WARN_ON_ONCE(!msk->recovery)) {
+                               pr_err("snd_una %llx dfrag end seq %llx frag len %d bytes sent %lld acked %lld",
+                                       msk->snd_una, dfrag->data_seq + dfrag->data_len, dfrag->data_len,
+                                       msk->bytes_sent, msk->bytes_acked);
                                break;
+                       }

                        WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
                }
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b94d1dca1094..25004473e7ef 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -475,12 +475,12 @@ static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_data_lock(sk);
+	WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
+	WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 	if (mp_opt) {
 		/* Options are available only in the non fallback cases
 		 * avoid updating rx path fields otherwise
 		 */
-		WRITE_ONCE(msk->snd_una, subflow->idsn + 1);
-		WRITE_ONCE(msk->wnd_end, subflow->idsn + 1 + tcp_sk(ssk)->snd_wnd);
 		subflow_set_remote_key(msk, subflow, mp_opt);
 	}
 
-- 
2.43.2

