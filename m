Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9A1FD4
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676992; cv=none; b=cfuAXpajIb9kItILeojEPt9rvR9b2Kb/qvZSzPmHQGLuZeVRqCA3yS8kevWmKH87sAxDhsNmo/MFehCHe5KbSGFBgzQcMs3SlE5cKQr66jUvyODVLPRt1Iq2ZTu8pFi3h66xuW3p2yTtACJuoj0Ah8QSBLAjGhN/vbgAVyvslow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676992; c=relaxed/simple;
	bh=ctpO3ZGeWyhIwAxEY/KuZY6NtJ0UXNQa6o35LS0kTpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=jLzcOzxOe1H+fCTD4Q2jWnRWW6w5BliUz8G3MTqbT11HL6XgtDFlfhCUfagb5fQYBbf/5mZXOvB3mxGXmL2sZOQOuD4/WgLFpWc0CJErC0Fv35LwUfSYylzvvWeCQC/hmY5U58YmnqPi0pcL/1S3X65K5ei0thMtHf17nlUkZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJe/zFfL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJe/zFfL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763676990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l1P+EVt1UlqAETGV4LYu/f08j2PTmmWemBqxi4gF2YM=;
	b=GJe/zFfLtWAzVBl9Byh8ig6bH20Oth3RZKvgfhbD7NlPstKb0YlLgLsrY/6Lf8+kJK1Zot
	JeHzws6LYeOshDTk/iZyiaf7IuVIntrqZ0EAeT+tnpXuTvxH8yJMQ2iehKGsi3VRIKgjn0
	tVmH2UrVLE/zCoyyRH1Wxul+9mjiCxg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-5767HhrrN7OSSNLfXtJYTQ-1; Thu,
 20 Nov 2025 17:16:27 -0500
X-MC-Unique: 5767HhrrN7OSSNLfXtJYTQ-1
X-Mimecast-MFC-AGG-ID: 5767HhrrN7OSSNLfXtJYTQ_1763676987
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D31571800473
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 22:16:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.89])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7667830044DB;
	Thu, 20 Nov 2025 22:16:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
Subject: [PATCH mptcp-net] mptcp: clear scheduled subflows on retransmit
Date: Thu, 20 Nov 2025 23:16:13 +0100
Message-ID: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y5RDov8raVwwPVFTcUszHnwWdFPU_PKs3c3LXOCNxUg_1763676987
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When __mptcp_retrans() kicks-in, it schedules one or more subflow for
retransmission, but such subflows could be actually left alone if there
is no more data to retransmit and/or in case of concurrent fallback.

Scheduled subflows could be processed much later in time, i.e. when new
data will be transmitted, leading to bad subflow selection.

Explicitly clear all scheduled subflows before leaving the retransmission
function.

Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f4220c8b5bb..3b327e9ccb78 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2763,7 +2763,7 @@ static void __mptcp_retrans(struct sock *sk)
 		}
 
 		if (!mptcp_send_head(sk))
-			return;
+			goto clear_scheduled;
 
 		goto reset_timer;
 	}
@@ -2794,7 +2794,7 @@ static void __mptcp_retrans(struct sock *sk)
 			if (__mptcp_check_fallback(msk)) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				return;
+				goto clear_scheduled;
 			}
 
 			while (info.sent < info.limit) {
@@ -2826,6 +2826,15 @@ static void __mptcp_retrans(struct sock *sk)
 
 	if (!mptcp_rtx_timer_pending(sk))
 		mptcp_reset_rtx_timer(sk);
+
+clear_scheduled:
+	/* If no rtx data was available or in case of fallback, there
+	 * could be left-over scheduled subflows; clear them all
+	 * or later xmit could use bad ones
+	 */
+	mptcp_for_each_subflow(msk, subflow)
+		if (READ_ONCE(subflow->scheduled))
+			mptcp_subflow_set_scheduled(subflow, false);
 }
 
 /* schedule the timeout timer for the relevant event: either close timeout
-- 
2.51.1

