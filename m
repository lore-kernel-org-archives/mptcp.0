Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A82FB6
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:14 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id 145so1190828pfz.11
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aN8OfYnqeEF8iGzX/EasTFdzOLaFQ2QrlS8HF72xT8=;
        b=m1EiTqBiaZQ9k/pGJ52R7ariuPic1R1Vun2EK+5iqGclKeJzBULgnraAJnMIKmHHuv
         hl6zxBGaxc6ThSJxPSRQAzMzPyfWtfmi9obYb1AVxUe+Dni8xCICbmTXHQFTRhTE5nBV
         zGRdaP/cDK0uPf2S7cNrmtlTNZ1fFr0ZFpW4UKsUBlA1NloKop/rT336bTpaHROFVaTC
         pS/bAbAAJNaKO9BSin0JglpNvxOPrljSxatE1KqjP0i7xuCnN1YVPW5YrJkS/2VeID+r
         6eNJs64Smr+84ZOruK91lz5s5Otw7BEFKSTslsOcgLd3mc/py/f1Ek1HdWI1LpZZoGAQ
         Ba8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aN8OfYnqeEF8iGzX/EasTFdzOLaFQ2QrlS8HF72xT8=;
        b=gNVe5tvypNHX+O1zZPpcysV5iA2u1SDWZZ9gJnF6wKOMdpTEBp60tH/ezqNTil0BkD
         vG7uBkZAa3EW7dSPFnzIPVKurBAJjGf2a8wYl6SKo5ht1uylrSUXYbl/2i9GhL4fZ/sh
         zPFgpUPePDxix5cPEm+G+ZnVcOMLzbecFFje+AYaYykrvf7Th03+Ea29HqqSP/45/xFQ
         wVsL453odb1wtOAfdS6ft/6VpQ1C/cTu+oayaYyObGGmsnRR622cVXbHVjVNqd7swRg6
         R7jut2qCjmKdzcUYfaAMXoxL/PQebBHaVKmZNYk9Dt4xjj3d8y6G2LsAbfcEg+Kd5r8j
         M3gA==
X-Gm-Message-State: AOAM530CuQxrHkU7cgWQB3PGOUjL+u2k1A7p6xChrLXGHcLQFg2CfyP+
	bYbnWjf88q433dEWUV3pZE/VdNLnl8nG+g==
X-Google-Smtp-Source: ABdhPJylj9/yEb+zeUE9wgf5llrL8XAqWjP/zkNgN0xCtPDhCSQlL5DsVNJ0236FynBdMO1oLvZxuQ==
X-Received: by 2002:a62:2f81:0:b0:44b:b390:956b with SMTP id v123-20020a622f81000000b0044bb390956bmr6071043pfv.30.1632900913859;
        Wed, 29 Sep 2021 00:35:13 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:13 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v6 1/9] mptcp: don't send RST for single subflow
Date: Wed, 29 Sep 2021 15:34:59 +0800
Message-Id: <92a6c95367cac890556d2483ea61d7ef62dceafa.1632900306.git.geliangtang@gmail.com>
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

When a bad checksum is detected and a single subflow is in use, don't
send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6172f380dfb7..92b45a7c997e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1167,14 +1167,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
 		if (mptcp_has_another_subflow(ssk)) {
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, 0);
 		return true;
 	}
-- 
2.31.1

