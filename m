Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C270
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 08:40:22 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso14523454pjb.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4q7I7z/oOMo99KXe7zMmdvUE8phb4XS4IiEOWNdyuig=;
        b=Xh4aNxCYgOx9pHi5F1LNRVdwVem68Z4d6F6oG9gbbSeHAmKKYPlKSopFVEodvxwKHv
         Uv6pHZa+ZQL54ZIxKDBx2XT8MoAKKd+yieeOGkJ0xTXc8CX+iouLpJcU+Ba4xZcSNbaO
         U1NrTfa75g7R1+Cqr1vHBvenlG0bfLFFmGxEoYm/H4IzIlMaTKqhsKt7XVDEeCSkO6JA
         cKaGiOfC0wEHDCEzr83L8jJpeiy9eFJyPQGvY90dSNKsm0okQpI3T68NGv6zTdZqkQXb
         UoUnVTokZrfRAguOM1iQDYTzM/Vl6UP+2nNDngAqwHTXoXriWlnm8FoL4TQEZ/Pjhlya
         LuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4q7I7z/oOMo99KXe7zMmdvUE8phb4XS4IiEOWNdyuig=;
        b=i7oD5nRWvtEbsFu97e0gI/3F0rZiOhv9XcgWVgziQCQOEVKVhaAS5Va393XUmXL0wE
         kVOsFedUWo8DOtgifRJ9WZniq0msG06YPe7xEGdHd0st6i8SHC70n9CVcejloMlrnMlB
         1R2DNdTlj8oNN76AydQGwAIk2em63sYvDGxWx520WJwQ2rEwZFI3c+y2n6ckO2jq/8od
         pUaBjajRv7tnF3YCIkcDqdUmssVuGxYJrZ7Y/G+kBzZjXxqkTBaXaw8GcFArdmsL8Fe4
         bH8bg6XkMeKJpRiHDoF0uO/5/JxkBfm0Tc0XRp0OAl2Ux/fh/oMoRGqXHIzgMzM0nb1a
         EWRg==
X-Gm-Message-State: AOAM531uQydN/ODDqKIz2DaWdp4wv0Ws/Xq6EUX5oFuGCRM2ISFv0qpk
	Hf/CqMAxsURfEQ+FTo70GMrYhT6vYKQ=
X-Google-Smtp-Source: ABdhPJwABKrzRMVqwLWzfUysxcAcT9xQP8981zkeVYIgToPJO5P144gmsHk0p4IdN262fMYl5zI9lw==
X-Received: by 2002:a65:6a0b:: with SMTP id m11mr2855680pgu.380.1627548022195;
        Thu, 29 Jul 2021 01:40:22 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f5sm2401539pjo.23.2021.07.29.01.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:40:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v7 mptcp-next 2/5] mptcp: MP_FAIL suboption receiving
Date: Thu, 29 Jul 2021 16:40:10 +0800
Message-Id: <0c155f43f4bc75c90cf45283e07ea48432178d48.1627547666.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <d04456a7439e4cdab65aea27a035e5b89d5c0e2a.1627547666.git.geliangtang@xiaomi.com>
References: <cover.1627547666.git.geliangtang@xiaomi.com> <d04456a7439e4cdab65aea27a035e5b89d5c0e2a.1627547666.git.geliangtang@xiaomi.com>
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
index 6db24cf72ac0..ba7166daf6cb 100644
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
@@ -1145,6 +1156,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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

