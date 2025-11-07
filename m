Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78550313531
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554309; cv=none; b=H3dzjyUe3t/1m+zj1kXDsCAysPAwSh7+qVdu3rUSoMNFt9fqJKFdF7umpSqXWvbxFTrFPR4cU6TyvS9Exr1bSiJM35xwH9BN9OK2bvyL611oU4zq0wdkiHny2ycVFiTaw13sFyMelROhj5KDzxDOzjxtv2n6u7c9u7mHXeQD92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554309; c=relaxed/simple;
	bh=TTQWkaVUnJaySbIvx8DKaASj8x92w7/cplwy6kScPEA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=TAa4PH0PeB4vH0UnyuiGfVyPytgdSla0gSkLNoagz+XJcanmcW87s3w/bMRbYUcdxaN21sLuRH8bfU1aqfEQmJ+dRF1qaFSXrj+3SfAo1So11mfHEMQyw3XDtQ9iETE49r5BXe3mRR8oVYjn++u99wjjIs+6IXHx5szs2r77LDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/LEgt5w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/LEgt5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762554303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/lB4EUm6GX1gcsmgMVtY2QcFJHbpXjMqMfLeTEkvtVA=;
	b=O/LEgt5w3c9IADYcCJ82rEzeqygJugAwRpjQSlg24R0cPr2zpc4RblHRlT/qpbya3AkzlV
	JeOihA1f0MiG4CBRgs6H9AXdEtAZAsbODMIiK0JrvyGxt8nP2jIJfBn1rDjhim7IwtBBFm
	ZYKDdDxM3V8Gx4ESIpa9+CV6IBd5Mw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-WH6xvICHPmyXk9hoBtES8w-1; Fri,
 07 Nov 2025 17:25:02 -0500
X-MC-Unique: WH6xvICHPmyXk9hoBtES8w-1
X-Mimecast-MFC-AGG-ID: WH6xvICHPmyXk9hoBtES8w_1762554301
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DBDD1956061
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 22:25:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E37F18002AC
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 22:25:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: leverage the backlog for RX packet processing"
Date: Fri,  7 Nov 2025 23:24:53 +0100
Message-ID: <f9ee505fd5da965ab78beb4d51e6f479ad8fe4f7.1762553784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efddq3grVLOOP2ojLLiOiies9iXe46NCu5pyOVkHHz0_1762554301
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If a subflow receives data before gaining the memcg while the msk
socket lock is held at accept time, or the PM locks the msk socket
while still unaccepted and subflows push data to it at the same time,
the mptcp_graph_subflows() can complete with a non empty backlog.

The msk will try to borrow such memory, but (some) of the skbs there
where not memcg charged. When the msk finally will return such accounted
memory, we should hit the same splat of #597.
[even if so far I was unable to replicate this scenario]

This patch tries to address such potential issue by:
- preventing the subflow from queuing data into the backlog after
  gaining the memcg. This ensure that at the end of the look all the
  skbs in the backlog (if any) are _not_ memory accounted.
- mem charge the backlog to msk
- 'restart' the subflow and spool any data waiting there.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5e9325c7ea9c..7e58d35f6b13 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4082,10 +4082,12 @@ static void mptcp_graph_subflows(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk;
+	int old_amt, amt;
+	bool slow;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
+		ssk = mptcp_subflow_tcp_sock(subflow);
 
 		slow = lock_sock_fast(ssk);
 
@@ -4095,8 +4097,46 @@ static void mptcp_graph_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
+		if (!mem_cgroup_from_sk(sk))
+			continue;
+
 		__mptcp_inherit_cgrp_data(sk, ssk);
 		__mptcp_inherit_memcg(sk, ssk, GFP_KERNEL);
+
+		/* Prevent subflows from queueing data into the backlog
+		 * as soon as cg is set; note that we can't race
+		 * with __mptcp_close_ssk setting this bit for a really
+		 * closing socket, because we hold the msk socket lock here.
+		 */
+		subflow->closing = 1;
+		unlock_sock_fast(ssk, slow);
+	}
+
+	if (!mem_cgroup_from_sk(sk))
+		return;
+
+	/* Charge the bl memory, note that __sk_charge accounted for
+	 * fwd memory and rmem only
+	 */
+	mptcp_data_lock(sk);
+	old_amt = sk_mem_pages(sk->sk_forward_alloc +
+			       atomic_read(&sk->sk_rmem_alloc));
+	amt = sk_mem_pages(msk->backlog_len + sk->sk_forward_alloc +
+		     atomic_read(&sk->sk_rmem_alloc));
+	amt -= old_amt;
+	if (amt)
+		mem_cgroup_sk_charge(sk, amt, GFP_ATOMIC | __GFP_NOFAIL);
+	mptcp_data_unlock(sk);
+
+	/* Finally let the subflow restart queuing data. */
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+
+		slow = lock_sock_fast(ssk);
+		subflow->closing = 0;
+
+		if (mptcp_subflow_data_available(ssk))
+			mptcp_data_ready(sk, ssk);
 		unlock_sock_fast(ssk, slow);
 	}
 }
-- 
2.51.0

