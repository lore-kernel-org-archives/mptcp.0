Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4402110E
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788189; cv=none; b=Q6v0O8yGV22SFxFaILx0Kl2udoTnX2IDpcqiOt86tfczE/RgSua/y/yNd3VVronIvImIvmUFiuHifdF6s0pAGSkxswHbcYmLnXF97JpHzz0d7cb6Z2xC3gxVQd525Bq/SUoinzYd56wTJPQSAxNz6gN8ysWZ/38V+JXH9l3QucA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788189; c=relaxed/simple;
	bh=QZC2GbyatsjmsTXmET/5NTOz+d9crLFzNnxQTpjybZQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=Ir+4nGqHTaCtHCjovw7w0p/rm+74wFxFJvrH0s1Q9Pm0zKVAxP8Ii5H7uyUW19nXeZ+jjWKSiMnFppq4YN7tl69wC9W9HvFvt0fsB3TGwHs6cciHxIAxoUPN8dKmn2fYT74l9ML++xInxO3wfYx5w8Z3WgrmBlYiRSCcmX502L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxQou3DA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxQou3DA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764788186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cTytbF+jt922KXdzH3Cm4Dhr+hyqBIt+1ZDWbyw8xrQ=;
	b=JxQou3DA7KZLK4qddZIaYbkUwfdGBXfMWUa0OBYoFnXsp8lISrN/+SGvxiMFW/K7U9pevX
	vU5NeecapFdpZ0IZg9DFcby8LZ8KOmXwQWbNVaQE1xpBiim/oWIz8W3sDtzoD1OwhquVzu
	bsJ2UI+M7kR7GnmFKvd7p2Io25VmwnM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-nVonuhYHPM2HJo6VzGvA-g-1; Wed,
 03 Dec 2025 13:56:24 -0500
X-MC-Unique: nVonuhYHPM2HJo6VzGvA-g-1
X-Mimecast-MFC-AGG-ID: nVonuhYHPM2HJo6VzGvA-g_1764788184
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 076951800245
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:56:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FCB11955F2D
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:56:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: avoid deadlock on fallback while reinjecting
Date: Wed,  3 Dec 2025 19:55:25 +0100
Message-ID: <6ad37e65c7501b061811e79b45f7898cff838a4e.1764788106.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tDzGwSknOGjGGyV-_jWcTkibayr30bJQ6QqDUo_XUMM_1764788184
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Jakub reported an MPTCP deadlock at fallback time:

 WARNING: possible recursive locking detected
 6.18.0-rc7-virtme #1 Not tainted
 --------------------------------------------
 mptcp_connect/20858 is trying to acquire lock:
 ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280

 but task is already holding lock:
 ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&msk->fallback_lock);
   lock(&msk->fallback_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by mptcp_connect/20858:
  #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
  #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
  #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0

 stack backtrace:
 CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
 Hardware name: Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6f/0xa0
  print_deadlock_bug.cold+0xc0/0xcd
  validate_chain+0x2ff/0x5f0
  __lock_acquire+0x34c/0x740
  lock_acquire.part.0+0xbc/0x260
  _raw_spin_lock_bh+0x38/0x50
  __mptcp_try_fallback+0xd8/0x280
  mptcp_sendmsg_frag+0x16c2/0x3050
  __mptcp_retrans+0x421/0xaa0
  mptcp_release_cb+0x5aa/0xa70
  release_sock+0xab/0x1d0
  mptcp_sendmsg+0xd5b/0x1bc0
  sock_write_iter+0x281/0x4d0
  new_sync_write+0x3c5/0x6f0
  vfs_write+0x65e/0xbb0
  ksys_write+0x17e/0x200
  do_syscall_64+0xbb/0xfd0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7fa5627cbc5e
 Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
 RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
 RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
 RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
 R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c

The packet scheduler could attempt a reinjection after receiving an
MP_FAIL and before the infinite map has been transmitted, causing a
deadlock since MPTCP needs to do the reinjection atomically from WRT
fallback.

Address the issue explicitly avoiding the reinjection in the critical
scenario. Note that this is the only fallback critical section that
could potentially send packets and hit the double-lock.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp-dbg/results/412720/1-mptcp-join-sh/stderr
Fixes: f8a1d9b18c5e ("mptcp: make fallback action and fallback decision atomic")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cd5a19ab3ba1..2df36a125816 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2769,10 +2769,13 @@ static void __mptcp_retrans(struct sock *sk)
 
 			/*
 			 * make the whole retrans decision, xmit, disallow
-			 * fallback atomic
+			 * fallback atomic, note that we can't retrans even
+			 * when an infinite fallback is in progress, i.e. new
+			 * subflows are disallowed.
 			 */
 			spin_lock_bh(&msk->fallback_lock);
-			if (__mptcp_check_fallback(msk)) {
+			if (__mptcp_check_fallback(msk) ||
+			    !msk->allow_subflows) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
 				goto clear_scheduled;
-- 
2.52.0

