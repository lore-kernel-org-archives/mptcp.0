Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389122580FB
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202167; cv=none; b=NDRSJ2KPdtWweZQJ0+RCu9ugWkt9GsDTuHaV+/DMRF/HRypG475tv8svXSfd2dByONqAstsnYnvU6UEIP4S8i35ZvhR+Mu4UnANnPhv8rpjTh9AtbYr0tEuBKomzSU9FP0iIgRw+Dg9lOW+tgZAJhyCyh++CRNmDBp2DlK5h89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202167; c=relaxed/simple;
	bh=9e+MQL+1kufw9HczfwR0qRzJsdj8exP9jCcEPhaMv6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R88xqF45Qbk69iJ+bgENgTvXBc6+oarpqIbrFltFJ7L/nE7xk1ctgV3StCu6/fBnQ9OPcMdl2qYYkXL+XD+4qLOlb5cTwVCGOijDdmI6XPMmvJDPw2+8HT6kM+Vt6mLWJmAYHi62uGrmyM6L1PsRnIobwio6i+fXvF2KKw7ySlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbipzOus; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbipzOus"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457efb475so15483875ad.0
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202165; x=1755806965; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN4H8OhMESZggI/pZXAKf5UmJPFi9rM002XSMoc6emQ=;
        b=jbipzOusliTJcHBaDJCTu7e/x3nPvnexSAM5wniJbB2V53t6hSf/wESufeiGpMsBW8
         j4i3lLmlNJkutPOS0qwy5llaPkswcSH/2MP7XCDS8918b24vZ881k032lYCLmnwb+O7D
         SL8yppUDH7U1mC/z/5pTxkUClPcRbcgLXnr5O8SlPVChMyd4borwSQUU3ENB6d/zOSyT
         XDLUWQaIAlID6Yg2DlA2VKkSBQntMBWlQ78GGpsh8YhZwDdbCliA2HpkJ+kWQc9YfKYR
         IFd/MG8lEbb7+pb00lU/OX6mYbYUVWW69OzNi/WNQQTHqwVXXdOJQ7TVVD5s7N2IJEFV
         JV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202165; x=1755806965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN4H8OhMESZggI/pZXAKf5UmJPFi9rM002XSMoc6emQ=;
        b=Cf04QitgIByPiBqJR+gPij8yz1fEa8GPK1yFqAwpchgtFbWjUr+bBtaXTYBg3EmYeP
         ln3P73dfKmVGPX+Hf+a8Pts4Cc2yKCo3zVq09FfnSbicO9mv7ODRPoHsq/0uQ5unY2sv
         xHHJdiG1tLZ4Kjt5k0dglM9UlweBYi2mEU8+eU1s4izdX3+tLGILXCZrbj762N5SdoYg
         oeRefRVpE78womHYNnhbgdavREP8C2xugWskWtX8aASSTMeibRgAnSsr2uFKP5mO5ecl
         EHeu1qba8cmPnW+0+tC4pYtv6wN4amhOOtWpSBVTn5sUKNMSFQqUwH/b00vX3W9CmgkY
         nF2w==
X-Forwarded-Encrypted: i=1; AJvYcCVSVcOZufCUAy/aYGUza2i7HzRWPZ9qopRFEpLLHODDAJoHp28EF625/tx5W9IaGmQq/7R0Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0IvRTWXhu5jP9CNDL1wLt31xeVGwTqJNUDKDFlMvU0nIKHOTM
	kn0ZkuoCIfzTNkzP3Yw4DKqeezQ8VvG562bkEdIGbsN1KCowyoe6TTdzxBMoIE4morM+B1qlshG
	3u8noVA==
X-Google-Smtp-Source: AGHT+IGjybKWRKb8eGBGrIqhLAFzL1Ig08nwLcmkE6zoBHcD3GY1TtW/rYf6Ml05cqJS44L2U3FStQ7jMm0=
X-Received: from pjbnc16.prod.google.com ([2002:a17:90b:37d0:b0:312:dbc:f731])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32d2:b0:234:8ef1:aa7b
 with SMTP id d9443c01a7336-24458a4c885mr60555155ad.20.1755202165500; Thu, 14
 Aug 2025 13:09:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:39 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-8-kuniyu@google.com>
Subject: [PATCH v4 net-next 07/10] net-memcg: Introduce mem_cgroup_sk_enabled().
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/net/proto_memory.h |  2 +-
 include/net/sock.h         | 10 ++++++++++
 include/net/tcp.h          |  2 +-
 net/core/sock.c            |  6 +++---
 net/ipv4/tcp_output.c      |  2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

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
-- 
2.51.0.rc1.163.g2494970778-goog

