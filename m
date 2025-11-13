Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9619311969
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075253; cv=none; b=OIupN8gQ82OvxZwAV6TyszAUUjVNQbkM4vygz6nrl+LwPI//rhonpjNluA4zdDc89fIQ5bhkMbqESiVOFZKvYlx/wohFHU1nB4WqjTOedePq6gun6W/el7ZBIYkorUYLfNp++maLZ0NsjZaMtyIlcY3MGYSRngEtorl4rSc9J1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075253; c=relaxed/simple;
	bh=q+zYn5n8j/3mZQxdzIAuybQEOOzeRTUwhTd+8uQjW/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kHdDaPxj5YkTYIKFHTb5mq7YY3r5ULwAPbxfVs2IgvP2pVBHNr2RiS6AAkRtLBltGsP6u2YN+UL8TRBN2TZwi4qj09MycsTt2/Dpl1U8gS0OvAd3KdKkMW78TqjmNIhJBT3+0DVdMMKE5GSjSZwG+4OZ+4Ihyaku/1pjX+4178o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5tUVwbX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5tUVwbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763075250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53YzFswBN0IuCTAWQlwgIEh2ElrEKCex7hvo/Dn3tbc=;
	b=N5tUVwbXPhmbvssJX41O5i4gY777JXozbtrogT7lKWR0U5uN8XePgi8VLD4tvJdV/58GuD
	ydwQN2qUKhiRhEJeKTFyEsUEquMqMOzgkg+vaUqlDgrYLUzWA8ADKvwYarBxF4VndD39zp
	tg2JCmNFM8nIJObx4bUNDi+V0SVV5cU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-obhODuvVMGWQHHzanBQH9A-1; Thu,
 13 Nov 2025 18:07:29 -0500
X-MC-Unique: obhODuvVMGWQHHzanBQH9A-1
X-Mimecast-MFC-AGG-ID: obhODuvVMGWQHHzanBQH9A_1763075248
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 720B4195609F
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71F803000198
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/3] mptcp: fix premature close in case of fallback
Date: Fri, 14 Nov 2025 00:05:29 +0100
Message-ID: <03e2e84a1b632063bc6ee47779b75b72b03227c7.1763075056.git.pabeni@redhat.com>
In-Reply-To: <cover.1763075056.git.pabeni@redhat.com>
References: <cover.1763075056.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TNNPwSZm-oMdg8MxmbZ7-F5-Dg-FIyVXQVAPXCXOLoU_1763075248
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

I'm observing very frequent self-tests failures in case of fallback when
running on a CONFIG_PREEMPT kernel.

The root cause is that subflow_sched_work_if_closed() closes any subflow
as soon as it is half-closed and has no incoming data pending.

That works well for regular subflows - MPTCP needs be-directional
connectivity to operate on a given suflow - but for fallback socket is
race prone.

When TCP peer closes the connection before the MPTCP one,
subflow_sched_work_if_closed() will schedule the MPTCP worker to gracefully
close the subflow, and shortly after will do another schedule to inject and
process a dummy incoming DATA_FIN.

On CONFIG_PREEMPT kernel, the MPTCP worker can kick-in and close the
fallback subflow before subflow_sched_work_if_closed() is able to create
the dummy DATA_FIN, unexpectedly interrupting the transfer.

Address the issue explicitly avoiding closing fallback subflows on when the
peer is only half-closed.

Note that, when the subflow is able to create the DATA_FIN before the
worker invocation, the worker will change the msk state before trying to
close the subflow and will skip the latter operation as the msk will not
match anymore the precondition in __mptcp_close_subflow().

Fixes: f09b0ad55a11 ("mptcp: close subflow when receiving TCP+FIN")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 935a32217741..1b222cd3096a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2630,7 +2630,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
-		     inet_sk_state_load(sk) != TCP_ESTABLISHED))
+		     inet_sk_state_load(sk) != TCP_ESTABLISHED ||
+		     __mptcp_check_fallback(msk)))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
-- 
2.51.1

