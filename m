Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AE2D595A
	for <mptcp@lists.linux.dev>; Sun,  9 Nov 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696419; cv=none; b=djpwLhH0LUlgXQT62tQK/JCld65TYc6QQQ11dc41V614lI8p6PLfTpLmmpY8m5h3/SGDPR7pvVrSBtRxUv1wlJV946Ahu/3G4XICIPS4SvAHHkjZ40XQjWjl/vG1aumFpdXQ+qwXNhPg+MN92mGIpu138CT2pj59s/nNDwwufXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696419; c=relaxed/simple;
	bh=FKaTiGuEXDTFkscifAJrZnqrENC5jb2Hx/lQUXXLSVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=CmB3niToO46Kr4Dp94EYKrsyOomzbkmImnSGhI+gwRsfR48MPqqzcLl4QvZsXpbOVlUVXeZiyqAw445ncHfrORy2iZpxIsTNITf1Zv3p+YnyfVSVCIvI5ssAx4YJeQgCrepC7RDGSNVghE9BvzxruG2vAi+8t/t6hV8tG6v6oaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqFjn1el; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqFjn1el"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762696415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMzb5Cy70il6kpI3arliHl/hq6MpCpCj8GWikxwAFQQ=;
	b=WqFjn1elZwrbU4zkwdnwl2BxyJ16Spq6hXMSCiNB7EYs4L7LdrWZ1NCzLnLKzUJahlMaxW
	O9Glc6gfZve7hWmKq0fJtk/WYGGHDbmh0KLB2aKGTeD5Ppx8DO6RVOLExjMMlPV0mYZIvP
	HljKgOl0fsi24VwS/5IQVhAFSFObpUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-ACw3DnOzN7yZCiJK39gw6A-1; Sun,
 09 Nov 2025 08:53:34 -0500
X-MC-Unique: ACw3DnOzN7yZCiJK39gw6A-1
X-Mimecast-MFC-AGG-ID: ACw3DnOzN7yZCiJK39gw6A_1762696413
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5372B1800447
	for <mptcp@lists.linux.dev>; Sun,  9 Nov 2025 13:53:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 852BB1955BE3
	for <mptcp@lists.linux.dev>; Sun,  9 Nov 2025 13:53:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next] Squash-to: "mptcp: leverage the backlog for RX packet processing"
Date: Sun,  9 Nov 2025 14:53:30 +0100
Message-ID: <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yeIm-2mQYtQCGL7bxsF_l5DENxQqamx83OewSg0cXtc_1762696413
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
 net/mptcp/protocol.c | 46 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5e9325c7ea9c..d6b08e1de358 100644
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
 
@@ -4095,8 +4097,48 @@ static void mptcp_graph_subflows(struct sock *sk)
 		if (!ssk->sk_socket)
 			mptcp_sock_graft(ssk, sk->sk_socket);
 
+		if (!mem_cgroup_from_sk(sk))
+			goto unlock;
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
+
+unlock:
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

