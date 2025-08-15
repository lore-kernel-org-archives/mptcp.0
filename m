Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFE2C0F7F
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289062; cv=none; b=UfsGO8x+3Bc405hL48Ha1q/lBv8fi/n6L4U03EjbjXDTY9kUaYhaYN+vJrMfFtbToNKXfcqJ/QjzHHzC8subEYOYUoZ1QU9TIX5GNIDX+vR0+I3gdYCB5G6MZ3Laz+n4cwcj7oiTIpOrORpELkl6uFtbzAMoL3g3Gd4MSa3MqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289062; c=relaxed/simple;
	bh=Vk6bFDmVR0eydWLS78TqNF3dMof+YgbdfAs4lP1WhE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMP0duxveQ03oLQopUE3/pzGrc/CnwZCi1a9Lru/gmMR5MJnPF6JqnU+0ULzn19KqcffG0nk6HbxtmLdHbbKw9aUEk6WLwpkfCZ9C/BoLEHvux+i2kz9Dv9lpZnEdloHh5V3TqX8PS9ZwELpucDqql/jhr9iQ6DJpOsUF+K7lpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcc9Do0V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcc9Do0V"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4716fb2508so1769564a12.0
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289060; x=1755893860; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=dcc9Do0VTHmrfCOn8t/ytm9+Gy7I3foKqNoZ03rUygaIF5ZsY5hqUqZ+kZ+Ex6rwLd
         2B38hZ1caNcG6VM1t9bNtkPy83+u2n5aZTpMRiShNnCAM+RY8PBKakfjiGB8OWkmFKQK
         FS+1+sE8tEsy3cUuru8qcHdgObUrXsV4ce7CdlrdOjbFsLIFH8ua2m1jj8xY7oHh4uNj
         0N2ST63BOV6ds3Ed2CgFjDG+gc+WXsW1RW/1YzKySKSsb2/lKOMsGIbd2yj8XTwO3Hmb
         cAiiEsPwSFO7oOb3Uo+jiDeC2iXfKgQwPTOe48EbtPSuOVB563RrgLOd7xj6ejFKb8o0
         O1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289060; x=1755893860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCan40y/zjv6ovcMCtQie3VVVYhwoaYNuUUlLHYJCrc=;
        b=AwgVtvB/R95uVNEIx4SnUM1Qx3Bpb/PgkHLhV7EIlSTvkEKxzMFgM9d3ScOmCI0QYV
         AXDQMSgYwbsIApRaVsStQHopRPZoJMsJRIRjbUD+EJ3Mpd99AkhPY3gj4em3n5z9bhKP
         LbBA1QxWi7dyV0b1wUy/lfco98r9IW6c4PhhIHCOn8h3x9r3O6Bzexscxf+logQcMNY0
         Q2/Q1B7nfhrW4Y19gl0mLp3BhXzCCtVNwAO4ZIbyS7olapECdPvcynZEt+8woh8ZTrDX
         f4QYhvNW3RsHvj9zOh+deezVVg3w4Tj8nmFuQ+dKJnXdcu+PXyobNREhx4qrejl7D/Qd
         FlqA==
X-Forwarded-Encrypted: i=1; AJvYcCUFNkVMlPHA0AGhmzI5mos035nkKj7k+DDNf9pltwQFw89Kahk2Tbw+cquyLigftvxdSQF+6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDc/rt3/IcMib3pw1Np+ZjPcTDLzodiBG4AZeI0oIe3TqEssfS
	VL/Wyb2RSJpBV55pyj1jpTzeGTDZyQWUHkFIVrq8ssjGVg3ghJ75zDRZ4a+4telgGy0eIz6EfrM
	h0EcvBg==
X-Google-Smtp-Source: AGHT+IG+NKmG4fQxWApznT/iNlBlE89VZOBkEiuZXVixRsMQFotYGpJhNutY1IkiTXx8XPjH7buaFadPEzU=
X-Received: from plgo12.prod.google.com ([2002:a17:902:d4cc:b0:23f:f3c5:dfc9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c4:b0:23f:b112:2eaa
 with SMTP id d9443c01a7336-2446d8fe30fmr49723005ad.41.1755289060168; Fri, 15
 Aug 2025 13:17:40 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:12 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-5-kuniyu@google.com>
Subject: [PATCH v5 net-next 04/10] net: Call trace_sock_exceed_buf_limit() for
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

