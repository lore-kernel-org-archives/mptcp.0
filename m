Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322713071
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687887677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YxKcFDTD3rimCclb8m2LxA0p+FRareNLkg59chKryFU=;
	b=FlZli0SPvuKVd4wRAvRPaRYTLrHvTD0pkBrqZsq5llkqChGpGN2t8l+naYfheHorKVhSaT
	V6VE/IaVjd/hU/Lk6lCdhfNxwcmfHhkI5vxmeo8vQ8AC20uUELSfW4aRkdGdP6XzJ0OTvw
	P9bVfdSG/6IvAItUFznrHijfz1uf4do=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-8I8hlS8WMLGyr_2GNowHGQ-1; Tue, 27 Jun 2023 13:41:15 -0400
X-MC-Unique: 8I8hlS8WMLGyr_2GNowHGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F43780027F
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 17:41:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F85D14682FC
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 17:41:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix bogus socket state update
Date: Tue, 27 Jun 2023 19:41:10 +0200
Message-Id: <4e3c5d0b8d30cd8aa36ba591be38e5ca8958edf9.1687886219.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Since the blamed commit, closing the first subflow can unexpectedly
change the msk socket state. In case of incoming fastclose, that
allows a listen() call to successfully race with a blocking recvmsg()
potentially causing the latter to hit a divide by zero bug in
cleanup_rbuf/__tcp_select_window().

Address the issue simply dropping the bogus state change.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
should close issues/414
---
 net/mptcp/protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a50eaa01ba8a..7fa9a2ce21ee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2377,7 +2377,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		 * disconnect should never fail
 		 */
 		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-		msk->subflow->state = SS_UNCONNECTED;
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
 
-- 
2.40.1

