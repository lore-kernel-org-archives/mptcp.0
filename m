Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807543921C9
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681005; cv=none; b=STmT39O4jLCRbTMnlz1uzzpjInpBazVF2DOfNMiHP5xjMqW0ruCVOPsu+3hxDrCPZrWb4Lq4tt6SI4lCHkhMSnwEKn6rU8ditKbw/145yDpW9fDJ2ff3+WkGtJx40ghVif7fn1OSqim77u3dJdfXdnhJ5SS6lbktAVal53jMy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681005; c=relaxed/simple;
	bh=36HkXCFvRLarh8qECxqLCdMgeYL57YifkTfP9yWtN6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bddbkgikjAUxP5pY2RpGTzLhtYHbVU1l4heAui8y9C8DDEnJ8UXiSp1PVDAsYJjzXrlzegyu9uyvGHUDa/86mA/Ts8vcPoZm3aZJNxxFW4Q8db5GBT1tbKB01tYLRV6HjpiyEV/Nd+L6vaXsOPx/21039IFrSo91oifbqDgCWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ls/fuPmC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls/fuPmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLUooHHRrG/C8VgJhCVNfnE0H3o3WsT1QHphbEO0VdY=;
	b=Ls/fuPmCgTE8OlBXiGSWrmBnTNucnnJu9evW+L8UARkHhbOTt+vjErIycCM1OEn1/GIugX
	bJA8DSdi/Ii3k8Cmjna4z349KboUNC0zwhTODZSl4f3NINWumEVDr0MREMf3nSmDbsjcrn
	6OwA7PWP4kr2LQTaMgIw1zGnpxtIuHI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-NS7cHpsqP_2QZ4lbNlSHIQ-1; Mon,
 20 Apr 2026 06:30:02 -0400
X-MC-Unique: NS7cHpsqP_2QZ4lbNlSHIQ-1
X-Mimecast-MFC-AGG-ID: NS7cHpsqP_2QZ4lbNlSHIQ_1776681001
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F323195608F;
	Mon, 20 Apr 2026 10:30:00 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DBAB195608E;
	Mon, 20 Apr 2026 10:29:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [RFC PATCH 1/6] mptcp: move checks vs rcvbuf size earlier in the RX path
Date: Mon, 20 Apr 2026 12:29:25 +0200
Message-ID: <7bd58b4078ae99c6514d356792baa75e0c4f1b9a.1776680489.git.pabeni@redhat.com>
In-Reply-To: <cover.1776680489.git.pabeni@redhat.com>
References: <cover.1776680489.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0ZDlm7WIfAa-9hFdBcQ47lA2p2lAQBt0seVmER_NerQ_1776681001
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Currently the enforcement of the rcvbuf constraint is implemented
when moving the skbs into the msk receive or OoO queue.

Under significant memory pressure the above can cause permanent data
transfer stalls. Move the checks early on, before landing even in
the subflow queues.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that:
 - this needs the follow-up patches to really fix the stall
 - the memory comparison is intentionally very rough, as
   the msk socket lock is not currently held where the condition is
   now enforced. This should require some refinement, shared as-is
   to avoid more latency on my side
---
 net/mptcp/options.c  | 21 +++++++++++++++++++--
 net/mptcp/protocol.c |  9 ++-------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..a6d290427611 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1158,8 +1158,19 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false in case of error (or subflow has been reset),
- * else return true.
+static bool mptcp_over_limit(const struct sock *sk, struct sk_buff *skb)
+{
+	int limit;
+
+	if (!skb->len)
+		return false;
+
+	limit = READ_ONCE(sk->sk_rcvbuf) << 1;
+	return sk_rmem_alloc_get(sk) > limit;
+}
+
+/* Return false when the caller must to drop the packet, i.e. in case of error,
+ * subflow has been reset, or over memory limits.
  */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
@@ -1185,6 +1196,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
+
+		if (mptcp_over_limit(subflow->conn, skb))
+			return false;
 		return true;
 	}
 
@@ -1263,6 +1277,9 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return true;
 	}
 
+	if (mptcp_over_limit(subflow->conn, skb))
+		return false;
+
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
 		return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17b9a8c13ebf..2d143b929bbf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -739,7 +739,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 
 			mptcp_init_skb(ssk, skb, offset, len);
 
-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2197,10 +2197,6 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
 
 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2229,8 +2225,7 @@ static bool mptcp_can_spool_backlog(struct sock *sk, struct list_head *skbs)
 			       mem_cgroup_from_sk(sk));
 
 	/* Don't spool the backlog if the rcvbuf is full. */
-	if (list_empty(&msk->backlog_list) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	if (list_empty(&msk->backlog_list))
 		return false;
 
 	INIT_LIST_HEAD(skbs);
-- 
2.53.0

