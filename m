Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03FD2571B3
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202163; cv=none; b=USAnmLwmaV3Ri2LON4jx10to4+KzS9Dc08kOYkg6CnbUjsCgQEPvQrNRPIqSGNXoANsiDI8Hi5OFhKa2fsscUbaWLKLit7UcHJOKhcZesWr8/7+LjuyUzJCcg5AOypXRiBKwCS2qOc5K1D2S67B56zNGMSXwDmRbu8MKEfnBaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202163; c=relaxed/simple;
	bh=Vk6bFDmVR0eydWLS78TqNF3dMof+YgbdfAs4lP1WhE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j02SPKlUacsyAwD+4YajjDr2lIw8CzTMwh9ltFL+6rPGQCnJv72OOwPGZJqjp6M09MSacW/r1bUSO0OfMpoE1XhKd9ZeDGhci33hClhsz45otSG+MJHEBzQObkGop5utQwjRCHzpsHgXWfsIBZ6+P/quQrHaLgaRYTRnl2ih40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyo0IZJl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyo0IZJl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457efb475so15483495ad.0
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202161; x=1755806961; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=vyo0IZJl+Cwo6hUwZqq0Do4efOu29G6wyVyYSzLoJr7WC3fVGN9q0LRovAsegDvy+q
         pLVnWkp0tk2Fm46PTO+GfJ00T4qk14a8Ok1YeW8Z5pOTI+UYFrGM9ap9LWTFeDq9vMMJ
         /re4T06L3oTquax08Yq3jajgMuuV5LWXMnod6c44Xj8pUBjxtZBbZ0ekYgxGlugeJ4HM
         1+AGfObqPFQZUkpDZHCmN2rPG2flkzDs8tbtvaTVSetNEHcO/Myd6tqkOKNaXgHWiaxB
         w292eEhK5xVCdpsL81aavJl2PDOgrVN3BGUQnjPhUZzuKDJSCl4Z1N5CnDhwNknPyRxO
         6W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202161; x=1755806961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=DkszQ0fP5FXN8fuR6DMc1lS2SiZZ0pjezyx3McCXVK9mYelBS5YOn6WjJLTYlGfSC4
         mVrdsd/LaG/yjnpFcg3wMAe5gpsQrOnY37lIF5K2hYSqDlE3uZXdf9CVSaC3+SCdkN0u
         LJt0RTIKHdW+TOChTQuTwRLF7kxAikOoS335TE7cu/wRDvaOQICJRNqWttZlDTYYltWm
         C+YfCXO5gxETRfGj7YkvNftmgBIXPzvCo6AKXyGOypdedN214A4I2v46Tn+fJmgjtC7s
         5AttgqF8yp41ZKgBGNZi9jb5VdlvwaIrZtQPzmYwJ23/3UIKvTHRSOUNsbkMExVKJuJC
         idRA==
X-Forwarded-Encrypted: i=1; AJvYcCX6kc0h6LBZuVfuVGrVkFKgCB+5OLAtECrn6KqvlvshqqMggJP39qMV/K1FGdfnmMZANLZCaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTFQObeaUV/r8ViqMmbgiPpACMQUJB+kPQvMiuvU7PltSdMWGp
	Sk5LA7HZ9FaFvX+SySI53QZW+6OfOZcf41FjfrGog8B3LetjglWofiLODHLo60HUJUHa8UP5FDL
	7A9+0pg==
X-Google-Smtp-Source: AGHT+IFZG58mv+xFex5I3IvbaYDViC565d/Zaj2y0+6TxgO46lJTn88mwWlXmxsJcHxyM0rDApPblLTIl7c=
X-Received: from pjbpl10.prod.google.com ([2002:a17:90b:268a:b0:321:370d:cae5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:240:92cc:8fcf
 with SMTP id d9443c01a7336-24458b58443mr83319395ad.49.1755202160983; Thu, 14
 Aug 2025 13:09:20 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:36 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-5-kuniyu@google.com>
Subject: [PATCH v4 net-next 04/10] net: Call trace_sock_exceed_buf_limit() for
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
2.51.0.rc1.163.g2494970778-goog

