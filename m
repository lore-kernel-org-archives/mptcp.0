Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932222FE569
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021544; cv=none; b=Dh7/xloeI8D9ORI7soquJAAyiLVnzh0Dgdzf2R1P0dSmyGDe9HWnCbekalEjjLfkd2cRY+vtgbGH1a7NXKQaleCit1Z3duPuMAS19UxweUL542lMoMcessuAz43fGJxIC3vPCvD7/pU7ai+9grGqcH4xKfw22SzMi7HWmrHluHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021544; c=relaxed/simple;
	bh=Ax2UdSGe76cjX/U8fn+wOjQ7zXwBXHN69rzEWx84VMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/G+yCoSWBwQ04KdqVUgMi2FJm6GJsydv1KltrwQO6FE6H0yN7JVm6BJVy7TYGQbl7TJ7nkKALEyTdZyUNt0A4ssVXOv4hVsEpxfpCbs0yzjxipfM6PlULxSIqc095feQ5HxTaXQD2J/o9KRZEns9dabUur3yF/gJH6cLyf0oEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EmiJhH42; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmiJhH42"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76be85bfc0aso4544888b3a.0
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021543; x=1755626343; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UE7+fyIYJB9pTP5Kh5RXBJc7LN9wQtEkFd8ieoqRGBc=;
        b=EmiJhH42rqZ6I+49VPy6Kk0n34NOrzZFEGGqZCeUuInySwzygdgM15OgVd5neRGyEL
         /2uqQmyN/LIDNq95DWhYJF6/AB/XhwoxAsr/4jQmn8ANmG8yYUHY9+DQGJTuwHVmnUdr
         ZSOs4Z7YoaLcvItpby1Q8UsjdpEMihgr+XCebpSxN3LvTRkB53MIntxGvYRCkcWjwVYC
         5mK05UFzw9eGsq22NG7WWJjifI9y9iGY5a36R+It06psaq22Y67lQdAKSRMUIRIPpYQH
         GzD59wiLDsb1hBIgdHGY5Tjpo48FJQn3TXuUfTvI2+5x2AH3uOCN2D69Bs61UMC5irIp
         o5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021543; x=1755626343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UE7+fyIYJB9pTP5Kh5RXBJc7LN9wQtEkFd8ieoqRGBc=;
        b=n7FjbJz7CV7HjLZ+CBcbgVScUdtYf3MliI6129VfX6G9ftMx5h9C64zgPqM2CqTqAg
         1o5lstNW9zgetoYZTkqDgH/3pDOlxIN330ovn8mU0KkXBORouTjzhQMzye9H8oB0wsgd
         AqmrM4AhxkUvwaSFfVDXJcd2E7yN10geNKR9InDQi7VF/YwPuobJ2x3H+WqGow54xT9r
         erzSpFgXG3F2zTp2qtGphujR46f+jNptfInO7hmLWJ2C39X/nLbdWxtKt6HUkxMvRSKt
         PDyBmXWlVgSJoK/7KEX+NRRM9ah4EyscTPjLnikNxRzP9li86jCMQtxUtXsLwq3OJMvy
         oMRA==
X-Forwarded-Encrypted: i=1; AJvYcCUb4++r/LBG2lpN7Pm7Ud9elZPG+keoroZJiLJXXlsYxB+uA1Fyknc3G7H8DiXQ+K3f+BQV9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1Oss+iavSF7Cp4k39y+GY4u2ae11RW3WZ74s3MUR7jkSrae6k
	zk3p7Q1i8MctZb3yNwwPC/OT5sOy+zJGheEMPf6lVB0Ow4B7qWdMY9DBJbeeny9sF+d4LJSS1e6
	G9b2ybg==
X-Google-Smtp-Source: AGHT+IFtBSrb2xrrpV4Km05LIJWdOq8vUPj5EVaB8QdNd7zmXRO48lhifltEO3FaesYyLeoc/sVTWfW8tqA=
X-Received: from pfmm1.prod.google.com ([2002:a05:6a00:2481:b0:768:7cb5:740a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1910:b0:742:a82b:abeb
 with SMTP id d2e1a72fcca58-76e20c9bc63mr181842b3a.2.1755021542861; Tue, 12
 Aug 2025 10:59:02 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:23 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/12] net: Clean up __sk_mem_raise_allocated().
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

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa6982..000940ecf360 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3263,15 +3263,16 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	struct mem_cgroup *memcg = NULL;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (memcg) {
+	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
 			goto suppress_allocation;
@@ -3358,7 +3359,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg && charged)
+	if (charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
-- 
2.51.0.rc0.205.g4a044479a3-goog

