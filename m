Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49F72
	for <mptcp@lists.linux.dev>; Thu,  2 Sep 2021 09:15:34 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 17so1269667pgp.4
        for <mptcp@lists.linux.dev>; Thu, 02 Sep 2021 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMJJy2bmAq63khQ+A0e7qbcz1Yh1BeMWuLAFMYocNOY=;
        b=SIqbsjzBxrwj5BwxXGY1riqjj/q3qIi+vJlkl0pBkViJluXYbBznLZaCraTqVTCVZF
         3lSYF189Zwyk8VZZzJSDEQ4EG8+Pn/dD4+BSCakZXzd75kDd+VHKxoABNLZec+ueWuPj
         HMKkIMTOoMkLcKW8wRm2dNGCrvjjqgTQYwolIZdWLPU5v+cJN0ZsP1Ylz3FogbZdAZEF
         J56v0YbHW2W9ZDVi7ZLvl4mqTVxkiy1G5j4Dvfc2ACLlM1qypomdjVOmo70MhYz1iFEL
         R1QeRgyrm4z6SFtEAYd86fhC8N1HvjRf7ecnuUYEe7CRh3jVcQ13VrPzLlZlfl5FXjK2
         36oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMJJy2bmAq63khQ+A0e7qbcz1Yh1BeMWuLAFMYocNOY=;
        b=hIdo+H9QbY9ttgqbthd+8C3rGtAETQ8eurh/x03jkVWw3qbxkXZXkBFK19wEjnumda
         RFb6zALYTw8MaI3pR2Bq25ec95kdwbmadTCF1cJ4xrPnWkyeOzB7hmAEFTtQqXf61v9p
         RwuWPRJTSxjIMPsK5OdQgmrZv/tK6gCOdY+ROCQsmeGj+l0B/M51cl6Tg9pm3mSIA1G6
         sihWVENKukBraQZrN5l14O06s+Q5NnAMnxKupreHaqauWUlEsrfYR7SDKHEfbNaEPXoq
         /GaMFdqHHGTnWMziXkAdKHC8krJe1LcHIlXCuSsqFcMh1M79yZJGv1arFK/riO7JF33Y
         8xXA==
X-Gm-Message-State: AOAM531CM3fkLRfC4l1I894KwC0xL8D5mAVq7U6wGfIP9cS3nHfF1wNF
	2OZZAarM/14irrVHj5pBP0CRUPjeNDA=
X-Google-Smtp-Source: ABdhPJwOB4SdyP/ZLxAGIrLw/lyqCtTT1XrS3zAaPfiLWbP6L/6RV1aN6yN1V3IXFyjpU5/lFsertQ==
X-Received: by 2002:a63:3ec9:: with SMTP id l192mr2289842pga.141.1630574134375;
        Thu, 02 Sep 2021 02:15:34 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 66sm1608762pfx.29.2021.09.02.02.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:15:34 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH v2 mptcp-next] mptcp: use OPTIONS_MPTCP_MPC
Date: Thu,  2 Sep 2021 17:15:27 +0800
Message-Id: <10d25ba91ac41cacf02608b9e9a6e884d1eae996.1630573884.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Since OPTIONS_MPTCP_MPC has been defined, use it instead of open-coding.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 v2:
 - switch of yoda-style in mptcp_established_options_mp_prio as Paolo
   suggested.
 - keep yoda-style in mptcp_write_options, since the other options in
   this fuction all use the yoda-style conditions.
---
 net/mptcp/options.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ec6529c4326..422f4acfb3e6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -748,9 +748,7 @@ static bool mptcp_established_options_mp_prio(struct sock *sk,
 	/* can't send MP_PRIO with MPC, as they share the same option space:
 	 * 'backup'. Also it makes no sense at all
 	 */
-	if (!subflow->send_mp_prio ||
-	    ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
-	      OPTION_MPTCP_MPC_ACK) & opts->suboptions))
+	if (!subflow->send_mp_prio || (opts->suboptions & OPTIONS_MPTCP_MPC))
 		return false;
 
 	/* account for the trailing 'nop' option */
@@ -1327,8 +1325,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
 		}
-	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
-		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
+	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
 		if (OPTION_MPTCP_MPC_SYN & opts->suboptions) {
-- 
2.31.1

