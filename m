Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6070
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 06:45:25 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id e21so5924227pla.5
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0yRg0PxOP5a6TIi96nrHyjmG54dBWIEziwzaYMx2e0=;
        b=vg9uq6JJHU2iULDt2A4wMsAOmk0YOVw/aW2/EgZ3aKyIX6OvGHEscm8X/PdG80Tdh8
         e1n4w+HLJs7D9vtNcOnIV+2Siec4H5VB5rfzg0lfTxYbN7q21B075V7xusx2D2VDicPZ
         RPeVgB7B0ekEbhbK/ELFveq1mS5z9fKxzBTJsc037R/LChCWnuizxIETzwZSS8JsYOdu
         WGKBKkl6i33rFRc/WhWNtydPJ5dfQ/dC1XZUc6l9ITHgiO1KWzcnirJUEMONL9lRPREn
         7atTPnv/A+Y47BNTM7FTantBjYqgZ8x1S4YPfVNnhF1iixdROt1KWUxdn+GOMeRCMQf5
         YRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0yRg0PxOP5a6TIi96nrHyjmG54dBWIEziwzaYMx2e0=;
        b=bGZd4ybNaew37x51dybmQ4sv7KHrM505Mg4zBXdqgUDJoj2Yt2WI5+96sEbN+CKFuS
         w1iSJfYlSP0FYWF17fY8ihxHq0/BrIf1g/ooFAEwU69ZNv9LxDEN5g1M06L+xro57hEE
         sTOaKiVyKLUVi6IjgvFTlf1+Onwc3vA3hB42tRN+o2GwXhh/NliXqZ5yf9A2+FsvGqQ2
         gD8nILJ2GHMebo9lq4N52GxpAo7iARwHlbxrnNU5WNinN/uPDhjXGmNlCn/ZNN+48A4v
         V8THnKg3uQNaeNquD2lJM4PLHyeUyiYyI1u1XbChK/5DrfGU/QGHJYMMHoRtfzSrHWpY
         JnxQ==
X-Gm-Message-State: AOAM530X7id1yERl7czTD96rWtpt28y90lpellEJpKitQvOSE9ddQWQo
	24qWz77M3PPbW3VuFDIUZou54oNHgYKRzg==
X-Google-Smtp-Source: ABdhPJwMKpZxDIV/oysXVodOebwOLBkz/Fdk2FFBaQgNXh+yIexrZoy32iceN5UegDAp8C1t5CKUgA==
X-Received: by 2002:aa7:947d:0:b029:32c:c2e7:5f38 with SMTP id t29-20020aa7947d0000b029032cc2e75f38mr16459909pfq.39.1627281925460;
        Sun, 25 Jul 2021 23:45:25 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k11sm10634697pgc.30.2021.07.25.23.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:45:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 2/5] mptcp: MP_FAIL suboption receiving
Date: Mon, 26 Jul 2021 14:45:12 +0800
Message-Id: <bcdbfa514af7e5dc3741c16bb692c070ed50f3df.1627281326.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com> <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com>
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
index a7365379096d..62085834782d 100644
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
@@ -1138,6 +1149,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
index 692614c1f552..f37a014b4875 100644
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
index ea4ab9b9d6db..19533e5778a6 100644
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
@@ -726,6 +728,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *addr,
 				 u8 bkup);
+void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.31.1

