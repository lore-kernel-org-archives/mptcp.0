Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD64A688B
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160557; cv=none; b=Sf8gPBCYlfOWs6ro63hNbQgMJu0TVio0K9WCq8vOwUiluoiOW547M0v23boZ+nXQaHrzRq0W4ySM2cDbtmnV8W7FV4iv9HPl0ii5AwZbTTlvLHnzZGA6PLwBx6iDNiBdCqFD36XXR9NoUmpbbOpyWRn60jg/oxekjSs54NCDTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160557; c=relaxed/simple;
	bh=uF7Nd+DEI8OkPrNNU+anLFNb/IT8yI5R0LSGe/uYY1w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=hyUkouzluCzXe+j4UE5H9zZwrLRAOckNN7xKBjZ5RIWi0zBQDtJyeEwQOyBAyf+tdmGXhaIa+iQTfTWvk3PTvE2lmgG7cV+VWfc/JPHdabqt+fVag1rw0sU2EwO2XlaRB/9qab19OJR04QeXou3LkOPZkmkx8wGaw4i0LHnutnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGXQDkxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGXQDkxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790160548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ENP9UMFSWCe+OPI9OILK7XMUayYQ6X9O+NkcQKFBksw=;
	b=VGXQDkxw3x2L4MP+Qr4y7MouiffkLufYEENHgvkxidZdtDnn6njdHgvyGkcN/Z89VeP6ya
	x3idNl7aCaj1nb5Vs2w04mzxYTgBjKaL4i77/tTzJpYOS/GpTD4KbRwliWATfuSFeOmQ50
	Oki16ugrCVOPb8xp+/OISNZEB5roQ78=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-1ropILAaMEKfyYNuyZ7oFQ-1; Wed,
 23 Sep 2026 06:49:06 -0400
X-MC-Unique: 1ropILAaMEKfyYNuyZ7oFQ-1
X-Mimecast-MFC-AGG-ID: 1ropILAaMEKfyYNuyZ7oFQ_1790160546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6BCD195609D
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 10:49:05 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC8B218005B8
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 10:49:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2] mptcp: fix subflow bitfield misuse
Date: Wed, 23 Sep 2026 12:47:29 +0200
Message-ID: <0c859a0153b64833949f03be2391e4d2a60f8d6d.1790160379.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fIHhrbHFeeuqm9e5eljUQ5n9QDYlmgFNsfPlpWwgDwY_1790160546
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The subflow status bitfield is protected by the subflow socket
lock, with one notable exception: the `close_event_done` bit
is actually under the msk socket lock protection.

Flipping the latter bit may corrupt other entries in the same
bitfield.

Move the  `close_event_done` outside the bitfield in a 32bit
hole.

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - place close_event_done in the reset area, drop the chunk in
    mptcp_close_ssk
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4bf04f9ecbd9..d18272fee2be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -598,14 +598,16 @@ struct mptcp_subflow_context {
 		closing : 1,	    /* must not pass rx data to msk anymore */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	bool	close_event_done;   /* netlink event generated,
+				     * protected by msk socket lock
+				     */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u32	local_nonce;
-- 
2.55.0

