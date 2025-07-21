Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924323D2A8
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130192; cv=none; b=G3Jgpmg+TDg6sfSazzbtap5kXl+GOBEzXzB4n3zf1XSbuRwZV8VKyIcM8w12RfuxRbKEjSecpyTrzEPDy4Dzmu9UqAJLFMpd2/iOAU93sWFaK5EBOz4N4rVu4KDuCKfnSdhIAyLFzBlT0PHHfgKRUeIYYsOTOfJnOypo+sTPR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130192; c=relaxed/simple;
	bh=lqqyywnLH34ueK612ieCcIgpjbH8J04q4qB8KlcMhUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWcSg3RnRE2y049A/PMQz4feulNyAxPB6bHWBWiotC8w5AELKEjUVdQESTwYmLdyoks3dufd2u4iKe1tGQDZpyV0OIgcne0yyOOtj9WjLsJTzP3FHO8H615VJSBHVdNKibjKWJOYfCXl9oN17+4JGG3ZTr6x9caYj4m8jZV/ai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oAq+ELV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2oAq+ELV"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f3613e6aso2293642b3a.0
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130190; x=1753734990; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1Ez/xk0myRMpWYi7JwhYCdmsN/iTRwifsr6matvKU=;
        b=2oAq+ELVJn8lbKUyzrRNJN6/JC52OSW7NFPUOLtOW+I9klj+LQJk4714pmTDGnctqX
         ClKaDz5PZkIFEp2J6P1jYLMoNiVLWCXvzSsT5f51g1go21gArM8JA9bD3e685VIoueY3
         41K5cH23pKuCjZsgctDtuX584B7Qsjaeq0ZkKKbrS8cdWQX93jU0nupBZZ8o6HkMRuxr
         0MZExM7xr/lTXqS2e9itIkZQ2wLF6XIm8vBtoap22gNPEMmi7Cjxo7Y92x3d71Xhx1zr
         mcS7Oi3hmmVOgA6hjgZ58F0L+Wyy5T1o1iwBC4omB6fCenYwPc59dLssqqu6vk+CdlnD
         KPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130190; x=1753734990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc1Ez/xk0myRMpWYi7JwhYCdmsN/iTRwifsr6matvKU=;
        b=FVXTbT1CM14yLT3dXuGNMD01nX3FnOvu8srJSg+aXCxOU4LUycBdPY30yqHJpXgwAq
         VVXXiLrpQzf/9HqmXaplGrduZ5nrrHTNE9vfRjRBG091E4OVV6hZerNf3ZdiKKbsAdKj
         g8HC7NK+KiOW74+63LDdlhSNzLA+VoreZrofunQ0xhVjoBLJOnRYMq+6P1zFfYA/4xot
         1cpEQfQHVpEsXk6uPk8wt90ceebAZ73ZWrkhxmvAEqP8GWpwCSzAJ1BY4gbTn2doCjzP
         zxaIg8Kl5YoMkKuJgUWYwGMAATpyCNfWVjfPet7NSgHykad/ee0tO3oqzzHok2WQ9DqP
         jnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoQKWwtU7JiBFm17hQSEZQ8Y2QAaLDTufVSOY28xF6xp2SJN1w3Bz9vrFz9VMpnRo9pozA2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXAXX67kkgCE2SS6KjOu87TsVlxAczFD4T8iJZavPsKql/ETgL
	ahqSi7cFwM1jHHuWrebpghlr6eQhaYZJmTa8AbHbW9NEUHpmVVIB8iGKuxvqZW8UB7hVTtojHWh
	OKQtBpQ==
X-Google-Smtp-Source: AGHT+IGaUy/HgUE6Lp8HLDEGr2kbd1XL7Q/OQ0eUpQ2PrdZCIeYCL6Si0ZJ9Rped6b5KZL3DccuQO15A9BE=
X-Received: from pfbhd9.prod.google.com ([2002:a05:6a00:6589:b0:746:1a7b:a39a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a05:b0:742:aecc:c472
 with SMTP id d2e1a72fcca58-7572266ffdemr27218148b3a.2.1753130190133; Mon, 21
 Jul 2025 13:36:30 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:21 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/13] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6ec245fd2778e..752e8277f2616 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -787,9 +787,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
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
2.50.0.727.gbf7dc18ff4-goog

