Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DEB3FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:49 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id k23so10528193pji.0
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aImpRo1tXFoohxU2lmnLZDP4zK7ys+eyhb6HmIPSZ9Q=;
        b=AsACY/ZJPBF0eCOU3jV3Oz8/1o9MgPPWlqQbncWIrYbc3qcPd9tFDW/M8BapmDyMxG
         N/mqU6Mrd71gFsGIk6lV0HrylVL6FFnPHhr44L+ufq3pLgWO/fFHTVFZRvP8OOqOUOrM
         8qCz7apVw++Y8G+uzU5QktCSi9YvVtczrGDQBlzlJOMiF+W3ZlN1jGSSqn7DcQMKhdO4
         bhusM5e0wh8vmg0kCp8BvZKK6iTP7gzeAnY0inEcvqDAraBS+SmKONkyTS0FKNJgYbXn
         dxyqrkKq/NYAuv7CNuIJ8aBGoZAT30fxaNxHhtHB/USdThFMD+fxBaF6vNdYMmK/dIbO
         svAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aImpRo1tXFoohxU2lmnLZDP4zK7ys+eyhb6HmIPSZ9Q=;
        b=3vrWQraxtf9watgN7xR7zEEsWigK+A2gJSYfmx5jGdU/tfOWFyeBH8pXXr0NS2MvZ7
         lr0v4X65BsiBcvee9DgV7xO1AqJFsWHFkbevRmAWV5XT4Bgp4TcoiEZsLDZq5kLSX2xG
         AkaOrcMD3relXw84PMcoyx1C1451feFu858lwiibkyD+f9gf8Qz8eqOQhaLG3S2W+EG4
         NUlk71tvnSeVCYqJrGjHsllYNvr1wZ3bjU96j+r4S3iLA0aTXNnCGGtvxUm9Oio9tSfw
         V0TpQcTn/LaNPb2g0cDMeY33JvEP6BagMTmEk/QKlX1X7yl6Jf5YbBmsAf5aYtP4PH/V
         sf3A==
X-Gm-Message-State: AOAM5319gE/2Wi7h9P+2atKCIRVbW87ff40BQL9q0LycDwaTHZ0CW3/B
	5t2vx5BR7radlXbRH4KImO3qMBK8FNA=
X-Google-Smtp-Source: ABdhPJwYxvtGpu4YdJe9nrgcWTQb/GxEEba0oBsg336RW4KbyPzmytsOODye+w8+xGq+3N/j7uT8bg==
X-Received: by 2002:a17:90a:c712:: with SMTP id o18mr12351714pjt.124.1632666588636;
        Sun, 26 Sep 2021 07:29:48 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:48 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 2/8] mptcp: add last_fully_acked_dss_start_seq in the msk
Date: Sun, 26 Sep 2021 22:29:32 +0800
Message-Id: <d30c647d6795c98797d3734e618016a30d7db13d.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
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
index cf8cccfefb51..1cf43073845a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1074,6 +1074,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 		}
 
+		msk->last_fully_acked_dss_start_seq = dfrag->data_seq;
 		dfrag_clear(sk, dfrag);
 		cleaned = true;
 	}
@@ -2895,6 +2896,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	msk->last_fully_acked_dss_start_seq = subflow_req->idsn - 1;
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3151,6 +3153,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->last_fully_acked_dss_start_seq, subflow->idsn - 1);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e090a9244f8b..e9064fec0ed2 100644
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

