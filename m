Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8D2FF140
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021541; cv=none; b=l8PdycYFrePZOoySvO5EvtF+h74UQbrcd13wVhiVsP6ATbZuzjGkDL1mTIZiBSqwzjjB+h38OzT6SWGnXEvGShWieVBO8C4rXbJ8Q/D3fTavSbk5kvWZX4tl5bfo+Q2XGDx+eW04ULwtUZRvWljrk9YQhj2k4lECPfwvZjDDRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021541; c=relaxed/simple;
	bh=gUdtY93TVXd8U7THwQpainuRObH4njplELc5maxDEW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pl5vVNoLljaUOmoPxCoWeQAydcDoGoSJvNZNzD3TvC3SohT8PLAWMgweO//cCbxgy+838GaRPJiO8ROQm2R0h3yLAXUhP6fOxywq4IrzmRqGNm8WroR+LbDTt4/U6CNMigBvBbb+uKHbPLLWKTxgc9P9Wa05pWnM4yskL+Flrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSelYudz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSelYudz"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bf8e79828so10966342b3a.3
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021538; x=1755626338; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBs0EYqfbWl9UFV+H52iOxDMUVB4Qqo6amOw5/a/xOY=;
        b=kSelYudzuYmGdHgqM/LC57zkX90reQMdbmILUXGpgrFqB/ISCPYeFwb4mMio9dQpOF
         vCJXMb0Q9SlHQnzuAAkK36JnHLrNZy7raB8s8eDAqNC/ZikX81d+JNjNxfQ4A+8NkYdg
         Uoa0AH22xBowicrMwP+XWlsAFfXQjrcSkdfiW7LDzPOpBpuqrgpS/8QxyXSqo4A1WDtt
         kElf9+0myBMPxVV/2B3cI6aTXsBLVCjJ2hpqzGD0kWrzrJFrkCSFbcBYH4jqQYJqqH/G
         ZaHfqhZgdbX6B2ZrjCYGGH5zpJwxSMIr1gSNQsFiwL2sj6DAibUcUCQfI6CgZdMBBQNI
         cVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021538; x=1755626338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBs0EYqfbWl9UFV+H52iOxDMUVB4Qqo6amOw5/a/xOY=;
        b=DtRrIP9p+ZpI7lsmhUZy8YkfGU5Q/FaU6tncg03SdpNNA7LEBSnZaxpD/rF+DdmISG
         PAoH2CQ8TeMURm80GsS3T9riwTmVB2T7DA1/kbimhd/Qq++nviUNgY7QsBdxjgagYElZ
         1m7Cs+6yMnug3/t+Gt5qNDnvivxqq4aYOGNLBkHNaGbpsCGxaXO5vpDt7bP7V5p6ef+X
         l0mT/tCRngwbaRfDcBoZDYnYz2O1QOumw0y0IHVgadU/CxqN9G+7y0EEER5poT91Qar2
         cL0mxPmGF19+p6EDyIYEa0pel74UMVtwoY/KMZul6kiZ0jyPDScuoNYJmYiz0y5+tMWa
         QXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEJ1jw93ozWzH+D5fae/mKsA8GfkrxFTe30yUzLGhbLQEwAXjyvdcBMMf7uOLJW6CcW9pWRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZDNTqVNDNUva1nXEdAIrM+nyp01LQZsBzD5RPmLkJ7EOMMmtO
	EaQp9YEnxDKDDgjL6QIKBxqbjiMUrZwE5LNvgcYLfJX+uVVDQTOZ9IzJF5ywpElrytHDIVj64cF
	XDKZjkw==
X-Google-Smtp-Source: AGHT+IFYsGjbaobi8vNz9wbDh44fnvU9qpjmhcBJj3ep2W5xNnuwjJPdvlexzH+8pKUpV2yp3JlpFVyM3a8=
X-Received: from pfblu20.prod.google.com ([2002:a05:6a00:7494:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9985:b0:23d:d612:3dfa
 with SMTP id adf61e73a8af0-240a8bc1fe5mr267608637.40.1755021538144; Tue, 12
 Aug 2025 10:58:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:20 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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
2.51.0.rc0.205.g4a044479a3-goog

