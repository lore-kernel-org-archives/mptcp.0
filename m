Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924712DE1F0
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933507; cv=none; b=mqwv8DnGbj+iguTRMwITAPlsAz+LUe2uOcbrZ6tEK3f2T1x5WrYqUQqB2ms0T+nLsxcNA1M08NGj4BztMfdPF/GlgGKJYxPvLEuGe6Mqw7VXKfQDHoPHFYjEZ4p0uINvurNzGGVI0fMWxikHcT0ySjxvfsspRbviN9tyXCbf/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933507; c=relaxed/simple;
	bh=ZAz1mVorVRFB618WT7mmuym45O0GXG2XAc0+SY/lJcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tgz5ne4lQjpcANVFWCZmzoVUmynSoDa3EWM4/G2lVZ5yOZV+PM2NTOAo6FtCoWkIlFNqKy72Q48gp8qFsS+YDYeSqRFqZriTWLIL2fpzqPE6GNNLmSP3Bt+H+qXbsUZ0L5256T471T9BKxiqaCWe57Wlhpe5zK8eKUQ5b/nKgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3BMyvIjX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3BMyvIjX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403e4c82dbso36335605ad.0
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933505; x=1755538305; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5aWSC3VweCjbJoCLklfizXMRwOKGjiP4PRbbUtyan4=;
        b=3BMyvIjXrzY4TpLL98sKQiBU4jX5LMoD3Xc6th1mnSVHeWtMXAPG0aTX9OERixZWmO
         tOWo7t5WV6gmLUWbXe73Odc1xJjKvemy9tzK9wkSbpyPkjQb9MM7rKSqtx/p2o92ebw7
         H6DpcZFQn+X1IaHvuqRbXR1ydjrGPZDL6yleABn+YaCTD1USL8CNxZjFDW3d7xjhdvm3
         88KPasIDo9cGX8SDPvGT8PrJCSf07AgUCdum7CLRb30hTsTS+d/YQ5kSCRRM0hBuNMdH
         yBqtVgmx75vYTjRdprTvGeByhUk3q5CTWXJIgmm50prEpQ2XZrZE8Ttok3KcGqfl8kjX
         +wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933505; x=1755538305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5aWSC3VweCjbJoCLklfizXMRwOKGjiP4PRbbUtyan4=;
        b=vZF33o7+swEi6229IBdOVyedaGOtsAYFZazr+ksMguBLRyhiDDrnBJwlSukg3QKxnk
         K/uz7UP/7LX0KjV0CPpykk711LEnbkN0yM+CEUJ4Ogy98GvbdNwiQx2F22C8gO4E6SGJ
         flMJo3NrNGkV9nlMqRzPOQ5q5Hy2u4xBENvtbKeNEeutpnis4XRk65ZbZ2gH8sH4NVwd
         aMWZ2rQPHnIfpUWk1DHYMR1fsvTVZW5bE6sUdBq8MKuYavKGlm3x8IkC+raD6zsTwwr0
         Bpww/y9k7MXtjON6pmVdbzkhfOKvtTlUkMT4TAW6SGsFRvlPgB5MBe4us3rhXkMe6v6X
         8Xrg==
X-Forwarded-Encrypted: i=1; AJvYcCUQaU9uR63W4RzKgZQ8wzQRT5ggoxF2NvMh0NaX5hKHuFSWyTzYYa85iv9MURpUtShj7hifLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRZK3lHBY7S6DxO4/zkbi41lyM+kfew1c4HsBTFwiu6Edij5Yt
	nhQ5qRvpXVJOngFDGLdm9WWvlutWh6TbtohRdjXWlz5DiggvGrBderN120p3rnXY81gq1s35u1C
	TU78Ykw==
X-Google-Smtp-Source: AGHT+IEtI0hZmQkLl6do9xR5bq6fk+hkwUvmFCZYReLtL0+PGPBf8SbdQd0pvNwlObuC5a18Dro3jK8mXEE=
X-Received: from plbmi15.prod.google.com ([2002:a17:902:fccf:b0:23f:cd4f:c45d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc2:b0:234:f4da:7eeb
 with SMTP id d9443c01a7336-242c1ffb1f7mr164182355ad.7.1754933504815; Mon, 11
 Aug 2025 10:31:44 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:37 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-10-kuniyu@google.com>
Subject: [PATCH v2 net-next 09/12] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
2.51.0.rc0.155.g4a0f42376b-goog

