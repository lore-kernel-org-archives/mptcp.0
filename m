Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C83FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:28 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso1249617pji.4
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNbetCXTVkOPIwZs4Xp8418mnDKVPZ04yx3PxjkEX9E=;
        b=UmVG40MhavLkT3bfT56wl3id1EfSjPH4cyM28uih5fvbcjmHOBPlBXEyZNNMG8/MVE
         LTbPkMwGkEnhQ9NFF4nr78qF5IG/Evx2cRjGDJEXwXNurdHtAn2m6OUV4mkJhwiOJay0
         5c9P67gZNePnmHvZAcuys5yO6NZz9ZtUYC3S6h1PNh1LG+yoKmcVWBg6dTDjOvedd0dk
         QPBpy+89qsWMyKnFj3499Zs9svDAgu6W29lryj7wkig/LJWMqiNh8l2O95AnWmWsv34f
         edZrcuGWObB2tIZVSB0jm0mvulKV7i+q22rbADF9TOfennptkTt3LLiVY69gnZFO/YAc
         78FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNbetCXTVkOPIwZs4Xp8418mnDKVPZ04yx3PxjkEX9E=;
        b=Ulq3EQKpA5VuYWyXo1KjqpA/XhFuD94yUlKI6ePzTsysT4rX171Of3ZCgaR7M0zCgh
         rJkh9GMiIIXyzQSY5wYmJkwCwAgPOnheVoX9ZCKiwmErg7zbCCsVZMQ2kL384XQCf2ff
         YbxaTjX2zSI2IdjpkRSMhTCM2Bq4MShlZM0SSVqnbFPuCtNM04HyEg8MusRUfWN0P6Ab
         CbbXZWkeXynfA+JzruxYjYcEaTLW22kxeVQsUswEZWDAoACYrQmXgeDq3DXhsL2+71GJ
         Y94zxFDa6liUyMW28pP883z1sQbQWXnOp8W9kt/udjd9BJ0/uZLMa2Pqvz/mD1iqLauC
         pi6Q==
X-Gm-Message-State: AOAM531yrke+cTR399fzvWciW/cJ0e8LRrBx0pf0hSD8ZfH3FO+FhDn/
	U3w7v/f70Rr1KeRTrPAjaAQYCJZwst4=
X-Google-Smtp-Source: ABdhPJxENS2qoydEnMo6i7HaS8k9HdgYqj2/9zJ8yxVQ0HfO0hh4S5ejYb7/XW7QVSPkV1W1mN9Q3w==
X-Received: by 2002:a17:90b:1c07:: with SMTP id oc7mr3070189pjb.153.1631188287585;
        Thu, 09 Sep 2021 04:51:27 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 5/9] mptcp: infinite mapping sending
Date: Thu,  9 Sep 2021 19:51:07 +0800
Message-Id: <e32e444b498565f85da14285dfc5a865fedc6e58.1631188109.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the infinite mapping sending logic.

Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
when a single contiguous subflow is in use in mptcp_pm_mp_fail_received.
In mptcp_sendmsg_frag, if this flag is true, call the new function
mptcp_update_infinite_mapping to set the infinite mapping.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..2830adf64f79 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && !READ_ONCE(msk->noncontiguous))
+		WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7ecd3e3b537..4ebbbc6f1d01 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1278,6 +1278,21 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->data_seq = READ_ONCE(msk->start_seq);
+	mpext->subflow_seq = 0;
+	mpext->data_len = 0;
+	mpext->csum = 0;
+
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
+	pr_infinite(msk);
+	__mptcp_do_infinite(msk);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1410,6 +1425,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (READ_ONCE(msk->snd_infinite_mapping_enable))
+		mptcp_update_infinite_mapping(msk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
@@ -2881,6 +2898,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
 	WRITE_ONCE(msk->noncontiguous, false);
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 77af55171ded..b4a7c54f0d78 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -253,6 +253,7 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		noncontiguous;
+	bool		snd_infinite_mapping_enable;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
-- 
2.31.1

