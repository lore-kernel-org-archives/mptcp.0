Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726CA4A3F
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668426874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXhQbFO0g4yji4J/9qSwPm1L+w7WUFfA2OrRoLHyLfE=;
	b=AYCGZLUBr0HbrEJ/F+RIXT+6FQdJu6Rn04MTgMzPYa8GKIRBfe7d0yaF3nyqm4qcbN5eDn
	DGlyLh0WozZWeNf7ziiC93fdHTPmRBtIcBWTCjgwlqiWajDlFi5J22a4iNSjF+XnMt+G5+
	GkY6Oa1816JcBCpWrEg1F/CcRlTpEyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-W52A-efsPB26dWg_OBWSsw-1; Mon, 14 Nov 2022 06:54:31 -0500
X-MC-Unique: W52A-efsPB26dWg_OBWSsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B99A9800186;
	Mon, 14 Nov 2022 11:54:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2732840C845B;
	Mon, 14 Nov 2022 11:54:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 2/3] Squash-to: "mptcp: implement delayed seq generation for passive fastopen"
Date: Mon, 14 Nov 2022 12:54:06 +0100
Message-Id: <b51634e0c9313e40ecccb67f6e8ed91114d2c07f.1668426733.git.pabeni@redhat.com>
In-Reply-To: <cover.1668426733.git.pabeni@redhat.com>
References: <cover.1668426733.git.pabeni@redhat.com>
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

fix checkpatch warning

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index b41248b50123..e1fe919c00c2 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -70,8 +70,8 @@ void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptcp_subflow_
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
 		pr_debug("msk %p moving seq %llx -> %llx end_seq %llx -> %llx", sk,
-			MPTCP_SKB_CB(skb)->map_seq,  msk->ack_seq + MPTCP_SKB_CB(skb)->map_seq,
-			MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
+			 MPTCP_SKB_CB(skb)->map_seq, MPTCP_SKB_CB(skb)->map_seq + msk->ack_seq,
+			 MPTCP_SKB_CB(skb)->end_seq, MPTCP_SKB_CB(skb)->end_seq + msk->ack_seq);
 		MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq;
 		MPTCP_SKB_CB(skb)->end_seq += msk->ack_seq;
 	}
-- 
2.38.1

