Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C604C77
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659118490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOxjCT/a5P87RNatFo2lM2GkXg3NSBmm+aMpbukibtQ=;
	b=ce6+Gj9sAri6MYA9D15MbdjXb/VE59Jql54+pvitwH1K//GMl2Ml3CzXoqA0eoZgq2o/uP
	bzre56njwbsahYiV06Xo1457xNKUCbK7wYTG+CWbzEc30goXxs8C0nrvZ2s3D5kOZBz0WW
	ObpLHWpgawntMewM7iIZ7Oim5VxMatQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-UADs1iQBMZeQpZG6MmSVpQ-1; Fri, 29 Jul 2022 14:14:49 -0400
X-MC-Unique: UADs1iQBMZeQpZG6MmSVpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CE7C1C05139
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 18:14:49 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91EBC1121314
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 18:14:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/4] mptcp: move RCVPRUNE event later
Date: Fri, 29 Jul 2022 20:14:38 +0200
Message-Id: <81be75dff29adfdc136035168f5bcd6d1378b0b4.1659117128.git.pabeni@redhat.com>
In-Reply-To: <cover.1659117128.git.pabeni@redhat.com>
References: <cover.1659117128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This clean the code a bit, and avoid skipping msk receive
buffer update on some weird corner case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 970da88cd04f..5af3d591a20b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -642,6 +642,10 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	}
 
+	/* over limit? can't append more skbs to msk */
+	if (__mptcp_rmem(sk) > sk_rbuf)
+		return true;
+
 	pr_debug("msk=%p ssk=%p", msk, ssk);
 	tp = tcp_sk(ssk);
 	do {
@@ -786,8 +790,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-	struct mptcp_sock *msk = mptcp_sk(sk);
-	int sk_rbuf, ssk_rbuf;
 
 	/* The peer can send data while we are shutting down this
 	 * subflow at msk destruction time, but we must avoid enqueuing
@@ -796,20 +798,9 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	if (unlikely(subflow->disposable))
 		return;
 
-	ssk_rbuf = READ_ONCE(ssk->sk_rcvbuf);
-	sk_rbuf = READ_ONCE(sk->sk_rcvbuf);
-	if (unlikely(ssk_rbuf > sk_rbuf))
-		sk_rbuf = ssk_rbuf;
-
-	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
-		return;
-	}
-
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
-	if (move_skbs_to_msk(msk, ssk))
+	if (move_skbs_to_msk(mptcp_sk(sk), ssk))
 		sk->sk_data_ready(sk);
 
 	mptcp_data_unlock(sk);
-- 
2.35.3

