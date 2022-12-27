Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF563B6
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:41 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id l29so12978118edj.7
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fd6j44evsdxLh0WpMpw+J+gHn9aMiDodElArLsrBkw=;
        b=q0hwGtzjxeHHRfXPu0dK+c/oadyIarW2yPQ3MhlbA2iBg2QPlKAFQp0R8scPRDMk0U
         pWwEbCJyFHsljVhF8Kj0K8RyaMIaqesJTiR8t1hrtoD5WmrSBggmbeEEMIt2S+PZuJwB
         3rIyO08K7HVVTRsT5BtI7nmS3qHxoizkQcAtmwTYklu1bGJbFm0fd46/GFxUewvXETWn
         DQlNcaWSpomhHqdmfp27RdKVSzZLHxBA2a5M8SbkyXF3B74DVVuiXYXngybz6dmoDGfr
         2DSdisbBKLoCre4m0GXJPrIrtFxZq3Rat/YDljukuchfUya1Z0L6xIH5u4tgfVEMLlv4
         9NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fd6j44evsdxLh0WpMpw+J+gHn9aMiDodElArLsrBkw=;
        b=2zxqKYN9zJBMaSc2ExlicOGI/XYs25ouQxy80DAExQql+hgA1jqo/CYhEMDvoetH29
         cX/IA8w4D5FOnF+Bng0AdWaMlVbn0I76kz7VLH3RhA17HSPQNW9SVEavrPh9oQeUtBki
         ceCp4DaDP+JYR6HSIGAg3yviebQ1BOp/ySNvOtw9NIkgLAKEgx0LrMoi6xGcdzGTTUqJ
         0dClaAqYCXZGRmiUxH5q4cJdxw7LjpuZWFaWPtluAZ7mVu6yUZkBQYWlOK+BCZK2USFm
         K8+mkZkCD16rXIotmXsqDXIQ5vFYfXSmauKdfbZvkr02U8mcel/pDr4L/wZDBNTAdrvP
         qgqA==
X-Gm-Message-State: AFqh2koFvIqMIBHLOU4AcoOBZUqObU65F5D0TEnvOlItTl/cY6D8lUyE
	89R3C4ErApLncblalDTrXsqFqvdsAVSgdC1Rbb9hHQ==
X-Google-Smtp-Source: AMrXdXtFsaf4JtBZCgcg37LECq8acTAjjD/ERukIevH6LCs7ky3l8QoTZq2gHUjye5BssoVORnWy4Q==
X-Received: by 2002:a05:6402:1caa:b0:475:b14a:f83a with SMTP id cz10-20020a0564021caa00b00475b14af83amr18525185edb.15.1672165299360;
        Tue, 27 Dec 2022 10:21:39 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:38 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 05/11] mptcp: propagate sk_ipv6only to subflows
Date: Tue, 27 Dec 2022 19:20:51 +0100
Message-Id: <20221227182057.2288816-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=3kFlGna5rOeu2JRWjKHDAzgElplXk4ztNIOnJGHXgXY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd6R0xH4p4pVLmey+SRnwbbsIZ0WGxSsK61eWLt
 hTDcQo6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgcx71EA
 DgH5avFmnHEyIgSmKkA1Jmfiq23L0XUQq7WUIuJB6QD4SDy30PSdfq0hImgrGTw40a75pmQX9cSL7K
 dR4RExmA4lypeDDfoRgzXs7LRY3Cv0eCfOrFKfWkYG7ibVbqVHcyp0+sKhpMQGby3PZ1xOIkJrWgV1
 Fa17dVrihAQf1kwO288IGJNEYLZQR+TtiGOfGY3JuIRr2p7EjZgSc98jYkVkQbd+VixU0FDkLbhmve
 zEu7bejQYykOBBJR8A8liQ01oyRgruHzlpdTk3GChFHEGtCPocvgal+gqUyXA+j1puSC84fs5tPaX+
 5XU6r84CIbmt/xdWOOIEjKhzgK6QqTWmvWBi6zIWkg0UB+MlOUiROtP8iE9WDvczrvBlaFykXw42Q5
 sVHPkVDzZReYYG9q2GdzdqATdjAc1BxLaR4ERkd0g3BEcoOJZSqBXcRb9ExTJmLdNhy+ek+Cn43Rp+
 WaZNRnOUdnkudVarjMnGFsFaZ2uOvaOgQqdIOPcK4OYYTAWA/1XQycYrX3qsEg/qNj/YfQjFz0q3+q
 vS+MwEUkpL2kOq74cXnlYRK9qyigT4CRckTxXhgTC101zIDSD9if0pZ+0unry/lJDiAe/rFHTK2fhB
 LKQ6cvyVMW9EZAe0aAzcIGmsVuMKZIZauVBl++MFMYcNo1LR7nHn7LQGli4w==
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

