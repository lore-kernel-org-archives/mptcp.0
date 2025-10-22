Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FB33F8DC
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143539; cv=none; b=GOj7Xr/elzZnZNLPEUtxNhw/k8u5BFR1ABUtPC52NMfwuOAjF2EQSaeFtsztOSacLrU93pebTpZ/UJonfy18KNY0BgzvtWw1VTCc2K+Jw+AXLt+iAbxpf/hIaVtmo7meGPeWL6q1YDetBHUM3AzANWIE4iBbKogA+XtzGRLlNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143539; c=relaxed/simple;
	bh=oZyYKPe7uUMeS4kgPt35j5eo6Z61wKpmP/26cOJRnn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ndSy4N6+BbNakF4POgxjFxaSZYpHiVD7VLOUT0yIUxB7iM8KPoleiE7prycsFwAnoVwwklsE3gEYY2uif0knCUJBkLvxUJhKlXSjKbVBF6jT3Cfu0kIIzGp4Mm6KyiMxPB2XBYZNGEb67az7tAfWLOWPoY1hcd9yni+SWys8kzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUSWfigh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUSWfigh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0P+xuL6QyOomNNqsC20omlo8taSnXjOgCXp/nwpVRk8=;
	b=BUSWfigh/jxVOMCuZstis7dq0c7MRZEQZOegzyajuV8oYwK+QRPBr2+U16sYh05vFlcrTT
	ea32Mfubc6IhnL+1SSwINrYQj64q9sxuxUiB0ey3j1mz1+c6buHWPRo1GrYrKcmuh2TOqH
	H6XlISb+SiVAdoO/DL67Yp8nOlO0CVw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-qqNGzLSXOQ64VZZ5bZK2Lw-1; Wed,
 22 Oct 2025 10:32:07 -0400
X-MC-Unique: qqNGzLSXOQ64VZZ5bZK2Lw-1
X-Mimecast-MFC-AGG-ID: qqNGzLSXOQ64VZZ5bZK2Lw_1761143526
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9759419560A5;
	Wed, 22 Oct 2025 14:32:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 378D31956056;
	Wed, 22 Oct 2025 14:32:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 03/11] mptcp: cleanup fallback data fin reception
Date: Wed, 22 Oct 2025 16:31:46 +0200
Message-ID: <3d0984585464292af2c671af2f532d7251d08a7e.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0kwR2PTL4xkOuXua0hIxCaacE6PtKF9PpDxa_IJAEJA_1761143526
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP currently generate a dummy data_fin for fallback socket
when the fallback subflow has completed data reception using
the current ack_seq.

We are going to introduce backlog usage for the msk soon, even
for fallback sockets: the ack_seq value will not match the most recent
sequence number seen by the fallback subflow socket, as it will ignore
data_seq sitting in the backlog.

Instead use the last map sequence number to set the data_fin,
as fallback (dummy) map sequences are always in sequence.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - keep the close check in subflow_sched_work_if_closed, fix
    CI failures
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8325890a32238..b9455c04e8a462 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1285,6 +1285,7 @@ static bool subflow_is_done(const struct sock *sk)
 /* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
 
 	if (likely(ssk->sk_state != TCP_CLOSE &&
@@ -1303,7 +1304,8 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 	 */
 	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
 	    msk->first == ssk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
+				      subflow->map_data_len, true))
 		mptcp_schedule_work(sk);
 }
 
-- 
2.51.0

