Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8C10EF
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 10:24:25 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso12567962pjt.0
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDMRQQgmzcLrWi3iJXP5+Yn2rtVedztMbMwGnRNqbyM=;
        b=qHyuyv+aKvhuD59QBvrnsY3H3BMXw4mTCFsMNKDzSzeLKIaY4BzwVyLo3ZE24kaish
         uL8j5XivyvY0sXjVR/aFLdSL3fYARmzsdO/jc1aiiC3eDHeNFS9GNiBvWYC8xNxfMG2c
         KW5QnFG+0SaP/0k7Cw8BiPl9cqkFpFpZE7rPt1R8z8cs1SCx7h3hSnz80EE/DOchJjtR
         /2Y34wL5vA4H8Z3EIWtB5ZpZ+6fVVKokkPzM49VmF02caJzbPVZ4ylXwRZiRTtbFhgFx
         mTbLJ36c97SLuS6G/7h1nRXnhXrosIX7Zzo4W0zK8bk4RtOs+EMAS4X7P57arzuEuvBT
         bzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDMRQQgmzcLrWi3iJXP5+Yn2rtVedztMbMwGnRNqbyM=;
        b=nQw/ZQ7jHnnA3snuMRv1a54CTG4nLDdUjC6jc0bFsrLfKZ/MweRWeQTOSq3TUBSNNQ
         yzI8MGq/LbiXx0NSVw+rUmgrBrUO+KCd1NoBfDqENuZ0L77vhfljQeDv3bAUvD1ehWAy
         wHPuk/hQ0i3eyAzJlRmx54qScEgDgufbwy0zXrG50iuq7lBwCXNxVJnm4HRaoLcDC/ZJ
         yfnN9Bev7S4aH3maB46k/Q5Cbq3fJGWIouU2v9av4M1o+KU4xgua9Gx6//8WctyVqo4m
         wVjDWeoXl7kJ7HEcM5Em3cW5D60av72WKdEk//aSco6lwIRu61V3enaf8HtaCmPoqyNa
         YNQQ==
X-Gm-Message-State: ANoB5plo6P9PmRXWkCPvSpTGmF3N+Q2+Rn5fU4prHxbE7Kzxb7ZXzjlP
	YDzAcvQoBF/GZjMRK4IuxGrrUCHbdLjB7Q==
X-Google-Smtp-Source: AA0mqf5f1gBrNjPRVfZ0KwCxgw6cLoAoaojf//fvSvS/TVwDnKfKo8rzLNkuqaYoUokGS2G/O+8Y3A==
X-Received: by 2002:a05:6a20:bf02:b0:af:1a39:553d with SMTP id gc2-20020a056a20bf0200b000af1a39553dmr21527791pzb.14.1671445463155;
        Mon, 19 Dec 2022 02:24:23 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.23])
        by smtp.gmail.com with ESMTPSA id n5-20020a056a00212500b005775c52dbc4sm6206517pfj.167.2022.12.19.02.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:24:22 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v10 1/6] mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
Date: Mon, 19 Dec 2022 18:23:11 +0800
Message-Id: <20221219102316.627491-2-imagedong@tencent.com>
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

'sock->sk' is used frequently in mptcp_listen(). Therefore, we can
introduce the 'sk' and replace 'sock->sk' with it.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/protocol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5e813580c394..3de45444557d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3655,12 +3655,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 static int mptcp_listen(struct socket *sock, int backlog)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *sk = sock->sk;
 	struct socket *ssock;
 	int err;
 
 	pr_debug("msk=%p", msk);
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
 	if (!ssock) {
 		err = -EINVAL;
@@ -3668,18 +3669,18 @@ static int mptcp_listen(struct socket *sock, int backlog)
 	}
 
 	mptcp_token_destroy(msk);
-	inet_sk_state_store(sock->sk, TCP_LISTEN);
-	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+	inet_sk_state_store(sk, TCP_LISTEN);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 
 	err = ssock->ops->listen(ssock, backlog);
-	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
+	inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssock->sk);
 
 	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 
-- 
2.37.2

