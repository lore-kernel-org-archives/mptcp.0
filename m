Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121CA307AD9
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786295; cv=none; b=l6hIrR1e6FCufboZ1zP+eHG5mYofkVUUeUsKkt9Log5z2/P0jIGhzlf8hkxfYgzh/oA/mHMMozFo4cVfanm5zztHHhMBtYH0OiUWEtjt5sa5QFB2yLTsuk9IQmS3CCOhdtfNH8C72bo/cLwCz5qA1XG90GXjho2WrGNHIIFk8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786295; c=relaxed/simple;
	bh=X/73+89lcRcs5N0rhhm+FVux78LqubxSAr2BdgM/uco=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=d2fOKWWaEkrfApYoDb4Vc8meVIfoKmyVrpYX4NHgvwOOGROd2aQ31PgX50jq8wQvIHws69wqhfrX9ov1wQZQy+rTg816kCOGjaMbUKcIhxoP5y9dj1oj3UI89dGucAJNt0v4LOAMtGhSf2immh4hURpebNvWtZ//wJGmXFBe8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNXTacLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNXTacLD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764786290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8ehTuz5iNTdAh3dXVgduiPWYksEhy4ggvfdhWIXdW0=;
	b=VNXTacLD6rYdZJ/V9HynQ653QLeQFsrljhKSXnSPkOPpOUVQqm84p7vQf+jJtehocxUrjR
	ETvtOMd4jzCb5FtvUxFhhfndwjqogUvK03wH6skE5aZZkpg0LfjFKx3zqNryw7hwTCmaZi
	gf0fRSpYpYWKeBmsNS+L6PtNAl4N86U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-3dGc04iWO0KBE1P_wBFamQ-1; Wed,
 03 Dec 2025 13:24:47 -0500
X-MC-Unique: 3dGc04iWO0KBE1P_wBFamQ-1
X-Mimecast-MFC-AGG-ID: 3dGc04iWO0KBE1P_wBFamQ_1764786286
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA95A19560B2
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE33E19560A7
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 2/2] mptcp: ensure context reset on disconnect()
Date: Wed,  3 Dec 2025 19:24:35 +0100
Message-ID: <7789f18691733c076dcc69321963080d30ca27b9.1764786151.git.pabeni@redhat.com>
In-Reply-To: <cover.1764786151.git.pabeni@redhat.com>
References: <cover.1764786151.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jpFVGeyMHH71K7iBQm8o_YEpqTXmnbu5-x9xWyWiIG4_1764786286
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the blamed commit below, if the MPC subflow is already in TCP_CLOSE
status at mptcp_disconnect() time, mptcp_do_fastclose() skips setting
the `send_fastclose flag` and the later __mptcp_close_ssk() does not
reset anymore the related subflow context.

Any later connection will be created with both the `request_mptcp` flag
and the msk-level fallback status off, leading to a warning in
subflow_data_ready():

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

Address the issue ensuring `send_fastclose` is always set for all
subflows after mptcp_do_fastclose().

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e484c6391b48..cd5a19ab3ba1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2891,12 +2891,15 @@ static void mptcp_do_fastclose(struct sock *sk)
 
 		lock_sock(ssk);
 
+		/* Ensure that the MPC subflow will be fully disconnected/reset
+		 * by the later mptcp_destroy_common()/__mptcp_close_ssk().
+		 */
+		subflow->send_fastclose = 1;
+
 		/* Some subflow socket states don't allow/need a reset.*/
 		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
 			goto unlock;
 
-		subflow->send_fastclose = 1;
-
 		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 		 * issue in __tcp_select_window(), see tcp_disconnect().
 		 */
-- 
2.52.0

