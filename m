Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C419CCE6
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922855; cv=none; b=aUWqlXuX50HBVHjIB8h0723OcXiinEn1+8uutsZW8CAmxJWikcjw4fQAKr8AbQR2JLGV4hQSixJ9VKYnbW1uXGLxwbB56iKS2Fb4kCg0Ic948GCKoN5U0ik9dd9h8jzxm37v3/KwBkQ824gigHxbXvxYZ4z+lW/QUsCHimH3+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922855; c=relaxed/simple;
	bh=SuLC6N7kJDpvwho4FJubawIycpPKfdv2ArLTC3gwtI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APKXUQKkPinb2jHyShikRhVBOfIKCoz2rVq5SndBOCLUYJKhNt51LCTWkqoFRVdT0Ob8KCaozMxjX/sxx89E7pKnnQTmU7djZqnujSlhuw++/4218dPHK7qMpF3O/U07UXv3sQemYEaKDGNTUsXiGvr8bOXqyN6yiHE7jXve65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTXzvu4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTXzvu4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721922852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmOTxa6fO9XuEE/aRS5veqUwt9HFjjMlw+jv2OoiOog=;
	b=QTXzvu4zEcfbOot6WGF6mDCLesehhtJSrSBTsbYcyjmBlK5AxPyCWbKYpF360xJzePaD9a
	wCkV8+IKFOJLcUWCFqQX9VDgQcxNPsFeCFf6HcBwPYjGsmQHLXcVQnl4TbN26KEVXL2wnZ
	M0GS4E/a2Ar/19OVHpbd0l9ojn5fOdY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-PX3QpnNqMSKKOwXi_McCEQ-1; Thu,
 25 Jul 2024 11:54:11 -0400
X-MC-Unique: PX3QpnNqMSKKOwXi_McCEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62B321955D53
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:54:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 786EE195605A
	for <mptcp@lists.linux.dev>; Thu, 25 Jul 2024 15:54:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] mptcp: fix duplicate data handling
Date: Thu, 25 Jul 2024 17:53:53 +0200
Message-ID: <1ca08110195a81b95a38449f1a12b5593dfad864.1721921695.git.pabeni@redhat.com>
In-Reply-To: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com>
References: <51cd83cb7690d756e9a71797b133bdd9f286de76.1721921695.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

When a subflow receives and discards duplicate data, the mptcp
stack assumes that the consumed offset inside the current skb is
zero.

With multiple subflows receiving data simultaneously such assertion
does not held true. As a result the subflow-level copied_seq will
be incorrectly increased and later on the same subflow will observe
a bad mapping, leading to subflow reset.

Address the issue tacking in account the skb consumed offset in
mptcp_subflow_discard_data().

Fixes: 04e4cd4f7ca4 ("mptcp: cleanup mptcp_subflow_discard_data()")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0e4b5bfbeaa1..a21c712350c3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1230,14 +1230,22 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-	u32 incr;
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 offset, incr, avail_len;
 
-	incr = limit >= skb->len ? skb->len + fin : limit;
+	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
+	if (WARN_ON_ONCE(offset > skb->len))
+		goto out;
+
+	avail_len = skb->len - offset;
+	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d seq=%d", incr, skb->len,
-		 subflow->map_subflow_seq);
+	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
+
+out:
 	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len)
-- 
2.45.2

