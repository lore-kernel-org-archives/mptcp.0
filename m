Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3D2D47E7
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933495; cv=none; b=O3afodMTLmeWI+wLOZDQgkdWJfGzq+FFu0cNxRsM6fmNOYLRqn0x1KYrRczJzXpKRMUlr4j8g5oZUWqO0LCODwbIClRjxJFMNLt/hJN9L6UUcZ6VNG9av8aFUxX3VzT+Daki4Bv0922Kf2jpyMnxax0qNSkh5RCuwxmjTLtNBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933495; c=relaxed/simple;
	bh=3O4wwZNIii75iBCsOBIERzFRse7hN1ZJ14qZD4q5cuU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hSX88GQ7Lk30BFlOaTt1EHzZ1Lgx14T0Rs7N4zHXdTTgDKluhKru54pIbYIPYwwM8fpTpAy7uePn50CWh32gBQzb0SiGfpDSeQf6ig7n2MZiDX95kOYp/GDJoxnHsK3lC7iMK+20I/ddLcg3t6lN9KDM9rj40LYM1HLp5eLkB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4gUmM31E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gUmM31E"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so8993402a91.2
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933494; x=1755538294; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUMgP2fCvnJmK1Iv88gPtdmkhT/9+UsLcGRktrUImI=;
        b=4gUmM31EBXqn0F11nqivjd8CrY4TIxTphK3FMm42bgOMf3tLavmShOfZ19e5O2Nt89
         mjskNBj+JyYx+NAM2TQxgj1ugAOPJAiybVWgG/s/t1mqbMMEo0IKxiJYH8pQ6jBxeOJQ
         rgmZ5oiX4Wz6nYcykID7AT73mtOixrDvDdZuwICoZdKAjGK8U6Im3jIDX9mswMdlmUnR
         Sx0F5w5mgG9buGkte2afO+rAC/GEYbpzrC/aCVV06dPiWwSWn5WFeFRhygjS/MwwTFdT
         9CfnOK6GuCcrpeE54bfzhpvXMyoAVUOjkMM70zK7NJyq8nWbxwUT6SmZh44FYM83FVhy
         kIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933494; x=1755538294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUMgP2fCvnJmK1Iv88gPtdmkhT/9+UsLcGRktrUImI=;
        b=xLe/uE2rrZEGnBcpm+7nHnKbbxb4+fVN8DFepqxOvWbmysGPeOViv8OdIZ57Dn0R5c
         vGrrJYHXg57cqu1ImsCx0ugsr+vGfMz1aN+WgXRH/PxbajfE7eWRgjbIfzXCNxhbEkQk
         dcI5GOXOJqYD764uBGh/y1vx66au6bXj9PyvnHm+oJcPLhFYaXIpckSc2ihR8gErwYZY
         cP7uFWaJwFZsvYnwh65/aw+azmqvmaI2dbV7kNfD4m0KamjB5hXt++5PpMAZ8Q4c0QJl
         XHoZcCBYu06/jKjKVgouddCK7Jsb+6/hfJZtd9oi0EIhktOHPLsiSQIyqTCaBG/l8MpP
         eg0w==
X-Forwarded-Encrypted: i=1; AJvYcCU/TG1Oa2s3MC1QLv8kAhO4RRah1od/ZmC3UTJ2CuI2Qd/WprZfV0TWn30HWnQiQ/QGGZ1h8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7wTh6uUdRRTTqhcZcQ/NbRCfrRRuuAHtQ0ehWRhDSeqJ1sAvy
	XxOqodmSmn7AjgL0TCtx4uo2hKmkli4Y/mnJr2unA4qsIh8LBOEt9XYBEMCWGH8n8zYSC+Bd7io
	/NXpapw==
X-Google-Smtp-Source: AGHT+IGLJHxtKJ3Pk5R4dgQvk7gs39J/mY7N5xl2jz8WX6Gc8LUYFyja4buobT+GhatPyGHT1yaWPuvm76w=
X-Received: from pjbsn13.prod.google.com ([2002:a17:90b:2e8d:b0:30a:31eb:ec8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2251:b0:31f:1a3e:fe31
 with SMTP id 98e67ed59e1d1-321c0a11aa9mr615779a91.11.1754933493761; Mon, 11
 Aug 2025 10:31:33 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:30 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b15d7fab5c4b..a1787a1344ac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -788,9 +788,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
 	 * as it can always coalesce them
 	 */
 	return (data_avail >= sk->sk_rcvlowat) ||
-	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
-	       READ_ONCE(tcp_memory_pressure);
+		tcp_under_memory_pressure(sk);
 }
 
 int mptcp_set_rcvlowat(struct sock *sk, int val);
-- 
2.51.0.rc0.155.g4a0f42376b-goog

