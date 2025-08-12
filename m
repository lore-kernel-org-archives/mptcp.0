Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C35307ACE
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021554; cv=none; b=KWPiNr0lwjydOXVnopLENRdouvAT7+vWh0b75p43Rfn1EcTIWWuHAsVkmb2NWZ0nPko4YOWJ76toFAjUAR52KJkJ1O0XtkXQRx1cYXBhxsXZzH2jr2uzg/JxMJr13adpEjuE5+fEPcol6IZhi1YceH9uL0DFhJyrrPQ9moMEApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021554; c=relaxed/simple;
	bh=AzdjAyuAeTtLY2TPo5CDqjmI3gwoVZT9bLy7bQdg2ww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MVhi7hG8ml1Nb/2S6ppx4+lfOAQ88aopLI6dwC2LdefG2s4gfwcJDNpoLGKlbSGxujd5oTCTCAEbmL2uM2P5k5MVqlftx6yzW3dgRB5XxeOo6JQmOCpi1YJgtrMBoulNZBp5ICXAcVIyXpzN/TobjdzBnNxQrRpPWsNTB40Ub0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1dgM883; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1dgM883"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bcf2cac36so5410939b3a.0
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021553; x=1755626353; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovBhq/8jpHlM6xqUqyu+IoeRpzyccIKyfTNMwGT0Gbo=;
        b=k1dgM883oUAUAFQiunDQCr8LuztKbtNuz++4TD8CXihJ+a4Fc5gp1vhPvsQM5iyBb+
         e9m3hQReBoZoNWbf361UtbbPXRn2b1faWVA/c0xqIXucz8aJdsdNssbHpaVti5C+ejSq
         M9cSRpusdXWYrXGd7q6KPuC6XEDpsRSq6UA++86MP5Z5BCBHRyF2GdttiKSXAC07QSZE
         oTRcympGozkz8DRSxGk3ZfwskuJxUOBnUSwZgp4iQmzGyFzqsid0VIpC7p3DGbx9KI+Y
         cKaRJ7bON/5JFeLEZOx9mnMZ5R+h/Fe84oDgZONVeXusghrDf9KOp5VBPC0tKNOtOXik
         kKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021553; x=1755626353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovBhq/8jpHlM6xqUqyu+IoeRpzyccIKyfTNMwGT0Gbo=;
        b=VvMolHkNeRwh+OyV+ftMMCk6NghT1ZSRCIS3i1HKvY2zIMKGBTJyjiVqZetu8LMDGW
         CszRSeVuAUbYrZ4GLFzsPQCu/CQpmru/tgHBTPtOxzwVpTDTZoj3SALr8zkjszGs0GKN
         lECOhok5yxQuyjMGPHTxUWuN3Nl0NNRSWjagoFSKD3QSIfuEsbxr9TAe8a6rooxx0eay
         fKjLyIFqf/W0wBOJ22JABRbnRWEXtonLCvp5xti8tOnTW9cE79B3BGvAQNXlKbu+kwdy
         yk1DAOaM7ZjKpnbXS0DpYWjwwa6eTsAd6YgH2KJMOwp5NK2E/+UdG4fJUdBouSSDljLp
         Ls9w==
X-Forwarded-Encrypted: i=1; AJvYcCWNi1jTSnSlhiOAjoJSoiEbElncBYVAGV6Ivr2/qWCirOn9WoLrIREL027WxCHaX5bAEnvEqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxHOynwLxMinBsGLhI3jscn3B/CCDtvyVZ5Q3f8u1OO7SIyMD1
	z2KXKnbYkLYHcODEWmwkQ9O07Z4dO2/anKkKiZ1wEuT6hiYzuYBkRMhrCrmB0+J+aP7dG5veKQl
	iThrFdg==
X-Google-Smtp-Source: AGHT+IE5Mz+dp6VV6fNyX45tpzOfL0y24+xxBoFkDHbdJqD0bFXipR3WVQOWKJpZtMRbGnc0JSgega5q8zY=
X-Received: from pfmm3.prod.google.com ([2002:a05:6a00:2483:b0:76b:d2d1:119c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a8e:b0:76b:e561:9e1b
 with SMTP id d2e1a72fcca58-76e20c9a3efmr172719b3a.1.1755021552359; Tue, 12
 Aug 2025 10:59:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:29 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-12-kuniyu@google.com>
Subject: [PATCH v3 net-next 11/12] net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
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

We will decouple sockets from the global protocol memory accounting
if the cgroup's memory.max is not "max" (PAGE_COUNTER_MAX).

memory.max can change at any time, so we must snapshot the state
for each socket to ensure consistency.

Given sk->sk_memcg can be accessed in the fast path, it would
be preferable to place the flag field in the same cache line as
sk->sk_memcg.

However, struct sock does not have such a 1-byte hole.

Let's store the flag in the lowest bit of sk->sk_memcg and add
a helper to check the bit.

In the next patch, if mem_cgroup_sk_isolated() returns true,
the socket will not be charged to sk->sk_prot->memory_allocated.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Set MEMCG_SOCK_ISOLATED based on memory.max instead of
    a dedicated knob
---
 include/net/sock.h | 23 ++++++++++++++++++++++-
 mm/memcontrol.c    | 14 ++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1c49ea13af4a..29ba5fdaafd6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2597,9 +2597,18 @@ static inline gfp_t gfp_memcg_charge(void)
 }
 
 #ifdef CONFIG_MEMCG
+
+#define MEMCG_SOCK_ISOLATED	1UL
+#define MEMCG_SOCK_FLAG_MASK	MEMCG_SOCK_ISOLATED
+#define MEMCG_SOCK_PTR_MASK	~(MEMCG_SOCK_FLAG_MASK)
+
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
@@ -2607,6 +2616,13 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
@@ -2634,6 +2650,11 @@ static inline bool mem_cgroup_sk_enabled(const struct sock *sk)
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
index d32b7a547f42..cb5b8a9d21db 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4995,6 +4995,16 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
 EXPORT_SYMBOL(memcg_sockets_enabled_key);
 
+static void mem_cgroup_sk_set(struct sock *sk, const struct mem_cgroup *memcg)
+{
+	unsigned long val = (unsigned long)memcg;
+
+	if (READ_ONCE(memcg->memory.max) != PAGE_COUNTER_MAX)
+		val |= MEMCG_SOCK_ISOLATED;
+
+	sk->sk_memcg = (struct mem_cgroup *)val;
+}
+
 void mem_cgroup_sk_alloc(struct sock *sk)
 {
 	struct mem_cgroup *memcg;
@@ -5013,7 +5023,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(memcg))
 		goto out;
 	if (css_tryget(&memcg->css))
-		sk->sk_memcg = memcg;
+		mem_cgroup_sk_set(sk, memcg);
 out:
 	rcu_read_unlock();
 }
@@ -5035,7 +5045,7 @@ void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 
 	mem_cgroup_sk_free(newsk);
 	css_get(&memcg->css);
-	newsk->sk_memcg = memcg;
+	mem_cgroup_sk_set(newsk, memcg);
 }
 
 /**
-- 
2.51.0.rc0.205.g4a044479a3-goog

