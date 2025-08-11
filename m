Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963682D481A
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933499; cv=none; b=B6YL0IaaATPKmgTrBUCQwrPYTBMSW1SsHYZggPkxWIswUd/zWe1O3v8GO0sdqmaN8VtTi5YVcVDHf+JO8F1EQxr5chfSPTkTp+Un6ZZTUehZ6J1Zj67o8SM2nX2C3+jnt9pFFRheGLAKtQa7LfYhFokx3UTTioRBwNQc2zU7al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933499; c=relaxed/simple;
	bh=0sASMMf3hdYMOoWJgOc7ZaOQV4MEaeOmZCKjZhVqGRo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOIIARTXEaP3VKlLJiFfh+EGvTkUVDYlNmmM/uEd8VNR+KyKFZYhfgqNLF1q1a3cTIVQpYQ60Is17zNGRD4BofpO88hl1P7sHz0OYqdp/zcILG1iMrRRVeGq5oyVnVKqZ2WUxtHVCCUxzVRdcDudad3GFFfCGG4SYvEr/8okXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhiuphjA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhiuphjA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23fe98c50daso36869045ad.3
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933497; x=1755538297; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2qfuFeHIs9pZcvOOidK5ttDb4kIntPZhb9KYt5G2e4=;
        b=AhiuphjAWYB89WoIMUItPFB29+rl4/fQhO1KhyE+PT9QOur/K67UR8pQ5lfG/zhk+Z
         b4lM/EfhKX+hKeLVy8GL0DpoveCeafmVZWRHBdgboD2DWpkxo3NSm2cztoP7d96obsu+
         nzeroqkIL1LGpiJSxmoBH3G7++cZY1fVrl9gTH1+raimjeJe9sXwF8dNd7MVdsBvSw3g
         LFL52kei5ZiSXfXcbPXQ8QmMZUzY2j/C8OllWFbImVTiSDG4JXyL4zxPyiXfzR/Mts2h
         hQuh4RQVlO4/8Nm7hhwvEJlMyE3c4on7mxCqMaO8vgjPZyRwkY/j2O3ZRUSnKSI/mI9s
         O5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933497; x=1755538297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2qfuFeHIs9pZcvOOidK5ttDb4kIntPZhb9KYt5G2e4=;
        b=JckrRo4V0b2M0VN1tFB0LgtGJiRq+7WfuKupAYm2bK4MuWjwYmSi+VzERjDoFuehMu
         g6RQ3Mae7j8ejO23SzJpoakiJgVBXutffjng/VXJm20g2Fv6qrkHxQ9wEKhYqnuYclMx
         NAH1b/kuloaT8zS/yTmNBtNflARsFijLlipUoa0RIIuqbRIrZdVFIsjCOuvLx9wnNlGl
         K0pYsiw/VmUQL8hQri5PeLQWwdbFB+U68WY6+pBdMHrzqgFhGKgRJATeB6ZYzuJGPJDQ
         IrRgIbKea5WOHdTNy/ZRI7ZD16RkV1CsWljIvdfDiunmqOQodrlKfnnbKSa1zNJOS0JA
         Oukg==
X-Forwarded-Encrypted: i=1; AJvYcCV7XjmfXpqOzgjGbPuWjwM7aoSoFawVd9TPhF+h0kcc8/8m+/IbOzYiKBH1aWr1IwVrKalttA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7fvNd+oeH43v3ZqCeXs0jvWFVTU8jlVSh4Oz+w2hACY1VuKOt
	E+Wg1TDNQOciuhWSLjv5hlozXOTFRRQgGq4PxfHjMhU6PQ5srrt9MlfUOc7OC8dh6exVj2n+56L
	EDk5ugw==
X-Google-Smtp-Source: AGHT+IFCL/e8m3EpZsorqhDOQWgbVKsvSbTHCyrTvZCPhbJX57+yQJEYtdDdTVRR3b+15GDZLagPnHJ4FnA=
X-Received: from pja13.prod.google.com ([2002:a17:90b:548d:b0:321:abeb:1d8a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a23:b0:23f:c945:6081
 with SMTP id d9443c01a7336-242fc31aeefmr6642605ad.31.1754933496988; Mon, 11
 Aug 2025 10:31:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:32 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-5-kuniyu@google.com>
Subject: [PATCH v2 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for
 memcg failure with SK_MEM_RECV.
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

Initially, trace_sock_exceed_buf_limit() was invoked when
__sk_mem_raise_allocated() failed due to the memcg limit or the
global limit.

However, commit d6f19938eb031 ("net: expose sk wmem in
sock_exceed_buf_limit tracepoint") somehow suppressed the event
only when memcg failed to charge for SK_MEM_RECV, although the
memcg failure for SK_MEM_SEND still triggers the event.

Let's restore the event for SK_MEM_RECV.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce63..380bc1aa6982 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3354,8 +3354,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		}
 	}
 
-	if (kind == SK_MEM_SEND || (kind == SK_MEM_RECV && charged))
-		trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
+	trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
 
 	sk_memory_allocated_sub(sk, amt);
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog

