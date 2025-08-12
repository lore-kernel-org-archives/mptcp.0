Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34E2FE599
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021539; cv=none; b=s1jAxu9USjyUkyuCgo/9JJUk2FSEV0ZZQcLCzcZkEEySAVCC/WCZVtbCAGFJ9lUp8H/ZuQ5/aLikzWxDYJJjmeI78DbDDdE3AuOtycrJO2225e5sgieOHkLrGPrS8B2aOUiB0yX45CkFxYKJtRWp3D+IRinmeFpQMFHvM5qlsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021539; c=relaxed/simple;
	bh=q6y1Mod3BWMdsGSHg0SEmtds3ikTNBJyifvdqgX0uCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RkR8cDjkt80e/tGwp73c5M1jB1BY4iTRA4NKzV1bJsS2EajmEe04XK+IGV4NHZA4QGMRZjC/FoXoc3OAVrCRn3P99PTHw85Wz4Bxaxu6tEi8tegd2dARhQKQuqK6y8+mAXJxRnhakfYnZevK7m7n/eTAE+6pHsrjDsr/UHF+Jj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOoM7l99; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOoM7l99"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so9593484a91.2
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021536; x=1755626336; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5967b+D6n+JBP35k0TPK9w7l1JYggqKd+S8TzhqKYXE=;
        b=aOoM7l99ufXs13RhzBnMZkXpUtCkGS9/m7K3Pv7ntzEwIRaKFlNCuSECDGRo1ZQTgh
         6VWAaU5OoX2QcdpKkbuw/g2OGBSqdns9dyU1wUOUaQJITrhupL0NebMmFb8ECLaOFhbm
         pAoAup9DN7Sh1k8vkNjHy40j/8a4JBjkQckrdoHe1C+EnJf1mCa79vveV5/F+SvEfGPe
         pV0Vnpv3gL5WiB1QEpZmzx55+g/xkA2GJ6HXiMeWmODu9EQARinW3z36kj9IP9W3NtNy
         AoXmTGsBoCLJs75P/M3KBs/yzfFDnt+Ln8bvYelPTG3twvQD5uVfOjsuFSdrhtR1RBb8
         +DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021536; x=1755626336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5967b+D6n+JBP35k0TPK9w7l1JYggqKd+S8TzhqKYXE=;
        b=FxoHpf8xk95iDk9MGCFhEW4wVELSC3qL2BSoF4zfyiWR43SwffmKRP194qW7wDmbHQ
         x1gbVMxyg33h2nWMyxETDTGZ9FgYPppI5bmakEhzBkWcEnCVCNlc+cOkN+JAmbzo05kd
         M+h7liBWxuM4yZZ55it2RwEleJUTpuWWsYrCeGSIFRGq6PPTzks1UK2lZgAIMh6GxILX
         ea3tRoygdVRI6GKLG0abPq7DChtFSpj8J/4zDTckQr8XLc4tG/ke/ZBLjQc4t6MPMwQ7
         xEgidANDrZaETATkcuso0i5axg2AU94nUzqPSGhh1I6Afd++/+gAiGtA60QZu00G37Wx
         qTEw==
X-Forwarded-Encrypted: i=1; AJvYcCXvvBQGlwrtJLXI/8VtPMz6YvUiRtJWndk6W6XNAvEtybMatXPKh63ZssfJebDEzftc6ssypw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn4MCAeEnDvaVKQb+22dpuy/EnDzGa1+lb2cY7Vn4MReacSodk
	eAIlf04yIjPU4qQLaNYPhRQtMxZt2vNDn/mUXnFtcEX2PICfPOuHSRArhQRRva90hs9YELCE7Qk
	LqI0xlw==
X-Google-Smtp-Source: AGHT+IEHywGL60FQFSS0J0vulVLgaUAf9Fyk68Q4f3QM+UdkI4p7EfgIk7dpwlIPEPt8UyX87u+Sce3emJ0=
X-Received: from pjbqb13.prod.google.com ([2002:a17:90b:280d:b0:31c:160d:e3be])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:de85:b0:31e:94d2:c36f
 with SMTP id 98e67ed59e1d1-321cf94cc50mr651519a91.8.1755021536592; Tue, 12
 Aug 2025 10:58:56 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:19 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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

When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
sk->sk_memcg based on the current task.

MPTCP subflow socket creation is triggered from userspace or
an in-kernel worker.

In the latter case, sk->sk_memcg is not what we want.  So, we fix
it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().

Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
under #ifdef CONFIG_SOCK_CGROUP_DATA.

The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
correctly.

Let's move the code out of the wrong ifdef guard.

Note that sk->sk_memcg is freed in sk_prot_free() and the parent
sk holds the refcnt of memcg->css here, so we don't need to use
css_tryget().

Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 10 ++++++++++
 net/mptcp/subflow.c        | 11 +++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..25921fbec685 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1604,6 +1604,7 @@ extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk);
 
 #if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
@@ -1661,6 +1662,11 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
 static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+static inline void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..08c6e06750ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5024,6 +5024,16 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+	if (sk->sk_memcg == newsk->sk_memcg)
+		return;
+
+	mem_cgroup_sk_free(newsk);
+	css_get(&sk->sk_memcg->css);
+	newsk->sk_memcg = sk->sk_memcg;
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe88..6fb635a95baf 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1717,19 +1717,14 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	/* only the additional subflows created by kworkers have to be modified */
 	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
 	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-#ifdef CONFIG_MEMCG
-		struct mem_cgroup *memcg = parent->sk_memcg;
-
-		mem_cgroup_sk_free(child);
-		if (memcg && css_tryget(&memcg->css))
-			child->sk_memcg = memcg;
-#endif /* CONFIG_MEMCG */
-
 		cgroup_sk_free(child_skcd);
 		*child_skcd = *parent_skcd;
 		cgroup_sk_clone(child_skcd);
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
+
+	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+		mem_cgroup_sk_inherit(parent, child);
 }
 
 static void mptcp_subflow_ops_override(struct sock *ssk)
-- 
2.51.0.rc0.205.g4a044479a3-goog

