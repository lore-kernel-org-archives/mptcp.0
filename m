Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399432FF165
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021543; cv=none; b=R4chdehmyP3xfD08rToDL2ywC4j4iTqMNflm8UR4a+mGSLCtmwcbeiz8Q+uvRtMIR+P06F4ujiJaomEkaI/RQLunp0q2Y63U5mit67b/z+6J6m8AK9/j0Qrv5hxS0qaxWGZkvjGRpn2QvNPOMggSV2NAUE6n1/Lvj4opGv/Dg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021543; c=relaxed/simple;
	bh=SLf5TpKyjI/drORtpadj8vr2WiPeiiJ9tj+Tj+3jSoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k0koEtQMmv2Dc/KGyfzOGEdoTxH4jw+hMpaHpmw3qF8DMvIwJboJmndG0/juvbRvO5Yy2/kgdL2SKemkYR4fbz7yhymnjKsfWBSBa0kBKdJpYRghTUSNI+VmO5Suvhmcv6kO1jJx4fkaJ6CFjHL27n6T14kDu3Jymo+k9L9/X9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZbcpFF4G; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZbcpFF4G"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bf7375f8dso5187168b3a.3
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021541; x=1755626341; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc3v5O63MgSThFhi2UQQb6roBFqZjuJWPv2BdHmfVp4=;
        b=ZbcpFF4GHHC9p+XTLyR/weDJe4r+K7EE+EF02Ufz1IgOVqG9U66jY4fbGakmxLrQle
         MIng0YIyR2W3j/fw9f3hXZVmQ97/k8rV+DRf4Z2uFWAU7iCGXv7Ql97ckuzXf+DpnYCI
         4VEa/kdczYBQK8jIqzvVdaJRiPet/3sQgHWGRufzPGaZGYA00CfM6zRCDCZos+a0myMP
         TuGnw+2nv0mw8TeeowEGr4SfyKPLIle3qqJmt43n9ntEIlCTwKVX3DKQ4b15Q7gk93uA
         xnQT5UzqPC7KVkuhPBVatGk9Ug8D1rSkcUT+MzorH6M4uAX2ufj5pDAXh6qlb1wLW/rq
         EOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021541; x=1755626341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc3v5O63MgSThFhi2UQQb6roBFqZjuJWPv2BdHmfVp4=;
        b=oCR/+G85vKMLbQGnEsA5+dgRO8OCtug4vy34Vp+XwOLygblrh0vv75LK0BTKTc/X/D
         ktnta5/Z7/lYZIXl02zpBZdvf7Nj/YXSJ1cailLycGIjcSTgQl5NE8OfoTqHPVxfR+Tg
         +astMo6odKdLD1feAzLoTfG0qGKwf1HF6KPpfVjeJPFTDkwfAp0pH+G0VySsBSrjg/rf
         EuhLAtcH4IM1Oh1zCr033XFHX+mQpRgjRYxLQ/tfeSNxOXibCO1A69P/yK/C/rl8Y7FS
         Hk5sYNoAv9dO4ENqlTVsBG8cbDK+zJwEItNnTaNfyN8EIg9BpQhG0wNWcbSjahvEBc1P
         ZhSg==
X-Forwarded-Encrypted: i=1; AJvYcCUHdjQ6ReVGgAP9+a5fAMegpp57nn6EwwzcCFeglIaqdCIxnwT7cOF/KxQ8ftHH3esQCNUTRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5cuMP+VnE3BCfomAVUOLBbY4Jw26uAmsQ4957LHgOf4nkWTfY
	Wp+AsFBbsunrBFELnVz0vzcJqC7kgPKWEpBOzUOYAS8WWY/x8Wn2NfmFa/5Li08Kg9d2SBLgj9E
	yGNm3oA==
X-Google-Smtp-Source: AGHT+IHNkeTr1IXEx4pv8zbKdsHdKo0sVR+9B+i4vxPeQfrBSyN50QT97gh1gKgnaZexsZ6oSyAsjRSzwYM=
X-Received: from pfbko17.prod.google.com ([2002:a05:6a00:4611:b0:749:1e51:d39a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12c2:b0:230:69f1:620a
 with SMTP id adf61e73a8af0-240a8ba6504mr218627637.42.1755021541287; Tue, 12
 Aug 2025 10:59:01 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:22 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-5-kuniyu@google.com>
Subject: [PATCH v3 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for
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
2.51.0.rc0.205.g4a044479a3-goog

