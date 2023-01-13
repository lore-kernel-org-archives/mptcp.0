Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC1AD54
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673634069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjPkWWNE9azhq5ojepZFEiOca5tuHazJAF5vXdx5JrE=;
	b=Zatgc6QlxpGyL21piARM4sibgcoxTzLo1gmGl3Aa++kWZpf9nY2ZhrrNHI5GqYXHxmcZbx
	VhQKuoOai6XVIR43HUqP3DMveNlcj73Te88bVQWQhAzmAgcK1CLI4j1RfTRUVlnkiy4y9c
	jPC+Syr42/9wrvJvlcggD1TA9mLg5II=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-DXfj28aNNuicg3R5hx83gQ-1; Fri, 13 Jan 2023 13:21:08 -0500
X-MC-Unique: DXfj28aNNuicg3R5hx83gQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34A1E1C00423
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B01274078903
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 3/9] mptcp: drop legacy code.
Date: Fri, 13 Jan 2023 19:20:50 +0100
Message-Id: <c060bd1c364a9dae9e855b34e500a5528dae43bf.1673629755.git.pabeni@redhat.com>
In-Reply-To: <cover.1673629755.git.pabeni@redhat.com>
References: <cover.1673629755.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the previous commits the PM worker can't race anymore
with the unaccepted subflow close and disposal, as the msk
keeps a reference to such subflow.

We can remove the now irrelevant and confusing checks explicitly
preventing the mentioned race.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 7 +------
 net/mptcp/subflow.c | 7 +++----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 99c4f9e9bb90..91d5b59540e9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -988,12 +988,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	mptcp_subflow_fully_established(subflow, mp_opt);
 
 check_notify:
-	/* if the subflow is not already linked into the conn_list, we can't
-	 * notify the PM: this subflow is still on the listener queue
-	 * and the PM possibly acquiring the subflow lock could race with
-	 * the listener close
-	 */
-	if (likely(subflow->pm_notified) || list_empty(&subflow->node))
+	if (likely(subflow->pm_notified))
 		return true;
 
 	subflow->pm_notified = 1;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 769ac8b7900d..d3a17f924377 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1933,11 +1933,10 @@ static void subflow_ulp_release(struct sock *ssk)
 
 	sk = ctx->conn;
 	if (sk) {
-		/* if the msk has been orphaned, keep the ctx
-		 * alive, will be freed by __mptcp_close_ssk(),
-		 * when the subflow is still unaccepted
+		/* if the subflow has been closed by the TCP stack, keep
+		 * the ctx alive, will be freed by __mptcp_close_ssk()
 		 */
-		release = ctx->disposable || list_empty(&ctx->node);
+		release = ctx->disposable;
 		sock_put(sk);
 	}
 
-- 
2.38.1

