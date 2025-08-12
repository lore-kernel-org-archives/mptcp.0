Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DD2FF14F
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021541; cv=none; b=n1PkYaASBuxOcu91JYSIFPFgE3GbhADKBZyx5TibWE1xAtAgi51zyTjgdTm+K30joITEepeQqKMe7fspOTFosEYkV8VAOO4UZVIuwzpTVpg3y8tZMJGOWqwElRVGtqcvYN+lM8IWiq3evSDW/tYe8KlHJStqcin/RtxedBSY4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021541; c=relaxed/simple;
	bh=xhnYwO7GL1+CtMhfwDFOhfD57z1pVtgWyVGZ0fjlUoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C7A6Vk+q127rqsac7YJ/4lkHX2KXkl4xi/Vb7iHOo0x18xytz74xBNTLGjeQikPz4Vzw8L0rO5IxrLFDLQuqYjiHfOWRIy5MucJtT0sT2GHE8l4zU9lVjyaGjelPgkrWeRLqpxuyeKslFiYEqi+/monVEzEhZDGQG3mzpKQJ7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuvzjAUJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuvzjAUJ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so5473253b3a.1
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021540; x=1755626340; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5rCQpTg40XvAN0nRmC8PJTXTHlgnacsK7xSr02TOwk=;
        b=GuvzjAUJFb1P5twyf/0FT5HN5HN4Kgv385x+NNXuseIgUCXHtRfUG3sJIcOzNQLA5+
         dGaDLxKaLza5VtP4y83mb0QQsZbsQP5HsOlSvxi9Nidx41HsXJ3zRxebg4d15gT197fY
         W1V/KJGxSTc2wG0pryEEvQW9EDaiu4m3Aig8yycLjW9OsYGD4Ji9h+q0sjls3KGFqo3i
         uiLZzEI2eF8PLyHJR2ltmd+EzmpYXjWSvzv2D1ZH4p0RKK7UYo7m07SpWZVL9DjVoETd
         GY3rdGVWuWtK0rGBQ1fjD4cFy2tk9vZzGcBeTVJwBCTYjSn8B9B3GmT0DJhqXMw7hayz
         VbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021540; x=1755626340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5rCQpTg40XvAN0nRmC8PJTXTHlgnacsK7xSr02TOwk=;
        b=t30HVmRQu7Y0ShguHv4xRcPfqjuxmNjs6nLeDeQ4BYuy38QggeXouGUbqoCXyiOHWQ
         n/HWv8zblO0u5H7WPcpl93WYSCLT7UqWC18XoXtoQWM98xjxu6betMFQWfHz2qYBDSun
         Q3mUe19Hvqr+twWpk9eDjWa0dHEUHyxaOc8zuuEya7FyLu4j+fygCkQWfXV0z/ik+b6B
         Fb9iP6WTMIiw+v00au+QzCHwzvakJugZPqIHv30kKYuwIK7w/GpXGpACdjfPhJM7ukhD
         KbO1I3dT9nLaGhXOsKi67vm/yJpOXIxz7Q+lbW0SdGXgmoWwnFpae4jYdKEE9c2biyvW
         a6xg==
X-Forwarded-Encrypted: i=1; AJvYcCWi8VTkWKOnWBgSv350ym3aNAfvc+wbqlPGyJiFKOyoEr/Ku+f8C8NokDOtoAhfdM7Svh43Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfwBq/TeO/PwuMiihnYfnbgc4fyVAZGOFEygMbiWZA3gFxMGsc
	pd9Ax3LdPUTgagEiGqoA4yoBtdsRyVgPWAONUa5n8kPkedSA+KEH2p13AZSTjvzMq7AD+50FwLN
	W57H0cw==
X-Google-Smtp-Source: AGHT+IFWOE5iaFIohAGKeh/7bkm49sAtcTJw3E8VuXd5fFWE4AD9T9o/O9JzYSwQSyIb+xne5Odsyex1rCE=
X-Received: from plblh11.prod.google.com ([2002:a17:903:290b:b0:240:39eb:1e8c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:440f:b0:240:127:85f1
 with SMTP id d9443c01a7336-2430d0fc548mr1608415ad.18.1755021539728; Tue, 12
 Aug 2025 10:58:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:21 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-4-kuniyu@google.com>
Subject: [PATCH v3 net-next 03/12] tcp: Simplify error path in inet_csk_accept().
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

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fe..724bd9ed6cd4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -706,9 +706,9 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
 
-out:
 	release_sock(sk);
-	if (newsk && mem_cgroup_sockets_enabled) {
+
+	if (mem_cgroup_sockets_enabled) {
 		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 		int amt = 0;
 
@@ -732,18 +732,17 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		release_sock(newsk);
 	}
+
 	if (req)
 		reqsk_put(req);
 
-	if (newsk)
-		inet_init_csk_locks(newsk);
-
+	inet_init_csk_locks(newsk);
 	return newsk;
+
 out_err:
-	newsk = NULL;
-	req = NULL;
+	release_sock(sk);
 	arg->err = error;
-	goto out;
+	return NULL;
 }
 EXPORT_SYMBOL(inet_csk_accept);
 
-- 
2.51.0.rc0.205.g4a044479a3-goog

