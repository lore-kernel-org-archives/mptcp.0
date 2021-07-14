Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3072
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:42:04 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so1445524pju.1
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYts0lTnLC4OOns897Ye4dFQFbK11BaC+JgOnXhXyiY=;
        b=uAHEmpsNME1DlBCGA69O5/EzpQQCs+U/C6G2IOOAha04UNkdhzsIq1MBwLXAWI50cQ
         qKopwzw4X1YmUKeCNio62EVxKNBAZK8EC4GjjrSAgJIvfQqwIFOGMqPPGtktFg0m5a8m
         2dFnCZerTlA39UyTQadJ6e/cveDQMXOmGEY54jq3bWCp6NCYwIaFakl27+jc8jcXhZU9
         mDNqYSaTpyQK5uEYn011Yw/rGGzz0myyTS9yi8fwDzwZxq38ohQCo+MkYQM6t1FWfGgP
         26gppGj5a2eNqHeGy9cyGZAypvPbGeXDgRBnnfP/1GIhdtJYf6Un3WX8jVD9w/FcGm3S
         37HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYts0lTnLC4OOns897Ye4dFQFbK11BaC+JgOnXhXyiY=;
        b=mjv26MiSgLYBHRLCV+cCP9dnkakBVNVJc1XT/AOu2WVOqI1BWDApyusV5VXWimszpL
         0lyWH4DfQ+AFLvbJ4xCuQ+21b3NqI4vj9F32JVwmjYAzBFxJ/TIst2LOwx5O7qCEFliH
         Hg/hS7Ukw454j/6egvNyDkPy6Gnh1gw0U8D8vZiCi3c7hDiQQx5SYthKRo+NTG0yxc9B
         0PZSSgE0uyw3OimLvLYax0or25gi932iaJjvZkKFQXTXVFtEBpx70+THcG2xHSwg0QAY
         6rVgdiRxbjTp9uBWbZefUMyBgF8ZYPfzKz2ViOHTyFRS0j2yWU988pXEoOQF74JZKfta
         8pLQ==
X-Gm-Message-State: AOAM532VSxOGwiBMOm5kvl/RhiQmMmO1BBstckhTS962jPW1E6SGbOTE
	JhFR8GGFGNdZIuqkpZiBjtoPpT+LRjPUmw==
X-Google-Smtp-Source: ABdhPJyO8cr70U/2Qb56aB5b2F+yzRcxNJutu5a5zH9B5845D0vR93omdtq2FiQKrSv42r7NnyNn/A==
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr9178999pjb.200.1626259323952;
        Wed, 14 Jul 2021 03:42:03 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x18sm2122904pfh.48.2021.07.14.03.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:03 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 2/5] mptcp: MP_FAIL suboption receiving
Date: Wed, 14 Jul 2021 18:41:54 +0800
Message-Id: <c9b00f7ce8d17ea4fb6e60c09433f36cc144a2f7.1626258797.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com>
References: <cover.1626258797.git.geliangtang@gmail.com> <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com>
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
index db7d0ad417d0..ed9a4a645459 100644
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
@@ -1137,6 +1148,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index 5a38d850f564..20f8faf0543b 100644
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
@@ -711,6 +713,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.31.1

