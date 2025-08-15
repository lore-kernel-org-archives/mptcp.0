Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6A29C35F
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289057; cv=none; b=omJEHRHJKUziIybM6FcraIFLJcqNiMWGJIrGAvZbDqXsAtuOLGjo5ZauDOWpnGzu+Yd/wooxo0cMI6uCj5mjgCGD0WF8FuczfkaUXEhETYrG9In4JyAlMWY2kxIJVppRwXQPrF7AZTLtm3ADN6YwXt2UCC99DIRnTec0jG+MATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289057; c=relaxed/simple;
	bh=twkMnoDWF2WEDu7aGDJTpR79gYT+9DDfGd76WM0w1Qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZSQ554lUZxddavnm88dVb9Tit4OLKXZOGWhpg4g6TW+alhIjohBwLIU5coU3hu84tcT10+EiDEH8CbaK/5ibyxbFHw3ug4+lp00JNA8aWf2Qa0YY++wO8kAulaV+5uPFXzjuM3SNN3NW58xhREPgAJRoGCZ+ovWGhTbIAlTd6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w6eNopz2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w6eNopz2"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e6c74eso2418080a91.3
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289055; x=1755893855; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QmaKJoKwHw82XyXX/d5iEOMfvSvHT9xY0QGibQUjsoM=;
        b=w6eNopz2cIAw22P6Kfei9mwS3g/IuOMWfJWSxlFeTTdOZ0ux7YbZCxo86Ks/C7vQ6U
         zm1sxrKhmZSNgcFVzqty8dUJIKGS+vRM7WIiU5TTciay0XvIyCWdVetDieXnn4/Z6Izl
         FCNuaAVFS3VDXrL5C3rT6j38tOcNtiak6GwT6kZrUD4j93MnAjIDE+yoYFXJSLsMtgkK
         LF+X9eO3331nvusWJ2GELL6mHIxyERzNYNbsyCbHjXqa6+p/Pxafg7+CW7lmkaWn0o7U
         hROF2DLZcLuIePGb8iS/O50fKGC3pF0/FMHbmfQQrkaeUf9gplYuLVpOSzbXe7f2fgVv
         oG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289055; x=1755893855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmaKJoKwHw82XyXX/d5iEOMfvSvHT9xY0QGibQUjsoM=;
        b=l8HFGUUJlCqfs0xCB6TB9da2HXXDrtM7hg4PTBSgBeq29GGEkiJTtYMbIgGJMyX6xn
         1heq+F3CK+uWaQQ5dtiZ0vK+GnI607Ghh7/K2O/ShtYYRJZ62DKPEPL5U2KGLtlm/AWu
         YFGxUAgjX+xS29Dh3s/KobIXl5fT9SCnafMRi9fNeglshug6DJdf9xwiTemt634mxPa2
         OEVbaDVyWgiQoMCNAaHq4JLq7SR/DCmg99evekol4N4DwXa+mfztem0lAVexv/uXqsys
         1LbCisObQM73DLBZ/DTcZQoDG+2QxvUtXi7sv5LZXry3OGZK+DsrK+KCO9zDlNt2vKUB
         U3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUWZuTru71/EK28YGqY5UAWF8dKrym08UXFgdVgT6Gndko2oWWItixY1XshCtPJ0U09qfJZRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8smw1itNtQ/N6igKPsMftnT0sTkfgOjMqBF6yQJZVEDHCAulG
	cBIyHqmlRpN4iwZqWvZpWYiGkfGTOBh0FewGGIj9o0Qn58ee6fqcxuHZgZlv8hYab4Sjm3A60cz
	7COdCRQ==
X-Google-Smtp-Source: AGHT+IFGdAKK5lsJCVHw32dBU/IQeIjE5FuMNI2s+BoaP+r58/XH4MUq0ZbtlmMZS9ZWWTLlSD916PektfI=
X-Received: from pjbtd11.prod.google.com ([2002:a17:90b:544b:b0:31f:2a78:943])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c7:b0:321:a2d4:11b6
 with SMTP id 98e67ed59e1d1-3234db8e481mr643458a91.12.1755289055548; Fri, 15
 Aug 2025 13:17:35 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:09 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-2-kuniyu@google.com>
Subject: [PATCH v5 net-next 01/10] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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
Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 13 +++++++++++++
 net/mptcp/subflow.c        | 11 +++--------
 3 files changed, 22 insertions(+), 8 deletions(-)

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
index 8dd7fbed5a94..46713b9ece06 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5024,6 +5024,19 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+	if (sk->sk_memcg == newsk->sk_memcg)
+		return;
+
+	mem_cgroup_sk_free(newsk);
+
+	if (sk->sk_memcg)
+		css_get(&sk->sk_memcg->css);
+
+	newsk->sk_memcg = sk->sk_memcg;
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe88..c8a7e4b59db1 100644
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
+	if (mem_cgroup_sockets_enabled)
+		mem_cgroup_sk_inherit(parent, child);
 }
 
 static void mptcp_subflow_ops_override(struct sock *ssk)
-- 
2.51.0.rc1.163.g2494970778-goog

