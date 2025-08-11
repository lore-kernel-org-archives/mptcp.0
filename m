Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253F2DECC5
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933508; cv=none; b=i0v1ahrLISy+x+st7bDIp/yAzMVwOFXm3irxKj8HS+srJRMusu0/+LKHu4p7syDOaBt7Ov1xoHCOZ4lFqJLTLBGeTEfPv0e4chmLQvx5Fljr6gBywcN7VNlDZNbi852cjFnjJJzrLTj2cR+YF+Q8h2tZMMZleLI98SPOuHCqwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933508; c=relaxed/simple;
	bh=YWgmeeUhSBtdIU2IYL8FWGMjBkXvcKxfNS9et8o2ZvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U2jj9wCuv0a3/M77v7P9wX6m/7SCXAn0tIn/yjjH6Kj5ZgUD6d6IPzb/TKrgIku6YfQyiAIIEgE0M2VF9sDhqsYliiMtOcZvV7QSd51DIMAcsqgjTTzf0lghZPGyGK6TTn/8kr4fW490W/WMNVaufPKC98BdKUgCtTUEiEAriQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GIHhtaJ7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIHhtaJ7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fe28867b7so61593635ad.2
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933506; x=1755538306; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmnhomKCr3e2ahj1QMW8pKbPe/+04IGBoELpRw2IfXA=;
        b=GIHhtaJ7XjcMo1FhUAjVLs4DgWvWVluFVmNlh/7iOJhfWzqVvIlLWUgvxVY51+gRCq
         8pByGlKTz6xM8ZUkICOZlB/KcXVLGRflcNiuaYIKZEz+N/SkLw6Dil9eRDR0UyQr+wGh
         IM50UOq9r3+d5u1mWhL4fu1eFm1f73UJxdpi6VZE9VdtMFPdvooCwnsVdLEQGY8ZyHs0
         tfw4ri12gmt00kcgs5dwPt5P/L3l8EjP+3gU8lS6dRCxuC/cQ5Lf3HfPCv3vwrCx3S2N
         z5tOpR7FLTLjD8LnlrcgW1aIs8iKbSgAZcH66HoGWhhE47rKsMHwpujOSIsMk6swL+sR
         /7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933506; x=1755538306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmnhomKCr3e2ahj1QMW8pKbPe/+04IGBoELpRw2IfXA=;
        b=wQuj1WMnTS4tiM9xPGyAsayAp1cF5XT8hjNZsIbfWl1NyA7AvehAowXERBdUd5jcG2
         64z//4iNIjMI/1rvDrKNWPWSXKENsaMLY8iA9GK0YDMgigyay90w0KGa1Agn08wQaVwc
         vOSV4IhbTEbfT9I9JEjIQ0P7yiXuDpypL66JDX+mx0ncw7q4+TpjBo73M2jzUEQF2SX+
         hDuAXAulLUHvC0kD6o2mr2KK3RCFootYm0km48mHhRrYFEj34hzzS8gG96DwWTPSXG6U
         3HcN+gMPjF/xxH4RI4fLIF8G2tR6vt5mNYJ0rtTgatqWB4IOKsHPK1MLwl+EMcfFnVRt
         eTPg==
X-Forwarded-Encrypted: i=1; AJvYcCWxb1lO4E75tKt/A0B4Qn3M0tIYdFP9R4jupjYGuzU8Y4Ahq/eaiJG1Htk9gN2ZYFY11KGtvw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb+545WDJoee0AQ1Jfysky3V8ta+1OI8jaAQGUw5H2LJ8vfLFI
	+tLEYCWaeM2yFH7bHeRLkajg+U/1IWbShfOHyzL7UvjfVA8NFbQNb1CaoUKN6kkT8wAr7/QkkDA
	wGRSfRA==
X-Google-Smtp-Source: AGHT+IEbQbPObtr4lDb3C6IUSrTWzurWfQ/uCHMXicVSCI8UFHPyb3Vp4pwMwBuWD+yHcnEb6yN4kCs20/w=
X-Received: from pjsa15.prod.google.com ([2002:a17:90a:be0f:b0:31f:26b:cc66])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2ace:b0:234:b123:b4ff
 with SMTP id d9443c01a7336-242c2011167mr203387105ad.21.1754933506388; Mon, 11
 Aug 2025 10:31:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:38 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-11-kuniyu@google.com>
Subject: [PATCH v2 net-next 10/12] net: Define sk_memcg under CONFIG_MEMCG.
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

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3bc4d566f7d0..1c49ea13af4a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -443,7 +443,9 @@ struct sock {
 	__cacheline_group_begin(sock_read_rxtx);
 	int			sk_err;
 	struct socket		*sk_socket;
+#ifdef CONFIG_MEMCG
 	struct mem_cgroup	*sk_memcg;
+#endif
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
diff --git a/net/core/sock.c b/net/core/sock.c
index 5537ca263858..ab6953d295df 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2512,8 +2512,10 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 
 	sock_reset_flag(newsk, SOCK_DONE);
 
+#ifdef CONFIG_MEMCG
 	/* sk->sk_memcg will be populated at accept() time */
 	newsk->sk_memcg = NULL;
+#endif
 
 	cgroup_sk_clone(&newsk->sk_cgrp_data);
 
@@ -4452,7 +4454,9 @@ static int __init sock_struct_check(void)
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_err);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_socket);
+#ifdef CONFIG_MEMCG
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_read_rxtx, sk_memcg);
+#endif
 
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_lock);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rxtx, sk_reserved_mem);
-- 
2.51.0.rc0.155.g4a0f42376b-goog

