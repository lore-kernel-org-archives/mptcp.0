Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04430DEAC
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289071; cv=none; b=kMqaXM27aIaW7yj+Bfcgx2QJHvgAtkRga7drdTU6PtDJ9LA+NtIBahnx2i5O0+nOueNarBEauh89XcXVZPXYNx5LRiIxXwsNUG0B1FcSdsI+o/jXpNebCnb6vrZkxciXAf7d95O1rMrXcq/HuPL7RYg0pJFRNy+W02bziEgAe6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289071; c=relaxed/simple;
	bh=MRR/+pSEWAeLMgDmwMpMUrOeg1/9Qpf6YfZ+Z/dvLPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GAasNPEl38+IBzlQoVLxit84rTE48XkaJNPDG+KtKYwlHHr1+4du/+D96xiaF5qlGah+IV66xPART9m1fSTC3OxmlXR5wjdO4t1e25HjKqT9tfyBVEdKfbs/wPubZ5J6c4u3YRaCpieTGhnIsnEWRLrG+xqCOxTqbhKuKcz2NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaG0t7o+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaG0t7o+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174b2582so3555651a12.2
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289069; x=1755893869; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf92k/WXre/NA9XVBZNM2RHpUQnxne1oa7jt/AbjtmQ=;
        b=uaG0t7o+cDC/S1/vZfCLrid+7a9SZ10IdHSAZsZDFDDOZpegS6RA/0O2V/KSdGjgR7
         10egZmeh8X7+GZSltoQzDJG2+ZWVSXMehboszwTDqLZJmyLOot6e5/gt9quKNNbJhTh/
         Uz+tfzFnbMSWi1OeP0QXeqzo0JxE01igAZzjfP4/q2ks0b8KM4PdfT/siYBMCcQQbX4i
         OajXniByrJg3m7jBTp/8jmfnVGgfnug6d7awq8U8ogInWwOF5izDj4RUqOPDTxQbYqAw
         xPmVr8RhRGrUM0oTRw7UXXNstcnVyX3PxXBDXXW/XiKt5XPSxAsvPuuperA5qoNvXIK3
         lrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289069; x=1755893869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf92k/WXre/NA9XVBZNM2RHpUQnxne1oa7jt/AbjtmQ=;
        b=OJSvXj3zkxyQxFuexCo9vH6amPspJVbpt8dXUPxO//7GS0Zm5o+MIjswomjTFtCITR
         2PtkPAp/FiYP2zQYaS2dFxBNFj0+QXuqLa3HlbhJZDI3Cga+cuNxo84gWy7HbD51kn6F
         SrfHPCYPizv07x1JNQIIYXxHyjSVcrqA3wUDO9e7L0MrDFPFIHIu1RJsUACMkEbZtUrg
         eIMkuZe/hGuLNf3kLwo/p4rFdA4R5z8sxOGsgo0NApXacJCKLjN8z4aw12S4fW4VtLiA
         HzOGhWIu9IgTqEpfdWG/o+wzOYGWvIgUSIqdjJOULynzBnga16lQjOgPuhnJBjUl4Zen
         rhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+AnXm34RglMKl8oNYD2NZ+gweqEfqtjmK48eDUzq6U/ODSCV2aOFpl63z7gBpmL4ceD6vXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyja2ZrY6VZBz1rCF4EOIbAHiKeojzCVpFgKabxCrUtZzePZf2o
	LGea64FJ7JisdVjC3VNlFsOW/U0bxm3sUvWx9f7ayPrCCqgstNq4rQJQToqICns6W7EcRlBdV2k
	ZPSuC6Q==
X-Google-Smtp-Source: AGHT+IHqEnxA1uJzc0XPdj9fJKBo3wWRxP+lR/iywZBaE8USdSC80qtRAT2PdogMo7IxQ/C4U5ZzQhy0h2k=
X-Received: from pjbli13.prod.google.com ([2002:a17:90b:48cd:b0:31e:d9dc:605f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c06:b0:321:cfbf:cbd6
 with SMTP id 98e67ed59e1d1-32341e9b0abmr4796319a91.6.1755289069062; Fri, 15
 Aug 2025 13:17:49 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:18 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-11-kuniyu@google.com>
Subject: [PATCH v5 net-next 10/10] net: Define sk_memcg under CONFIG_MEMCG.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3bc4d566f7d0..1c49ea13af4a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -443,7 +443,9 @@ struct sock {
 	__cacheline_group_begin(sock_read_rxtx);
 	int			sk_err;
 	struct socket		*sk_socket;
+#ifdef CONFIG_MEMCG
 	struct mem_cgroup	*sk_memcg;
+#endif
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
diff --git a/net/core/sock.c b/net/core/sock.c
index 5537ca263858..ab6953d295df 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2512,8 +2512,10 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	sock_reset_flag(newsk, SOCK_DONE);
 
+#ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+#endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
 
@@ -4452,7 +4454,9 @@ static int __init sock_struct_check(void)
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_err);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_socket);
+#ifdef CONFIG_MEMCG
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
+#endif
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
-- 
2.51.0.rc1.163.g2494970778-goog

