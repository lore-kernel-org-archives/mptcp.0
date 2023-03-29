Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72A1C32
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 13:18:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id e18so15678482wra.9
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680095909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiLSryY6/Wq0AhQvPBGjPMa0MK9KMwgVs/2Ngs2rmEk=;
        b=5ALwImz/iPST55mnt5AE4SzZ2DZZIaZyLgeJM9wXHcDidQACVqS9WqE8Zsb+GJIYmy
         XzDEdfVzYyoe3UIJQs1FceptftPtxe5WndHBxd1vvTJ62uG7YVhSiyjqWsKzl9Sl09rx
         lnovyQG24IhYXwozJs1t+Dy9PTbVNCITZw1H0LlqHkhzVBQgqTVsCFVXDdNMsUfbZqjx
         n4ZxZCy5ulJqqRIqrWhvLxa49tCV99DkA1GRQAbE8O+sg7Ka8pmpNro0KARRkMa+VuGh
         BmiMBCX4neASMFd4ar6BvkwpyCw0Z9QiF89KvHG+EBF1iMkjaR468fFxOPVj/TAbQhM2
         9Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiLSryY6/Wq0AhQvPBGjPMa0MK9KMwgVs/2Ngs2rmEk=;
        b=IxET/gEX3BRgiZuYgF8AP8Hbu6B0PIkUlyMCdwgbq0DvpTZtMQ5UN/ZeTkE7+LD7to
         DoVFHhOVHbgL8SlMce5PIogBmee2U3Zawrh/PWPEfOGE56DjU1SNgIqRWKStwT4kEQF8
         jbmx2Q1ZuV8Jz6+oAuJWh1yvS+dva6Mt7O+pNN+GgpPz351RO9ETWH3MCNCjUpIWd974
         sj2MXof9TGSLft3LfV4fZq7KSFNCqRew3YpUxMTRX6Ic4c1EZvlCw+z5ZzwwqJzqeXzT
         dh8S4uTwv62aLvbxNE7qZsK7Xjm9F2qqUKknqGEboLCFSYIhuOVBQW/BCotLTmIzKzyt
         I5vw==
X-Gm-Message-State: AAQBX9fZV/xiIvzPO3YPPhahMAHvdjh7qcwpq5Jlj1MDuindJiGx+goz
	xp7TURG21avQ3SDsfgwdXtTlLKmNLn3F0On9BnI+qg==
X-Google-Smtp-Source: AKy350ZLi+nidu2PefUpD2fOTu548LNVkBLaxPJ5wVAqyfNsDoxmFA5+4io5mys6dk3TC4qJgcu6EA==
X-Received: by 2002:a5d:6e09:0:b0:2e4:cd4:f59a with SMTP id h9-20020a5d6e09000000b002e40cd4f59amr1171430wrz.26.1680095908879;
        Wed, 29 Mar 2023 06:18:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000120d00b002d7a75a2c20sm22933678wrx.80.2023.03.29.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:18:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 29 Mar 2023 15:17:57 +0200
Subject: [PATCH mptcp-next 2/3] mptcp: remove unused 'remaining' variable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-mptcp-misc-cleanups-v1-2-a839001f0b05@tessares.net>
References: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
In-Reply-To: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Abaci Robot <abaci@linux.alibaba.com>, Mat Martineau <martineau@kernel.org>, 
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=2INg7m8zdyJ/qJzdop2FpEzxkvtqlBXbn9X3jI9J2nM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkJDqiltsl3qTTZqoGZfkIXjCKwsUe48sfuCn9h
 2ajIWgvFXSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCQ6ogAKCRD2t4JPQmmg
 cxZGEADuw0hejir9BiVjh4wqxGor+YyOzWo/qqAOaV4v2DvxZceqBpZh65o8rkj0vYCjpDDjpKb
 2ptQD98T3PxPYE0hmcts34r8qryzvFsPELWHkTiIqDBPnW2GmqyWe6whHSqnl3d6NzHY5dLhiEM
 Xn7OiXAyvEmNQHISrE+16BfpdSwKRk+kA0v3N9i4uWbj8NZXZCxgOAd03yamU+6/+he09ht0a1d
 w9c6lIdZ2fB4g4z16YVHm7DtiVBbOBqYNUCfsoL707K3rhp6RzzPDqEy3nP5PhgUlOw5R/SZF6N
 K5Ia+w5ilDqaDuoJYhK9mNrmZw9xRU4/37UnDrzmw2ZFoqGFMPa271H83HAV+53qXBVYDf5uDEZ
 6JNCPSEAQDNTj0MX2vbFHCi+j1Ngm5xN/ld3lKn18q9NVQsnjPdRJeDrbbQz6hull2cS6GOc0SJ
 qLqQV/R4PQB/LTpxHqsG1aoYq2+ttjk32HQktqyEbjcd0geDsPh/PuitHLHk6TD9BDMRWGCpv5t
 T5vQ+zBALD/yN+0D4PLi9DmmUFWSMgqYaLcDV1OjEO/T3b4VwZ039XAoyP+hrEFQatH+tbeFsLd
 BkZjaZFWnG/U+/yAy5DIa9PPIi3fjSOEpQ/Bkqf3eNzxFNdAOpFE8LpdLD/ZX2awEGFQSKP6REx
 UpWnyQpAcMsz+aA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In some functions, 'remaining' variable was given in argument and/or set but never read.

  net/mptcp/options.c:779:3: warning: Value stored to 'remaining' is never
  read [clang-analyzer-deadcode.DeadStores].

  net/mptcp/options.c:547:3: warning: Value stored to 'remaining' is never
  read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Suggested-by: Mat Martineau <martineau@kernel.org>
Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cd3b885c8faa..19a01b6566f1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -442,7 +442,6 @@ static void clear_3rdack_retransmission(struct sock *sk)
 static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 					 bool snd_data_fin_enable,
 					 unsigned int *size,
-					 unsigned int remaining,
 					 struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -556,7 +555,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 					  bool snd_data_fin_enable,
 					  unsigned int *size,
-					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -580,7 +578,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 			opts->ext_copy = *mpext;
 		}
 
-		remaining -= map_size;
 		dss_size = map_size;
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
@@ -851,9 +848,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	}
 
 	snd_data_fin = mptcp_data_fin_enabled(msk);
-	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
+	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, opts))
 		ret = true;
-	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
+	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, opts)) {
 		unsigned int mp_fail_size;
 
 		ret = true;

-- 
2.39.2

