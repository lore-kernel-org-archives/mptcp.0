Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890D22FB4
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622134399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7c6DRvhA7xGIsqas31NB4sv0D3Dw0lAaj82iUdqhsas=;
	b=gs8sKo9GEGkwGouNW3CajUgUEnDDogNVU4FQn4dzx3oPI/rDEoYUs+JAUHgYLkmpZwGBJ9
	3aUgZXTufcV02k+Xj3xC1Ny16sWQrjpwTmnkthuiSd5Ahzqc37PZ/yFqKtdh3Ap7BndFKU
	Hu5aIRnwqitoP6p2+coSkiVlXJR/o7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-7RP_wAyANMS9SUW5m6fSRQ-1; Thu, 27 May 2021 12:53:17 -0400
X-MC-Unique: 7RP_wAyANMS9SUW5m6fSRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EBDE8015F8
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:17 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-53.ams2.redhat.com [10.36.114.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B5461349A
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: drop rendundant test in move_skbs_to_msk()
Date: Thu, 27 May 2021 18:53:05 +0200
Message-Id: <627c15b052e2ecf4a2c6a897a83da7e25db55f32.1622132917.git.pabeni@redhat.com>
In-Reply-To: <cover.1622132917.git.pabeni@redhat.com>
References: <cover.1622132917.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently we check the msk state to avoid enqueuing new
skbs at msk shutdown time.

Such test is racy - as we can't acquire the msk socket lock -
and useless, as the caller already checked the subflow
field 'disposable', covering the same scenario in a race
free manner - read and updated under the ssk socket lock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a08ea8867716..4ac55e696f52 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -686,9 +686,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned int moved = 0;
 
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return false;
-
 	mptcp_data_lock(sk);
 
 	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
-- 
2.26.3

