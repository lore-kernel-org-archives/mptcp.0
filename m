Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D452C1788
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289063; cv=none; b=oC53NbbxiWZ9bbTBa2g+aVaGt3FfJ62krBg4eZ2BZI+VpSYUG1rsW4Cgobk364Dm5+0XEQOhrc2rioJtdIsHb+SdfEMGrppNzFzNNXZIfX6X5I7ajQ4p8EvS6OooOQpDC069Z26RYibqNLdp0yS0D2BF3dba0k324I5Q9kROc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289063; c=relaxed/simple;
	bh=49AUVqRZ9QX0gApoGVu2lLYolROcKxAhbfDoW1MZFwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZmUVMgHqKDGbKqBddAbD9+VebRykdcBOS8k4N/yfikeG3erCXGDJiKdUlKgyozjmjtr80p+nitmG/MKurHq8iUXQmqfUFt/kvZTMOALz9LdpeNrPwcenaqOktzRhKPONmRRhUBUEkdfjSe4gAqSdcp6n0kU2DPaqV82+P0pF6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yWVJEcmw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yWVJEcmw"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581950a1so25982795ad.2
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289062; x=1755893862; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=yWVJEcmwxdDDhHDcbZSdXm9Asrh/0eMzMIZQReS1yVmLoRHBOM4PbPtePoWZPk8291
         yUNp4zTVTxWQv0tUfDXCivZABLa9J2dUNAzy9sqegCs8Y6Us1SuANQCu4XbSAsRf7f9X
         7ic3G8p/DPYhvp9+q410QNmRBaC/LUq3kJ02u/DdTyVfZ5RpriMHERk9NBKE/4QKuTDO
         C7+pz+bq7Yc7CLfNAyP5rkMGDRdhMQHCFjiSM7+9kSMzVeDfbi7YDTYZQS5J7BNFxNkF
         hnOSJ2b6zUODX5LR9fblTX1NO29NwurC2j8Yg2KJf7B7QBDoQY9rM2581d8CY3Wr09qL
         uzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289062; x=1755893862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=FNwGL4K6u7cjBXyUHdPwBK/NsgOnO7LVxwnWXjqRZYURjsbkyQ4y0l/OyGfmYM2LYa
         mIUrGVnM9IcXpQYXox6y5aEs9ukKFkuiMokQlD931CrSC5bBS37nWtaKmIcHegeMvKmQ
         GLUQS4tBxzYWmhrZd0MV+duN1HKNSDSUlV+ui+sVF09FbJ8F87kpa/JqXOSvcG8jlmJB
         fgJ3uEhPAthJU73U1dm855kwHHxq2cXB1oUnxbLl96JAmcWLI3JlsjeiH4sw4ocq2a8N
         JXwTPVf1M+mjNmcWGV8QS6CUUP8OdnNNQ5dF6P7XPpTbYufL5dN/Wl+519iQ/hDQZLqK
         ESZw==
X-Forwarded-Encrypted: i=1; AJvYcCWGF+lEDoltcl9S9HW7MVwwLuocLk+P0TyNYQTx22uUaV3Dtmrx/Rq01F8uc0xdDAgTjxZAzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaLaz/zGA/50Mp4VeR8hLaxo6E/KFsIW4H/gYqO9EFXRPohUH0
	7qSRdBXGTHpsdYMVl6sRaH7uRlUksIy6b0iYJU0ElSh2ajJX3CuF4nSxSN6aRJ1wXP7TAcHXto9
	sjWpY6w==
X-Google-Smtp-Source: AGHT+IGYcQH7/mF6y+bCQF+wvj8byumWi1k0Tu655xRzdfVqKzsBybbZLpijTnLaQewu7vlc+0MtmLwfX5c=
X-Received: from plbmn15.prod.google.com ([2002:a17:903:a4f:b0:243:5a:ee2a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c8:b0:240:3239:21c7
 with SMTP id d9443c01a7336-2446d89d237mr56657975ad.37.1755289061594; Fri, 15
 Aug 2025 13:17:41 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:13 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-6-kuniyu@google.com>
Subject: [PATCH v5 net-next 05/10] net: Clean up __sk_mem_raise_allocated().
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
2.51.0.rc1.163.g2494970778-goog

