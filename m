Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A7ED2
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 07:51:34 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so12134299pjr.3
        for <mptcp@lists.linux.dev>; Sun, 18 Dec 2022 23:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0thMjq1glmFz6YBbQcPg0/GuHxz5v8dFqaU9ZI/vas=;
        b=p7xd/0UJiigTgrMPyCYC7dYtSf7LziDvMAhajVXxcrsI3268El3QSepPwyBFQaCF9O
         bTnDGil7oaVNM2R5mSHO6MjDD/e3+1bXDdP67Toza+0VRjwk+PHC1lvYEWqPF2aAlHZB
         YUjW9i+G/L2/sr06iC/G2R0p3jZR2CmXEh0oD/WfskFivMEa/DuGaMsZV1YISxFpFeBW
         XbX+GqpDKPmhdOqojpKmDkDW0JEC46D6cmCKn/lSgeNMvAOiXxCvUSqX4P0YaJNEa/kH
         nQN5wiaopGQD0OsDsf6/xWy/xDngyfHACDjOr84abeRXxVjopGftQk19mD00jgZE1y8F
         9lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0thMjq1glmFz6YBbQcPg0/GuHxz5v8dFqaU9ZI/vas=;
        b=Vxq9hUfs+9WjPQgjw6d1VBvHEBhng3h9AWRmCR9I7xEOkW5ODEYJJYmewBU8P9qqc0
         mcYVwxrkatDTql0hE0AqOIQ9UWYL9EFKNvJh9udpFhiAMv422iGyhb331LNQnZfWnFTg
         Txt9IHo0NBMQ2GLrOpN5TrEvo4ELp9tVvxlExGzOqcF/ei2VOoFy/3MNtZGE5bYRdl4B
         wNarafpBkU6VKUiRQ5BWybWUaE3qzta27IYXVghHDg1BRvMXhZN4z+EU9/SMZK0NGNkJ
         lNLMRNT060mfmA6/NLa0zmLGTC224igXNDai6tNQhrmxAIVErQsMB8gEP/lni3OCkjBi
         Rl6A==
X-Gm-Message-State: ANoB5pncmN/VbD9EIVdxbt6nReCw1BN/uC2ajdkvrzFnleGWV3lYnSH5
	eNRfNynhfyfbOQxizb4XQW0=
X-Google-Smtp-Source: AA0mqf7TNizILOYFB5TPQjVnTTFT6POm8mzTI7Sg4GMQyKwl5uErM1fqHy/7DnwxBUrgol927M5tMw==
X-Received: by 2002:a05:6a20:b557:b0:ad:2c7c:9510 with SMTP id ev23-20020a056a20b55700b000ad2c7c9510mr38605125pzb.19.1671436294108;
        Sun, 18 Dec 2022 23:51:34 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001888cadf8f6sm6366673plg.49.2022.12.18.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 23:51:33 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v9 2/6] mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
Date: Mon, 19 Dec 2022 15:50:44 +0800
Message-Id: <20221219075048.255811-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219075048.255811-1-imagedong@tencent.com>
References: <20221219075048.255811-1-imagedong@tencent.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

'ssk' should be more appropriate to be the name of the first argument
in mptcp_token_new_connect().

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/token.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3cd3270407b0..de7d901a79c6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -766,7 +766,7 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 
 int mptcp_token_new_request(struct request_sock *req);
 void mptcp_token_destroy_request(struct request_sock *req);
-int mptcp_token_new_connect(struct sock *sk);
+int mptcp_token_new_connect(struct sock *ssk);
 void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 bool mptcp_token_exists(u32 token);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 65430f314a68..968008f6db45 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -148,9 +148,9 @@ int mptcp_token_new_request(struct request_sock *req)
  *
  * returns 0 on success.
  */
-int mptcp_token_new_connect(struct sock *sk)
+int mptcp_token_new_connect(struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	int retries = MPTCP_TOKEN_MAX_RETRIES;
 	struct token_bucket *bucket;
@@ -169,7 +169,7 @@ int mptcp_token_new_connect(struct sock *sk)
 	}
 
 	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
-		 sk, subflow->local_key, subflow->token, subflow->idsn);
+		 ssk, subflow->local_key, subflow->token, subflow->idsn);
 
 	WRITE_ONCE(msk->token, subflow->token);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
-- 
2.37.2

