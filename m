Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA47494
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:46:41 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id f5so29807944ejc.5
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHX4+gdlsJi/TnSJ+BMespZ142cMkBysPDTUnskaRiY=;
        b=xPj9VMwck65gslV1Ej2RHnTjwZR/kjnnwiuCs8F5uzUDzTnNGSbFWAbkw19wvCy7qV
         MGTXEfSL6ATjT3HTCE+2y2p8iuO7QOdUG9rZbvimUAf5a9WAJSZdAwuKcOFMdY38etOq
         /UDVMWXbVvHvV8iOOcIAfoeB6TSJXjCQ9eENM8Q98upS0uU4WnSa5fhhoJ2MQ9ws3AXH
         WoRLyCyDvkjqUpodXxJJB3uxfwdY6gCK1xcT+vxQUweLokkXh1tiwc8Z84YfXHFanQOt
         L0QrUPttcZQmP5CVdeD3iB9OqOYq8ApAnUud5+etTgwqOnDMJbSzwpZCzJwVOJIQ6aDE
         UQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHX4+gdlsJi/TnSJ+BMespZ142cMkBysPDTUnskaRiY=;
        b=QOXlG8Q1IqTVKCspeSmQuMOmtA3gWaukawWhW9Gc2I6+0EFFYNQtMbujWb5DUeobTK
         2DoSCTP32GYzSEsBFPZ+1ZtgJd4P2J0yx6zasol6g42RYHZJp/ATf1XHpcWomcm+KG2o
         kUlDvb9IK8obIvTlNWVX0I6rHLH83Q2le8N7/bulUxr3pwz213e4JAxVUSpbaO6Mn4FH
         ZSPh4Y2MKxOWCU2q6GPne1Md37syzSvrip16+E19mVhp0wk60ydvaGTc1bfxAZ9E25PA
         xA5JY8nf1r1Hkal2rFHqPEBZNfsMXlevbtCyWy5RXQGB2r+FsMfEkqZCB5DgqI1hS0Ir
         MQQw==
X-Gm-Message-State: ANoB5pnUsd3FJG9EjxovG+R+9qkR/EHbDyJA2hFJyilx7rQYcFVmMzY7
	/Wgct2Ekm6kg79h50ZLm//mbEldCOLiXZg==
X-Google-Smtp-Source: AA0mqf4/ZwtSDnCzUyU+xb6eYA5ob4IHW1UPOm6QQOt8zJsFwzZP1kiEwfGAqzBMrLLkswu8D9snWw==
X-Received: by 2002:a17:906:e245:b0:78d:bc9f:33da with SMTP id gq5-20020a170906e24500b0078dbc9f33damr10741947ejb.80.1668444399682;
        Mon, 14 Nov 2022 08:46:39 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00773f3ccd989sm4377877ejb.68.2022.11.14.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:46:39 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 4/5] Squash-to (part 3): "mptcp: add subflow_v(4,6)_send_synack()"
Date: Mon, 14 Nov 2022 17:46:00 +0100
Message-Id: <20221114164601.861295-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114164601.861295-1-matthieu.baerts@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=UbjdJ1yOCyxrxwDoyiHxqe56zSM3kMXoX21HQQUK3Ag=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjcnAxsE3qxOe4+rQ2+MoUFTzDjczJgmQxF4HP9qKw
 pfiPADOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY3JwMQAKCRD2t4JPQmmgc755D/
 4xPRUEUW5I+64dKI6Q30C7r82VJBgdnkC8R6dWmbAS1FzYk0mhBmqQ/E0ew0GUFhhTxdHxVNF7w3lf
 FUy01UHq0QCfxlEdrJpuBPmC8yJ+F7d8Z5WtrLGUPAO1XYHUbXUbgE4w8+bV6cU1bRLalDIvwqdvpQ
 qaoTdlKgLHQ7ol2Up7k9ysZkwzCv2IcmFWRYbdzJPfiQfOv2X+pspeEQsG4kWL9CcN/8ZbKce4ppHt
 jT6NMR22qk0Pkape/sP59yHFtQ7R1iRCgbsxURcUYtAW7kF9zQ/B5Xc/wgo3T4ed6sFkyoNKfhO8WA
 rQvIj6zsQqPtfhFvGvmg2aVJHUv/A+fpzRJSFp8iKdg8Qrw/ySpm5C/qjgYL0dwJNox7/4mF3BEmho
 0cCTsD+n7Ws9w6KLe1ApNe9IwK7nmcNBrP56Ed76+GAZ8XAaFpRPYHOCrYPUMMl8VB5x9eNguoR0cD
 CAho2Wn/zFptZaA7bKxI0635WU5B7XywvYoUAQVBnuWN2wBJ9J1OtgPaAo5vJXCQuuCBnIBw9ni6Zs
 lIyNVWOml1S0UKTBjxVqVNIqSPPjjd0O7wtvmTDsnd3BsFkoJIE/RotsS0A3vAqKO2OEbOfRfE6y2Z
 pKKJ7PZTeFGQypklu38S2Mj3Ww+SJalIm7qIpj4ilRHVfYtUFPwSEUPZz06w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp: fix warning reported by checkpatch (with --codespell):

  fastopen.c:30:  'belown' may be misspelled - perhaps 'belong'?

(while at it...)

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/fastopen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 4a85e1110328..a3ec92c1e1fe 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -27,7 +27,7 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	skb_ext_reset(skb);
 	skb_orphan(skb);
 
-	/* We copy the fastopen data, but that don't belown to the mptcp sequence
+	/* We copy the fastopen data, but that don't belong to the mptcp sequence
 	 * space, need to offset it in the subflow sequence, see mptcp_subflow_get_map_offset()
 	 */
 	tp->copied_seq += skb->len;
-- 
2.37.2

