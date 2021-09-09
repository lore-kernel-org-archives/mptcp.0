Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D173FE1
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 11:51:20 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id f129so1531317pgc.1
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IwQx+UGeHAuHdCt1Z8OYgPtaYSyiG9TEUMf//P9Z0A=;
        b=iBf9bvqkZU04lknYC0GDiQ5rslirbulZyy50UVh55aomVZGaVr3ZiERD2oiS94O8tt
         WTRICRmwHfRPz/wwI095CkdtsCHkwhri7xrKoQo3mRNyKoX/8PlYpM7HIBv+eHiHf8NE
         as02RGL85YHL258sWJqJg+G1IAau8KMW6Wgt535G0/twLS9qOj+sgY434SMG/CVYc6bM
         DKJGUuH7jTX5bXg2wsUFSSMnzbmAokMGNWPwt1tx6n3DiTLuJnHZdr16hBcwWdigCWh4
         PetThZaCk9GcwaAzG/TM5tSchfnvYMaCx6Sgov5MBf5Eee6Qf/jd5h0XAPrNgSH+cHSV
         a8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IwQx+UGeHAuHdCt1Z8OYgPtaYSyiG9TEUMf//P9Z0A=;
        b=GjN1JM/OgrcBzDApTPU0gcU2dXEz/23xb5cbm5YeZZCgzy4/8cSwv2mn2IyXl3++6c
         OMGMWF9K0yI9NgHNMdyKe80G1ga2HvATY+BUQFs2v/PA3h1Gp5PjpgXD1Cqt36HRN5qv
         vDZEz/FBiG0CCH4Rq1FzsUE8jW2gnt6HzVcOjQCHo6qcHh82GUS7phAYJvLAQ7AUumU/
         FYeEv5121nv6r2VaWJvGTKivqg0Jq3JO2eB3NhCf9Pah5jNLf9u7TkCj3Ai9SW8A5Ues
         uMej2JfxQOiQAM+E+JJ6G3TkCc+tHmGLdtr75NCZlHR1PMKdSl1li2LIOwUIWVZZSZs3
         0EcQ==
X-Gm-Message-State: AOAM533KSPvesUhjoC+qCq8FXqSQRxmxgVSLZpVt7/gBfobtvHJaDZSb
	njkmQEptQyERdgBnRh8DNsliCDeJaTw=
X-Google-Smtp-Source: ABdhPJxkhbOeLSWVMsYoR0h8ocmCSmds1eUmV6wp9VE6IHfNVqwKq/Fp1w1mL/MJ99t3ChDfRu1Ssg==
X-Received: by 2002:a05:6a00:1255:b0:3f5:26ee:ca2c with SMTP id u21-20020a056a00125500b003f526eeca2cmr2806617pfi.62.1631188280336;
        Thu, 09 Sep 2021 04:51:20 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id n14sm2458225pjm.5.2021.09.09.04.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:51:20 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next v2 1/9] mptcp: add noncontiguous flag
Date: Thu,  9 Sep 2021 19:51:03 +0800
Message-Id: <138e3913108d313b11a261e6c9e3db2cc788183f.1631188109.git.geliangtang@xiaomi.com>
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

This patch added a "noncontiguous" flag in the msk to track whether the
data is contiguous on a subflow. When retransmission happens, we could
set this flag, and once all retransmissions are DATA_ACK'd that flag
could be cleared.

When a bad checksum is detected and a single contiguous subflow is in
use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/protocol.c |  7 +++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 12 ++++++------
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb8a2a231479..81ea03b9fff6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1095,6 +1095,9 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		dfrag_uncharge(sk, delta);
 		cleaned = true;
+
+		if (dfrag->resend_count == 0)
+			WRITE_ONCE(msk->noncontiguous, false);
 	}
 
 	/* all retransmitted data acked, recovery completed */
@@ -1171,6 +1174,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
+	dfrag->resend_count = 0;
 	dfrag->page = pfrag->page;
 
 	return dfrag;
@@ -2454,6 +2458,8 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		dfrag->resend_count++;
+		WRITE_ONCE(msk->noncontiguous, true);
 	}
 
 	release_sock(ssk);
@@ -2872,6 +2878,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
+	WRITE_ONCE(msk->noncontiguous, false);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d3e6fd1615f1..011f84ae1593 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -213,6 +213,7 @@ struct mptcp_data_frag {
 	u16 offset;
 	u16 overhead;
 	u16 already_sent;
+	u16 resend_count;
 	struct page *page;
 };
 
@@ -249,6 +250,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		noncontiguous;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1de7ce883c37..951aafb6021e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) || READ_ONCE(msk->noncontiguous)) {
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, 0);
 		return true;
 	}
-- 
2.31.1

