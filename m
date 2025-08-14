Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4025CC58
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202170; cv=none; b=dEqlGgAfRXEqiNsgFWy4nvqj/0hwRQdWnZ7vPvuDRYuoamnoNYpToMQxxAiyUpWvQVrlJAxi0zCx5NBvVe7ES5lBQyVTdGJb4/CiveZ3JiyAWfwmFGUobKm2kFCPjzFjHaL9Y4vwJ9FhpIFesDYQ4sYhjyx1XFEC22a/BmDNFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202170; c=relaxed/simple;
	bh=0XUmvTwODNsLtlQN5tBduVwPTmibzhPt3TSnhK/L4MQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Khnyf46q3xmPZTFUK3RtMK1i5b/101AP019PUbNrGYLWGOVqgzb/X8jYfb00/a00sYyj1Dj85BUayMfgsqsPAay/tjqLaByKHi1GN+VRj7ly4vVatjZS587fpKJFCip6eeoxOX9WOzVKBt7VjqRYBFVD4ptzvmpakoWaiX9t+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQ7Bexda; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQ7Bexda"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581187c6so15773245ad.1
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202169; x=1755806969; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YO6ZjmNOtKlWEF8G8K+b4WUo0jZB94+FQ/E9TVkGFI8=;
        b=wQ7BexdaVbUEh5AVucF3ZPBYytP+WjnaeBasTpe4kJqwAhcR4uQne+8tN2GcbWR/lN
         usNBhXUuAf6xqd/gE8o/AlF5QnDBiWQ4hLYpOFGthWgczvZIkADdxMIOkzIap6qZkZ3J
         rHcaX591g38ohOHMUM+sEADVax4wGrkHEXtf5r26fZdTzTwrqLU0mVHIi8uBT1jx07Gw
         s3MDoi9XE+xzMgO2n1g2Z1uUqJbiiO9x8hno0htN09oUdo8U/c55ORm6jhlfjTjudxu3
         PnhlbwB9kbo9QDFRnzeiHWeuUsBrR9u77RanFz/sHyAg4QohWD7f4Pfvle/+N9Ihus0X
         6pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202169; x=1755806969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YO6ZjmNOtKlWEF8G8K+b4WUo0jZB94+FQ/E9TVkGFI8=;
        b=GOzwSaF9V3SL7x/uYFPHpjITEkTkodndhviV8w4iYpXF5fJSZgw1P6EH+y2eLGZPph
         T72U5T1lQm/bpnuorcCb5qw+iB+eM1EoJ5ArH9zSQDA3jwTaaYzb0HptbDrZut/pJDTi
         w5N8nCvXxCvjhepqAF1eo6pBf63DcPZdDTigulJhwP1Vio0eylmBKmZ4KaUdb74HKZwo
         RDraqscFfirpdA9qXqKUODzwyWYiqqBXvKGofqetdQpuGqaunGxyuVjvM6zGARMKrW7c
         U+tA78DrvGWJtjyi31Rrvd0rcQRkZUxcCmGxGFTl5sfWE5ttN5acI8O7Y//hFxN95mSs
         9AQg==
X-Forwarded-Encrypted: i=1; AJvYcCVrQLZpZ5X2zihs8RxyWixHQcKKA5zDpyxdxSXPbCCdtwzTb9RpCpmCQuiQO8Nq8k5/Q1JxFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8bGF4NZFNmbTIdoiKDDM4nzotigfuZrCMrEdukTIrBuVzQLIL
	SWFblipkMlLB32rY8l+3ygC7lh1/kUQgBcy2VHGa0hPXSRmksKXb9+IFC8MW/lrO+RbaO2FLG/V
	7otC2aA==
X-Google-Smtp-Source: AGHT+IGw0N92d+X4yz4oc9MBEew+9vy8e7l67AOxNN5kdBHZQOpNiXDNq1+p3W0QI0ndx+Xd9tnK9OUDOCE=
X-Received: from plbnb3.prod.google.com ([2002:a17:903:15c3:b0:234:c104:43f1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aac:b0:240:2efe:c384
 with SMTP id d9443c01a7336-244584eab3dmr62286625ad.19.1755202168661; Thu, 14
 Aug 2025 13:09:28 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:41 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-10-kuniyu@google.com>
Subject: [PATCH v4 net-next 09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
index ff008a345ce7..723cc61410ae 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1641,19 +1641,6 @@ static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
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
@@ -1680,11 +1667,6 @@ static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
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

