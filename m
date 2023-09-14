Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8D21355
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694710941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3spK7kfYXjBeLtRekBsY8TTdAohgmRCQPN1fCq5xwnY=;
	b=A7AfbwVYpfQU9ZwHBQkBEuiDQNBvfCgpX18YrrYRo+/WBCPIOrtEeLs6KAxC+jLwJxdFgL
	hWjTJRNHzrpT/RQeUgDSN52keZB2zlcBF7kFfULQ4V7RFbImG+sJIPlLdPtRZJxtiyvAxt
	Ku945LLCfZmSwjZ2LLj8/uU8neIphg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-1TUeLC8BOAizQjtDGRkXWw-1; Thu, 14 Sep 2023 13:02:19 -0400
X-MC-Unique: 1TUeLC8BOAizQjtDGRkXWw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAFA8931343
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 17:02:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 395EE2156A27
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 17:02:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/3] mptcp: ignore notsent_lowat setting at the subflow level.
Date: Thu, 14 Sep 2023 19:02:05 +0200
Message-ID: <5699711c3526920c738895685cd771501e1553b0.1694710538.git.pabeni@redhat.com>
In-Reply-To: <cover.1694710538.git.pabeni@redhat.com>
References: <cover.1694710538.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Any latency related tuning taking action at the subflow level does
not really affect the user-space, as only the main MPTCP socket is
relevant.

Anyway any limiting setting may foul the MPTCP scheduler, not being
able to fully use the subflow-level cwin, leading to very poor b/w
usage.

Enforce notsent_lowat to be a no-op on every subflow.

Note that TCP_NOTSENT_LOWAT is currently not supported, and properly
dealing with that will require more invasive changes.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/sockopt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index f44b364b0055..453d6c78c25c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1450,6 +1450,12 @@ void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 
 	msk_owned_by_me(msk);
 
+	/* subflows must ignore any latency-related settings: will not affect
+	 * the user-space - only the msk is relevant - but will foul the
+	 * mptcp scheduler
+	 */
+	tcp_sk(ssk)->notsent_lowat = UINT_MAX;
+
 	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
 		sync_socket_options(msk, ssk);
 
-- 
2.41.0

