Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CF2FB7
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 12:02:54 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id e33so4544286pgm.3
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eFpCkhuS5UXJH1UbFLEDu9o1tRKdXjIXAhsh3wJkvs=;
        b=TCZ4WQU5fPrhed1arIMzrQdD9KAro/yUHKMzmhgfEpqw40I5q/Oi9LDFksBczrpZTO
         N2dYqJkOX0HBS8SvUpWBf10M4mPu2TYVTSdbr/t7DXgh2wuQ+3/xAu8lStQbwkALxymf
         8YryNYxyk0S8/C9Z/RsQolO5Fcg/OkWhGuvx7fimn8sTCNdGwfMbAC3oWFBJHbjwnaqz
         iBhJBOZRGljalfuxkw0lKnsG0Hn5oU53ctkLOYhXc+hpk7qztfKKFuZpV7kXLTA93k1b
         06UpGkLK9t7YZgzkpKSUD/QNkMOi05mmO5XaS1yteKjXZUzAZzS5tOEiaujuBcfK+HN6
         Dycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4eFpCkhuS5UXJH1UbFLEDu9o1tRKdXjIXAhsh3wJkvs=;
        b=X4pkN8Fbc+UyDmp69/MN3QTHeGgWuxEt/o+3JKgrRTRShi/kqkQOwAihgswsAPgIKg
         WQ36Dw2GIOh7qktyfRkbkTJK1yQlFeTqk+UxX9fitNXFtFTruiweO03+UZIz/QTadvIf
         TSci0qioC8L5Cai/wNv0dfMGN7jBTAMrMJnE9nJWc/RqsRpOiT1Z4F62g5DUBctgs/r4
         36pocu11SgrfkrSJNFy7QK7kZgVPYlRAfe2hZLFMNffL6LScX688/ZM4/l0iFJHhHyT5
         kC//OaEUJ+Bnz17iJKMw//1a4PWNbwwmBkDxbuPIw/t7sT1qLoDbFD6IvwKURKI+x1KU
         Kf4w==
X-Gm-Message-State: AOAM532ZvQlqF3E7MvLV8jfwJpFgTmPEmIo9UHNTbnxZyJVedoSUwy9N
	+aZYHGyTrk3Qh2m600gjQMDJ5WYiLbg2iA==
X-Google-Smtp-Source: ABdhPJyiDCwq0j98TXK0Vb3rhvhrIPlYSoVLaEzysX2krR2k+djkFS75g7iz8VExRQGigcSqvkfksw==
X-Received: by 2002:a63:ec43:: with SMTP id r3mr4408322pgj.344.1624536173876;
        Thu, 24 Jun 2021 05:02:53 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h24sm2863824pfn.180.2021.06.24.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:02:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 2/5] mptcp: MP_FAIL suboption receiving
Date: Thu, 24 Jun 2021 20:02:43 +0800
Message-Id: <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added handling for receiving MP_FAIL suboption.

Add a new members mp_fail and fail_seq in struct mptcp_options_received.
When MP_FAIL suboption is received, set mp_fail to 1 and save the sequence
number to fail_seq.

Then invoke mptcp_pm_mp_fail_received to deal with the MP_FAIL suboption.
In it, if there is no other established subflow, fallback to TCP.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/pm.c       | 13 +++++++++++++
 net/mptcp/protocol.h | 16 ++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eac23ceb9843..cd4d0521556d 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -336,6 +336,16 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		mp_opt->reset_reason = *ptr;
 		break;
 
+	case MPTCPOPT_MP_FAIL:
+		if (opsize != TCPOLEN_MPTCP_FAIL)
+			break;
+
+		ptr += 2;
+		mp_opt->mp_fail = 1;
+		mp_opt->fail_seq = get_unaligned_be64(ptr);
+		pr_debug("MP_FAIL: data_seq=%llu", mp_opt->fail_seq);
+		break;
+
 	default:
 		break;
 	}
@@ -364,6 +374,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mp_opt->deny_join_id0 = 0;
+	mp_opt->mp_fail = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1123,6 +1134,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		mp_opt.mp_prio = 0;
 	}
 
+	if (mp_opt.mp_fail) {
+		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+		mp_opt.mp_fail = 0;
+	}
+
 	if (mp_opt.reset) {
 		subflow->reset_seen = 1;
 		subflow->reset_reason = mp_opt.reset_reason;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 639271e09604..d7792f6e38ba 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -247,6 +247,19 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
 }
 
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	pr_debug("map_seq=%llu fail_seq=%llu", subflow->map_seq, fail_seq);
+
+	if (!mptcp_has_another_subflow_established(sk)) {
+		pr_fallback(msk);
+		__mptcp_do_fallback(msk);
+	}
+}
+
 /* path manager helpers */
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fd36c743c638..62fe09394624 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -139,6 +139,7 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
+		mp_fail : 1,
 		echo : 1,
 		csum_reqd : 1,
 		backup : 1,
@@ -160,6 +161,7 @@ struct mptcp_options_received {
 	u64	ahmac;
 	u8	reset_reason:4;
 	u8	reset_transient:1;
+	u64	fail_seq;
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
@@ -591,6 +593,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
 }
 
+static inline bool mptcp_has_another_subflow_established(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	mptcp_for_each_subflow(msk, tmp) {
+		if (tmp->fully_established && tmp != subflow)
+			return true;
+	}
+
+	return false;
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
@@ -703,6 +718,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.31.1

