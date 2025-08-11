Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B22D6E77
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933503; cv=none; b=YbAJKJ/+RyMjs/HO3yZxQwI3CL9KnJ4ptizOiLs0HTrPHTzR8oNGQLbDtZ8+W9KHLZM+by/o4rzKTK2K7/13azo3bpAcdU2sfJrTwVT5+LsB2P5KzUHWMS8eyagVHWuGaS4qtuv1yGuwQe/2hSvak6d6sURoZcYjmxJkjtqw1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933503; c=relaxed/simple;
	bh=scmT+L01eD7wAA+tQ1VYtZfqLo/bIBN/pToeFw110+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDCa6Pf26G3V6ZjSrhJSbo96Nx+oAhV4z9YrdTWP+FI5xotvDrqyhlKs4XqUoHfv/ZaPnsvXz6gA2GVazIuPnYaNaXUCrR3r1X+9hi/bXLGeV2Xk21svJ2FH+hRWXLGR1JdbtudiaWXzO3jC5KpfmqDTfhf/0RDVVgIOHHuzHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3aleMfF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3aleMfF"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fe984fe57so72236465ad.0
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933502; x=1755538302; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1GHMwnAvIaqWLJyXzy2eGeZ3loP62R3df/KRW2nnvI=;
        b=a3aleMfFuIhI23+JBwvPDVJmzKr2FFkHDTPFn1eUD0ezB0MNhJIPUba/rRn5tm2Jk2
         HY+BUDG5ur7XfbIku12DIL8CQu1cdKG0KY9EH4NHfpJb+Oz3fyUcxj7zH1drYv4AW1+4
         C51gV/SmRDkMAldKQ3XV68AsJ8y1BPW5PHHVkTS4MzabDyGW1iX37v8q802wRtUmpKZI
         3TW+qHfXhpJN7OT3FOx40ibCvcuPL47opPqtZ3+lcfaMnd2swor3RS55SmV7sjgpA1Tr
         KWm2PSqQW/k1rqyCINg/Vk9osZZzfjnPcsYQE7FCh8FKkhC4SMIQ4Hp/bTC9yU1kft8z
         Uz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933502; x=1755538302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1GHMwnAvIaqWLJyXzy2eGeZ3loP62R3df/KRW2nnvI=;
        b=LsISOncD98WzEpmYx+UQT44iuvH8jyMGuRa970t0OrI6vsgodv+upXRKhMzefWiMep
         fSuY5icA81fmgMRHzcxH6NszdbXBydNMTw06qYqBgGuFK3YaEkUlJ3QeyemM/p+f1ejo
         7q/xJjhnXf56Eo1/P8p8+Pzey1UEWGeandj4V7U+sSvTOvmie7HbXvQN4Bdq6YcT/ejV
         Fvy/4/IbLg+UssfdByIorB3rPkye6XnwmYH/yyHIlv7gSwGKFNTvrTAJO0JM2WJ0UYZZ
         PB/73lRgDBNv+xMHmxCQcpAEmqj7gVYzkdwG9nEgSt8RQE8fZk5qbTozLrar1a4/RHlW
         KCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJON6tbzV4jEv4iiFr53W/GYKwt9j+bUDrlXoaobkVXtyZbwYHs9ZgVTyfKeHzRnrHv7+UJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcdhiq4SYOpP9UTsBwfpbvKKPj6hQTEXtFKSNqSF0doRz44RsH
	j5cFpW9n02+poOCujMAKmBd7CtbjW0+6tjFsgrTatYS0VXRphZ4MHZjc5QEOG7tAgWVPeuJFHTI
	SQNBpFg==
X-Google-Smtp-Source: AGHT+IFMNgVf+Ayq9j3qMwMUXApKfzqqa1VJ0zOmoONCV2R4q5dCIl1lgeXBjm87U9qu7vPQAjok3apSCjM=
X-Received: from pjxx5.prod.google.com ([2002:a17:90b:58c5:b0:31f:b2f:aeed])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea08:b0:240:4faa:75cd
 with SMTP id d9443c01a7336-242c225554emr205010325ad.48.1754933501503; Mon, 11
 Aug 2025 10:31:41 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:35 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-8-kuniyu@google.com>
Subject: [PATCH v2 net-next 07/12] net-memcg: Introduce mem_cgroup_sk_enabled().
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

The socket memcg feature is enabled by a static key and
only works for non-root cgroup.

We check both conditions in many places.

Let's factorise it as a helper function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 net/mptcp/subflow.c        |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index a6ab2f4f5e28..859e63de81c4 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -31,7 +31,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	if (!sk->sk_prot->memory_pressure)
 		return false;
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	if (mem_cgroup_sk_enabled(sk) &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 811f95ea8d00..3efdf680401d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2599,11 +2599,21 @@ static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return sk->sk_memcg;
 }
+
+static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
+{
+	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
+}
 #else
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return NULL;
 }
+
+static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
+{
+	return false;
+}
 #endif
 
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 526a26e7a150..9f01b6be6444 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -275,7 +275,7 @@ extern unsigned long tcp_memory_pressure;
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	if (mem_cgroup_sk_enabled(sk) &&
 	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 000940ecf360..ab658fe23e1e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1032,7 +1032,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 	bool charged;
 	int pages;
 
-	if (!mem_cgroup_sockets_enabled || !sk->sk_memcg || !sk_has_account(sk))
+	if (!mem_cgroup_sk_enabled(sk) || !sk_has_account(sk))
 		return -EOPNOTSUPP;
 
 	if (!bytes)
@@ -3271,7 +3271,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+	if (mem_cgroup_sk_enabled(sk)) {
 		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
@@ -3398,7 +3398,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 {
 	sk_memory_allocated_sub(sk, amount);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
 	if (sk_under_global_memory_pressure(sk) &&
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index caf11920a878..37fb320e6f70 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3578,7 +3578,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6fb635a95baf..4874147e0b17 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1723,7 +1723,7 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
 
-	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+	if (mem_cgroup_sk_enabled(parent))
 		mem_cgroup_sk_inherit(parent, child);
 }
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog

