Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F072
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:35:23 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so9073803pjb.3
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YOdjqLBqf8Dzekn/XowyzlY711ZbJxLE7bzcbdPc2jI=;
        b=JQk1ocbCxaMY497ZkYxKIN3iVhvuEevLxdJ7daJnhWLKccfkVztHE/3ZFpfXLzT9YP
         +zZeO/Lz51IfAlcNK/9fswQiIZcxnwJR2VfiZl7zH43F7h+VOZA6PkutrOF7xOzbUSKZ
         8cIjJTKwf5cUcQXP8okP0sYiM3BDMd4YxUpRmkCIfQs75eJe2Yhe9ChSmkJIZKKFm4Cc
         6LZWMydByeBuSLknZbreZPPFG7Uv90iJVAbqBo1iPu/U4KiKA0MTou76KWBMDxsZVoTm
         oUpw3jdo4g2k35jsnWFOefNd2Pjs3SunttYTgjRtQ+KYGOtKd+XCkNrQE6Axx2zzpATM
         VALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOdjqLBqf8Dzekn/XowyzlY711ZbJxLE7bzcbdPc2jI=;
        b=DzLwPIrdHh0Jt9ZFMIUj12z9x1zX2xEtVaDDJcyGvLhT7t5zZ5cc/E7bv9nih4rNxj
         quixbFT1ozuqYUBvz1XFNbqKeBPFfwMjSBX/oKKP0UvfWtUlJa6fYzTFsl8YhwjCWWeV
         4gVLGfe6IweQiUwLg6Y6MsMJrboT+oenF4gBBeLprB9tKJlMXBrwXmiAlAKvtZs2RXs6
         BWzlq3939P8/WvOWwjNlCTNHRkCUSWiZ1w8f033gecCN/xeEMS1FkxlYtrI/6TF0E1pt
         HQgCnaxK+8dzYRY0vibwCVHVwL10SJ9tNYhoS2ExejByE6uNiUJoQN/tXOXzZ58jqjj6
         obiA==
X-Gm-Message-State: AOAM533WGUNthsh0qy7tG5lAvT5YFm6I7QJOIPXvznrigC29iV7m93bw
	KB5VMIivESBCUuioQI+01ZNM2x4koO0=
X-Google-Smtp-Source: ABdhPJzwpAdQdDYGd4AUms9XVFHCySyi/Zl+1GyWUSk8hydhtzvFpiC+c8NFSrTOoNQE1C940gHMZQ==
X-Received: by 2002:a05:6a00:218a:b029:3a1:a7b7:bfb with SMTP id h10-20020a056a00218ab02903a1a7b70bfbmr6059715pfi.27.1627464922995;
        Wed, 28 Jul 2021 02:35:22 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v10sm5312560pjd.29.2021.07.28.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:35:22 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 2/5] mptcp: MP_FAIL suboption receiving
Date: Wed, 28 Jul 2021 17:35:09 +0800
Message-Id: <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com> <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added handling for receiving MP_FAIL suboption.

Add a new members mp_fail and fail_seq in struct mptcp_options_received.
When MP_FAIL suboption is received, set mp_fail to 1 and save the sequence
number to fail_seq.

Then invoke mptcp_pm_mp_fail_received to deal with the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/pm.c       |  5 +++++
 net/mptcp/protocol.h |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2b15063c8009..cd9ec4acf127 100644
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
@@ -1147,6 +1158,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index da0c4c925350..6ab386ff3294 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -249,6 +249,11 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, mptcp_sk(subflow->conn), sk, GFP_ATOMIC);
 }
 
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
+{
+	pr_debug("fail_seq=%llu", fail_seq);
+}
+
 /* path manager helpers */
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b389fec18c89..09d0e9406ea9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -140,6 +140,7 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
+		mp_fail : 1,
 		echo : 1,
 		csum_reqd : 1,
 		backup : 1,
@@ -161,6 +162,7 @@ struct mptcp_options_received {
 	u64	ahmac;
 	u8	reset_reason:4;
 	u8	reset_transient:1;
+	u64	fail_seq;
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
@@ -727,6 +729,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.31.1

