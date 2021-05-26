Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972012FB4
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:41 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id a25so2155314edr.12
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O4GJMAR/SATq/O2Mm/2b1e/3yRGICrW2t1dd9kq6qDk=;
        b=LJFBMTECmEa1rWV/7TKtN2v15BZ1PlTVo/MSIj6ovQ6QKMKnfHIuZCKizySRGd2lGu
         W03NWQq5FKGqcR5L2u061Rq0nuUbm9nzLTa9nJ7k8KZB+OUpXPTIuvxZjHF4sfWm2RO4
         kabAuR91y08zN962wNRIX15LzBKxDxh4mFq1PYz28AVfQh9Ibp/nOVAE7rHFMQ0s1VFi
         NWVkc51PZMjvfv63tK/+Pmux9AAVJ/pengobaK+iOxO2xtQkBmWiOaaFZde2xlPCevys
         9+FCFJL6WFViyNiFo4EOuJaaa5EjxVVZaHYldT4BDc+zBken+yGMbsnWFpa/+IV94/T6
         KBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4GJMAR/SATq/O2Mm/2b1e/3yRGICrW2t1dd9kq6qDk=;
        b=E6GAQJzG/Op483O8mrq2crdbcLjU+WoSFgU+jVikc3Mw81RN6eEWVCHBwLSf2KCMBV
         2eT3ceSO+t/NlLeLlhTo3Bo+JgoZNgMJfvaL3wCm7Omp3nJeAIsgZ10yw7g4VHf5syTO
         EzryJ33+rqWRTx5fbKGFxR/nMxHuXbpbcgK1L/4P8IQJ3kXOjho1v/qFV8EtQdVQGl6a
         xBcpKtw+E7C1sx9qHSBNXNv5DAk48XCo5qhIDvNEiNwjsoG8R58u6kOc1uTzdFUBO5Vq
         RPf2W3U5b/DKn/hlRkGOHmuqw1UWcGJ7NkWrQhDoFlw4MSwpOrdGYPX8MSYU3OG3v1Jj
         7g3A==
X-Gm-Message-State: AOAM533l4xCdRWMEZ9Pe8FR/PPf+jk7octs/fhjCNRzfFUlkJwf/FrX1
	FXtdz6Oy/9kmlWtUXK5X3fZLXEJ7wKeo1plg
X-Google-Smtp-Source: ABdhPJzm+VzSsxO7ECIoDopvGDICCq0ELhetX/V3LehUkjYZ5Www1ihTtN4n2M8qcX2rttKSC8uo4A==
X-Received: by 2002:a05:6402:424c:: with SMTP id g12mr34938472edb.145.1622045319945;
        Wed, 26 May 2021 09:08:39 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:39 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [RESEND] [MPTCP][PATCH mptcp-next 2/3] mptcp: MP_FAIL suboption receiving
Date: Wed, 26 May 2021 18:08:12 +0200
Message-ID: <bbdc6ded86ae034f443853b6e207aea2b3b2c519.1620282929.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160812.nJ9nFp6uAPdlrkG1qgb_3F9wHiiyoxynnFwgsojxVgk@z>

From: Geliang Tang <geliangtang@gmail.com>

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
