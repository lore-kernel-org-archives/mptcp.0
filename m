Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D6823D287
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130206; cv=none; b=L/3rOPfjZ7A0SkQSD7Vx78dqRdQmeVRl2HJI/+i1HKx1xrOlSSxMtSMjYN0IT8ZfQEBXJHexVKcE/IPe4FDX8lF593D1yoMTmVlN+XU7LtfKgeXr+AD6frNyOpRb2adxwRPkuTXp7nSq/N4Hbdcxcl4Z58aIlvxPm1dBb05N9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130206; c=relaxed/simple;
	bh=zcJtco0ccgJTHzB1ejYPUAyCNXBYGZIb0tH+3/ptyMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pR+WW+YWyV+JkOMiFhzx0ZYgvfCJDM53/UaBYwbGcw7XOL1dk4TgJFGmJgu9KBFsUoUpsMvdrC/P3CSsAsMH9n0g69AZ5N+CW1YaDBWKDV9VSVDl0S7gl2bd++nrfE2mVd5cICNvWPpARLpmCbtfkN+UEb4sbpz1OnbK2akyiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9rPAZCh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9rPAZCh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756bb07b029so4242633b3a.1
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130205; x=1753735005; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdQJmy4blGtPG7gm97FaKmrzo1iYWfvkpp5t2qCAUbc=;
        b=f9rPAZCh1hMuxNELo2t7a/vPBsIgcfoRuqgRG2hXOtpCW3OpeQXVY40Wf1CQH+G38G
         BMslwWjDzW48t5XqIjI1IkcJZ2/ueE9yihvV8cA3VkRwUPHVQfk5Uwca0YFFKFLOF5R7
         88yR2VtNuJtCKLGzokUIeD/d70A64NHCmEYj+ndVScOSLPXGtqolO1lvUVLkxdrWhYYa
         F95Wss6Y6DHekYNDBemohEq2pIQ2S69rKpaw1mMBdmsc88FjKNhkE1E+1Mk/sXbZnb4v
         tnI5wybm7KcNkqL3uOaDyZNwX53M2cxprVfOZOGwGDcHanpmbQ6EMVZchwLXvx20L3XH
         lKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130205; x=1753735005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdQJmy4blGtPG7gm97FaKmrzo1iYWfvkpp5t2qCAUbc=;
        b=aQzg3YsiDZpAHWsUPPjvi9jsznl19A2AO9WXpg4UfRRqEyrdLv2ndYZO9ipluoJdf/
         paNq8UsMhhqaODCnuBxUipWfsbemFNQE8BVvzgHMndA5PJbZwl3kvZIxIgnXNeogNQWd
         qM+kv1tGif5TBFM4+or7AtZ1ri2KQJMp8gz9TkBhaEG3HjENd1I3P5fmBu9xy9755wSD
         5SiKbJUkJAYhFbgxu8kHpAVYC9PaqzMtIDaKGSvfLgw9TFhIrsdtrWSwgBhwOXt5lBjG
         HM3wKwcUeHwJqZgOBE89/omIbmSKe7JxyQQNAUQrr3STjvVEKSrLuYG/1kbxNwveAnX7
         LFxg==
X-Forwarded-Encrypted: i=1; AJvYcCXxWSIvmgMXab8eGhc78W+yZWu6Cry0nRE+fFxaJtjQWusvGWWthOpxHcDtXJAAYrwMCDhmIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfhbRyk+ObqTUFL/wCbCuBwSrJtWC36ry9zoZfz3cEO6lcjsEh
	AdOi/7MyAn0clUQHQ7fyj5Uj3ffM6Nfkvt9IK81vVBHuD5c5WHm9A12HTxOF0XU1TbuQKvzc2kV
	J5pJoQA==
X-Google-Smtp-Source: AGHT+IH3cVl1mpYtpoQ+O+03muSwme2Q/Ci4haqA3DdzxtA/Bzy9F6BXAV1IYuYuGpbybBp0dJL0GcI6AFY=
X-Received: from pfoo21.prod.google.com ([2002:a05:6a00:1a15:b0:747:a97f:513f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c88:b0:742:a77b:8c4
 with SMTP id d2e1a72fcca58-7572267b30cmr34198928b3a.3.1753130204945; Mon, 21
 Jul 2025 13:36:44 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:31 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/13] net-memcg: Store memcg->socket_isolated in sk->sk_memcg.
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

memcg->socket_isolated can change at any time, so we must
snapshot the value for each socket to ensure consistency.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line
as sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and
add a helper to check the bit.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 20 +++++++++++++++++++-
 mm/memcontrol.c    | 13 +++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 5e8c73731531c..2e9d76fc2bf38 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2599,10 +2599,16 @@ static inline gfp_t gfp_memcg_charge(void)
 #ifdef CONFIG_MEMCG
 
 #define MEMCG_SOCK_ISOLATED	1UL
+#define MEMCG_SOCK_FLAG_MASK	MEMCG_SOCK_ISOLATED
+#define MEMCG_SOCK_PTR_MASK	~(MEMCG_SOCK_FLAG_MASK)
 
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
-	return sk->sk_memcg;
+	unsigned long val = (unsigned long)sk->sk_memcg;
+
+	val &= MEMCG_SOCK_PTR_MASK;
+
+	return (struct mem_cgroup *)val;
 }
 
 static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
@@ -2610,6 +2616,13 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return mem_cgroup_sockets_enabled && mem_cgroup_from_sk(sk);
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	struct mem_cgroup *memcg = sk->sk_memcg;
+
+	return (unsigned long)memcg & MEMCG_SOCK_ISOLATED;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
@@ -2636,6 +2649,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
 	return false;
 }
 
+static inline bool mem_cgroup_sk_isolated(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0a55c12a6679b..85decc4319f96 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5098,6 +5098,15 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
+static void mem_cgroup_sk_set(struct sock *sk, const struct mem_cgroup *memcg)
+{
+	unsigned long val = (unsigned long)memcg;
+
+	val |= READ_ONCE(memcg->socket_isolated);
+
+	sk->sk_memcg = (struct mem_cgroup *)val;
+}
+
 void mem_cgroup_sk_alloc(struct sock *sk)
 {
 	struct mem_cgroup *memcg;
@@ -5116,7 +5125,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
 		goto out;
 	if (css_tryget(&memcg->css))
-		sk->sk_memcg = memcg;
+		mem_cgroup_sk_set(sk, memcg);
 out:
 	rcu_read_unlock();
 }
@@ -5138,7 +5147,7 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 
 	mem_cgroup_sk_free(newsk);
 	css_get(&memcg->css);
-	newsk->sk_memcg = memcg;
+	mem_cgroup_sk_set(newsk, memcg);
 }
 
 /**
-- 
2.50.0.727.gbf7dc18ff4-goog

