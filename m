Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EFD302CC8
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021552; cv=none; b=VQCrtk5oLuHKATSl2fQ1uUztsKK5KNObMGJh/qYTCWu8N25kO34JHFktt8RIkvukq1Pq3NkCdhE0z/hwYpMNZWWL1O2QkG05ngbIlg/zmp5Q1V5ul50QcQ8h0r1+r4+g4KldVzHSkH5UcatffPc3bReNWoh0xiEzjhJeuWETpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021552; c=relaxed/simple;
	bh=6MrgQrtYS9YcOgA8JGsGDbYNAfgLSAk+AgWzk7gDK6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1qOeSRZFzPGMndqlb1o+KmrwCKKwMhEMxOaPfBKxZmj97KPsH9YCtPuBHvsVMoPJgUU75nM5oVLk5izjKpHh5j8q6EdSLe+/h32ZQCVvX8HHfI6qRykLCbOOEUWIExV62jn3bQYuegzLt671gQ7ZeYF6ONT80LFi7WwMHKK2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ah8YblW9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ah8YblW9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bca6c73f3so10707526b3a.1
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021551; x=1755626351; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KhRu3fyzeIM1cEVseI3UE0mtgEXOJWM2aq0opP5CZE=;
        b=ah8YblW9ONO/2DOyzI7ftrvE1CbDI/upObipJipbyRTAzE4bRfB2Tanj/WAmwi6s+E
         7oYeoQapXb7FdmwL7BwNntz9f3AXxEHXnPR+5BPFiDR8LbNAuqmi7RbW2Cj9T7WLYj4f
         RVJobpiA9nFsBRDyZ6wco1s/diWC1WO/YjWucQFNgrR5NtIoqw/rg+8lhsEF2lseCwwu
         ZlvJ42cQ6rsxVLVa6PiXFS/dBAOnBpsxU+KZPHVhUbg9WUPxy5QCCPyFvQwtR25zzZTm
         FyLyXxuDNjmAP63dtP/2nVAxqNql65ykEMUDtF48ZDNgCd2It/puGZS6FkyL9Hv1InOu
         ySRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021551; x=1755626351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KhRu3fyzeIM1cEVseI3UE0mtgEXOJWM2aq0opP5CZE=;
        b=G+fNm6KgwLAe8ON3arXOZdiPgTNEz+r0VG3G6YP/bHCwWvDnBgn947KuJaAkSdq6A+
         IhtG1z6nP+iKY++HHkaLl8Upo5ydPwuJtLqK3zJBmM8Yc2E4ruCmkHAgp+mBmQtbdDEv
         U1Dcqg1TP6ztiC9bqBaz9obRsIwt0Sq5zEMb6qKoYsYkxREMMkDMDAa+8Y/taA2rLp1m
         5EMQxXGXlyqplQkQq/dWt7UvzqI/ptNIH2eVZYj1Ovd4Zq8ap3NBH+kiplpBcp6jFprq
         pxGt7+VejHOh/OsaIcdPPQl+YMrvvSSV15WPFk5M1ZxBQz3R0/2fi8JWX0btIyhVIXno
         qOXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKfrWpsg+UhLWPxwe+hIXLQ6gFwmVV5HK0Y/6AfN4FiTgsXpLnfWDQ2fA+BujuKyeJ0/vcAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSl5RtoTudfXTVgSLbICQBWPgOP7Mqv/gC+5wDWaBonsjlgk9F
	WUun3bdVrGT46RPMGvtcP7yyhQOeQefs46un9n1fvpfOfTCkLZygMI/3AqdLZRiprPeOdiDuQew
	JalWqow==
X-Google-Smtp-Source: AGHT+IF63iH6Z4gy1nQZqVIq3G/a8abCEtoljmxhNBcGHE63GfGOSxTYCt4U1CIor9EBnSEyEuEehfcKfyo=
X-Received: from pfblu26.prod.google.com ([2002:a05:6a00:749a:b0:76b:ca57:9538])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:66d6:b0:746:24c9:c92e
 with SMTP id d2e1a72fcca58-76e20e2515emr199538b3a.8.1755021550862; Tue, 12
 Aug 2025 10:59:10 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:28 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-11-kuniyu@google.com>
Subject: [PATCH v3 net-next 10/12] net: Define sk_memcg under CONFIG_MEMCG.
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
2.51.0.rc0.205.g4a044479a3-goog

