Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0C10E9
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:13 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id ud5so37417663ejc.4
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drNb1S9tj9maCJICCjpsuyCFdKnsYG7mF64cROKJf/w=;
        b=Ja+NWqsFxNmM+6znDx4JQCS8MwYs6Wfq3paFc2mzyIg+b7gXkR9tCBGWuP96ddQqAm
         UlDTNWjzdx79pT9CjR8qPS3LgwfHm2ZScxdxxPz7o3GakzB0qVOMDLlENSKrZmRHhCIq
         HwN41LAl1vorKg+8yW5kdGke1slnWCvudYu7X+PMHZksSXgkluMmxzm8JKPKzG4df0sb
         pAHMP5Qj5Gi3EKGuUfPYww3/LRCQQ6c22VwEXovP8wHpuQV2d9f9w6i9jnw1bCGDdgmd
         f/NwJeMwI3EzqmszgRdejXnxQG7zZJz/dWThM4dIy7QI2QZhfHmCZy6ERTH8qbWq5Lv7
         BpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drNb1S9tj9maCJICCjpsuyCFdKnsYG7mF64cROKJf/w=;
        b=L0TT4v2gFa7dIi6dktA8qhzI6QgALhHTXRG1vKPXrnbClH5nCvZQ+gNLKtvuJBHBXJ
         Rcri7/cngLbGpyexHZogvEZTDO6EQuGZVErCvc2GSsipSFcX7lTwjvciZyDHhsqfjxRe
         Q2f1NDERF8NQvicYHDN6LRRX1LxqLCOHdXJFDRIk45YpRICDKV6bxJwiso4U3RNh6sWJ
         1lrn/Hszl8xARkdxRqAPmhaJU6JM4ImRqCDf0oQ82ZHj1neyCeQmLxdSm9zZgqWYDYbg
         LFNFnlnp4VUeQ6l73CKbeSdv55GyTPoTFFFIfYGzSDvJBp3HbMm0CNv1ma3wxH981J8K
         h2RQ==
X-Gm-Message-State: AFqh2kqpnUBOc1zDrteZJZn0fI7SZ6uwt+bcm/+oZle2sqjtiyoCdZEU
	0X2OuFS5w8UYfGJv2E7jDlRQOpsQ0XearXnAy6ChUg==
X-Google-Smtp-Source: AMrXdXt1XL74MNNyFt4yC5ugKvHJMXR01Ec8c9hAZ43JwfeOGHbyGczQ9YoM9OhiwUlSkGn6fx60oQ==
X-Received: by 2002:a17:907:8d17:b0:7c1:1ada:5e1e with SMTP id tc23-20020a1709078d1700b007c11ada5e1emr19927257ejc.26.1672222691604;
        Wed, 28 Dec 2022 02:18:11 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:11 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 07/12] mptcp: remove assigned but unused value
Date: Wed, 28 Dec 2022 11:17:43 +0100
Message-Id: <20221228101748.2518303-8-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=653; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=uZ1GtsrShc9C2g5MMHxhX8M/nNp+YYPJg4WshuQZCy0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe/zdwNwhX5GIi12lg2zt1E/c6//XWQ04V9HwzN
 HqFhr5CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgc6FOEA
 DIX2LtBwuooJknrtMs1BxqYT3qMae/c/AReJPhylCWIqVNsSW5TtCaqT5EzzFpFb5UBQtVZxrMGYmR
 E/rdg1lMdU6lvskKsRteBuUiYZdXkhYp9YZ5udCPp3cFiukgFysyblr3/ft0uDwPyPDT7b5XM23u62
 nDnYWTd2kky3/SJwwI0Thfi12pR31wLd7sXixkp9JNnrSLodHFP8W6r/fIhU9UsNwCZcpuz5Q3QTrb
 qLOUg5KSQ9vNB6Z5WqsWb387isIC/rDrKS06KlwNnJA2N4QxOuIvVF6bKE86k9fGszLlM9xbMMIzDW
 v/exs7GHPtKIVqecrOJWPhvrefiAusLXSmn0fmEjmDx0nrtBtRuEMGtSsRfkCW4BYKORSH7pN0CAa0
 e+YLEt0d6ptl7sADJtqdC2GyMv4Vp2YNz/0pPk9k6ujlDHuUusGx6u0rtqOFHNYG/+DdOjuNjzFkxn
 hYU4cl1p5ktaCc25CC3/mEvgPGY8WAlFQD3JVlIkGZuaKu9q3CoNyTTdiy+1WByGUc7C1wgImldruN
 sgMidIw35kjwv+0zy2sGqpcojfcLyBh7iZI+Y3XkU0F8y4VkCOqHg2r/eIhiux5erVpnucsPHuD0EW
 OsK5iPcM1sCMrFWDPpW+AXYCeeJGOrs5nZUAjkzi1LL4FOls2LRBZ4gTB7UQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

'ret' is always set later before being used.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea6ad9da7493..be389dad3f0a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -34,7 +34,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
 	bool id_match = false;
-	int ret = -EINVAL;
+	int ret;
 
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
-- 
2.37.2

