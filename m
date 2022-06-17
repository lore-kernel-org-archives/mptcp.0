Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F22F2F
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 10:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655460403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYQus3YQknyusLBNs7uB0crJL6zFcmSaszgzANWh19k=;
	b=BJCcriSJY2QkSFl2HJaAVdgtecjVG8+oyxevGMFqnp0l5pHtB3ECyJiQ4f4HGTK13C9Abq
	z3xG924AFVm0ZbeFh7uqEBba0MvnFbnYhorHNOoWGg5njLBA0AYkpbxabJDACkzMuGRk1H
	nLj23snPMobUuJuJ/R7GXOGy5z/Q4yw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-uC00SaTBPI6BJ2KCqETvuw-1; Fri, 17 Jun 2022 06:06:42 -0400
X-MC-Unique: uC00SaTBPI6BJ2KCqETvuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBD03802C17
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 10:06:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7AAFE4010E4D
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 10:06:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 4/6] mptcp: fix shutdown vs fallback race
Date: Fri, 17 Jun 2022 12:05:18 +0200
Message-Id: <ef3975d8de84bb8ef404b6f8f1c6de04abf54072.1655460262.git.pabeni@redhat.com>
In-Reply-To: <cover.1655460262.git.pabeni@redhat.com>
References: <cover.1655460262.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

If the MPTCP socket shutdown happens before a fallback
to TCP, and all the pending data have been already spooled,
we never close the TCP connection.

Address the issue explicitly checking for critical condition
at fallback time.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h | 19 ++++++++++++++++---
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0bfa6662447c..57eab237c837 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -966,7 +966,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 			goto reset;
 		subflow->mp_capable = 0;
 		pr_fallback(msk);
-		__mptcp_do_fallback(msk);
+		mptcp_do_fallback(ssk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 725fd417ebb1..00ba9c44933a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1245,7 +1245,7 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
-	__mptcp_do_fallback(msk);
+	mptcp_do_fallback(ssk);
 }
 
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 077a717799a0..ad9b02b1b3e6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -941,12 +941,25 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
-static inline void mptcp_do_fallback(struct sock *sk)
+static inline void mptcp_do_fallback(struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct sock *sk = subflow->conn;
+	struct mptcp_sock *msk;
 
+	msk = mptcp_sk(sk);
 	__mptcp_do_fallback(msk);
+	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
+		gfp_t saved_allocation = ssk->sk_allocation;
+
+		/* we are in a atomic (BH) scope, override ssk default for data
+		 * fin allocation
+		 */
+		ssk->sk_allocation = GFP_ATOMIC;
+		ssk->sk_shutdown |= SEND_SHUTDOWN;
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		ssk->sk_allocation = saved_allocation;
+	}
 }
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)", __func__, a)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c82a9a6e0267..b157e275315e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1279,7 +1279,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return false;
 		}
 
-		__mptcp_do_fallback(msk);
+		mptcp_do_fallback(ssk);
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
-- 
2.35.3

