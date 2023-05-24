Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152C182D1
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684936222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXg+vaMupeIkklAkNYBEKxYeIjDDhEdSH33BXUqlVTo=;
	b=cvWJTuVdMswGboU5UdfUW6U8Tr8n0AsDfhQpK+HUZzdi95e2KkMH2t9fB28Eb9FDeQghXD
	cd7uqIeAd60Alq29q8ED2mQIrMwy/oq4gmYQEcAU9CZmNDn1XU3ETcay7bMnD1PSVd6C4o
	0vaUC0+r7s7HrLB+l7aYI1GiXuAXa0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-GzslMqhxOH-mPkcqNz7SUA-1; Wed, 24 May 2023 09:50:20 -0400
X-MC-Unique: GzslMqhxOH-mPkcqNz7SUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9116D8007D9;
	Wed, 24 May 2023 13:50:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFD537AF5;
	Wed, 24 May 2023 13:50:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v4 mptcp-next 3/6] mptcp: move snd_una update earlier for fallback socket.
Date: Wed, 24 May 2023 15:50:08 +0200
Message-Id: <cc28ac96bd6b70fbd15bc1b992c3c2e42d631407.1684935727.git.pabeni@redhat.com>
In-Reply-To: <cover.1684935727.git.pabeni@redhat.com>
References: <cover.1684935727.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

That will avoid an unneeded conditional in both the fast-path
and in the fallback case and will simplify a bit the next
patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 6 ++++++
 net/mptcp/protocol.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a8083207be4..4bdcd2b326bd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1119,6 +1119,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		mptcp_data_lock(subflow->conn);
 		if (sk_stream_memory_free(sk))
 			__mptcp_check_push(subflow->conn, sk);
+
+		/* on fallback we just need to ignore the msk-level snd_una, as
+		 * this is really plain TCP
+		 */
+		msk->snd_una = READ_ONCE(msk->snd_nxt);
+
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
 		return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9998b2dd150e..89fee2ac84e2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1006,12 +1006,6 @@ static void __mptcp_clean_una(struct sock *sk)
 	struct mptcp_data_frag *dtmp, *dfrag;
 	u64 snd_una;
 
-	/* on fallback we just need to ignore snd_una, as this is really
-	 * plain TCP
-	 */
-	if (__mptcp_check_fallback(msk))
-		msk->snd_una = READ_ONCE(msk->snd_nxt);
-
 	snd_una = msk->snd_una;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
-- 
2.40.1

