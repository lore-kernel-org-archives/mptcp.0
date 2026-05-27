Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BECA3F1665
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878786; cv=none; b=cnVDDaA2e3KkmQi7HC/AJTrKuJJc73qNYRxXLRVxtjBfPpJBxkn10nSH4crK44e3R1rULfDRgYPqXCpua/J4h3DLrNPvuDO4Q2CeNtKOLtaTfTVhugYp/XYp7syM56w5V4KFml+4d1Dk1cKxU7cQ6kpQqv9teiW71VLNm7+KpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878786; c=relaxed/simple;
	bh=q2y6wYZ1kFZxhyFm2Sr8uf28Z+yUkWk2d7xtyKkHR30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=g7nuUFt3Oi2K/LIitQ6fwq0bu2tnNf44VZJ303ymnV7k63kC6l9qPrtDMYBCliuLCBzrZ05u0gGyyjRtw2Duyu+sALnaCtNk8qfr8pij/z7Ns+WzqKZRkRrgz58ZA4XoXwdN9+jfJO40ND/PcDrkinDcv93KL6TxUgK66V+aZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kbbvq3WS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kbbvq3WS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779878784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt9SaCLUquw51iOI5MDSGLtvCvn1tQArR3VoX8zNqoQ=;
	b=Kbbvq3WSX9e3dEurQytzS/+Uc31ieETnYguTrxCniF1qJ/teXyOVjxyWPf0c+ZT/VX2Tdp
	wqvjn2cINgy3sB0UhJzbUtUtqQw4QzaCuZlxu6HYGj7TZkqp7FzNNaJySaFTzT993Ie0UO
	k4qo7PEcHxbKk1PpQruMgep4V7f4ag4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-7_4iAceIO92Qo0I-kfqy7g-1; Wed,
 27 May 2026 06:46:22 -0400
X-MC-Unique: 7_4iAceIO92Qo0I-kfqy7g-1
X-Mimecast-MFC-AGG-ID: 7_4iAceIO92Qo0I-kfqy7g_1779878782
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E64A9195608F
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.107])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 284D719560AB
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 10:46:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v9 mptcp-next 1/6] mptcp: allow subflow rcv wnd to shrink
Date: Wed, 27 May 2026 12:45:31 +0200
Message-ID: <b58529a069f4fd67118ade4dc792ab6887d426c0.1779876523.git.pabeni@redhat.com>
In-Reply-To: <cover.1779876523.git.pabeni@redhat.com>
References: <cover.1779876523.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WkPDQ8qnqTvZfystsF8k0B_nSBHfS2S921iFcW0uawk_1779878782
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In MPTCP connection, the `window` field in the TCP header refers to the
MPTCP-level rcv_nxt and it's right edge should not move backward. Such
constraint is enforced at DSS option generation time.

At the same time, the TCP stack ensures independently that the TCP-level
rcv wnd right's edge does not move backward. That in turn causes artificial
inflating of the MPTCP rcv window when the incoming data is acked at the
TCP level and is OoO in the MPTCP sequence space (or lands in the backlog).

As a consequence, the incoming traffic can exceed the receiver rcvbuf size
even when the sender is not misbehaving.

Prevent such scenario forcibly allowing the TCP subflow to shrink the
TCP-level rcv wnd regardless of the current netns setting.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4d72f286a485..97ea4aa37b33 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -566,6 +566,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int dss_size = 0;
 	struct mptcp_ext *mpext;
 	unsigned int ack_size;
@@ -614,6 +615,12 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	if (dss_size == 0)
 		ack_size += TCPOLEN_MPTCP_DSS_BASE;
 
+	/* The caller is __tcp_transmit_skb(), and will compute the new rcv
+	 * wnd soon: ensure that the window can shrink.
+	 */
+	if (skb)
+		tp->rcv_wnd = tp->rcv_nxt - tp->rcv_wup;
+
 	dss_size += ack_size;
 
 	*size = ALIGN(dss_size, 4);
-- 
2.54.0

