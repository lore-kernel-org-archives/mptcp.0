Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9526A2106
	for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658769064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6d9M0WpQgGw088fIU9GIxO1Q0Z9KkVQlFkXRlyxQ1f0=;
	b=JTYPiX6N8gXW2FnFuG0ZVVQ24t2jRyVMZgWb+yeuMvOv/01WryuJG01Wi7RKgLvxjLpoGQ
	EKHw17l/2ZHU/8PaxkWkI13fN6v7DD8r5IjPGN9Rp2BUexiA5XNlw7d4NTU7DvKFONcv5p
	lGa5qduryt5znagdTJt8aqjUattU/0w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-1bdl3bBHNoCok7PnhA4XHQ-1; Mon, 25 Jul 2022 13:11:01 -0400
X-MC-Unique: 1bdl3bBHNoCok7PnhA4XHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D021C29ABA05;
	Mon, 25 Jul 2022 17:11:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF10403D0D9;
	Mon, 25 Jul 2022 17:11:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dipanjan Das <mail.dipanjan.das@gmail.com>
Subject: [PATCH mptcp-net] mptcp: do not queue data on closed subflows
Date: Mon, 25 Jul 2022 19:10:50 +0200
Message-Id: <937464128633daa18ebc093215ac04487f001b3f.1658769042.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Dipanjan reported a syzbot splat at close time:

WARNING: CPU: 1 PID: 10818 at net/ipv4/af_inet.c:153
inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
Modules linked in: uio_ivshmem(OE) uio(E)
CPU: 1 PID: 10818 Comm: kworker/1:16 Tainted: G           OE
5.19.0-rc6-g2eae0556bb9d #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events mptcp_worker
RIP: 0010:inet_sock_destruct+0x6d0/0x8e0 net/ipv4/af_inet.c:153
Code: 21 02 00 00 41 8b 9c 24 28 02 00 00 e9 07 ff ff ff e8 34 4d 91
f9 89 ee 4c 89 e7 e8 4a 47 60 ff e9 a6 fc ff ff e8 20 4d 91 f9 <0f> 0b
e9 84 fe ff ff e8 14 4d 91 f9 0f 0b e9 d4 fd ff ff e8 08 4d
RSP: 0018:ffffc9001b35fa78 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000002879d0 RCX: ffff8881326f3b00
RDX: 0000000000000000 RSI: ffff8881326f3b00 RDI: 0000000000000002
RBP: ffff888179662674 R08: ffffffff87e983a0 R09: 0000000000000000
R10: 0000000000000005 R11: 00000000000004ea R12: ffff888179662400
R13: ffff888179662428 R14: 0000000000000001 R15: ffff88817e38e258
FS:  0000000000000000(0000) GS:ffff8881f5f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007bc0 CR3: 0000000179592000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 __sk_destruct+0x4f/0x8e0 net/core/sock.c:2067
 sk_destruct+0xbd/0xe0 net/core/sock.c:2112
 __sk_free+0xef/0x3d0 net/core/sock.c:2123
 sk_free+0x78/0xa0 net/core/sock.c:2134
 sock_put include/net/sock.h:1927 [inline]
 __mptcp_close_ssk+0x50f/0x780 net/mptcp/protocol.c:2351
 __mptcp_destroy_sock+0x332/0x760 net/mptcp/protocol.c:2828
 mptcp_worker+0x5d2/0xc90 net/mptcp/protocol.c:2586
 process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
 worker_thread+0x623/0x1070 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
 </TASK>

The root cause of the problem is that an mptcp-level (re)transmit can
race with mptcp_close() and the packet scheduler checks the subflow
state before acquiring the socket lock: we can try to (re)transmit on
an already closed ssk.

Fix the issue checking again the subflow socket status under the
subflow socket lock protection. Additionally add the missing check
for the fallback-to-tcp case.

Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Fixes: d5f49190def6 ("mptcp: allow picking different xmit subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c |  8 +++++++-
 net/mptcp/protocol.h | 11 +++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cc21fafd9726..7c7670942e76 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1275,6 +1275,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			 info->limit > dfrag->data_len))
 		return 0;
 
+	if (unlikely(!__tcp_can_send(ssk)))
+		return -EAGAIN;
+
 	/* compute send limit */
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
@@ -1448,7 +1451,8 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
 			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		return __tcp_can_send(msk->first) &&
+		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 
 	/* re-use last subflow, if the burst allow that */
@@ -1599,6 +1603,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					continue;
 				mptcp_push_release(ssk, &info);
 				goto out;
 			}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 480c5320b86e..93d783039fce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -625,16 +625,19 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 
-static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+static inline bool __tcp_can_send(const struct sock *ssk)
 {
-	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+	/* only send if our side has not closed yet */
+	return ((1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+}
 
+static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+{
 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
 	if (subflow->request_join && !subflow->fully_established)
 		return false;
 
-	/* only send if our side has not closed yet */
-	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
+	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
 }
 
 void mptcp_subflow_set_active(struct mptcp_subflow_context *subflow);
-- 
2.35.3

