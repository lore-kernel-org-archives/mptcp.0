Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A37F7FD
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529550; cv=none; b=C0XXXJQiA5tbwouGr3xHpfmoa4AoKoskhURrDbbNAAZ8nI7qFErBAAsMkz6/AYcur+Ojj14yn/AgbX2pOcULbL0ve0sDqdmQv7ZiYs+ivErsq/NYR8WpIcyPyBTkQ3JLO2c0e8FY/xFiXtA9nwyMe5ItSzLWXtvaoKV0yq+DdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529550; c=relaxed/simple;
	bh=LCfcHdVQdcl/Gi4bY9HEk6uAfHdfc1kKfgVRi99z7jg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8mweq8UtdeutzT5auIZ25z3TbufFdWrvluZg2geTyCvoZRKru6ZfScQRzZ4Fgtl+xU+QLIfIa0N3qVbeNG+futIDbrDDvJovV7o40JNJl0KiOnSC7l6D2g9I+Xtcnlq9zSwZhs08Hx87yguL2iSM6XT0pPpdwKHl+ALmyPwiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOJ3+C0I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOJ3+C0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708529547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQymLmjohQlW5b0pHcwFfJMWUP3T/rM+9zz1QnFwPts=;
	b=XOJ3+C0I9IWEPV49lZduCF/12e5UpOY/tzYXWnaAbmVSQSI/3OtGtrYGX5gc4nbuLvW00r
	94MYXyR+fIoLmT6aZXNDvvMqThJs5a6MOl3eyPWJ7P0eG2d1gZb0Dx9npXFEgD+LQvnU4s
	+Teq7SwaYlgk2gmABnzsKtsFC8r62Bw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-NveUzipxMcSZB-3g6RRbfQ-1; Wed,
 21 Feb 2024 10:32:23 -0500
X-MC-Unique: NveUzipxMcSZB-3g6RRbfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F119B3816443
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 803FE492BE7
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 1/2] mptcp: fix possible deadlock in subflow diag
Date: Wed, 21 Feb 2024 16:32:16 +0100
Message-ID: <c376ef4c50673757067a1aa85e3123d9b20d7d49.1708529444.git.pabeni@redhat.com>
In-Reply-To: <cover.1708529444.git.pabeni@redhat.com>
References: <cover.1708529444.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Syzbot and Eric reported a lockdep splat in the subflow diag:

   WARNING: possible circular locking dependency detected
   6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted

   syz-executor.2/24141 is trying to acquire lock:
   ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
   tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
   ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
   tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137

   but task is already holding lock:
   ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
   include/linux/spinlock.h:351 [inline]
   ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
   inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #1 (&h->lhash2[i].lock){+.+.}-{2:2}:
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   __inet_hash+0x335/0xbe0 net/ipv4/inet_hashtables.c:743
   inet_csk_listen_start+0x23a/0x320 net/ipv4/inet_connection_sock.c:1261
   __inet_listen_sk+0x2a2/0x770 net/ipv4/af_inet.c:217
   inet_listen+0xa3/0x110 net/ipv4/af_inet.c:239
   rds_tcp_listen_init+0x3fd/0x5a0 net/rds/tcp_listen.c:316
   rds_tcp_init_net+0x141/0x320 net/rds/tcp.c:577
   ops_init+0x352/0x610 net/core/net_namespace.c:136
   __register_pernet_operations net/core/net_namespace.c:1214 [inline]
   register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1283
   register_pernet_device+0x33/0x80 net/core/net_namespace.c:1370
   rds_tcp_init+0x62/0xd0 net/rds/tcp.c:735
   do_one_initcall+0x238/0x830 init/main.c:1236
   do_initcall_level+0x157/0x210 init/main.c:1298
   do_initcalls+0x3f/0x80 init/main.c:1314
   kernel_init_freeable+0x42f/0x5d0 init/main.c:1551
   kernel_init+0x1d/0x2a0 init/main.c:1441
   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

   -> #0 (k-sk_lock-AF_INET6){+.+.}-{0:0}:
   check_prev_add kernel/locking/lockdep.c:3134 [inline]
   check_prevs_add kernel/locking/lockdep.c:3253 [inline]
   validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
   __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
   lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
   lock_sock_fast include/net/sock.h:1723 [inline]
   subflow_get_info+0x166/0xd20 net/mptcp/diag.c:28
   tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
   tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
   inet_sk_diag_fill+0x10ed/0x1e00 net/ipv4/inet_diag.c:345
   inet_diag_dump_icsk+0x55b/0x1f80 net/ipv4/inet_diag.c:1061
   __inet_diag_dump+0x211/0x3a0 net/ipv4/inet_diag.c:1263
   inet_diag_dump_compat+0x1c1/0x2d0 net/ipv4/inet_diag.c:1371
   netlink_dump+0x59b/0xc80 net/netlink/af_netlink.c:2264
   __netlink_dump_start+0x5df/0x790 net/netlink/af_netlink.c:2370
   netlink_dump_start include/linux/netlink.h:338 [inline]
   inet_diag_rcv_msg_compat+0x209/0x4c0 net/ipv4/inet_diag.c:1405
   sock_diag_rcv_msg+0xe7/0x410
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
   sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
   netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
   netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:745
   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
   ___sys_sendmsg net/socket.c:2638 [inline]
   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
   do_syscall_64+0xf9/0x240
   entry_SYSCALL_64_after_hwframe+0x6f/0x77

As noted by Eric we can break the lock dependency chain avoid
dumping any extended info for the mptcp subflow listener:
nothing actually useful is presented there.

Fixes: b8adb69a7d29 ("mptcp: fix lockless access in subflow ULP diag")
Reported-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 6ff6f14674aa..7017dd60659d 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 	bool slow;
 	int err;
 
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return 0;
+
 	start = nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
 	if (!start)
 		return -EMSGSIZE;
-- 
2.43.0

