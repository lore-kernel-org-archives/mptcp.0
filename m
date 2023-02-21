Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D7847B
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 17:54:58 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id az11-20020a05600c600b00b003dc4fd6e61dso4277764wmb.5
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 09:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc+9jtdKdIOVkdKdtr9ZAm30tv4JuckVD4TXe+B9cEY=;
        b=8O3yVAqbXXh6V//DDnsVmJEasApfFKC/AImDouCQV8BxtqQQduxBq48bGeIFk0uBtZ
         +83b9h+P7dddoHHd4NdnlIy/0OvXobxyR76X31dc+Ju4a6cXxf8+EsIunAUKCv73uHiu
         8LBnhqdd6FlV40kC3m/CvNR4GH2peoWtnObP+B7RWI8z2CKo4Q9YUAATqBvWkqlFxcTM
         WERNIvMmHJlW5QumrvbMVs+We4hzhCegagjU0gGtZoLx+0xOcpV2hwJHoZ520zDtARXN
         51row3JxLO2OKMhSGEol/rgU64hdotbfphBDqPgJV2TQ+L34LuQT22UZy0gczf5RepTf
         G55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yc+9jtdKdIOVkdKdtr9ZAm30tv4JuckVD4TXe+B9cEY=;
        b=z7ityfP9Kzc8x2jLoOydMiAy31tE/3lv+3Csu2VqZmb7TydX4fBuWgKrTh4BZcTgLX
         8VbJ2+pnT8NTiun6DOiWalYXxMuP5a51OsjWCzzjYGQReTR6DbzuiR6jOiLPZPrjjdVB
         JKRNZ/WiPYqfYR+IVDJh3qRcmo5OeJIwl9RSyP8WwaVvB6LdyHTngGv78D+4bBP9Y3nU
         mf+N5dDQhR8TjdHM4NK52NOgxa2iE/+a8ZLkSmzoknxj8xI8JkRvWjmIil1pZ2jLNt6K
         NKhcHxv/A3eJARp0bySfkRR2kJ0d9zafkz+9nypGtgeKahVnnceujuAkOZdcfQsVrL+e
         ACIw==
X-Gm-Message-State: AO0yUKXWXqp+C9IUKoq9urAr2I/klFv7dfh22wXCnC/1eMWiAUMVl501
	N7A5kGdn2YhoD3uPW/T/t3oNEwaiYD1zeY1A7iqbBA==
X-Google-Smtp-Source: AK7set+tnaNVGBumkw/aqPV/xMY3xUstLa0Usj2U5+LXXL5Tqzz9T9eM99pd/ygtgPsVtGWIR/ttfQ==
X-Received: by 2002:a05:600c:a694:b0:3da:1f6a:7b36 with SMTP id ip20-20020a05600ca69400b003da1f6a7b36mr4038546wmb.0.1677002096043;
        Tue, 21 Feb 2023 09:54:56 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t23-20020a05600c2f9700b003dc521f336esm4780228wmn.14.2023.02.21.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:55 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 21 Feb 2023 18:54:39 +0100
Subject: [PATCH mptcp-net 1/2] mptcp: avoid setting TCP_CLOSE state twice
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
In-Reply-To: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=HE/qrwOArBK25rtzp8whL9gcWhG14qb2CD0MTJ5HHHw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj9QVuREA5bK9H52L7RKptlmTjf2H6ULFDv+4b9
 eGJqINItQOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY/UFbgAKCRD2t4JPQmmg
 czCRD/9y16zYz/m/FLVc4qAw6F6LLImSgD4HUQTJzYP+sxcbLyt5j5srLz+O3b+8G0aWD3LyFH6
 +V+LVv2GKPJICur3li/CwnH1mSplwqd8eXKkU5anGRYvffoSEgx/ncZCKR9RD9xy8MqNTQLUrFK
 YQfOiZY/J9XMdh+khRQuhKQhcpfqaTcG16gqVhBh37ceTlIKAnDaQfyZfBFfvFjy5zKGIui3/me
 e+uz0IDAyKpYFShAAHY4BOEA3H4m0TAa6ysYZrpf2UHAO8ji8h6rAqYqdEIuhR/bJkrwiocVgtr
 W5c5HeJwoJIsF1OP2TDxnXNNrowGjCsySoMsb+oytYQj/FCiPUWG0O8+DoQNwbgL2q83EfRfopH
 40RTaSYHis+qGfx9rM5W6PppBuVbShV78PFaP1QLqGbvHWewMmiC3OuUQHzjlg9aNrrrJGW8Vzg
 AFF9ph3eAPbc1zdBIzME6liuxvSn17j9ARGdz8Ne3/glLwM+b7/9qGqemN2T0mr9epOaeGAPysa
 9meX48TOiHuwZ045ORIsby2PFYxSMmZVF5S793JsLVWaHMTi1CySKvXOQ6OLVu01Rwa/q664F8s
 s7oGimJvTxVX0kCL7E4jL+b491oehPNVlpf9AyK75ZLn1eGIrx4OxzuHTUXyNE2W27HHmix9F+F
 WrYohbk56EIWmGg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

tcp_set_state() is called from tcp_done() already.

There is then no need to first set the state to TCP_CLOSE, then call
tcp_done().

Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 28c64811a8af..a36d1b1088d7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
 	/* must hold: tcp_done() could drop last reference on parent */
 	sock_hold(sk);
 
-	tcp_set_state(ssk, TCP_CLOSE);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&

-- 
2.38.1

