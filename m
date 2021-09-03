Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A32FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 08:15:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id e7so2853039plh.8
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwxhdUzNs4Yv7BXNL36duRUzjPNODr9/N8vCnfzjf38=;
        b=OcrvsWdqW3u17KZudNttY4Lum9mZTkmKIKM4T+QCpnPHn/KhYkJGTnFj336HBjuTGx
         zVucAGNy16nSb6WvyATtea1KyHG0Tgp2P2/v0pRHD+DP0KazM9MOSER0Bzgmf/gmv36C
         hc0z1HuTgai6cPn5g85DzeQZ38g9kUV1FpTLAj6JfdXZDj4iFsVE0jt94kJfyHwx4dqQ
         rgL7PHUgVKTIjYePev42LSg8LgZuks6eAvhUzrpqExKygE5CUCuy9AelLdK1XLtzyAds
         g8RfVtPbR0oTr9cDhqMkCi8c0qfI96N1HdA34L3w1Q5x0/UCHNdQnoAaxyewKBsmSRlz
         uvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwxhdUzNs4Yv7BXNL36duRUzjPNODr9/N8vCnfzjf38=;
        b=GQaxmPcJePzmLT35ZfeUgKwEoBGEBbK5iOYRkQTwe2dP4zzdtrXUlpFh0/PRxoty9x
         9oxz8N7X7ohJ5lU0MUo8G2bG0OzYt8cPkeZ9qVOjRTyacSudatfhbDnDt5M4BwhjyVDp
         omKveFN6GJmFe1Leh1lR67k7NVZdmLa5W5IsWdje+xIEZqaqQk29fO48keBCWkdpRG3b
         l/z6klqkPd1gfi7HsK4J7bACArvOlxweK9ihUZV8TYI7l0G6KZOePvvoubCi9cM7Fy5v
         93sLn2eXxnwPj9HPPiVYQIFbOSzrxhw320JGpFlBQ+7KfPukPYkQsDvtb6R94hjdAu2U
         t+Ag==
X-Gm-Message-State: AOAM533xSH9NpWQkA70AOib1TZnVm4zxKzZoISR567an1iP8FbJAhV9p
	4n4A2haV27RWsBitwrWh/BC8FKtIqgo=
X-Google-Smtp-Source: ABdhPJw8aeb13KAxrtRaBsqApNAM+UCkHQG/ONtZob++/aQ9mv3N63pRYvbhT5zSymlr+NIekRObnA==
X-Received: by 2002:a17:902:74c3:b0:132:287a:c052 with SMTP id f3-20020a17090274c300b00132287ac052mr2066066plt.32.1630656923799;
        Fri, 03 Sep 2021 01:15:23 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j6sm5254452pgq.0.2021.09.03.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:15:23 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH RFC 1/5] mptcp: don't send RST for single subflow
Date: Fri,  3 Sep 2021 16:15:09 +0800
Message-Id: <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630656206.git.geliangtang@xiaomi.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

When a bad checksum is detected and a single subflow is in use, don't
send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1de7ce883c37..dfcd84abc13e 100644
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

