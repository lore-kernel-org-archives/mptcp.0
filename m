Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858265F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:40:59 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id e14so4194215plj.2
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0uBn4cEdyDd1GQuFKfmDOF3O++amt2KaQqZKRrVlMY=;
        b=oNC2AEKSwTVFqkxOx3W2+uUasKkhCUp8r9Ig3bayZbp6NTHzTI6EXnJxVZP3XWx0TY
         8CZykG+4Y2tRuQ0nJZPZjHqi0KFasaYUkDirO8mvvyX3q+jkcOdTlTx6ajveROrpQZdG
         m8HFKTMkjZS/g8tbcAzkr2stRlTqsGvsV2PnD+Tx711dg0Zx3rACp9+0kwCM+kWqf3Va
         WFYfyPoHHYL6FMk2CPY7keUqzJLLe1sennk4FPrqMMbsR8i6uLy1EJb4vxXAv6NMVHbX
         bpeVsa8SbSu+9Kn25xaj32Xtnqt7+pbg0DMEzogkC4u4DkvWfm0Ek28ggfUGr5U5Joux
         YSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0uBn4cEdyDd1GQuFKfmDOF3O++amt2KaQqZKRrVlMY=;
        b=J230wNQTv414AOdaEg8JwuVXcY2gfVuTMBd6fPxEP5KJ2V70PRWqMwT2xCCrW0Y6i6
         TZoGf5IHlkP5FLIFBjkev5Ow+qTiq1SViY+QPjStkmSn4iI8/Hw+OQD1ZvqujcGX9XMC
         HFPVWE6YY7NFTFroLn/ewSW2GMx9ispoyNW1a0PgIWwzqTLctxWW/uDF9ZLUsL2Xx5Dn
         qO8ik4uR5K+GsfrLK8YknD1dW1i9OFIlvYoIZZk8Vuv+CbPC0qHWLWaMgfi2lv2JptbV
         0srL+/knKgsPclndRKUDgiF7xVu1ac0AwLinwqBEEwmBPsstOxS3YUPlh97xMgQSXjQr
         Bzlg==
X-Gm-Message-State: AOAM532AlTjtFd49/ay0/306RwurDkFSSEt/OmZlXyEYktJLZT6rWJzo
	mgDBFZJK0HBYTyznmlwn0SZqCGCy3+sd8Q==
X-Google-Smtp-Source: ABdhPJw4Cx1TupaToNNgoLBeD9+7bugSqw0ziYMtpigc+axKyaElgfKznPPtbNl+YjOWFU5Jwbwy4g==
X-Received: by 2002:a17:902:6ac3:b029:e6:c6a3:a697 with SMTP id i3-20020a1709026ac3b02900e6c6a3a697mr28829464plt.2.1617014458792;
        Mon, 29 Mar 2021 03:40:58 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 12sm15546454pgw.18.2021.03.29.03.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:40:58 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 02/16] mptcp: generate the data checksum
Date: Mon, 29 Mar 2021 18:40:33 +0800
Message-Id: <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add a new member named csum in struct mptcp_ext, implemented a
new function named mptcp_generate_data_checksum().

Generate the data checksum in mptcp_sendmsg_frag, save it in mpext->csum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 net/mptcp/protocol.h |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 83f23774b908..23bbd439e115 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -23,6 +23,7 @@ struct mptcp_ext {
 	u64		data_seq;
 	u32		subflow_seq;
 	u16		data_len;
+	__sum16		csum;
 	u8		use_map:1,
 			dsn64:1,
 			data_fin:1,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 56103814afed..b053f92a8ee1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1254,6 +1254,25 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
 	return __mptcp_alloc_tx_skb(sk, ssk, sk->sk_allocation);
 }
 
+static __sum16 mptcp_generate_data_checksum(struct sk_buff *skb)
+{
+	struct csum_pseudo_header header;
+	struct mptcp_ext *mpext;
+	__wsum csum;
+
+	mpext = mptcp_get_ext(skb);
+
+	header.data_seq = mpext->data_seq;
+	header.subflow_seq = mpext->subflow_seq;
+	header.data_len = mpext->data_len;
+	header.csum = 0;
+
+	csum = skb_checksum(skb, 0, skb->len, 0);
+	csum = csum_partial(&header, sizeof(header), csum);
+
+	return csum_fold(csum);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1352,6 +1371,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		tcp_push_pending_frames(ssk);
 	}
 out:
+	if (READ_ONCE(msk->csum_enabled))
+		mpext->csum = mptcp_generate_data_checksum(tail);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 826019bb2093..b13b95cedb5e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -332,6 +332,13 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);
 }
 
+struct csum_pseudo_header {
+	u64 data_seq;
+	u32 subflow_seq;
+	u16 data_len;
+	__sum16 csum;
+};
+
 struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
-- 
2.30.2

