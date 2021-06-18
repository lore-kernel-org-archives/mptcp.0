Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31271
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624038996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e1rGyfq4UvN8Kx94+TjJSyhmZ2zH9ife2bRFR5pwln4=;
	b=KwpAanrCBRtxblaliOdvFECTWKyibpTerPOA+f8eLJqJQRbyVZvW9vMKmVm6SAe/tfj01x
	7gaui6AoC0LeFRUz1PEPXwpw6xTxopXbENXGg39onNC0dp0V9q/wSaOIUqmEh/mIa5DaSJ
	TpLg2eC4Ch3nhzIZIAE2NU9T6UKIbwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-KAYRvwBeNbOTHSlw3pWYKg-1; Fri, 18 Jun 2021 13:56:34 -0400
X-MC-Unique: KAYRvwBeNbOTHSlw3pWYKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2148100C609
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 17:56:33 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-48.ams2.redhat.com [10.36.115.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48AB45F9B7
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 17:56:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: drop duplicate mptcp_setsockopt() declaration
Date: Fri, 18 Jun 2021 19:56:26 +0200
Message-Id: <c3038e2051a4b0a718e868b9129b5c6ecc682fef.1624038975.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

commit 7896248983ef ("mptcp: add skeleton to sync msk socket
options to subflows") introduced a duplicate declaration of
mptcp_setsockopt(), just drop it.

Reported-by: Florian Westphal <fw@strlen.de>
Fixes: 7896248983ef ("mptcp: add skeleton to sync msk socket options to subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2480db50cbd2..fce3f34800ff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -783,9 +783,6 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
 
-int mptcp_setsockopt(struct sock *sk, int level, int optname,
-		     sockptr_t optval, unsigned int optlen);
-
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
 void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
 
-- 
2.26.3

