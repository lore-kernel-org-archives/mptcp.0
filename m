Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A32241672
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130198; cv=none; b=C09IoXnEY7h7qpCQU6amh45D6MwpKh8Zy0je+HyzvyLehKMroq3QezNQjZLqHaeu7TQcdSIOmHAMw6XjcVdbD6t+hh86ZEpFKHzCDbZE7ZLZzF4wQmJ/a5tGljwG/J0ih3t/1ZeMMm4ptkS+E3eBsVF2AdtCGubOWhDg5z+BZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130198; c=relaxed/simple;
	bh=wN2CF4G/nCvFEdVvHYYf1Bhf5FKqcQYYZZZXgtBjYY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqgLie0YEQTiCSbHdNFxmdQ2FBS3wQ9l7r9TP8OOKUPuk5OT2q9Qg751xpJsVUH0fh6z0VpfUMmxlrHV2oXqjlYjJiJRdPP1FvSQnPx2Y685NTTboJL+POWy+IdN3TloIIsfmhb/dSm9DnpAYGmC3EbRzBIPBfvzyatG8v4i6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0V+801Yx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0V+801Yx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7492da755a1so3550873b3a.1
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130196; x=1753734996; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGASm3CxvureKJlvs5onpPMiZoMQw1GHMHnORXuhuQ=;
        b=0V+801YxII0p7TrIIEyRn1Dfm8JyYxdFDz7wiNZx90APFdhHjdD6i0m3VnRuMnJqMQ
         Bei2f96Fm3eBCBQ7vDJN/Nr0eFji/D039XJtGQIjHAYrU82rT0mdUll1GKSHmUuzqmGD
         wg6Ym0Cc2kggKOUjKIkSsEdrJztPir/Cpo/MRHhpTCyZrltJ7bp5Uyhl8nDxXS+ZkpQJ
         F7C0xSo43G4OcYmGdARpXKqcdjzXgsImh300nIAkevMPPhVXHoU/Ib1DL++J3iTpQGha
         F0vxFIdJU7cUIwlrce4v8y/oMrRwAH+DBxIimCpzk38MMCwq3Yy7squj3td98LxU2Y/z
         oDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130196; x=1753734996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrGASm3CxvureKJlvs5onpPMiZoMQw1GHMHnORXuhuQ=;
        b=W+ETqoRy1MkWRd3/k9cYilkpPNBtlXH2Qn3dAz3FjaWZFh98MtP/sJpP3uzzD4UuAo
         tfwIPJDHU7PviV133Wu/3CzgM6v0CShX2zw6gMVR0331zPNZKDGTg466U6QaGSQnDTP9
         8j8Ap/WHC+PNZnjvUG71cU+3zWEs6+ZnLjQhALmpqLFD10ieNMB3398hfZshwY4DsTSo
         xQuQIxlqSvs2m4QGP+ZH4s+7vRMfzw495T7ucVsoqlB+/H/76VMCu9CELSJWc/iLpx64
         KkPl3YXEcPXkr+/kBdeg04rWCMrUYor1y/8eQXjfil46uo/XZbSzfvkFbIajv/697KFV
         qoEg==
X-Forwarded-Encrypted: i=1; AJvYcCVtr2KlLRInSm9sCWcgfkpoAekFYMa2Wq7Jj6fkqyzfj144TNall7ZVTIAgy21HZitjXDYSKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxPteT7iBrgHTnGfvclFBWrQPvk2pRVm8ZSBZuOFGil9NiOYRz
	Ke7LgnBBKUy6MvC2g3fr9dua0O27SdYvH6G3a5SEY43CuD0QTzfwMXcpnibyLTbss/vNLQWwb0p
	xh0DUfg==
X-Google-Smtp-Source: AGHT+IFThfJRCKKDOR0Nefiu/tzdT/WdSWlskFFKFs1Y1mRRZJXgb5GsFfKf6cD/RAM/mAjuTqVBtl3aIvc=
X-Received: from pfbcw5.prod.google.com ([2002:a05:6a00:4505:b0:748:f4a1:ae2e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2189:b0:748:68dd:eb8c
 with SMTP id d2e1a72fcca58-7572487561emr30325627b3a.23.1753130196319; Mon, 21
 Jul 2025 13:36:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:25 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/13] net-memcg: Introduce mem_cgroup_from_sk().
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

Then, directly dereferencing sk->sk_memcg will be illegal, and we
do not want to allow touching the raw sk->sk_memcg in many places.

Let's introduce mem_cgroup_from_sk().

Other places accessing the raw sk->sk_memcg will be converted later.

Note that we cannot define the helper as an inline function in
memcontrol.h as we cannot access any fields of struct sock there
due to circular dependency, so it is placed in sock.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 | 14 +++++++++-----
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6fc..811f95ea8d00c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2594,6 +2594,18 @@ static inline gfp_t gfp_memcg_charge(void)
 	return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
 }
 
+#ifdef CONFIG_MEMCG
+static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
+{
+	return sk->sk_memcg;
+}
+#else
+static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
+{
+	return NULL;
+}
+#endif
+
 static inline long sock_rcvtimeo(const struct sock *sk, bool noblock)
 {
 	return noblock ? 0 : READ_ONCE(sk->sk_rcvtimeo);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 54eb25d8d555c..89b33e635cf89 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5086,18 +5086,22 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
 void mem_cgroup_sk_free(struct sock *sk)
 {
-	if (sk->sk_memcg)
-		css_put(&sk->sk_memcg->css);
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg)
+		css_put(&memcg->css);
 }
 
 void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
 {
-	if (sk->sk_memcg == newsk->sk_memcg)
+	struct mem_cgroup *memcg = mem_cgroup_from_sk(sk);
+
+	if (memcg == mem_cgroup_from_sk(newsk))
 		return;
 
 	mem_cgroup_sk_free(newsk);
-	css_get(&sk->sk_memcg->css);
-	newsk->sk_memcg = sk->sk_memcg;
+	css_get(&memcg->css);
+	newsk->sk_memcg = memcg;
 }
 
 /**
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 724bd9ed6cd48..93569bbe00f44 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -718,7 +718,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		lock_sock(newsk);
 
 		mem_cgroup_sk_alloc(newsk);
-		if (newsk->sk_memcg) {
+		if (mem_cgroup_from_sk(newsk)) {
 			/* The socket has not been accepted yet, no need
 			 * to look at newsk->sk_wmem_queued.
 			 */
-- 
2.50.0.727.gbf7dc18ff4-goog

