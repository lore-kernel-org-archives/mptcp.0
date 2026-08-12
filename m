Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44E443E3F
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554513; cv=none; b=KJSfoAGcH+yr+yQYNbj9ofL/NOk+6XULx0/80TFz2moZeNyEG9a1lKQFFsYMUyraI1zDoKd1vt03dv4qtp90kGMLoE1JcIImh1pDmxBHn+UcOYIK6eXNH8H3jHNsAjcHpBPHDcJTGnwLUggaHHprrAzEn/kc3nMniGuQgaLqVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554513; c=relaxed/simple;
	bh=QdUJVrae3iLDU2cucvAzDRbw2QHWGweqLEO0IeYwasU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nChc7BCOQcg46B2kqbb3Nyl++MmwGS27QAgJoWEc8axSneKXUQw7RXhUsWujFlZ7LKJqSzs5dyq1sz7G+9ttnRfYrQvqERmSAeywTkizw3lrPwGZl/Or8lMCvBoVV2nu5vWNFHwxo3ihw4TXdWKpVX0qhDFbz30JIPVxsFJEBRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Meq8mbFk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Meq8mbFk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786554509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQWHzwPXlwM9juW6RadGEjhSY79VqqO39f0g+zuQP/o=;
	b=Meq8mbFk7CH91FHAy9olzULJB3FPODIEH5YJphJOJ/xeo0xEYiWtNrGHs5IwDE9tJg60wb
	r9dauEfARQ4OD0I9CoicULQ44tuNjcWKYNiWMyebnhsC6ZS8A9cDCxA+CQ55q1tQh7IfLc
	bI5GLTgOwf+yvlrx94oi2bySwmSaVIM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-XXa9D4F6O6up0E8-L8xMuQ-1; Wed,
 12 Aug 2026 13:08:27 -0400
X-MC-Unique: XXa9D4F6O6up0E8-L8xMuQ-1
X-Mimecast-MFC-AGG-ID: XXa9D4F6O6up0E8-L8xMuQ_1786554507
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 048521954B16
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4500A180034C
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/4] mptcp: remove unneeded READ_ONCE() annotation
Date: Wed, 12 Aug 2026 19:08:15 +0200
Message-ID: <d96944a628414e33eea6e52ef5371d71d0e1c7a3.1786553006.git.pabeni@redhat.com>
In-Reply-To: <cover.1786553006.git.pabeni@redhat.com>
References: <cover.1786553006.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 29l22gKuxC6fKVVXXnzm8BXx44OYeLhePZdfWc5gH_c_1786554507
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The subflow->fully_established flag is always written under the subflow
socket lock. Reading such value under the same lock does not require any
ONCE annotation.

Fixes: 581c8cbfa934 ("mptcp: annotate data-races around subflow->fully_established")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 97da22668dbe..11bad5670d06 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -529,7 +529,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
+	if (subflow->fully_established || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -980,7 +980,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(READ_ONCE(subflow->fully_established))) {
+	if (likely(subflow->fully_established)) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2ee23e9411be..b311fe30c785 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3912,7 +3912,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
+	if (mptcp_subflow_ctx(ssk)->fully_established)
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
-- 
2.55.0

