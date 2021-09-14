Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF583FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:24 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id w6so7752968pll.3
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIUuvixQDyQPRkmzFLt6CKToocq/GjmTzgW70ffvtjw=;
        b=lnTQkbKl7qK8W91+07UlQxzoancyrYfEENKE2FoncjejLZVB/ojIw2zZX+S0MwJNOC
         Ylp0Tc4ft3k+XvxTzILh+Dyck6HM3YKAa335rOqvB1ZKNdfIZE+7cSweMh6uZtRmf2C5
         iqn4pJVZBzvrKZY9X/mKGYrU2x4rPIOspbpIevh/2U2/YPG1+EmyCIlkTETrpnVNbMPt
         XARCDRJXTQBtEVRzYIXuJjSCXTo7KIyWi175o2JvTq/3tQEhN2xkRELOSEDffgkwdwOq
         9wjbT0glWtLrvp2G3aPdiPaotfDfc7/VBLdsr3BfEx2xuoxZM6SMNcWZUHf8o2csWJkr
         v1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIUuvixQDyQPRkmzFLt6CKToocq/GjmTzgW70ffvtjw=;
        b=HtApsElK7NeVVWwXfDnLZW0Pp2U6f6v6b1vjuaqMsixXfuulpnROmTmYziHD/FM/Pa
         lwagbKNz9Y5SgoyRh/s8X1ZesqH6YgC+zOWVKVz6crSFxOARqR+iQ4Y9vJqPf8jdJw+/
         csjkjCaR/lDxDHu4QcUIq6u10Rq2rS/c+qxa/6PC+fc2B5JrPTaVvZho8Dshc4v06ab1
         Hvhbnhy0TG2EJrdoQtgCBprfR+6b/Rw4XmuoBWevrUyjF02psKSu0tNQM/biQWfrUGAr
         LQpnxiPKoYZC7Xg9lqpKDtPFgbGAsk2tVM4ABGp3gzNriV3/WqeAnDDptTcCCPUEOb3w
         ZqZg==
X-Gm-Message-State: AOAM531Wlsv+o+VTygnWFTs5C7QNzYpbSENxQwEpZpXp3szHQipKKanv
	B3IGK3136yG0FjLpd3ogjPKR3kBnmiI=
X-Google-Smtp-Source: ABdhPJyV3WAlI/jYxXd4XNxjNicK0x0CjYcajz3irr1z42cSohBQvWW6EZI0oie6WQwHi1rSGpnApw==
X-Received: by 2002:a17:90a:8009:: with SMTP id b9mr955974pjn.15.1631611163699;
        Tue, 14 Sep 2021 02:19:23 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 5/8] mptcp: infinite mapping receiving
Date: Tue, 14 Sep 2021 17:19:04 +0800
Message-Id: <27849702bc924bbab7ca914387e18b6dadfe5622.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
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

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 89173f70707e..fd44996a7b9a 100644
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

