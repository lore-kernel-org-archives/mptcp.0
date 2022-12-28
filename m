Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34410FD
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:12 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id qk9so37418403ejc.3
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fd6j44evsdxLh0WpMpw+J+gHn9aMiDodElArLsrBkw=;
        b=tiLu8DjkfVV3hav18Ou5USDi9xnffxmqKf3SIRmYZKc1w8vl8xtAaBMjDiI4y7UAd2
         Q9cbFRiT3Uka2jCF5kqbuCFDpnhO0wF8Iofc6lOyxeCxlEDJXzZP/22ljDGdYURvvOv1
         pv2jrw/O9Tyc+95yUSjVDQ1U9cFfn6MmBR2IlSuyljRkGTyTA9dFaaXrpIq5Z4udBeq4
         lECBaHyQbkhb1cJKaWlNyleiRPhKxnYoxatLUk8swqtZ8EUKwTThwuNioLmHuEATRgJE
         7HCNWRv/EskOOkPTiov9mjWySx3if/XDXk8cs7Vuc34bxnk75dNoHrzyztZ2riCqBK4B
         186Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fd6j44evsdxLh0WpMpw+J+gHn9aMiDodElArLsrBkw=;
        b=3k95sXl1SotYTC1zR6vzysLWkkcsF8Sg2I6rC9gvnQpKxdBv276Vad5Gh0F/kNUyNV
         D6uD4YfKiWTxTPP1kLpSf0+M6pp906yWO3Wti4uuWl7E0EwGmwPp3aM9fy0YSwURUYnX
         5iMU24Tve/f+UH+sdLUsssJ81caVV9GmR/iE0wl7GVZwObpACkS0rsMZyI7EPRw/DyI6
         YVohgkh11A0cn7TG5XhApUYaogHHIFRqAUtADOQFsLiTRuN4yPRrgPTVlgezolzgKry1
         YwIkYf2VJ52VfQ2ZKrvDzUO0Ri4oUROJCLrZxAEaUQFydzdBXhoqOTnFnyVwMJEUPM04
         8nZA==
X-Gm-Message-State: AFqh2krAhbfDRcpXhJQbLe5JrTr968K/d1kmyZisN3UR4BeiJpR7BFi8
	YPmdr0UcIz1bQqjLleD2gLwmY92JKXW6CTvI4fDW/A==
X-Google-Smtp-Source: AMrXdXt1LuZIvlCb/2eKQdn/bHBEJRZO8GoIkAMpFoFYKf434sXBnXOdFVOvGQqrFxsx22okK/mWIg==
X-Received: by 2002:a17:906:dff5:b0:7ef:b60e:cb02 with SMTP id lc21-20020a170906dff500b007efb60ecb02mr21077138ejc.48.1672222690100;
        Wed, 28 Dec 2022 02:18:10 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:09 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 05/12] mptcp: propagate sk_ipv6only to subflows
Date: Wed, 28 Dec 2022 11:17:41 +0100
Message-Id: <20221228101748.2518303-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=3kFlGna5rOeu2JRWjKHDAzgElplXk4ztNIOnJGHXgXY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe+R0xH4p4pVLmey+SRnwbbsIZ0WGxSsK61eWLt
 hTDcQo6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvgAKCRD2t4JPQmmgc7UWEA
 DIGwG5xKWAO9mhRN5CoJwfoLaLwcdQDfwEsQuPbkL6tvsucHYDcHVg+pPT1MvPk4xbmVZM33JrI8OR
 y1AxsT//rr56wJoztZEtIMmODbm1YQQrckBkRpJY8b8KME+nYdqha1JtFeGDWXk8UdDqw9zldkNEi0
 /+i97HVePnlmNgoW/k2bXOAlkuaBPKdc2+hJIDX7Vxgs+CSlCGopC91fmCzpg5dih3nRCbmlpm5y4n
 0EipSKpU1PhCWl+NJJeIB6gt+YYBmTunlcxOle53lv9dTEUeR8D9on9srdT9VvXHS7SO7Mvo7Jkf6b
 bi3Y6H8/MqesAdvBmj7CEXv2+yXK+P2xtdsnzWQwTCNyqzcoPKVpcn+EW1PwsxqVls1c8amBjZpXnp
 4/XFzg9t45L2yhHC9ly80tzQxul7WZc+gkJaQMrfqOxvNXHMikHLZb+GcepeMz/QECKHnFOLtaPAYa
 U9OZ18ZXXeDug5be/frF9lJJfhIhD/yCyX6QVG/hDQpFvnfMHzIpftIkOk2TP1AKU3lAiS03u6aCgK
 EtublYLQhuogEjR9VHm3I+kTCGkS3xz7PV7s+Ufu0QNuQvcWu+sCcAczQOxTao7u+QaWgvCupZjSdl
 CTbEDe1/ZqNoY9uW+AWZSLXvMGv+mLB1KU/xyKex/wk0XOWkKN1rtIii4RhA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Usually, attributes are propagated to subflows as well.

Here, if subflows are created by other ways than the MPTCP path-manager,
it is important to make sure they are in v6 if it is asked by the
userspace.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 582ed93bcc8a..9986681aaf40 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1255,6 +1255,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+	ssk->sk_ipv6only = sk->sk_ipv6only;
 	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
-- 
2.37.2

