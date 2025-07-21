Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866D241695
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130200; cv=none; b=mgTorPRaAN6la5MKaIa4PvI8K+G/SdB2Ro3ijWtx/dhVnC+38B4AOuT8h/7vFv/6bKRGoSXQEQuM2qRy2JGUDpmxPWVU99b/YfeLXaeYM3z5JlPT4j+d/l1MY+kvSnacdFMubF/Mkf//e6sM26YJ3gHWhcza88WTzUH03HC2qSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130200; c=relaxed/simple;
	bh=Np33N9r0abllKVI2quaOtsW8GKG8UR/+pGRXFZjdmVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFX+xjKKUitlsCgDE/JyVxrM+43WfL+k0ArJW58rGEXhEVnYzhKkXQ6k5FQ31+TQoQwh8mzw5XIBegI+xIjjO/TLXdWx9pnT0zvaIZvlT8lAU/0lnSREMV46lmaDfU18A7kXPhaPJm7I2lPob4GAq+/BTpy7/faT78l3x25chFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9zXSvtC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9zXSvtC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso4608966a91.1
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130198; x=1753734998; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzkCcE7y2iiEKWHZNkTKmLOP5up72GHF++8nWGJ0fgE=;
        b=m9zXSvtCuCoWmlCU6UMFlXa4bq1emtZhcIuyR2eBfLEiRrlvmvKWW6r2N+HvAQju7a
         7etM9RrFobifKkq68gEFW9Ji/kCk1kWqGkn4S9s5brMJWv6MIHYH7+lo2+D5lEw/0ndU
         kVVjyO04RD7TgDIwY+SE/9PZa4wBqaZjXDKs0z/eZxLofK86FE+T5HubzbHZbWTL0XTp
         jRWXMGgGZoIwnQXzUmRhdI90gN8A6JJnCkwxmW1EIuXfi1ywGwau6EXK14hOe+VSe+Hi
         24b0LQYvkBRqu4rRKbxJkgJncviiPF4c0+ckKsr3FHTihLKXBSJcURbFHnAEhtIc9SrM
         JNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130198; x=1753734998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzkCcE7y2iiEKWHZNkTKmLOP5up72GHF++8nWGJ0fgE=;
        b=FM/qRgzN6IAwDFvVtErGd1Lk/hoMBht1ZiueAIHHPC0nLIu5DpD3iocSVWFkMrGrPE
         ZOh6DbrH+5bCS3ehRjHlLK0EusCbV8gVsGQd6+FGcBB2/PsQHTGc81xRb6/fBpNFp65D
         dXaqReSY4FLcLCPv+YTQ1SFZMRpTU0KuzYT/awbQEfKq7SgJSeFDnh9FtkCgyXqgPNfq
         zpSD2+iEYuSj660NhEKl5xaEON8Ko9FoSFQqsSxY/j1965a/vnBfYaqkXRi2KM3zUskj
         6ySqe8OiQ+r/6n58xO++AQEO20ZDDq5XhHBkHmOwDrYPEDUygW8+zTwaQrjd3YxYZVA9
         Y7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuwzcVqwzGCCV7BCmjIqbr8hRJynxP2B0bHk9/BFVfdRhvXOuqdz+WrknbFspSfnXlFnkLCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTLauFOzk1U06i1U3JoCFrcdaGeuiuGu6b+E8TvnECmVrMlI73
	CPgaQI7oER/dZJzi+PdPqaxFMhlY3oOAlop4GWSps7ypQ7tU5VcIj/0jBIgatiknOb1Jq89N+vA
	1N98Nhg==
X-Google-Smtp-Source: AGHT+IE6OSr24etnKRAVeW0ucA3S4ktB5FCi5MdQH2kT6HggNuPbZhFVkCzC2ipGvzXe9c/IyTBVfm1pHvo=
X-Received: from pjbhk17.prod.google.com ([2002:a17:90b:2251:b0:31e:3c57:ffc8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e8c:b0:310:c8ec:4192
 with SMTP id 98e67ed59e1d1-31e3e1cf38fmr1125302a91.10.1753130197825; Mon, 21
 Jul 2025 13:36:37 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:26 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/13] net-memcg: Introduce mem_cgroup_sk_enabled().
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

The socket memcg feature is enabled by a static key and
only works for non-root cgroup.

We check both conditions in many places.

Let's factorise it as a helper function.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 net/mptcp/subflow.c        |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index a6ab2f4f5e28a..859e63de81c49 100644
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
index 811f95ea8d00c..3efdf680401dd 100644
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
index b3815d1043400..f9a0eb242e65c 100644
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
index 000940ecf360e..ab658fe23e1e6 100644
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
index b616776e3354c..4e0af5c824c1a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3566,7 +3566,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	sk_memory_allocated_add(sk, amt);
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
+	if (mem_cgroup_sk_enabled(sk))
 		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f21d90fb1a19d..5325642bcbbce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1722,7 +1722,7 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
 
-	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+	if (mem_cgroup_sk_enabled(parent))
 		mem_cgroup_sk_inherit(parent, child);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog

