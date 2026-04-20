Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C66399377
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681018; cv=none; b=qMGtpBIPgJTyIhNpASZd32nperYnTmmZe+rSc9vsVxDOrrp0FVTr5WHPcI8Cdj/J9V5t2wTJmFqe3u9WKGgwB560s6AU26ZGEXAzJEP/Tk1Z3HpPwl8Y1JS2EmNn7VVoAIPwcpMEEMCM9RbAnXffskP2PULav1jlIKyHjoYOQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681018; c=relaxed/simple;
	bh=i0RrDDrd+hFVsmXhX6F7M++BkBVutE2T0LexjliuH+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=V7r+g0sRCNpSxxZlWVM7T0ud7Ek1BntIRLyXd9N4JG4tdFfShJUZCJQFEWoaM046/DsxnWhII9uiMCG5S8r0z7hrK1m6pVdNPYBxv9IjQWx79OjACORbAOgOvGoVMkyd+nJf0Wce4oXRIAA65JgIFC7OMY6l6tHBUeWr251lS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZN9UeA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZN9UeA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yxSuS76vMLmzgVW7whv3CCFI8Q3HZjI3RSdYor1u5Q=;
	b=WZN9UeA6Cc4aQRlNGh9AiPfsOIiWlWuQSxb0T0FmoCzqJYK1kLj7UOJpfh4mxPwpXls8gj
	zqPfET33ONxAP+jeydh/eXtOHXsM1MDkmAnuU8URbqG3GgU4Hwdpbv7qB9wd/zqn/DPihb
	LrGW73+vD4L1uaHN2V5Vub5LdQOLaak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-ZxqIpUddP4O6fJQmaKtNOw-1; Mon,
 20 Apr 2026 06:30:13 -0400
X-MC-Unique: ZxqIpUddP4O6fJQmaKtNOw-1
X-Mimecast-MFC-AGG-ID: ZxqIpUddP4O6fJQmaKtNOw_1776681012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 040B9180036E;
	Mon, 20 Apr 2026 10:30:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DBFB195608E;
	Mon, 20 Apr 2026 10:30:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [RFC PATCH 6/6] mptcp: unclone skbs before coalescing them, when needed
Date: Mon, 20 Apr 2026 12:29:30 +0200
Message-ID: <c8ee14698e08774aab1a0ec0d995c87997dc3b32.1776680489.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WP-GE_HBnWEgsZgRzJI0yEVPi-dgB5bEpry1FWTfBlg_1776681012
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The self-test can trigger skb coalescing on clones skb, as the
forward path uses only veth devices. That in turn prevents coalescing
making memory pressure scenario more extreme.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Possibly we could obtain the same effect with some netem magic, would
be better.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8ddd4bb5172e..42af9f9e935d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -162,6 +162,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
 	    ((to->len + from->len) > max(U16_MAX, (limit >> 3))) ||
+	    (skb_cloned(to) && skb_unclone(to, GFP_ATOMIC)) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-- 
2.53.0

