Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871E19441
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695368593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3spK7kfYXjBeLtRekBsY8TTdAohgmRCQPN1fCq5xwnY=;
	b=WWOowIhgVs3cZEx48ksppjkpNdXbABoW30zySj70JhNxNy395IR1lNMyMzDgtgsPnMWq0/
	mLNwTrWqZ5DUf2xzcoSVnGQiTSHdmWTcR7bdPosSrhLXZCob453pDXCDDykxwMnHKFu2lD
	E8vVoCu6UxWAiWxEXz4rqyTL4Ygak8I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-p66Gu6ExPoWFdII4m7RBKg-1; Fri, 22 Sep 2023 03:43:11 -0400
X-MC-Unique: p66Gu6ExPoWFdII4m7RBKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27AB53816C89
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 07:43:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA486140273C
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 07:43:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 3/4] mptcp: ignore notsent_lowat setting at the subflow level.
Date: Fri, 22 Sep 2023 09:43:01 +0200
Message-ID: <e473dfee355991f6f266e9e1e483a5ec552fb683.1695368456.git.pabeni@redhat.com>
In-Reply-To: <cover.1695368456.git.pabeni@redhat.com>
References: <cover.1695368456.git.pabeni@redhat.com>
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

