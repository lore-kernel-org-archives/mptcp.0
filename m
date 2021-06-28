Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061C170
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:18 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id g24so9261222pji.4
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u2Cse4vHa5d9H1STOIP+pQiduOLy4LL+P0cqwzAA73k=;
        b=WwmGSEK76GuY9/fA1ALCKKH6KI7JzAoXpeYWSBEWjWlUqUk4n9LD+Eh+cvKuZSnj0v
         Nr0Y6yG16tb5gIiVSlx66A8nsDcDWkP229O1+Zh1Jstg87EBx6YVCI/QCq96oGgOeM6R
         fpJ/drizBIfoUU9J71rxDa+Neny7rJpTFaK30XCrwdB8dif7UdPYQtUPPUBi6jIebI7g
         qUnM/QTLM4he66J+uwBfXB59sFm07xL4vLOdtompjPF1cOt5/qoSU8+Szp++kkVQec/9
         ZNepCSWT171PT4EATtRSpl53gsRdTKXeCTvPqhC++pE+VjJUAW3weio+WAWE+tB/UYYk
         qadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2Cse4vHa5d9H1STOIP+pQiduOLy4LL+P0cqwzAA73k=;
        b=iLpFMMFqncpiilTqRm6UiiOgbuaqD4reGTVUwe6xmaLxkgapD9n9JErMxAuJ/JihQM
         3Dwx6T1hjxjxWTwVlKXaTct1h4ipsn8Kz4c44dzif2Ss6nJfxl1qZJxM8jzqY5Q/Xnzz
         zCv84MheG6ZGkQEzFYfKn8xINlgxVykBs1l2uXbJk8VB4xfHUrvQ0HEiLRk/1tAtrLBG
         4bbhsLo24abVkaBjUvR9Nrv7feDqoKleCAqaFBcYHt6meuGIBUFnUjBbqeNW7Bmky+mB
         94HcJJKaO3lguZKt/Cx/LSKfuy0pKLynlCr4Y0mUqaj3z1hDO5dhtTc78QGmyM9iYbAN
         e+ag==
X-Gm-Message-State: AOAM533bX2bn5OJGk3ko2ibyp5fYwRE8oDbO4CHZAGUzXXa1lybbxge9
	kzbjrLPiNBEmF34aAkhO7wCTA0LLzXWSoA==
X-Google-Smtp-Source: ABdhPJwSV4HlmXqVgcV91zIRxtN1S0tm2oa0CRGsO4o23Z3VBTptvPCdjkhUSPVXb1Jx9s/y7rl2XA==
X-Received: by 2002:a17:90a:2e87:: with SMTP id r7mr35309179pjd.232.1624854558596;
        Sun, 27 Jun 2021 21:29:18 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 2/8] mptcp: MP_FAIL suboption receiving
Date: Mon, 28 Jun 2021 12:28:58 +0800
Message-Id: <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
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

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/pm.c       |  7 +++++++
 net/mptcp/protocol.h |  3 +++
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b78defe1aed9..9e6ab6a3d425 100644
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
@@ -1129,6 +1140,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index 639271e09604..d4c19420194a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -247,6 +247,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
 }
 
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+	pr_debug("map_seq=%llu fail_seq=%llu", subflow->map_seq, fail_seq);
+}
+
 /* path manager helpers */
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 007af5e4ba3d..8e050575a2d9 100644
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
@@ -704,6 +706,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.31.1

