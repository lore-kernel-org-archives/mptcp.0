Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF146F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 08:51:47 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id c17so9924609pfn.6
        for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otF1E4zJKsJgNAqMgKjClalFmyaBSrxYBNVlbpXECSw=;
        b=DJTA+OM54TVyl2t8c8EfHe3xJac1IoJaWrKwNj75Bsf6gCAaMmOeYIfxnJ2me3iku8
         xKXXrZbxH+VhsjxlX0BjwdwWeWzcgifVy5MT+KD5mTgkf8iels0Ijwn9r+glfJaH1p6e
         z0DSCy+wzdHe/KeQem+z4BoRKi64ZK1KPP3fhLYc7LQ54/V5mzrUpSLh9TmmnOrzNwZ0
         x/Z7a4d4+zV0fiEq9vxqKWyJikbzMXQwWnE9hFc/aOn2u3+ibaG6q89oaz3M1tCNL/7v
         PJBoSGj3tKNxG17MTzHnplUIcPYBrWCtkakGIyCTtQu4xJeNYmtVXE6DQRM3Gq32fSqs
         WxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otF1E4zJKsJgNAqMgKjClalFmyaBSrxYBNVlbpXECSw=;
        b=l4Xxsg+zd+EcmZo3hrsAdR1M4/GFBA5aYiR8XgK/qeiDTSUq3Xg/qoE9bXV7xeuOIb
         KOFOEvRMsPslJNeNA7dkeqUQK39rMy1fV0RVfGjdSBee4aRRZ4czum9dnh56gc57yBKW
         7qnj4QNEphcDNpHWbBpldYaKOsBHziAZQRdR0x0zrsbhOOjBPyj9eluGJ6DvhiRmrkwM
         GUkRS50m91K5804ZcWupnWWyRVkLcsf0QRHy7sJ5fqMD1Muvrnvw5drzlFN9xzkNV6l0
         2Tjc9MdaUECe0ZbebWXN2VuL4yamZ4MLg5WOAqYcL6anSxcotul7J3Dom/qyPBme5qUZ
         hU3Q==
X-Gm-Message-State: AOAM533oSZJyEBpcmCzrUB3PhH/BOMxjUHFbSg5yaBVE/u4GTjsAeppS
	wiJ+pQ9jCgpxCjghpikQ71Q=
X-Google-Smtp-Source: ABdhPJw3v79oBFUNN5CYBlZpfNL+KF7jU7NzptAeL1yhxX4oqAahLhuh62s1WLX4U4tSSdWF/8K5hg==
X-Received: by 2002:a65:4901:: with SMTP id p1mr2125541pgs.310.1616575907260;
        Wed, 24 Mar 2021 01:51:47 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id l25sm1735185pgu.72.2021.03.24.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 01:51:46 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.01.org,
	mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 1/5] mptcp: export mptcp_subflow_active
Date: Wed, 24 Mar 2021 16:51:35 +0800
Message-Id: <6e606e2aeb7ea4bdd1618783cb24675bcde693b2.1616575602.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616575602.git.geliangtang@gmail.com>
References: <cover.1616575602.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exported the static function mptcp_subflow_active.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d7e7e13fba8..3ad236689480 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -399,7 +399,7 @@ static void mptcp_set_timeout(const struct sock *sk, const struct sock *ssk)
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
 
-static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
+bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
 	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 14f0114be17a..20770fe39ea5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -538,6 +538,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
+bool mptcp_subflow_active(struct mptcp_subflow_context *subflow);
 
 static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 					      struct mptcp_subflow_context *ctx)
-- 
2.30.2

