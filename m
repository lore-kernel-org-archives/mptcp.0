Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146F24292E
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130202; cv=none; b=J+rRJyh4edhxIalW337kYKa+C+7jiSMeebdhOoldVEs5TkDJlFX5R0ut5giAXzxL1nMkGUCe/11cMpsuGRB0t7CXiLsbCSt4JKhyo7iWI0ujFTL280QDYdjq6s0gRUOgm9FbHcOh7L//hgHfCk8N2QzNAsmHPWLQfZ9IrV4ZfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130202; c=relaxed/simple;
	bh=vZGJ9wL2tKP1C/bt03aiYtXRl3GT/mAQoyMnOiZ1Zas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dsi7S9SUcuFuJt1CJJQ5L+ACG3m1uS9O4Ugc5qJ7oVoryaWruNnDaxUv/B47vuGUkw5PXeb9uxruiyvin79W8Qm8JRUG52zrCj+AeoISdsit++GbVXbOvzH76hQukYjm2P/NeumEjKEWGKPf6u4uPJvkPAkV25YJ5wCK4FW1fBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x4XZG5o4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x4XZG5o4"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so4826825a91.3
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130201; x=1753735001; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8n9gDKu0Z+DKg5LJ3hwVCmIJaGqgWwDHBafRHDkb0E=;
        b=x4XZG5o4RF1Z0bBe3xl3OMfFQLTqiTF3tkGgBsWhS7kwNQX+QUxuu1TFpGhfPvt6tO
         M42LTcKm8FNrft99JpCmv6PoWCU1DNnYknq3NAuchLcXlyRYy7YlhhzK4XbSCA1MuEL/
         r7fMDfRQsG6p1LJBMUpBdaG78nKiEuKZ97pstuPu8+m5A0j9nqc+r+i31oPhYd70I1qB
         Ae3N+xYL+0BcYxBZMatCRCsCxdd//5Rxxmwxm94PXFcwvEqEv6Lw1gITEJtzY6dgoUj1
         DrNz3eCH1CmVNGUbwAY7Lp91EhJ9QPC2OOdThMDrdEXHoESnbXgn3IXMn8ncv3H1Che2
         gMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130201; x=1753735001;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8n9gDKu0Z+DKg5LJ3hwVCmIJaGqgWwDHBafRHDkb0E=;
        b=aVTYHHa8csKu8drugBfVtICRsM6toPRsHzbX2MupLL+8CEMqwfy9H7zcaFiEHNcBj2
         aybffNClWNempiNE+Ui+TRalPo1BVm1MTLlnsZ89pq0huShkJGJikH2ibyl0T9hdsq1P
         zpv8ay07tfMhSOcgdfDGlL++vAXhlqIYlf/twCRC9/xUYWL3+a+42oIaOR91DgJ2ei+D
         jONpb5nWSDE86hhJtbfb4IyB/0s4i5V02MvqNIRuxGw5mZUVTMMdU+3j7GzAicmvWjud
         aidF+yp5Rzr3rmaBa15jyIJU70HNEiJbOvy7RYBNa7r4P5Q4dDIMuzR8f2NZx8AZrsaS
         5ckA==
X-Forwarded-Encrypted: i=1; AJvYcCVzCSoiUu6cGUTvw6L0S8MK6FKNmbZpMhEyAvmVkaXbdES3twAPvnWfqtz1H9Ih2yric+0JpA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5IDgGyMELtGc4qZeu1ziZAm8aXSXVcuwEoUTz0LQ5HGk31zVo
	KXm7TP5vSlLM0d2nnWuS8O8Ie2xbvt+hQM1At5AJUxv0ErwPtW04j/9ppcE4bhrVs/YoDsqr5QA
	Zr3PpsQ==
X-Google-Smtp-Source: AGHT+IFqBDBMTU4J8DYFBRw9/E8jIm7feevzb9voFXceLD2erJ4yjibft5LsmkvUX4Te4RL5m3uzw1eIikw=
X-Received: from pjb8.prod.google.com ([2002:a17:90b:2f08:b0:311:a879:981f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544f:b0:312:26d9:d5b2
 with SMTP id 98e67ed59e1d1-31c9f2b5292mr34202138a91.0.1753130200564; Mon, 21
 Jul 2025 13:36:40 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:28 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/13] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

We will store a flag in the lowest bit of sk->sk_memcg.

Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().

Let's pass struct sock to it and rename the function to match other
functions starting with mem_cgroup_sk_.

Note that the helper is moved to sock.h to use mem_cgroup_from_sk().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/memcontrol.h | 18 ------------------
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 21 +++++++++++++++++++++
 include/net/tcp.h          |  2 +-
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ccbcddbe3b8e..211712ec57d1a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1605,19 +1605,6 @@ bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
 			  gfp_t gfp_mask);
 void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages);
 
-static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
-{
-#ifdef CONFIG_MEMCG_V1
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		return !!memcg->tcpmem_pressure;
-#endif /* CONFIG_MEMCG_V1 */
-	do {
-		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
-			return true;
-	} while ((memcg = parent_mem_cgroup(memcg)));
-	return false;
-}
-
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
@@ -1649,11 +1636,6 @@ static inline void mem_cgroup_sk_uncharge(const struct sock *sk,
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
index 859e63de81c49..8e91a8fa31b52 100644
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
index 3efdf680401dd..efb2f659236d4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2604,6 +2604,22 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
+	do {
+		if (time_before(jiffies, READ_ONCE(memcg->socket_pressure)))
+			return true;
+	} while ((memcg = parent_mem_cgroup(memcg)));
+
+	return false;
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
@@ -2614,6 +2630,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
index f9a0eb242e65c..9ffe971a1856b 100644
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
2.50.0.727.gbf7dc18ff4-goog

