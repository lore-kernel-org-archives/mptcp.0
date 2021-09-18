Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC472
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:34 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id c1so8401710pfp.10
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9Ilu3DBTBvWXhhQsLyZtqcf8Ws6zDVpJIQ0MEyzYPQ=;
        b=kVsvZG9T0+KR05WnTxKPHYJV+8KinyHd6aAImcxLO15GzZYHYTxplixof0Z1QJIW3w
         6Lgya1NsYcXs7cZ7I+YN/B0KYpsY5/brJQToqF9UjUpGp0Dq5f0Sj6p8m300uxfH+hP3
         cek5hH+XTZPxurCdhukzo/xlofeXSrt+mm5Wt64nLvsSGwpnNlLz7L6WMBFaZzWKhWDy
         1qV+17FrfuNOXPPR2W94Ays1uQV1optzadt7kmz1uN1x8uOgp6dEtkC9RRmHYytdwqRk
         7BXQxNHjxlHDNHHkwQPsyQQzNjdZu1klO5mhXxC4SZkKGv9lMfqspoMJFBUwu26lQV71
         7WlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9Ilu3DBTBvWXhhQsLyZtqcf8Ws6zDVpJIQ0MEyzYPQ=;
        b=ZkR3kpoRYHtBJzGxuYGQ0PaynHrWWFUPpOyYg7tXk2yZ5nge+FhhOkrixvCBUMpsiY
         67jd6n6ChvBag3oHekKfB9t0CIu2lfLJTBPHYePKmpZ35ccl7H1HL/PPhSTLSIa8s77D
         OVlWhtiTtYk3QiB7fEndYAE2v2KmzqIMuogkY/9GMRp8Ub3s1WO/t5iAnPWAK7OJz5xA
         d38VHsGc9HBUa+M4c70xtuIsJy+ywNnmueT7OZPUiWBXEbVgQN9ynnV8OEtKBAK4/fbi
         GdLNBxk20O/WWm0TYcb/HxobZMrLk7/gZyyvdNq3NRoftNYWbFsN5WotWrKbCOZ6upwV
         543g==
X-Gm-Message-State: AOAM533RKUYp5BXg0AXp1Y22+CNoD/dj+XKcS37b6ORbZV0tvzadkWnV
	N1nvn7Hf54he32DZxva30NLUaewj5OM=
X-Google-Smtp-Source: ABdhPJwLf+SNQUEqqM4AvDKstTAaRW2fhL2+MvrQXg/mu6nkcNacrTj5ln7iNkedeawswUHgLZyyQQ==
X-Received: by 2002:a63:4f03:: with SMTP id d3mr13619695pgb.217.1631949753896;
        Sat, 18 Sep 2021 00:22:33 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:33 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 2/8] mptcp: add last_fully_acked_dss_start_seq in the msk
Date: Sat, 18 Sep 2021 15:22:17 +0800
Message-Id: <bf1bcce7f1d0a12b97fa55b07d0e0b7d38914176.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member named last_fully_acked_dss_start_seq to the
msk to keep track of the beginning of the last fully-acked data segment.
This would be updated in __mptcp_clean_una.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b766b36e6c93..b056672541df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1071,6 +1071,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 		}
 
+		msk->last_fully_acked_dss_start_seq = dfrag->data_seq;
 		dfrag_clear(sk, dfrag);
 		cleaned = true;
 	}
@@ -2899,6 +2900,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
 	msk->last_retrans_seq = subflow_req->idsn - 1;
+	msk->last_fully_acked_dss_start_seq = subflow_req->idsn - 1;
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3156,6 +3158,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
 	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
+	WRITE_ONCE(msk->last_fully_acked_dss_start_seq, subflow->idsn - 1);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index eb3473d128d4..2f8a8589668c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -224,6 +224,7 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		snd_nxt;
+	u64		last_fully_acked_dss_start_seq;
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
-- 
2.31.1

