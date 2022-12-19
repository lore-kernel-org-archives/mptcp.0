Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471D1103
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 10:24:27 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id d82so5867895pfd.11
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 02:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBA7CV3EQ+9fTM1bMrHYppBeRTRpqJ3IwFrDYg4UjbQ=;
        b=V3KHqeF7rwEEANkts+YM+6FDj5/YnRGZVUM9gqGODq1hzYr3+EguK6PYsUFNtEgXD4
         Cpf8HTltQh7AfuoanWRy9yOSq18nfRXBXh4O8EaAcz1e40YOK/9UCDfZn6i+CK+U5OyI
         3uNHyHybYGPXXbvSRcv3gvWg/gIHqMQr/MuwlQN2FoP2s1lsAfUAhvWtDOTPN4SEITrP
         YSmHakWP+B2TKNlMnoQLGYIodh+LGi/BBO6owioeOgSRMqkW7XIvJGKAmW+c8bdH2c95
         633iJHttsca5Xj2Qg4du+y4NEwBwlastQJXc4S+3D8DA5xnOpCR0/SLJipoUOQ7mhpcJ
         dQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBA7CV3EQ+9fTM1bMrHYppBeRTRpqJ3IwFrDYg4UjbQ=;
        b=1GMQVOfqmOU7KTmdgQy/X8wX4GhK7dqWRsYV/K83TjfAIklaQ2EtRJn5utIMNzLSks
         Fs2GYcxMMHgm57RPmxAC1OD/J7qaZnAvdaDTvNSHe+kKAWNMDIUWGr53hg2KNDZrgR/t
         jHzKr47dPF95Yy/wIWds08JkkVc9smjCw/ewJzyL9pgyp7yMpTxyoZNxXyoMZmaz1Mro
         hnAf8v9T00p1rbXzjzSzr7bSmpTRGm702MGtV6oeRwZyoYKNwM6FpPa8Br481MiipDko
         KtFnHvUNVKnbn2hsht5BahIM1tL9TWtVLt2gBrlubbtVUqiIU3Vxf4YbNSiABAFH3Rb3
         I2DA==
X-Gm-Message-State: ANoB5pnqMmx+H9BYW3T7/0tIwSgzu688oc5UrFEHc2g9scp2sp1EoawJ
	AfZDm77jof/VacXotZaCM4o=
X-Google-Smtp-Source: AA0mqf7/rUJ5GfZvIRF9hcIdKquxtP0Il7qBTA7NYCP6rPFrDE+ZY1c7i3ZjimY5vrRHnLYQ9hDnaw==
X-Received: by 2002:aa7:8190:0:b0:575:62f8:be3 with SMTP id g16-20020aa78190000000b0057562f80be3mr41242794pfi.23.1671445467166;
        Mon, 19 Dec 2022 02:24:27 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a00212500b005775c52dbc4sm6206517pfj.167.2022.12.19.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:24:26 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v10 3/6] mptcp: rename 'sk' to 'ssk' in mptcp_token_new_connect()
Date: Mon, 19 Dec 2022 18:23:13 +0800
Message-Id: <20221219102316.627491-4-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221219102316.627491-1-imagedong@tencent.com>
References: <20221219102316.627491-1-imagedong@tencent.com>
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
 net/mptcp/token.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

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
index 65430f314a68..3af502a374bc 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -134,7 +134,7 @@ int mptcp_token_new_request(struct request_sock *req)
 
 /**
  * mptcp_token_new_connect - create new key/idsn/token for subflow
- * @sk: the socket that will initiate a connection
+ * @ssk: the socket that will initiate a connection
  *
  * This function is called when a new outgoing mptcp connection is
  * initiated.
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

