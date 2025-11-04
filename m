Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A52BDC29
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293126; cv=none; b=p5yAp1N+u0n0CY7bKikwCmdm9h5lBPlYv5tihn5wTyK38YbtbxCRzNBFXlaUe+UcTlK8D6OkinbrpahTkbe/tpxCsHlqzRagsaOhO07JOUQJcd2jdObdA4vQ4UOchhjkkDsUjLN9Q60rHvf54H6XEPb8BI3MbBQWfVBH8bk3NTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293126; c=relaxed/simple;
	bh=NwbEEdj/AkproEAao//DBLfh3z4kJOZmrZToxZxcHsY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O5arQ9R4+rVIJIpACvZIIxXu7P04A7MnfedPawTR+dY8hxjnrexvG8GgNF+qHqn/yPlN+OGk1uPgOEDIyxk8lvb08pNh/WW/1eGR9Bhy7Ib4PrVS6h1rmBB49E8ezOA+uaxXrWGJDgrh5mONTVCl+pL6tfifU+0JI4HcmbrJflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rx9d3Toh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rx9d3Toh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762293123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Li1+Jv7qbUgUpuvaSFhubFLy6xlkszRtVs8/yb6nvAU=;
	b=Rx9d3TohciYGYNQDI4Ld7e9+3F2+FKFBLZfkh35+DRo4mGTY8biM+ORBdFfSjP/Vy7Dn4q
	ZRoCNY56E/B+zsfDxgxxFWhXPN9z3FFk7HR9e9slLUe0MWDyP+kEXEeEqlElNiM/XU43MN
	nIe+e4Spj1RvSL/AoH1D0frXpTbXd4U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-Iu3qb4A9M5izlbPbca0sCQ-1; Tue,
 04 Nov 2025 16:52:02 -0500
X-MC-Unique: Iu3qb4A9M5izlbPbca0sCQ-1
X-Mimecast-MFC-AGG-ID: Iu3qb4A9M5izlbPbca0sCQ_1762293121
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AC241800669
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:52:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5637E19560A2
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:51:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/7] mptcp: avoid unneeded subflow-level drops.
Date: Tue,  4 Nov 2025 22:51:36 +0100
Message-ID: <a63ffe2578d5c161fa798c465418a20cfb3d839b.1762292476.git.pabeni@redhat.com>
In-Reply-To: <cover.1762292476.git.pabeni@redhat.com>
References: <cover.1762292476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FAmTvNxlnN4pt6-dZNPfGsqX_EO--mlKIVXmP3p7CU8_1762293121
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rcv window is shared among all the subflows. Currently, MPTCP sync
the TCP-level rcv window with the MPTCP one at tcp_transmit_skb() time.

The above means that incoming data may sporadically observe outdated
TCP-level rcv window and being wrongly dropped by TCP.

Address the issue checking for the edge condition before queuing the data
at TCP level, and eventually syncing the rcv window as needed.

Note that the issue is actually present from the very first MPTCP
implementation, but backports older than the blamed commit below will range
from impossible to useless.

Before:
nstat >/dev/null ;sleep 1; nstat -z TcpExtBeyondWindow
TcpExtBeyondWindow              14                 0.0

After:
nstat >/dev/null ;sleep 1; nstat -z TcpExtBeyondWindow
TcpExtBeyondWindow              0                  0.0

Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 31 +++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cf531f2d815c..ad51dcf18984 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,31 @@ static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_una)
 	WRITE_ONCE(msk->snd_una, new_snd_una);
 }
 
+static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
+			struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u64 mptcp_rcv_wnd;
+
+	/* Avoid touching extra cachelines if TCP is going to accept this
+	 * skb without filling the TCP-level window even with a possibly
+	 * outdated mptcp-level rwin.
+	 */
+	if (!skb->len || skb->len < tcp_receive_window(tp))
+		return;
+
+	mptcp_rcv_wnd = atomic64_read(&msk->rcv_wnd_sent);
+	if (!after64(mptcp_rcv_wnd, subflow->rcv_wnd_sent))
+		return;
+
+	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
+	 * resync.
+	 */
+	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
+}
+
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
@@ -1209,6 +1234,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 */
 	if (mp_opt.use_ack)
 		ack_update_msk(msk, sk, &mp_opt);
+	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
 	 * propagated to the MPTCP layer, so the skb extension does not
@@ -1295,6 +1321,10 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 	if (rcv_wnd_new != rcv_wnd_old) {
 raise_win:
+		/* The msk-level rcv wnd is after the tcp level one,
+		 * sync the latter.
+		 */
+		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
 		tp->rcv_wnd = min_t(u64, win, U32_MAX);
 		new_win = tp->rcv_wnd;
@@ -1318,6 +1348,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 update_wspace:
 	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+	subflow->rcv_wnd_sent = rcv_wnd_new;
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0881db16b12..f14eeb4fd884 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -513,6 +513,7 @@ struct mptcp_subflow_context {
 	u64	remote_key;
 	u64	idsn;
 	u64	map_seq;
+	u64	rcv_wnd_sent;
 	u32	snd_isn;
 	u32	token;
 	u32	rel_write_seq;
-- 
2.51.0

