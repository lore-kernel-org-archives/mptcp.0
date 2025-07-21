Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932F2417EF
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130203; cv=none; b=BtqrbHPjQTe8uPjasEIKJ+8QoVvstGaXVwbNY3qPnOs0QfYufPpIeECpcTEtF5bxp/DCZ4A/2O28Mw4qkPRLYP1nW9Z5+VJV973uipX0vIo54ZEh9fd37TKbxza889UluiDyRLv3joWw5122B4TpdAJEXdDnbjdaPjgvvqBaWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130203; c=relaxed/simple;
	bh=i5GAzC5L1kuCCltZ38C9FzfkiUrjLYUlG5NNBN2V574=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKNFNb8qgLPBt0oWwfcfP7kFLj6Izy3ixAY8TtIrsy3HgnwlQmQcgY84FDjxq5gZciHJ50QTr36lWWCTG1S54EBI/2Dh+50KiX5ueN9eFtsaBRhosoo3ak/YDV28JxQohfh2zZEA9miBjvh9Py/jdAjoz0+EgtkoSeBUV95e/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=va5gvQuC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="va5gvQuC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36951518so5326843a12.2
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130202; x=1753735002; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssPdZm4XAVciTYPYdUcIXie5OXrS2r8M4cSNBMi+lG4=;
        b=va5gvQuCUU8PxZlOn3XdGLcjggsdeByV8H5o9r7hcPfGoHuSFiqZl92uiaf43siawb
         0L1hVIyRu+nogYFDUcUPqtaofnoEAQSJ6bgJbrhxfF21sQLr7IODDRe3E1k94DlZ46lD
         EdsXDBPdbuvvORmoUyu0MVtjvDSH+CUC5Lbmkd+wToD87+iGrKQ8XCSfwhcmOk26uIZU
         1RKNWFD6Eyy9AKTN9oosB5D66PsHNTZgh6WtYlkfiKvtzIAUYoyd25ZoRdhTEoWeHJzg
         kRdB9HI0QiFiQV9TZXQicSRMs2gyMiYFwoZ21y158slT/HbZtSoamUbS/WfnmRco+7q1
         LZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130202; x=1753735002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssPdZm4XAVciTYPYdUcIXie5OXrS2r8M4cSNBMi+lG4=;
        b=YTwmxXQy30gNkz4Ui3/Tonuu3hO8vOgWXHcdVka7UFADcvlLp8qvX9JXn8HXn3XHom
         snOA6VhAaVkcT0uMelTgb1lqvCxUx6I+5z1KvS55TEgx9nYunGYOhwXOliB+KtSLFvvp
         1I7Slsy/liODLI0RmL8HDvwAYayiLg6mR01iwRVhag0FA+z8xPLw92BrF8yxoNONEsXl
         +ZzoXFJhb+80i3nRq4+unIH7aioSFTAxFayn0NaOryIrdbEtlTrN6Ic5CpxtD8yqSFS1
         pW5UvQkmxy1sayGdyNE9Pr08hKWDy8TUU52FcOM6wjaFgew3M8Tdh5hl224D9yD61IKG
         0GPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXxj0lRDNpiX8MoPzLRlwI/SX/LdmgyJSGXcezRB5WDac2dyPyJlRT8DWLkS9jyNdMQ4kavg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz3/Ee5dh0YrHtc3SdZhIluPsLQOUUm6tYGZQae6dIyvFnjgtv
	Y26Lp86PM+lfGJmyJeVovOlmAw9JF4xlQFwdMsLfT7m5Vqix0NjG2PqaErRtB/j/vkP4l8uK4Gk
	D4J3smQ==
X-Google-Smtp-Source: AGHT+IH0bPuHNRYQE3IBCaVT7B1b82DZOEQMUavwyW5ZrY7G02YZ/hUnE3IIWK5LKSPidRIy8Lw1sZSx8D4=
X-Received: from pfblj15.prod.google.com ([2002:a05:6a00:71cf:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9188:b0:233:f0c6:a8a4
 with SMTP id adf61e73a8af0-2390dc51bc4mr34981014637.31.1753130201882; Mon, 21
 Jul 2025 13:36:41 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:29 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/13] net: Define sk_memcg under CONFIG_MEMCG.
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

Except for sk_clone_lock(), all accesses to sk->sk_memcg
is done under CONFIG_MEMCG.

As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h | 2 ++
 net/core/sock.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index efb2f659236d4..16fe0e5afc587 100644
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
index 5537ca2638588..ab6953d295dfa 100644
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
2.50.0.727.gbf7dc18ff4-goog

