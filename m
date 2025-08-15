Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506563090C6
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289069; cv=none; b=AcFMKPPGcAQJ+e1fz0XauU8oz6Vq4tFleBTWyclTNPNeu5ZyAONC1bMYvLSBtVWRTkYgPOK5y/PVHUTsyLWfEQCc5JNEDaEfb0+PTIXlPAy8ZZvWIlmRBbCJa8+1jfUCVGpHG0syaGOMXYehuhxYcUZTyJj/lbuuy219KrJti3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289069; c=relaxed/simple;
	bh=vh18PK56P28TAsZ8ZPMuAn9/KE5M8PEvCAMdT85jx+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxWy0zzLPg84xRxul668e9OyvuPSGnbY5wqrd6p6vYEugQF7nZeEs+MTr1LANkgBlb5UYg8FQTR55DAWwXhVRAwYTApMFQL98ruvVy947GF84NNJ4ZkLHSQ943HGTwAA250yG9P9CAMedVerfHai8/TUcnTz+S7X3D3gavSsfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llbz07iD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llbz07iD"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60c3e7so3681301b3a.0
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289067; x=1755893867; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQG0GMWGg0EW29pjW9cSPQlAKpK49JIR3c7s4HvSqPM=;
        b=llbz07iD3mUDdKtxwIYdlHPZS1i8q/6qpfSNjkl8vIgO2Hn/fZsNp5xWsgxw9muW74
         VsWTvhC6pM/TtIaR47Ub5yzz8VgJOqWJV/5XThnffEyCjYRvcibrds72m2e6ubtI0w28
         8BftTs+swOsyhGIyGiAh6G7I34zIAYe+j43wYbn7alDeaaUIDBmYMnBOVgfOtU5LsDtW
         4VELcqSb1YpeCzTd/pM6S8/8DTJ52JPvJCmHCnJk4ArLMsMRsTGu8HlFbVmRFx7sIeYG
         weCthG93HayBKkU5lLY7zhf+Fi8dvgAENWXT/NRY+ITiZOERzhABtc+wGjr4nZG5S3+O
         H41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289067; x=1755893867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQG0GMWGg0EW29pjW9cSPQlAKpK49JIR3c7s4HvSqPM=;
        b=d66lLqd0iShw21rMOnGX6jzZiwlExckM0Gh7KdAPXWHMJJ2zDbJ8MqWRlcDoqWKbNn
         mGg20RIzF+7br+9e72iLuwvxGOCeYUdG9PehA7kWGdE8UMuZRw+E9wvE2BE0BwBHRgmm
         Ge7hwyEdJOO12pSxd0lcUHc+2llBhW7RAV0kffVlH5QGUJYnUGxTZ4Nl0pNmEUv/62ED
         SXBdCERaKhHW63osewkY7ObLX1GIlUc6ZPayJefhEq5AQxWtY5CwGx/nld8Am48kaorA
         3VPxzKFt1tI3/jaTxcfD06xPHTXt44EpNxIl6odbaRRJsWWuxePds41DYHAiAFl+kfky
         nl6A==
X-Forwarded-Encrypted: i=1; AJvYcCXnkzLx/iwRkgIjspWUpSy7rCjYYFUiSRC3CeUdCALSW/455OPI5LRr88ax7REfQp/71hZpOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLSJM1+ruxgQlF+OTeG9gtZNiPj+Q0wrCM8tnVGWCEUpAD09ea
	z2bY0tH2yHarpdEB0I3YE+T1ph3hwlR9aclgIg2tDo8Nhk7ckHcSE3R/MG0gjEbDqYXYq1eqsbo
	xoqDn5w==
X-Google-Smtp-Source: AGHT+IFp46sq2D48DZO0gUoHI4Uo8szEk8EClj8DpiFjSc+NkMZfkRfKF8J0RyyXgIbY22ezjmDiUSSBttE=
X-Received: from pfbfb7.prod.google.com ([2002:a05:6a00:2d87:b0:76b:b0c5:347c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88d0:0:b0:748:2ac2:f8c3
 with SMTP id d2e1a72fcca58-76e448632b2mr5380061b3a.24.1755289067566; Fri, 15
 Aug 2025 13:17:47 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:17 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-10-kuniyu@google.com>
Subject: [PATCH v5 net-next 09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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

We will store a flag in the lowest bit of sk->sk_memcg.

Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().

Let's pass struct sock to it and rename the function to match other
functions starting with mem_cgroup_sk_.

Note that the helper is moved to sock.h to use mem_cgroup_from_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 18 ------------------
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 22 ++++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0837d3de3a68..fb27e3d2fdac 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1642,19 +1642,6 @@ static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
 }
 #endif
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-#ifdef CONFIG_MEMCG_V1
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
-#endif /* CONFIG_MEMCG_V1 */
-	do {
-		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
-			return true;
-	} while ((memcg = parent_mem_cgroup(memcg)));
-	return false;
-}
-
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
@@ -1686,11 +1673,6 @@ static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
 {
 }
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-	return false;
-}
-
 static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 				    int nid, int shrinker_id)
 {
diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 859e63de81c4..8e91a8fa31b5 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -32,7 +32,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 		return false;
 
 	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
 	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
diff --git a/include/net/sock.h b/include/net/sock.h
index 3efdf680401d..3bc4d566f7d0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2604,6 +2604,23 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
+
+static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+#ifdef CONFIG_MEMCG_V1
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
+#endif /* CONFIG_MEMCG_V1 */
+
+	do {
+		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
+			return true;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+
+	return false;
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
@@ -2614,6 +2631,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 {
 	return false;
 }
+
+static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
+{
+	return false;
+}
 #endif
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9f01b6be6444..2936b8175950 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -276,7 +276,7 @@ extern unsigned long tcp_memory_pressure;
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_sk_enabled(sk) &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	    mem_cgroup_sk_under_memory_pressure(sk))
 		return true;
 
 	return READ_ONCE(tcp_memory_pressure);
-- 
2.51.0.rc1.163.g2494970778-goog

