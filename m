Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A272
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 06:40:05 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id m124so4003755pgm.13
        for <mptcp@lists.linux.dev>; Wed, 05 May 2021 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7Ozr2aR83j5lpMgMUuDf1OzzgrVuZ5PbSPx9cpiStU=;
        b=R+3hZATYNEfFogx0FoAmFDYvF93euxAqRxmQPnPTJTX7+8vmfZX936pTUOgu2fByeG
         nDUZ/wG4rcZu9nJ8v0+XqcEkPxHEB2INRTOefzPyXqnQFOfwmRSETdAbT6HIMYQm81gh
         TstohE5Dn/c/nCcS/fphV5BMtQADyAeVcOn8IzQXu/C46pWtf3lS8TXJRMksx9Q9ivWb
         1KJxblUlwlQ2aXkKgdO365mcU/OPspJCyp0v3pVuFmaKiv+YvgarEsqo6rITAwX/QsTN
         ghGrxbH6A/IK/nxhDJbTeO290SYj4XNRjaFrJy/xE5aDKJ6nLiGq+5FUyi+uA1iNlELl
         N2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7Ozr2aR83j5lpMgMUuDf1OzzgrVuZ5PbSPx9cpiStU=;
        b=T0rJT0pBPOqPFOpqcz8x+ZdEZ7dh8e7yvu5ZvN5FCE1qUo71B7utB6XvmW5X0BEudk
         vIhSYCK8gRp0L2ixI4yb36cLglWIRemtVCpaMfgGOvwJHKCi0ZxWafPOfAMJjmmMEaRD
         ZXflYNCK6Y1rIdHUvEafsM7bly/94StK3W+oMqz5UKirvNh+YgAX3pP0yYskhbCNy+vn
         UeGkEnBwhiTTF8Bg2DQhjAIuloxqIbEG7X2aeNoT0sNJlJdWDrcVU9eveKmzdjhc4p6t
         gk8eYFSe0Y8losAtsMHt3IMuemiGEm1RwzFoYKfb+Jm8TVIl+T7sJlbOlN30UJ+/nBT4
         r5Qw==
X-Gm-Message-State: AOAM5317bX2NFL7AgsFxM41LnqdxDQw6IDfxxJlph+2JXOOAEkBgQtoZ
	bp1GDocU2YM2BVRr4hRR2+3QaKUisuw=
X-Google-Smtp-Source: ABdhPJxLFUTwIa4WKKITUuqfDKpqzS2hMZbCWAchWL6XHJh5dQqUbjJ3WGeGGItx1Y0T49EgBPTduQ==
X-Received: by 2002:a63:ea06:: with SMTP id c6mr2782049pgi.401.1620283205220;
        Wed, 05 May 2021 23:40:05 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x62sm1143679pfb.71.2021.05.05.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 23:40:05 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 2/3] mptcp: MP_FAIL suboption receiving
Date: Thu,  6 May 2021 14:39:52 +0800
Message-Id: <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com>
References: <cover.1620282929.git.geliangtang@gmail.com> <f158cbfcb748b9b6792d9b316b8fa810e5cb044a.1620282929.git.geliangtang@gmail.com>
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
In it, send MP_FAIL + RST and fallback.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/pm.c       | 17 +++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 3 files changed, 36 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 485c5a77e71b..9795e3ccf6cc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -341,6 +341,16 @@ static void mptcp_parse_option(const struct sock *sk,
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
@@ -367,6 +377,7 @@ void mptcp_get_options(const struct sock *sk,
 	mp_opt->reset = 0;
 	mp_opt->csum_reqd = 0;
 	mp_opt->deny_join_id0 = 0;
+	mp_opt->mp_fail = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
@@ -1127,6 +1138,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index 639271e09604..87152a2bcbc4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -247,6 +247,23 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
 }
 
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	pr_debug("map_seq=%llu fail_seq=%llu %llu", subflow->map_seq, subflow->fail_seq, fail_seq);
+
+	if (subflow->fail_seq != fail_seq) {
+		subflow->send_mp_fail = 1;
+		subflow->fail_seq = fail_seq;
+		mptcp_subflow_reset(sk);
+	}
+
+	pr_fallback(msk);
+	__mptcp_do_fallback(msk);
+}
+
 /* path manager helpers */
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ff70b3e97dd0..fef6adef3c99 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -138,6 +138,7 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
+		mp_fail : 1,
 		echo : 1,
 		csum_reqd : 1,
 		backup : 1,
@@ -159,6 +160,7 @@ struct mptcp_options_received {
 	u64	ahmac;
 	u8	reset_reason:4;
 	u8	reset_transient:1;
+	u64	fail_seq;
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
@@ -697,6 +699,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.31.1

