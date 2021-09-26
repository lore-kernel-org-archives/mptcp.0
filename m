Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9743FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:53 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id y1so9911689plk.10
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Owtom+qlrhC9U0a2v82D0lz5hlmsc4/3nQcA0zRwTIw=;
        b=RQdu6ZhmgkNOCznvuVtvASWnpi+v81KHtKj1NGxTb1XydnpMmzkt9eNCm0Dm+F5A2X
         nm33m4b3fBFmoyifRCEGf2R6owl6wXaZLRZFoxMgEvbt5g4iwnNsr7dFmlHs6QEae9Wd
         LMJYKRB/lhEL20j5BwL0n8sNzaT8TVDFAocCNy91KUYiTOpAwUmUK7ODcOTT7jZe6WQr
         LDDlfIfwQbKiGYBmQ6HVIFEl3QzhXGYAg4UvObPYwNJ80pREnwPrP0wEl87cBxR6tvYL
         Ml2oH3YKC72k3tafrJdAv3Bw55t8z5LrJa8xX43nEeoxWv2qUWQNyoYZhNELi1uPr5eV
         DpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Owtom+qlrhC9U0a2v82D0lz5hlmsc4/3nQcA0zRwTIw=;
        b=WtaeaDE/oQCb7jp+PCBoAEovexTykjbliF/7qvDHDx8kssHAfZ4c1ENaRUACaHyBio
         zB1qpcOz5iJGf0XTxfMmpJbIzlZ4JAKP2I29zHaNAC4pb2EcmIcyF4Zpgv5XPGQeomPz
         AWVCnSQGhBAN1HikShvBZuhLf1qYD9UROFAbVWwzae/o3lRF2bh8hOmziBxkHkMpj7iW
         0u0fI4lDiYS489uBjXkkDKEnbN77zI/qRXY17ALkZbfXDGtRIWFkJSUAAFCgZpMSGXvz
         9qRKGpKFJnJJxSH04QofMQIuNVUVq8+f+Ta8u9A3zutoNjrRmSMiWFbuFNd/nXALkM7V
         TPpQ==
X-Gm-Message-State: AOAM531Ccgv1czpQq+e7IaPjVXs3EQf96F/34hqC84LVNCY55P94DRnP
	jN0YoZd6TSTQsx/O+3laIZZ5iUqcqZs=
X-Google-Smtp-Source: ABdhPJwh6yVrfwm9ovDpbRxR1JJii+vuM8MJNgig16rqjOzcSKQTwOkko66oI4R8JQg/UMA5gfPvDQ==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr14200967pjg.17.1632666593115;
        Sun, 26 Sep 2021 07:29:53 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:52 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 5/8] mptcp: infinite mapping receiving
Date: Sun, 26 Sep 2021 22:29:35 +0800
Message-Id: <3a055280313efe6030d8f0130662a662dd9c734e.1632666254.git.geliangtang@gmail.com>
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

This patch added the infinite mapping receiving logic. When the infinite
mapping is received, set the map_data_len of the subflow to 0.

In subflow_check_data_avail, only reset the subflow when the map_data_len
of the subflow is non-zero.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 023fb95e1fa2..81ebefdef88d 100644
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

