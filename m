Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C423E33A
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130196; cv=none; b=GE/ZK+9eQuB7pEWIe+R/4RXsSGxkS+c+J+ZAgurCs8Ty/4eyGFgBi5VyZIHjEASh5NOyJUIsMfmon9w7l9g4b0Doc1yekrmcbZyPSCfZu7X68GN2Jm8fF4RRXnrAs0RgNJulBAkr3EU2TmA52R2KGb2a5PjrMCzAf1Tph8LrxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130196; c=relaxed/simple;
	bh=x6W9fSLS0sdD6u16GfcO5OEeoEdgWbD5AwJHjH26y4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FIqq/EN4TTl/yZ8pKceDRZ+d6yMNJgcsdxH8tyPmGp/9I5d5R7WWjRK8s4kFtFfpfqESKEnSDiP12hes5ESB5P1x8cCwM/TDh5BnPZf7hs5E9FWrOWN4bCQPx4CjqdMKXTHZnfd/dMq9M5aXNHMDaLOU/GM50q213XpX/dK5HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpRc0q7l; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpRc0q7l"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3613e6aso2293667b3a.0
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130195; x=1753734995; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I175s6NxGih3nP7OcDsLqMOyvojLdjw63UOF+xheMJ4=;
        b=GpRc0q7lN0gbCh2tDhOl/hxSR2QnpYzY7fbcAfmM+nkrXD6fi3VloHAbXugv9AMXQg
         j2vw5p2o8HVwtPEyOmTkwL7aQjJGBwQNXpP5QcLLav/Y2rpGKBpKnuoKIdyr4T4RFzt3
         G5qvVn+k2u1wM5CIU6H4YhN+z3PIPXjILgBcQ61c94UcwF5W1d5KjI8SL/P41qjNK3jd
         2KyGa/OBmrCozd57geF5calyzbxHBjcwdv/hqmaEFqT/sAmYD/+DVjdGyGwJCBjNF8fh
         s2/wS3X3wqBYIVpcXf/7BxgaowLcL2YD577BN6oewrPsxf1skSR+8q8dF+40nKyVB1Qs
         C06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130195; x=1753734995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I175s6NxGih3nP7OcDsLqMOyvojLdjw63UOF+xheMJ4=;
        b=TfVLIOjJNhE7s9oOUnPTfO3xf2LjDz9vIESvZjK+LCbtGELg+/dWrKM13IuXqcOXGN
         Bqdv6ASHAHyvDyyvmpIzr7tqi5/S8WF2gS3JFR6By0WvH+KN/HsANaue0ExFdqoJ5/ps
         AJPg6MH9+oUTYPJ2+tTfGEIjAXCBO3Ik97JBrumUV3ns7I+7JeChKLvR46s35PZ5sBf8
         4D/99U2nbSOtla4s4SCG2R8u06O6uFjgu/aCnq6qKLBjmH6dngyPjdzJJ4WjaLOi0bcX
         q51qTOhkcjZjHmBez805iSDCMbUWElzdKUjFvQ8Jim3j/EMBVq0mG+MReU87r2zyGHAm
         so1g==
X-Forwarded-Encrypted: i=1; AJvYcCXXT3FKF2niHu9blK6y/hr0d18gzVBYXGgh8A1bZshHjJnSDsS+vDjwZYnY0PaC8/31ifM2KA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTqMlopB6tUCRkWWiRaw0CXT3Mvv8wItVtcIbR1eGBKvzC2ldk
	d5SQdySLcnNHr/b5eQ/xYs8uEt9iS5lIs7Y690IYAg45y9/vxAeLWsz0Hm765VaINp3zx3is+r1
	fF9Gk+w==
X-Google-Smtp-Source: AGHT+IFv6U7uHL2iBa9yupFYshgEXju3eOkU6QMVmKj+fMe7znAZlxzbdQTya4Ql3pAJYEeoSFGsqqqmF3U=
X-Received: from pfay32.prod.google.com ([2002:a05:6a00:1820:b0:74b:54a2:ff33])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f86:b0:730:75b1:7219
 with SMTP id d2e1a72fcca58-7572466bee2mr28714696b3a.12.1753130194603; Mon, 21
 Jul 2025 13:36:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:24 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/13] net: Clean up __sk_mem_raise_allocated().
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

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa69829..000940ecf360e 100644
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
2.50.0.727.gbf7dc18ff4-goog

