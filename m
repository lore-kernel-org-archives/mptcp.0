Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07179D6
	for <mptcp@lists.linux.dev>; Wed,  5 Apr 2023 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680734872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVyj89yYIn0Jz4rzUgI0a1InX+DbzGmVU60fINGM2HI=;
	b=X5LQqbqWw8+tC3BybvJHARS3II/uw2izcWgA4+njJtDFx9CAK/RFLrLyD+pAIn7ZNmJaRL
	1rGbFkVKfsg2q+BVOw5J75+0fwmXaRN13s7rQae5wef1hR95WSMpFK7kktop1STRNyV94d
	44XU+KT54KzYttkp3/AiaT9lNVbpb0Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-twyq3NnnO1-KHa9-vVBa2w-1; Wed, 05 Apr 2023 18:47:48 -0400
X-MC-Unique: twyq3NnnO1-KHa9-vVBa2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE50429AB3E3;
	Wed,  5 Apr 2023 22:47:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A10C140EBF4;
	Wed,  5 Apr 2023 22:47:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 1/2] Squash-to: "mptcp: fix accept vs worker race"
Date: Thu,  6 Apr 2023 00:47:37 +0200
Message-Id: <a515310923cd2ac4610ce62aa48b21d6d36a19eb.1680733942.git.pabeni@redhat.com>
In-Reply-To: <cover.1680733942.git.pabeni@redhat.com>
References: <cover.1680733942.git.pabeni@redhat.com>
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

2 separate fixes needed for the mentioned patch

On some exceptional scenarios (e.g. listener socket disconnecting while
the subflow is created) a newly created MPC is deleted by the TCP stack
via inet_child_forget(). When that happen we leak the subflow context
and the msk.

Address the issue explicitly detecting such scenario and forcing a full
msk shutdown.

mptcp_subflow_drop_ctx() does not remove the subflow from the msk list,
racing msk lookup done by the NL PM could fetch the msk just before
deletion, and try to free again the subflow.

Just explicitly remove the subflow from said list.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 13 +++++++++++--
 net/mptcp/subflow.c  |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0e4961e87b48..76c1814c0b19 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2378,9 +2378,18 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 * to deliver the msk to user-space.
 	 * Do nothing at the moment and take action at accept and/or listener
 	 * shutdown.
+	 * If instead such subflow has been destroyed, e.g. by inet_child_forget
+	 * do the kill
 	 */
-	if (msk->in_accept_queue && msk->first == ssk)
-		return;
+	if (msk->in_accept_queue && msk->first == ssk) {
+		if (!sock_flag(ssk, SOCK_DEAD))
+			return;
+
+		/* ensure later check in mptcp_worker will dispose the msk */
+		sock_set_flag(sk, SOCK_DEAD);
+		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32 -
+							  TCP_TIMEWAIT_LEN -1;
+	}
 
 	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
 	if (dispose_it)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3d6ccf5067d7..32e54b7fdbbc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -715,6 +715,7 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 	if (!ctx)
 		return;
 
+	list_del(&mptcp_subflow_ctx(ssk)->node);
 	subflow_ulp_fallback(ssk, ctx);
 	if (ctx->conn)
 		sock_put(ctx->conn);
-- 
2.39.2

