Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2831FB3
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=barDMb2Xf6YqJ0tZHH4LwL7fLiEstH2PdV7UFCbjr2o=;
	b=R3KxFRO7+/4U1r3VfWTxIh7OCOIvDZZe6v3abd3FQPXBZfnLMMUaCBPv5Z4apGElKS5B1l
	+JfFb+GbjH0C6pascxE8zuBev8ZL+QL6L6PPEi1WoNwrSbsJf0WLMTSzkOoyampzQK1EhB
	1CB49j6WOJ+eV94B3ZoyaKlL8DGXnj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-FO-d1X3aMkCwM_3eZAJ1mw-1; Tue, 17 Jan 2023 02:37:16 -0500
X-MC-Unique: FO-d1X3aMkCwM_3eZAJ1mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5498580D0E3
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C8CE640C2064
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 05/13] mptcp: drop legacy code.
Date: Tue, 17 Jan 2023 08:36:25 +0100
Message-Id: <86e96a76504f819131cd3f6065ad0bb1b261d6b8.1673940640.git.pabeni@redhat.com>
In-Reply-To: <cover.1673940640.git.pabeni@redhat.com>
References: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
index 7b91dc57049e..6f198d6e1b22 100644
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
2.39.0

