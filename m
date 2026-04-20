Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57937F8A3
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681017; cv=none; b=IRDegQaAoFGSJZIkVFJVooVz4pRjyi8Qd+/GpFNe9pbYjnRPaoPu8O3ZBC3LZk/maFoQSRE4eoojYWhY0AkTdnHjLRAUfLcKgGhtU8zWmZ7w8o98OAHG5wvljg9p3iR2oUHh011RdrJc96cTeK+j+HdVSseYBuztDw6MQgHetFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681017; c=relaxed/simple;
	bh=0TZXzYI7oj9pepUXXTooRXQumm8DaFReB6bUhund9CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=azSuQgyrsd3bB854TrsrEYUzPdLsHisWu/OKjGlnu0IXiK/LgjbjTRfWVU6iffNQTX5leO0KRZOsjWFEOfx4s1tVcRTNVGbZppzt1XiiiGNTHIDGm2hp/uu8cBOIQ81YIGZfXIimT/M/NSZlAPzyv1elonB8Ky6rSAUqCAJs7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyXwhGHF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyXwhGHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776681014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csMFC4kJ4S6NfPJR3o6ZrAzNqVBFjBIiAaxzcrbR1Ns=;
	b=ZyXwhGHFbqrCd6SZNlf2ud6r/OmZMznexTUfIpnYfiRcokvLAzxuGty9uxdhflFkN7KP0t
	ZVz++HFLwsmy2s5FrlS2ZitFj+i08ks+YM7aiXBIWlyVY5YwgiIleybiOcgn5Vyh77+Wkp
	A+cRjtx1y/zaJQwxLahXpEG3YaQEK4g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-tWaam23XPHevXApFhCNxrA-1; Mon,
 20 Apr 2026 06:30:11 -0400
X-MC-Unique: tWaam23XPHevXApFhCNxrA-1
X-Mimecast-MFC-AGG-ID: tWaam23XPHevXApFhCNxrA_1776681010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9362195609F;
	Mon, 20 Apr 2026 10:30:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.233])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E54C6195608E;
	Mon, 20 Apr 2026 10:30:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: yangang@kylinos.cn,
	geliang@kernel.org,
	matttbe@kernel.org
Subject: [RFC PATCH 5/6] mptcp: refine coalescing conditions
Date: Mon, 20 Apr 2026 12:29:29 +0200
Message-ID: <df5801cbaf5520b6263d5a10d7e32eba74935670.1776680489.git.pabeni@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fNaOZm5lRkCR5XdhhvA_n4DmBrMwijosZ_O2RXiExb8_1776681010
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current conditions prevent any coalescing when the receive buffer
is small. Ensure that MPTCP can always aggregate at least at max GSO size.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note:
 - or we can drop entirely the rcvbuf-related check, to be verified vs
   simult_flows tests
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9cf135e04d69..8ddd4bb5172e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -161,7 +161,7 @@ static bool __mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 
 	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||
 	    MPTCP_SKB_CB(from)->offset ||
-	    ((to->len + from->len) > (limit >> 3)) ||
+	    ((to->len + from->len) > max(U16_MAX, (limit >> 3))) ||
 	    !skb_try_coalesce(to, from, fragstolen, delta))
 		return false;
 
-- 
2.53.0

