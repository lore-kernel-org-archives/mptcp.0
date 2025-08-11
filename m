Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9B2D6E4F
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933500; cv=none; b=jfxQAKa7xWhrjl/F5yDo4Su0rrQw47m2TpQOwfmULtwtBtuasdiq7hYZpOsZByw+coD8Eb03q4vgaC2Ab9Ui3MnklsYbkeRCaDRBVe7ZN1EMD80hzrrwcDspz1hmGjwR2IP56VmfQEYuFJQjeeL1TK1oSF+aUfm7ap9BCdTH3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933500; c=relaxed/simple;
	bh=X8eX2iq6i1SdpjO7hV/2ZT1qtsDqnu8t+51xQUHLbiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GviNlF5EMkdPCRwTRVkJ8SWVq/r2//RmCPDmjwMJa9X36u3gXAEC/bypEaiLfJ51Ytib5whogJLpRcmFQmcQwurFhUJy7QeawAJhnybz4dnwqnZfOkk70zw4FPq+wfQcXkXUtZfgkmfrJ0S7LWEEcktK7YXXd4VTrlR7/YrCkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DLlA/hb7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DLlA/hb7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-242abac2cb4so53547025ad.0
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933498; x=1755538298; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfVGGcr+sVaGRRL1v88D9i+PBN94epKYHJgJ64bEQY=;
        b=DLlA/hb7Oc7E/y1ZUD0myQURCJVMvMbX4CUissHz/rKJx7/ihy/UGQJOn87RctLeaR
         5RPl3E1QobJbhNJyzUErF1t83G7DKouoyfdZ0XkHyg7W7nOALYPY0oypK6+K2DXgaZdE
         LxEczyq/iG1sy9lXzFJjy05JO9MEqAU4GA9r9Q816IlkWa9fMCSFLHV07AE161nJmp/e
         h770mRpSfUcNjHJP9r5QL2VRwtSotvnx20wlL8Ljml41D6jeXe+ghkSEopXI2XR12i4S
         dnVWzO0tqGqfDMErwFTSnhcYGBtT9zrVPSj0quPyVZ0a8sLBljxj+zUY95pwPn5hUO4Q
         KqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933498; x=1755538298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzfVGGcr+sVaGRRL1v88D9i+PBN94epKYHJgJ64bEQY=;
        b=mlP6SdkXArBXIXPfLWxazX2IRq8lrPUKTMEIErqYlTzEhReVNQrA5zQnroT5sw6k7h
         xaNJQrcbG9hLYOyuIqP958ytarQ0eSUeoeoRewdRlEgaptT4+oUGNyBjSPBPzhIIW49q
         a3msoaDeNosL6vtibw1fYnU4OptCY78wP8Mw/XtJzhkq9Yf8GiClg+KcwOZi0zZslw1G
         1+K+EhJLz5qjMGXp2mns628AIo3YAIglmx8rlJSJHx69YL4TsP89rQmOZRlSsUGwfm4g
         iXlm6K+baPsmNTwdlxYbKJOeW0D3+NhYImDaY2o/6MFv1vEzi6hGsowGX8qW1Dx4ASK0
         nm5A==
X-Forwarded-Encrypted: i=1; AJvYcCUSf0hi6fVm3uWGPLNFiBQ6YimSrzL5m3d397QwPMon7cXF9SDiw6yOih5mUwySZ9GAntpeAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxGpVHSvd7sc9P5fXMe86EZYzUc/7UDOhvo3on7cGa5laBerxL
	WrsxXjkDLzr4pdSKmFRBVVul34h/bb0IRbgBtQO5tq8vKbri5bWF9xbAvURfMsDVs+N6iTBdlk9
	equ3dOw==
X-Google-Smtp-Source: AGHT+IG9Zlocy4eDqCS5oKFJ6Lh7wIqM9jd+N5Kyl95s+RAxxPEZ9AxG7sDpQwLNd7KdpVUzfZOq2F2IpGg=
X-Received: from plbmv15.prod.google.com ([2002:a17:903:b8f:b0:240:3c5f:99d8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0f:b0:240:9ff:d546
 with SMTP id d9443c01a7336-242c1ecb9c1mr190995095ad.6.1754933498485; Mon, 11
 Aug 2025 10:31:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:33 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/12] net: Clean up __sk_mem_raise_allocated().
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
2.51.0.rc0.155.g4a0f42376b-goog

