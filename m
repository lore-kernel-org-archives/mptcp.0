Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B635C1B2
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009153; cv=none; b=OhLOYxJyx0TSYdEiizOhlFqt6PK+TrZGiT173wR2AIdj0ZocGOMUcU+KHPUMN5x1QZn+CmWGGECw6sFi1ldOg4K9gSFpepC9eDA+NNUOHUxZkrSZ+gHbTQovPtNym+SswsoWZ1smjC7yPG2aWSSP3rWAkacBCgyEltlp3VWM4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009153; c=relaxed/simple;
	bh=r4JsKRuvCDa4Z9GlyLsr6P6Zz+0O/Vv0TbWY6skQ1xc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=muWoNJrvLYcDT5Dcy3OoR1wps/pqpbEhu0JVqhnwkz07bSc6+MrNBQ7pimvj9Nqu3Ls+WqcVHAnWlNBVL25bw4GNvXPnnhWs6+qHG7uSHc6t0/TOcxH5SjSVposxoPtj4EJ9SCq0/wtAEwQ6hA3KDX9LEntXGDVGRuaFYG4A/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrkJQWc/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrkJQWc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790009150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GxIBeAL3/IPqPXRLbC0ueu2RL7qpYYRpNvB7aFh7uSg=;
	b=VrkJQWc/BwNjSHrCIGpIautjAqWad+ktUZtf3WyYCZ3IsSeBdQ8CnSAbC5IbthESZsozvR
	pOhx8CjkJJGr4EiAUSaFpQth8s48g6Gkby3sUyIQxW71k6kvZWGa52ot6E7SoegsF2lDqv
	JDJ+D8PTeqb3sSpfnvtG72kIwwQZSB4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-FBWO0f0YOZmTzx_J4N6y7A-1; Mon,
 21 Sep 2026 12:45:48 -0400
X-MC-Unique: FBWO0f0YOZmTzx_J4N6y7A-1
X-Mimecast-MFC-AGG-ID: FBWO0f0YOZmTzx_J4N6y7A_1790009146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 254F119772DF
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 16:45:46 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EB651800446
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 16:45:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix subflow bitfield misuse
Date: Mon, 21 Sep 2026 18:45:36 +0200
Message-ID: <0342bcf7f4bc6c4598ecbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fRaEiWRv3LwgZvYRM3sUAmmyar79FjuuDKgKaLW-W2E_1790009146
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The subflow status bitfield is protected by the subflow socket
lock, with one notable exception: the `close_event_done` bit
is actually under the msk socket lock protection.

Flipping the latter bit may corrupt other entries in the same
bitfield.

Move the  `close_event_done` outside the bitfield in a 64bit
hole. Since the mentioned field is now not cleared at subflow
disconnect time, additionally remove the now unneeded `local_id`
check in mptcp_close_ssk.

Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 09779428e9ea..226cd1befe91 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2786,7 +2786,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow)
 {
 	/* The first subflow can already be closed or disconnected */
-	if (subflow->close_event_done || READ_ONCE(subflow->local_id) < 0)
+	if (subflow->close_event_done)
 		return;
 
 	subflow->close_event_done = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4bf04f9ecbd9..4be7450c3c83 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -598,10 +598,9 @@ struct mptcp_subflow_context {
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
@@ -639,6 +638,9 @@ struct mptcp_subflow_context {
 	int     cached_sndbuf;	    /* sndbuf size when last synced with the msk sndbuf,
 				     * protected by the msk socket lock
 				     */
+	bool	close_event_done;   /* netlink event generated,
+				     * protected by msk socket lock
+				     */
 
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 	struct	sock *conn;	    /* parent mptcp_sock */
-- 
2.55.0

