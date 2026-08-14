Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA141A797
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714717; cv=none; b=KgyvMH9A4dBsrsLRQcq76117oy39XUm6VF4RDP7chGnbHWl9zIm8cUyEPadUvLZGpiT78VMkAAoxFTKF2KOvqHSXPkkVR75dpt8JQx4PVuxsFhPMnjv/oWVXXtTJYYv0ZX0pqchb7obxsVNO1Mprp0obCGgEPORngBjojRD97Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714717; c=relaxed/simple;
	bh=3avHYOb3K81rljOb79YclD3VMNfOHkxhcrSMbwd84Do=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YHPr3lFJqSojTeK0kyfoptALzy5hwiVQchkDsdTYYiQAW1ilCDrnM7nbGzjbdVy51XwOETmyhzaulxnj46CRZ2w3LxnPCTeK0TtxlS2LLI5GNhfter69/xnQ6cw4TpL2fn59gbxqr95Ld/TYgvbG4KfwqeYs25XmLsD0w6Y+JqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9QdWt+0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9QdWt+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786714715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22PLh90W/4k4cuL+dO0q/fKrCO9E0D7hcwTIv7AqMXg=;
	b=h9QdWt+0AAnYwVexElaHCRFxL6hJnQiTGj5hgJGz7FCNS4pxvFcH1wMOXmL8YVO9e5murP
	anbeCKbzZS5kfkoTnAQttT06qpC+iYWw2Z/Zup5uWm9p5Az8RyIh8maJRLUXRSUJHPg4DC
	8ZcsKX/fy9o+iAQxapDs4iEjOfl7qV8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-E8_g6GWIMqirUUz3FNcnoA-1; Fri,
 14 Aug 2026 09:38:33 -0400
X-MC-Unique: E8_g6GWIMqirUUz3FNcnoA-1
X-Mimecast-MFC-AGG-ID: E8_g6GWIMqirUUz3FNcnoA_1786714713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A778E1800C3A
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEDF8180034C
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH resend mptcp-net 1/4] mptcp: being below memory limit is a likely() condition
Date: Fri, 14 Aug 2026 15:38:20 +0200
Message-ID: <8719c7e65a70255ca607bc874c46b4c2388871cd.1786713351.git.pabeni@redhat.com>
In-Reply-To: <cover.1786713351.git.pabeni@redhat.com>
References: <cover.1786713351.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EMf6BkzE3jd6tK7WEnONXsASlBgneCaR5FRJWqjnjiw_1786714713
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current compiler hint annotation is wrong, due to inverted
logic in the previous revision of the relevant code.

Fixes: e468d371180d ("mptcp: implemented OoO queue pruning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2762d74f29d..f879b1061f2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -289,8 +289,8 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
  */
 static bool mptcp_can_ingest(const struct sock *sk)
 {
-	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
-			__mptcp_check_fallback(mptcp_sk(sk));
+	return likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
+	       __mptcp_check_fallback(mptcp_sk(sk));
 }
 
 static bool mptcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb)
-- 
2.55.0

