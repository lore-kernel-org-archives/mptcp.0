Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F043222
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:54 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1781485wms.5
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=YwUEl+xf68vtGx2rsqgDyXqNzb0Ot4Y8cFM3ErpHR9A=;
        b=TgPwd3irX9CWDlpQtOiElxRWTlsLM2OWHhGBlAuOkNHRLjc+4RI87e3zE9Hs1+FrUY
         UxuBU1eF4CXtQOzFlX4+kBNnceds5VbVGe/u0xFYAJ5MGGNxhktRQkDPxIwfC3C7EiRp
         cyOoSR9uF99FgCxiBaEznj+7ZqhmTgMGc5bDXsKFnIJahdYRFFWPNxF+wpbmQytjv6pK
         FwRDYDXlnriFU9pmycV/EP3XH77BJgMqPf0adG+xUqRs2ZqtpdofJSYfzirmIHybSfbX
         I1H6wsVfYOv/ELl2MRckl9QJx1wGChO9eoexIdejYwHS2k/zy1VefyLolM7fkgNM5I2A
         xEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=YwUEl+xf68vtGx2rsqgDyXqNzb0Ot4Y8cFM3ErpHR9A=;
        b=zRAiLhkgl6MWeJUVhmkpAVhRTkQcjhikhTbWu3QJHZjF+g4sg9XG5aymZmuk5OlkcG
         5/Tz8firYbfvaf8QAhgFV/oRokA//4NOZd83xmbaY1zwu0tl0ztu81JGxSg0FnUHCdcM
         HL1fNBLx9VGXqx4neSUJkeKgpCItP1ykgsspW2p+zsLcwCgmHdjyQNDQuFCzQ23t3WR/
         iYQ+LwAtXx4vgO9GvjcyuzU1KT0rKHfG/QZz8ZvX2iE9ZWL563LRsUADq8T0/mnCPudt
         FLapuwE/+/NZSpIe34dwXeK5uSEVaV1qr3gnCSJHnn/TQz4dDGILjm044RJrkANUtZeH
         o4cQ==
X-Gm-Message-State: ACgBeo0UvmqXm+1abnAKHToJxNiah2RIMJwJ2jXirfI7O3qt+TAWmASk
	CF7jygTo3BWAQiJJc6pVbBVr2Zl0U4rXAfB2ekwFIUgNYnfSNmfG+OVPgPA3QQGAmisIiKE2dT1
	BmKo9SLw+c6W+4WLl60D41Q==
X-Google-Smtp-Source: AA6agR58NGRJo7UOelf9iJCMgBIdHv12FiP7afSKMuJBe6Zg24/bwfQPK/d+/i5sUz54Jel43kf92w==
X-Received: by 2002:a05:600c:444b:b0:3a6:6b99:239a with SMTP id v11-20020a05600c444b00b003a66b99239amr2363252wmn.41.1662644332604;
        Thu, 08 Sep 2022 06:38:52 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:52 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 09/10] mptcp: force data_ready
Date: Thu,  8 Sep 2022 15:38:28 +0200
Message-Id: <20220908133829.3410092-10-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

I'm really not sure about why this is needed, but put that in the
review to be complete.

Without this, the user application can hang forever

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 net/ipv4/tcp_fastopen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 1b2d045604e3..9ef357ae0921 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -197,6 +197,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	pr_debug("%s (%i): is it needed ?\n", __func__, __LINE__);
+	tcp_data_ready(sk);
 	tp->syn_data_acked = 1;
 
 	/* u64_stats_update_begin(&tp->syncp) not needed here,
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


