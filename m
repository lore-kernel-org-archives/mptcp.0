Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E33BA222
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045994; cv=none; b=T18VqUsMzAseLIEHQLnJ2H1ydnztjdMJ9SeEhVXrV1G6IswRSyxmOYWjVv4H5wmjwD7fKWRqhJ6mQnrFeC1ZY0fSMBwS2crpvzIa6Me1PlZDS2s40pYsLKlFm2vsw55HgCoFIa7Tp5NTewTA3H7T2fZd7X1Oz1ljRUG4cqKyspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045994; c=relaxed/simple;
	bh=U1KynQWps2B+ZIfb76MVhCEOSyQ0h3nO1yz8w2hETPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=Xenim0vZIj2aREGklnl7s5QfNWdFqHW1fsnzdly2g/O8tVeERjwaB37zLqnn+NvWRqs/y2fyPce/udBVVMHu0hzztBO27XnSZarNY7TQsiqvoLZrn9iIJbVndcE0zdWyPuXpqglF0EdALpvLXdjOyVtUQdPkITI8m+8Tk8PknMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWed6nI0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWed6nI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780045991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nKO9PsWP/u6LE2WA02/2wSxjD338A6pXmALyUl5RQVM=;
	b=VWed6nI0ok9UB7tYPHgW7kGkG9T44ZFxEEJQkRvP7qG6N79AcoLxNvkFgD6LVDefog7EkQ
	BXOkl4F9qjUjqsHdZlLQ806RFVW38MEEqlk/aJr94staWiCsI6YhPFoTmB/1ttSwhBkxJD
	u7xYUKZgmQmhU9nyMNyHoFOrNp1z2hI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-rY1tWUX-OoCfh4MFXjoibQ-1; Fri,
 29 May 2026 05:13:09 -0400
X-MC-Unique: rY1tWUX-OoCfh4MFXjoibQ-1
X-Mimecast-MFC-AGG-ID: rY1tWUX-OoCfh4MFXjoibQ_1780045988
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BDDC1956094
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 09:13:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC3AB180056E
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 09:13:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix uninit-value in mptcp_established_options
Date: Fri, 29 May 2026 11:13:04 +0200
Message-ID: <d776e14d19a313dd697e3715121f4e42e915287d.1780045909.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R8p4MOJqad1cV0ZLGYWRAQXtMd5EO5g5G0jNzW22Fuw_1780045988
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

syzbot reported the following uninit splat:

=====================================================
BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options_dss net/mptcp/options.c:590 [inline]
BUG: KMSAN: uninit-value in mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 mptcp_write_data_fin net/mptcp/options.c:542 [inline]
 mptcp_established_options_dss net/mptcp/options.c:590 [inline]
 mptcp_established_options+0x112f/0x3530 net/mptcp/options.c:874
 tcp_established_options+0x312/0xcc0 net/ipv4/tcp_output.c:1192
 __tcp_transmit_skb+0x5dc/0x5fe0 net/ipv4/tcp_output.c:1575
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
 tcp_send_ack+0x3d/0x60 net/ipv4/tcp_output.c:4505
 mptcp_subflow_shutdown+0x164/0x690 net/mptcp/protocol.c:3137
 mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
 __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
 __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
 mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
 inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xd6/0x2f0 net/socket.c:1514
 __fput+0x60e/0x1010 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 __do_fast_syscall_32+0x2c7/0x460 arch/x86/entry/syscall_32.c:310
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/syscall_32.c:332
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:370
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Local variable opts created at:
 __tcp_transmit_skb+0x4d/0x5fe0 net/ipv4/tcp_output.c:1536
 __tcp_send_ack+0x967/0xad0 net/ipv4/tcp_output.c:4499
=====================================================

The output path currently omit initializing the mptcp extension `use_map`
flag in a few corner cases.
Address the issue always zeroing all the extensions flags before
eventually initializing the individual bits. To that extent, introduce
and use a struct_group to avoid multiple bitwise operations.

Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that this patch intentionally omit removing the now unneeded
		opts->ext_copy.ack64 = 0;
assignment later on in mptcp_established_options_dss(), to avoid
conflict with pending next patches.
---
 include/net/mptcp.h | 7 +++++--
 net/mptcp/options.c | 6 +++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index aef2dbeb847b..8e666347b56d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -23,7 +23,9 @@ struct mptcp_ext {
 	u32		subflow_seq;
 	u16		data_len;
 	__sum16		csum;
-	u8		use_map:1,
+
+	struct_group(flags,
+		u8	use_map:1,
 			dsn64:1,
 			data_fin:1,
 			use_ack:1,
@@ -31,9 +33,10 @@ struct mptcp_ext {
 			mpc_map:1,
 			frozen:1,
 			reset_transient:1;
-	u8		reset_reason:4,
+		u8	reset_reason:4,
 			csum_reqd:1,
 			infinite_map:1;
+	); /* end of flags group */
 };
 
 #define MPTCPOPT_HMAC_LEN	20
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2b35bdc113a5..7301225bac98 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -572,6 +572,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	unsigned int ack_size;
 	bool ret = false;
 
+	/* Zero `use_ack` and `use_map` flags with one shot. */
+	BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_ext, flags),
+				 sizeof(u16)));
+	*(u16 *)&opts->ext_copy.flags = 0;
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
@@ -595,7 +600,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	/* passive sockets msk will set the 'can_ack' after accept(), even
 	 * if the first subflow may have the already the remote key handy
 	 */
-	opts->ext_copy.use_ack = 0;
 	if (!READ_ONCE(msk->can_ack)) {
 		*size = ALIGN(dss_size, 4);
 		return ret;
-- 
2.54.0

