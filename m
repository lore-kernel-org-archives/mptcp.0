Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317017F
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 12:52:23 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3795912pjx.1
        for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3psc4Kyq0qz6osLXuUBVCLtvFDcEH/tTivNBgiI6LYU=;
        b=mRA7XhvAakk/AupTnNiP1Ca8EWQ2OqFWpU6/Lu4RvonchA+PJoUe/swxwXlOKnRepK
         rVz9f3yivsvxEi1mf/Djzu8wb6rEqs5wf8sJJpJLOjoWIW6WxKAkxgCA1rn//oFLkLFf
         dYhoh0KcMbgxtKsvmnS7U0u1lp4uccCr/gGt2h1rYI5d8m7f70ATbIX4zPJFITI8HbV6
         qzMwMk0G6BWFE8kr3iuYsqYQ1Pp4TwgBQ9VS6ja8MuLWpuqsopw/M6XrU2ISfMzmsQyZ
         2SAGftxl7SACRHduZ4E81PC1qy2rnKXlkBKEXZNCjZk9D5IMG5eRCvHpjHPsokMVpKt9
         2aGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3psc4Kyq0qz6osLXuUBVCLtvFDcEH/tTivNBgiI6LYU=;
        b=AgeJGmEH0Z79kQnKs/827LjFqIitwE2X8CfQf6n90jOoC9r7a7NLlm4zOgcCZxThe9
         0ia+WE/KukG7S8b1WClMKENBrmvJo2zWtowOtrSICiGlnZqe5663h4jq3giIRiiECVM2
         SfkZOXhB10IZQL2r2yPbJD04TPscL1Ki12oFBrcg4lyf+lH26AaVeoCffYXoTXcvPj3b
         cWYXfvoDqg0jwWBcQMbbxJzscjuedtWIMP+GkAi1264TwCr7dc4t+hjLCOnRNeve2S9L
         hv1sTaM4EB0u6u7hlisUC0PuG1D0xeKN90K+DOaNDFFlAnsJNviTf/9qqhacPEVZ1wle
         LF8A==
X-Gm-Message-State: AOAM533uRUvn3MMAhUsVN06Y0/qcLddplv0wrUU78opbDT6xRniJNRQ+
	DR4Yi4+X6qQS3cgU8nFIDhkZ496zr9Csqg==
X-Google-Smtp-Source: ABdhPJx20EcRyPsTvRo8pDBV+Rr40Sn47zfIXuAskSHWerPmIOuuufesQXTToWRqmLgyvEg9Ojtu5w==
X-Received: by 2002:a17:903:1c1:b029:125:b183:7989 with SMTP id e1-20020a17090301c1b0290125b1837989mr31417830plh.57.1625057542100;
        Wed, 30 Jun 2021 05:52:22 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i188sm10672175pfe.30.2021.06.30.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:52:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: send out MP_FAIL when data checksum fail"
Date: Wed, 30 Jun 2021 20:52:17 +0800
Message-Id: <8f13271510c7d2289e34e4a72deee2e291a5da2a.1625057469.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just set the sk_state of the subsocket to TCP_CLOSE, then the flag
MPTCP_WORK_CLOSE_SUBFLOW will be set in subflow_sched_work_if_closed,
and the subflow will be closed.

mptcp_subflow_reset is somehow duplicate here.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d297b941586d..cbf91e22574c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1159,7 +1159,11 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
 		if (mptcp_has_another_subflow_established(ssk)) {
-			mptcp_subflow_reset(ssk);
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 			WRITE_ONCE(subflow->data_avail, 0);
-- 
2.31.1

