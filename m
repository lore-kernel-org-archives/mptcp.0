Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD93FCB
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:22 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id y8so1203538pfa.7
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAskNLE7Qo/f0tL7J7L9HMpHqNwlTRqMapHbxJbOPDA=;
        b=QQgJNh57RTDL7Cv1o5cgRyQGCQAPhdMC82+n5HQNBPVtDu9cMa3pyFgpErOh/Gf8A3
         cC6bPSRmCL7DeIoI6baRpHByDmJezAkcGh2vQ+UIrtH4ldxJviRjOZdsvGfsluLrTUUf
         4PlKXyniqEb3zrVFMl3qC8dRGW6xfQbi52olOS+clcLSPyOSIEWItSlzklW2R4d77WNN
         Z1gpOGYXUP7l2hoCdsoX6r11Pq9rElOLItQEGB5oLL6C7J6ruy6CUAID9wki63sndrz4
         b8X45l6b2eMZbpBiGZvQVIRLrHtESGLz6fvifabDZk0xoaeERMEhKxNo5s0HmZifho5o
         gCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAskNLE7Qo/f0tL7J7L9HMpHqNwlTRqMapHbxJbOPDA=;
        b=VcxsPBz1mjvlM7YTHMYUTan+wFlmyEzqbPiRAha3aqsqoiiV6cpYORIuDDlFFxwdJT
         COZp+M62uXvaQZuJ0Nqzs3pcK4YX1g7Q5NsjV+e+zs3+f+mwODYrnZB5XHnxFjtIhS2o
         zvXnT1tmdlrzcmsyVhFndVawHRfjKxWWMpkcznPvgNeOzhLRfk7Bi8cFVOMPnC5K380y
         VdFiPjpDx+mRCU2R+LMeW49+Iu8r6IjABhb/VbTmR/CnjHvg44mtiHvjM1fJTC48BPHG
         hgvpeQioz4MbePC9RM4MkcWS+OP33/VmgNJgMvte+I9HL3kBqb70eCESw48jgJmDdVxf
         IBBA==
X-Gm-Message-State: AOAM533zrIsikG9XB2wGBBCIYDaZFN54niLRQGUQ6Zj7cmqx1DdjjT8D
	4lzRPPcI83IcDhc20bAFlbNETRtAMxyk/A==
X-Google-Smtp-Source: ABdhPJwpvIUkugC8PPnbUc2lizhsgU2aKmiCHVvFZeEM0toU/RXDETMIuq0F5chhFFCtGPTiYnSzCg==
X-Received: by 2002:aa7:93c9:0:b0:43c:f4f5:aac2 with SMTP id y9-20020aa793c9000000b0043cf4f5aac2mr9519013pff.11.1632900921916;
        Wed, 29 Sep 2021 00:35:21 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 6/9] mptcp: infinite mapping receiving
Date: Wed, 29 Sep 2021 15:35:04 +0800
Message-Id: <dbc6641a71019ede7388b0bc48356f86da1f1b79.1632900306.git.geliangtang@gmail.com>
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

This patch added the infinite mapping receiving logic. When the infinite
mapping is received, set the map_data_len of the subflow to 0.

In subflow_check_data_avail, only reset the subflow when the map_data_len
of the subflow is non-zero.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 28ed7dc6e170..101bfa277a1c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	data_len = mpext->data_len;
 	if (data_len == 0) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
+		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1180,7 +1181,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (subflow->mp_join || subflow->fully_established) {
+		if ((subflow->mp_join || subflow->fully_established) && subflow->map_data_len) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
-- 
2.31.1

