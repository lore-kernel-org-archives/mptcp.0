Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1B24F4F
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668534401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3dqkIL2B8oNXVPILETvyHYm0W01vqDkIgrUNTcXe0E=;
	b=On/pahcNZ/jvnW7AMUGSYTWXDxt4bj7UBLhq3V7/Lgk5MRrC7ZCRsLSRUKc/1ewLMyySoe
	b3zb/FjvcYLjCGkfaq1Ii2uSX+7/lw3bD4nmTPwZwccP+vtC0hxDxWlToaP2D+4zfBPlxL
	h/1QVJmVbJb9H3gtIVi2SqPU1t391I0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-2CtQt505OJyxxpaqdnWfKw-1; Tue, 15 Nov 2022 12:46:38 -0500
X-MC-Unique: 2CtQt505OJyxxpaqdnWfKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B37753C0E442
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 436BB2166B2B
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] Squash-to "mptcp: implement delayed seq generation for passive fastopen"
Date: Tue, 15 Nov 2022 18:45:13 +0100
Message-Id: <ea8908dce28e3be0bfe76e6187b18f612aff2d23.1668531744.git.pabeni@redhat.com>
In-Reply-To: <cover.1668531722.git.pabeni@redhat.com>
References: <cover.1668531722.git.pabeni@redhat.com>
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

After "mptcp: consolidate initial ack seq generation" we don't need
anymore to do the crypto hash in the fastopen code, the caller already
did it for us.

Just drop the duplicated code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index ee6cfbba6c05..19c332af0834 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -11,16 +11,8 @@ void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sk_buff *skb;
-	u64 ack_seq;
-
-	mptcp_crypto_key_sha(mp_opt->sndr_key, NULL, &ack_seq);
-	ack_seq++;
 
 	mptcp_data_lock(sk);
-	WRITE_ONCE(msk->can_ack, true);
-	WRITE_ONCE(msk->ack_seq, ack_seq);
-	atomic64_set(&msk->rcv_wnd_sent, ack_seq);
-	msk->remote_key = mp_opt->sndr_key;
 	skb = skb_peek_tail(&sk->sk_receive_queue);
 	if (skb) {
 		WARN_ON_ONCE(MPTCP_SKB_CB(skb)->end_seq);
-- 
2.38.1

