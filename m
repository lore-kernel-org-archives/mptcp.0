Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38872D6E60
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933502; cv=none; b=jBTeWDDRoX/Qxao13JOeUENuie9zopqXcVLAu1rq/H2M/NqD/SlkipWVGd+PhclB5rGBk/UbUby5MnWnskr9wxKTrbH7EgXGN9DJGq3fUSwLpP9fCV7etxj0xibx9o3M8JyXfdqYpXB4N8MaMWA8zWRYQIMrvdqc9qATAmSrDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933502; c=relaxed/simple;
	bh=djnZb6zv07TTJapDcbZzy/mNZjUZFqFs7UwvKkwxTow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f83U9UqOV7Z8I9iYYHwN2jPx74D8xt902LcjYpiv7jOO7m8/iLDE052vho/yv2x5DkEw1qSOIW+9kUwGay45P92QVTJNL98lZCB2241KL/49tFlizdg+jA3hHQdnXMg/ovAJqHH6dhydRwXs0cYPMm1GbxJdA+qZwu7Z3+zWjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdMDK7Ax; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdMDK7Ax"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-242aa2e4887so100992645ad.3
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933500; x=1755538300; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1evf9NP8gzujZSmc68LKGIYtEyxxeyxaSo7A1dSfcIM=;
        b=mdMDK7AxZ4iD1JxVWN2kQ1cr8qBWFpWxjaIgvGGLgfTHZSRQuLmi5mXnmdU84/yoW0
         OxjHwRiIqYnwVms26PEK8F1yLVTO39k0/9EXnooyi33MMxvwbtO6t+6vJnQjllKmjDg/
         ELh1PQKh58bbZJ1WRHZYx43CiKhLAkh14jJUpl+UaVY4QosTjZAY1zgBCHNVon+r1B8J
         n2y+ApbSBEYWn0gd4gt65RT8ucFtSs7TONKUp1iY4kPiNIaUcGbi/QXoLdOPtbZYLZws
         1WDGTXqPG8mzuU/1nlRdg+ZucxHiQM13zcuwrxSRaVjDBK4BKXFwm45Mg4DeJcFPii5l
         mJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933500; x=1755538300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1evf9NP8gzujZSmc68LKGIYtEyxxeyxaSo7A1dSfcIM=;
        b=loI3y4QiE96m2k2SE+mSRHAeip35/R8QuwqVSVnrvep/wTi3oD8yJH0joivRI0h46Q
         j/l/Us5ZXrnkw9V+AC+eGE2s9Jkm4pCU09QynGn1fILE3ZCFLJ2Oxt2wwhfB6zLy/298
         a4aSTJGj5X6C1KWx5Bjab1KqsmRWduI7gzzLD09wfyqWYLY2dVVzkdA/L1KcTgM6vO6z
         Bl5SjkfIiYjgKfoIoNLFiG6lZpefmoIVC3CnFTuBvKn/dFDpNCe7ktaxBcPMGuAYimce
         nVmbVe5feCtrIAXPkTOM8viknQFGRit+19PBVvI6knDODw6riP4VDt76/jC+WTW5VugZ
         0PSw==
X-Forwarded-Encrypted: i=1; AJvYcCWt2vaHIWIy5dB9iokvhPtJ2ver36fnAEwk/sdvkHRNaZ6Mr6YOlZB07fbV+qTCIhk1pysviA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNASi64fdVofpybvlMHhcWP/CDD8Va4sSuhZGB2LWp/2yKSKIB
	SKYc4IU0Nar5UJ7hieO4UjNzc7BKLFdl3gt5xWPDOzadudA60euyfvY29I5KIzPB4Ju6KS7vUTA
	QYBPUgw==
X-Google-Smtp-Source: AGHT+IHeBDKPPyqvP1rUR5CAMk5yyduE4pb1HwUuCqZE282C8A61+qQgO/7HcPgBMgw3doePxcL7KhLi5Vs=
X-Received: from pjbtb5.prod.google.com ([2002:a17:90b:53c5:b0:321:ab51:e32a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea08:b0:240:4faa:75cd
 with SMTP id d9443c01a7336-242c225554emr205009335ad.48.1754933499961; Mon, 11
 Aug 2025 10:31:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:34 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-7-kuniyu@google.com>
Subject: [PATCH v2 net-next 06/12] net-memcg: Introduce mem_cgroup_from_sk().
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

We will store a flag in the lowest bit of sk->sk_memcg.

Then, directly dereferencing sk->sk_memcg will be illegal, and we
do not want to allow touching the raw sk->sk_memcg in many places.

Let's introduce mem_cgroup_from_sk().

Other places accessing the raw sk->sk_memcg will be converted later.

Note that we cannot define the helper as an inline function in
memcontrol.h as we cannot access any fields of struct sock there
due to circular dependency, so it is placed in sock.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h              | 12 ++++++++++++
 mm/memcontrol.c                 | 14 +++++++++-----
 net/ipv4/inet_connection_sock.c |  2 +-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..811f95ea8d00 100644
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
index 08c6e06750ac..2db7df32fd7c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5020,18 +5020,22 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 
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
index 724bd9ed6cd4..93569bbe00f4 100644
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
2.51.0.rc0.155.g4a0f42376b-goog

