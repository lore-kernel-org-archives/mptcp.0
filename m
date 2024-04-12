Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480114D457
	for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943036; cv=none; b=q2jQ2fUkiZL4pppLPUpA62nzu643EFWgXC1udL1Hn7a3NlPxdOZLmO++kVst5gQVnAlzqP6HpgHTEpnBWhyH2sUo0wxsOlDzHf9Ydg3IuQhbdJkjNM2XtqjJC7yBBOwgQQ7AXppJXHegdgpbu7mG7uYmei1fpo0jezPxpvLCq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943036; c=relaxed/simple;
	bh=4MrwLqjax6uhkG2p9BJOl98fs7TvRo7FsUncxDo3BXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQhxAbuR5U4KfjHxe9awjdnssxmujEVszPyXSYp+8diHFFyZhTLytRVxwK0V0RPq88HxBiiViSx8c/vx1nMbAcKoA++FjcE0wuMSi654f7jbQnDu0mlbVvHCHHvsOYv1osRiYiQj9j/LmCTNCC4d35ur2fzjpeCJYLqoim4c/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sd0mjtxZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd0mjtxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712943033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o4jeO9v3doX0aLBuuXBWlk/NBkAUzpSLGPSxxqhANiU=;
	b=Sd0mjtxZEP4A6dADIUVTe8XbyJh44LPvr8EoE5Gn3xFtUeO+XvKUnMBqE56R6I5BsrcJ0g
	ZyPcsVtQ4EDKkNrIQ2+MOejzZAQykFfP9bwW1G0+pIURps6rF5hoXlAM43PnYcm0RMWsb8
	mlZWvIxbwkwLu4NU6lc7sscOcn685kI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Nl8D2XguMqqvdJ_yZ8Cpvw-1; Fri, 12 Apr 2024 13:30:32 -0400
X-MC-Unique: Nl8D2XguMqqvdJ_yZ8Cpvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3FBE104B503;
	Fri, 12 Apr 2024 17:30:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2042C1C060D0;
	Fri, 12 Apr 2024 17:30:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] mptcp: ensure snd_una is properly initialized on connect
Date: Fri, 12 Apr 2024 19:30:19 +0200
Message-ID: <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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
at connect time.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
@Christoph: could you please test this vs the above issue reproducer?
The repro doesn't work for me.
---
 net/mptcp/protocol.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e1b15d76442..68247075069b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1002,8 +1002,12 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		if (unlikely(dfrag == msk->first_pending)) {
 			/* in recovery mode can see ack after the current snd head */
-			if (WARN_ON_ONCE(!msk->recovery))
+			if (WARN_ON_ONCE(!msk->recovery)) {
+				pr_err("snd_una %llx dfrag end seq %llx frag len %d bytes sent %lld acked %lld",
+					msk->snd_una, dfrag->data_seq + dfrag->data_len, dfrag->data_len,
+					msk->bytes_sent, msk->bytes_acked);
 				break;
+			}
 
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 		}
@@ -3730,6 +3734,13 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+
+	/* after the connect, the worker (and re-injections) can trigger
+	 * at any time, and that will need snd_una properly initialized
+	 */
+	mptcp_data_lock(sk);
+	WRITE_ONCE(msk->snd_una, subflow->idsn);
+	mptcp_data_unlock(sk);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 
-- 
2.43.2

