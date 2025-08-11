Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5A2BE637
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933494; cv=none; b=Jvh3lyiFLcFX+YlrK/njBLlHcJiJI9X7ghpFm9dN+UKzBheZ7aRfb8/w6BbxOtEtzLdrosaNytXctfeuZQMIEDlWUmW26L8JJVnm94Eq0geyEQlNBNOuXs9xxfZkrXKr1Frbym63fmlVPtC1Lmf1p9EbLM0/5+YHaygwK8g7EOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933494; c=relaxed/simple;
	bh=RraDdlXe6ciaP6cYzKFgCu43EUAwSOZf2SxKtlzfM/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cosozWqgZUfSIc1R6FCNqxTY/2jjUuxKmmuf1CIy86usd3DVLTgHkp3p/OqTXT3sk227vVQBZatgMrxnOZfVz+Ba3sF58gkXGGodoya9g0VSg2G7TtBHi/aQobQYbOvCTY2kaC/sm1pP+pMeuAaMfJab/OkFwCgNccOSOC7mwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMk5Gmfo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMk5Gmfo"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so4350461b3a.1
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933492; x=1755538292; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8XD71jgjXMWJD0GQyZXVIV2qpgVtIymKBEzG9L4F4=;
        b=EMk5GmfoCbwVyTiFVLYqGiDQMmGXtga+WaoXRWT20c/maSjlT9kdaGI0Kfcij2wL9k
         n92bqFm50a1dZzMy1Z7aMpp4ttiZLSA+IpwAExRZisV0ZXrcK+kVQY+/PVgSFWjJKlYT
         ceX2RLWq7GAGZE0kRqgRF83FxXifETGvK3LtfqBqhCbZd57O3hEvOZv5gYbv4E840c1J
         1DQU/hK7mvb5asIVzXvRU9UD8rd0PtEbBFJWdRSTSns+KSdQBzmR1jFjLghCd2/XHTia
         4IEAqCjUgdj1qJjc08tXK5tMPhP/m/KPr/WON5R4doayNOVjwOE35cSZ7k9hX5FDd6Og
         5j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933492; x=1755538292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8XD71jgjXMWJD0GQyZXVIV2qpgVtIymKBEzG9L4F4=;
        b=InGhZIpQ3owT9vVXqeOZgUEq2XTK1Jd6XvuysH9FW6qrYyh0Dxknsn7+WZ8JQlTXCZ
         UlXKJJO3YwzMaSO0lg8QkSj8sD9DO755zmsK4ocbWATT/DYqAiNdsoNOM9MNSchcKwJM
         lNwsAERiKfVYL+ai8o0c/ckDeBRKsGFmFMzom9vEvVL+qVjmKQ2LWgIDoIZ9h9MP+yvP
         Qk+wyAjTa3Hd+vSL8xP2eMyyY4JbX2VuyL/0UCZnccx6+Ty4DqLQHFUJ3XmBSTxExL3/
         iyAFafYlqPSt5JvB6NkVH3PP77dK5oa6cu4jmNa8sg/8pcVkVkrsX7oEc1vzIhY5s1hd
         6akg==
X-Forwarded-Encrypted: i=1; AJvYcCX3yRj07loAqjKwk54i9ygd7GasRcooe1u990RpX2YF/yy1Yc1Sa1LGFBFQ93ipU41o+A+q8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGEn/v6MLiovb6xbmXxFohQ17pNOL77inanFNZzKsDMUaBC+Nr
	nCpAMZrJ0+aPE7eSClUeQ6lY/jElSG7OeM2zlnLxYySSzMuA9TbGYtCTakEdTd5edbrPmV2AYv8
	1cvZUDQ==
X-Google-Smtp-Source: AGHT+IHo2yNLTeCJQnssS8cRVh9LBZumUnUBfB6vxpMn5hTdAQ6pUphTOW3txkt3Suq2A0M516UNLF041yo=
X-Received: from pftb15.prod.google.com ([2002:a05:6a00:2cf:b0:76b:ca57:9538])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1b:b0:748:ffaf:9b53
 with SMTP id d2e1a72fcca58-76c461af0ebmr17005996b3a.16.1754933492214; Mon, 11
 Aug 2025 10:31:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:29 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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
2.51.0.rc0.155.g4a0f42376b-goog

