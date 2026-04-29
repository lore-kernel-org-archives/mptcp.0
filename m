Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080442BFC85
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460920; cv=none; b=tK/pE9UEIsKqvEeXyGRxQygmyrDe4pUghgfxcVSydHUkAUaBH02Qxc5NWxvhkrx9/sjQvr5YNNqJUVrf0Ah7VpVJfhN9Sd/XjCsQQ8nExJheDoXfjJniryqXwZlEq+NxU8KGpu9if85Cswp1neksK3lxLl+ekKHlPPhccFz4r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460920; c=relaxed/simple;
	bh=xs+DfEQS3OZqEqJZQUkiQ3u3Zhtr4bC9LsHFsv/QWO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=IZhOyqYthxrX3z6gEnikr6skchtvCtJY1qinJvQ+uhkMXjVQPxV9xaM5FqdsL8cFG4EUiZra12I6d9GSy++t5ZtnzM+1U0i1Di1phT1tzM9A0MC/4RkSNE0NwS9OQMI8SuJcP5WmE05tx5YkWMZmZIUAYzjIERqVJNM++/9mql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLREuU1C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLREuU1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777460917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z1qrjgkkirxPS5bR7WxBF06MZ+QB12CREsqv6xZvMRs=;
	b=LLREuU1CPP7Vp/hdBA5l9jtllNgZgzqmr7YT1dqgKgxmwx+hqiDXQGO8bvrRYU0mr27r+c
	/Op5ZfF8L9ac1xkex/B2O0/YQRjdLAo1F+XRCPn4RyqpKF0mlPNlpBmxK99akXIsqqwvOt
	WgKqQ+67Z+MtMvPTZmFvacnOxg546ro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-PuT63qtMNAaCHzu0NTqEqA-1; Wed,
 29 Apr 2026 07:08:36 -0400
X-MC-Unique: PuT63qtMNAaCHzu0NTqEqA-1
X-Mimecast-MFC-AGG-ID: PuT63qtMNAaCHzu0NTqEqA_1777460915
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 713A318003FC
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.34.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A11D01800480
	for <mptcp@lists.linux.dev>; Wed, 29 Apr 2026 11:08:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix rx timestamp corruption on fastopen
Date: Wed, 29 Apr 2026 13:06:02 +0200
Message-ID: <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GSJa48dhjbFQJtN4BIjPUufvcgDoBZivthTZthYRcsE_1777460915
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The skb cb offset containing the timestamp presence flag is cleared
before loading such information. Cache such value before MPTCP CB
initialization.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 82ec15bcfd7f..082c46c0f50e 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -12,6 +12,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
+	bool has_rxtstamp;
 
 	/* on early fallback the subflow context is deleted by
 	 * subflow_syn_recv_sock()
@@ -40,12 +41,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	 */
 	tp->copied_seq += skb->len;
 	subflow->ssn_offset += skb->len;
+	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
 	/* Only the sequence delta is relevant */
 	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
-	MPTCP_SKB_CB(skb)->has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
+	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
 	MPTCP_SKB_CB(skb)->cant_coalesce = 1;
 
 	mptcp_data_lock(sk);
-- 
2.53.0

