Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1A2550A4
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202161; cv=none; b=tulixD47bXUI4+wG6F0OPBpW7MAvOW7YuAxlQErk3zuZFhpR/GNXapdwFZyiTbWHIH6/1MECahP4soPB0OC5SR8/TK4ZCslUL4Np1id7Wq0A5Pw1N/xC/hmHKefHbqXuDqhrpg9V9vCMsGd62jEaVNLIxvBhazBx0NF3dUUxE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202161; c=relaxed/simple;
	bh=kNCka+5/ble2uhxoCvBkpMNTXujkGV/J5QaB+v82p+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qqg8MBzfTSxhwHTvVO4NW6hmw02/OW4LjX30BiNHsGshM2VdAKxTGuhvY2bO6VjaxcFzcF7NJPOqoH5wOoI9nXWTy5RyGDRWUGVRAjoMgfU9PNMgq8W2FRPLfdjQ5gxPGVZm3Bbk1TB2mZS8K54kcr2Pzkrn2oUJcx0hpN/HvBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYrYrLp4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYrYrLp4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266b41f5so2682326a91.0
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202159; x=1755806959; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=RYrYrLp4J0uGOd//mNUIG/wWAawfE63uP+EcK2zn8vjmTW8NUciNo/tbkT6CDNhVDF
         u130iQMlIy33w+Gurr5D4C9f9JYgvfFcZLObkWatuSl2ct4iQSsDzM5NpN8XGar038It
         p+8HL9lvUS8fYueF6BkLhIVDO+YTG+M8UdWWn1tE7FgyhJ41BcTZQEaTjKCtGSaIMmtu
         +P3AAw+nHRNaWcv9HKPQ1JENrwr26c7M4+obxLvKZaIONfqU4MNHSd+K6PFbNFv8pfZh
         MyRvk5Hf97JRmGfZUrMpd9EbVH7xcJms0ZChOwyYFToV326aJjxJMuzZvlpfoOIg0bbj
         EhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202159; x=1755806959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=ejgnG+4hIvK1KSNkKw0JfkWibXwbTtZu7V8XHoq394iLjTKq8EI/b9fLDI4iZyGtim
         cdeaDOfyahPYL1NK/zEyHOp4NSrmc0wseduZXgU+34iA2QLNwI7PAVR9zW0wViRyE8Qu
         ilOuGHGgs/0PoQSGyUAWg2RYRZXtWhX7/0pdGAt3mMupuSHCBMvuXyBgl0sQF2+JMTQZ
         ULHvEF6qlPv4WKDwymilYn4nb11NH4g2g3FZWzcOgwqfW+x5P3k+vIn68FiTWrKPui24
         YxuCIIP533Gdr0dbjs6Utk436KMEzAJzyjyZLS22QdX3q7aGX3LWJvCJzf7x1q6uXAC+
         nmdA==
X-Forwarded-Encrypted: i=1; AJvYcCUBSQbk46WGfvEZZ7U44Vj1DsITA8GZPyoHVH0YHD5Kn4aHsI8fdgjEPaPshHj94eoHJVQb9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBztOQRx5TYNcoSmx5tDZftLxvbS0JR5TgtlpacBCo0KaIHUSR
	As8FhaC2dGixCmEm4AUOyNai+fVImdfopEz94IInOZg9WKfYjtgAyReEORmQwZ6vbyOfVxqUORR
	CFBYnKA==
X-Google-Smtp-Source: AGHT+IH+nzG+2OcnZiv+3/UMTbEq2fBzLGSyOMqRhyX99l+CDhgD+Ism6ZOY2XsIJISoEwSwcdBmJbzd56M=
X-Received: from pjj16.prod.google.com ([2002:a17:90b:5550:b0:320:e3e2:6877])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d82:b0:321:a1fc:a425
 with SMTP id 98e67ed59e1d1-32327a8b7c5mr6718040a91.26.1755202159430; Thu, 14
 Aug 2025 13:09:19 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:35 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-4-kuniyu@google.com>
Subject: [PATCH v4 net-next 03/10] tcp: Simplify error path in inet_csk_accept().
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
2.51.0.rc1.163.g2494970778-goog

