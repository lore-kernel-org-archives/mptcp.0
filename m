Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1656730F88
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy9RqZwA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697041260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r5iGV7Dw1hSFXnVcSTlHxAczCubdOpp6aV/ZleBPgPk=;
	b=Fy9RqZwAZ2qySg0Xquuf/djKk9XcBAzTPIJwkpFrRXWgaUGed/E+7dHL1ZU5ZI4UN0Oec8
	XTIAZ5hZ28goANetqoixalD8QdYcX5mHH9ZUSlTVg9Fa+OYLfwdLc2gaiYXFk9HFCtJc6w
	uDXZ6JFIk6ONx1V8LmffkoyPvqxvXxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-59PSF1c2M5eyqZf4Y45jFw-1; Wed, 11 Oct 2023 12:20:58 -0400
X-MC-Unique: 59PSF1c2M5eyqZf4Y45jFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CFFB101A529
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 16:20:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B046906
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 16:20:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: more conservative check for zero probes.
Date: Wed, 11 Oct 2023 18:20:54 +0200
Message-ID: <036c68f42c3d071ce7e52ef69ffec650c3301268.1697040427.git.pabeni@redhat.com>
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

Christoph reported that the MPTCP protocol can find the subflow-level
write queue unexpectedly not empty while crafting a zero-window probe,
hitting a warning:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 188 at net/mptcp/protocol.c:1312 mptcp_sendmsg_frag+0xc06/0xe70
Modules linked in:
CPU: 0 PID: 188 Comm: kworker/0:2 Not tainted 6.6.0-rc2-g1176aa719d7a #47
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:mptcp_sendmsg_frag+0xc06/0xe70 net/mptcp/protocol.c:1312
RAX: 47d0530de347ff6a RBX: 47d0530de347ff6b RCX: ffff8881015d3c00
RDX: ffff8881015d3c00 RSI: 47d0530de347ff6b RDI: 47d0530de347ff6b
RBP: 47d0530de347ff6b R08: ffffffff8243c6a8 R09: ffffffff82042d9c
R10: 0000000000000002 R11: ffffffff82056850 R12: ffff88812a13d580
R13: 0000000000000001 R14: ffff88812b375e50 R15: ffff88812bbf3200
FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000695118 CR3: 0000000115dfc001 CR4: 0000000000170ef0
Call Trace:
 <TASK>
 __subflow_push_pending+0xa4/0x420 net/mptcp/protocol.c:1545
 __mptcp_push_pending+0x128/0x3b0 net/mptcp/protocol.c:1614
 mptcp_release_cb+0x218/0x5b0 net/mptcp/protocol.c:3391
 release_sock+0xf6/0x100 net/core/sock.c:3521
 mptcp_worker+0x6e8/0x8f0 net/mptcp/protocol.c:2746
 process_scheduled_works+0x341/0x690 kernel/workqueue.c:2630
 worker_thread+0x3a7/0x610 kernel/workqueue.c:2784
 kthread+0x143/0x180 kernel/kthread.c:388
 ret_from_fork+0x4d/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
 </TASK>

The root cause of the issue is that expectations are wrong: e.g. due
to MPTCP-level re-injection we can hit the critical condition.

Explicitly avoid the zero-window probe when the subflow write queue
is not empty and drop the related warning.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/444
Fixes: f70cad1085d1 ("mptcp: stop relying on tcp_tx_skb_cache")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30e0c29ae0a4..88404a9837d7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1297,7 +1297,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt) {
+		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}
@@ -1305,11 +1305,6 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		zero_window_probe = true;
 		data_seq = snd_una - 1;
 		copy = 1;
-
-		/* all mptcp-level data is acked, no skbs should be present into the
-		 * ssk write queue
-		 */
-		WARN_ON_ONCE(reuse_skb);
 	}
 
 	copy = min_t(size_t, copy, info->limit - info->sent);
-- 
2.41.0

