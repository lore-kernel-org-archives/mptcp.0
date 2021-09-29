Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51C3FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:19 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id q23so1200803pfs.9
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pom/ZtrOD2M6Ftiy6IIch1Dq64jBCSnUsl5wPAb9gGM=;
        b=X3Ie37FNvLirRx0wfRRJag/jiO9CTWR9zMjLxriZqsfm9b4OTKfW4PNdpL9jASXgTJ
         jITE2Bmn7zONkQQe6oF1KqMqxcOJ8pELT1HgyPj3sdhoX773kzzZps1pPxX+2+/a7hvP
         rSXhMCRDr5tOZS3hbFRSQFGibIsBS3Fp+s1ceIhDsF4mg5EiBOELg43SK20vCtbgC7sf
         gcWTDqFZ/V9CJpidL+iE6jdQ2UBwtZlIPdKLVqSXfQ6+1w1m8Blo/8zbswY08PjcF5I/
         17fuMs7PvPTVn5xiDKjsFivdOG0HYwwJgurm1nYsSXsvm9IToE9wVxefl2uXjqiPVzbE
         2hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pom/ZtrOD2M6Ftiy6IIch1Dq64jBCSnUsl5wPAb9gGM=;
        b=4scRIVKqw18fqyx0aSHMoemq3AytyFnB+9NDg6VEw3TYpV69nc2vm363DdnozdRGql
         38ppgjSKN9PJwgnb8IQvmdQi5WOTXxnslxQbhxFmWsxL9lyilNvzBttzNopBYa4bvLRB
         G8FRESHZpEIhCDkplUekN7y+8HaSmpmJHSDxrdKz3PB7AlRUKlUg+ZtIDtng8ViAThXk
         QRuaVgb/Aar53Fhye3LpyX/bu176V5UDNrVj1kDZOfiHUoAKE+MVJ0WtBDvfnPq+ZBXg
         /KKcOA/ExQSok/zhdfXXMKV2TQpY5+sqPMk5hQBJGOMVzNy1AyghMsMqCmdKT+5Xqmbu
         LR3w==
X-Gm-Message-State: AOAM533YSxhpu+dgaj1GLTaggETeVd9kjBpm8g1Bz5z8sf4Exa53iCru
	riz5yYApF9169GYdj9L4yyZALxtCz1butA==
X-Google-Smtp-Source: ABdhPJyQUviFS1S26ww8/HRLFJl4OKRIhZfaaNi0liFisnlIg5EIBaslZQ3FblFq6DYsg92sMOhlOA==
X-Received: by 2002:a63:7447:: with SMTP id e7mr8469274pgn.46.1632900918958;
        Wed, 29 Sep 2021 00:35:18 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:18 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 4/9] mptcp: add last_ack_dss_start in the msk
Date: Wed, 29 Sep 2021 15:35:02 +0800
Message-Id: <b67052f2a5ba451f12b0e29346a164da06712508.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member named last_ack_dss_start to the msk to
keep track of the beginning of the last fully-acked data segment. This
would be updated in __mptcp_clean_una.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/protocol.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48979cb82126..334bbce69fcb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1071,6 +1071,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 		}
 
+		msk->last_ack_dss_start = dfrag->data_seq;
 		dfrag_clear(sk, dfrag);
 		cleaned = true;
 	}
@@ -2891,6 +2892,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	msk->last_ack_dss_start = subflow_req->idsn - 1;
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3147,6 +3149,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->last_ack_dss_start, subflow->idsn - 1);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4807e486e762..7927acf53f06 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -224,6 +224,7 @@ struct mptcp_sock {
 	u64		remote_key;
 	u64		write_seq;
 	u64		snd_nxt;
+	u64		last_ack_dss_start;
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
-- 
2.31.1

