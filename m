Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AB23F294
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130195; cv=none; b=lGqsVmteA+gACrrMB8T2oTn/G51Qdf42ZtbiIODqEk3prb0Lk2VgzVBvvUtTQ0mocUzb1DI3hN8k6otMpJIHFpFeBtGOelQcC6nzJmWawwtpsh6kZot9h2rMb4p1T061Ag47lT49UAroUCxjn0IoPQFQasW9cvNFqUPfckIG/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130195; c=relaxed/simple;
	bh=7GYx0gT7yKuvyKvrpKME7Js52yeuvXmMr+g6Ow0vwcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HkeurCp5RtJ63vrFsu8VMk6KxMH6cklRB0vjKM7JHAruz5uO9377uo/4FFNEIMfjw5zXzycrRCu7Y3nI9u1fHBetYrBTt5Ch/QlwDwNaHKcBYHbWqn2SUqEDsPuKnkDJUMf3fi5lu6Zhwzek1cxPMkt4kWxRx5YGbMawis1+DHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SD4AqN2t; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SD4AqN2t"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756a4884dfcso4489838b3a.3
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130193; x=1753734993; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYUyNgMVCCaofoOHBPPUoPupTfXzfLB6/aiuX2w18Mw=;
        b=SD4AqN2tC3MSVhV2xpW41HIU3w8GBzs6dhzTpASycksIkCt1+4UVQYT63muT8qF6BW
         atOz1T5XslGGx0w+NUdkJfbWEF+MJIdgKeeL954mTHkkNUaHASGmgckAcVXxlMJ89VMd
         cK2FTkmP6hAbQxW6hHEfDV0m2XYQzWXur1SuOeuCFlFvpm7e4Lf9LxXwylCgnq+buyGJ
         vFEQ84nwQUnJHvTST1lQbeeNGkixzHtQrkxQhAgTggeeG8Q1p+r9unp3d/oAjJdDzrN2
         /3HWfd12xg4R89l/ZzOn2qx0cRD0EZwJtXFso3VCh5F+o0Pywm39KgWGoYvBOtEoRWGX
         kgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130193; x=1753734993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYUyNgMVCCaofoOHBPPUoPupTfXzfLB6/aiuX2w18Mw=;
        b=e6djSRuWCDx7yDiENDNlvwiU4oUczyIN9t65whnhFBUH+IrxkSoaWjBiDGFRnMwKfX
         SF3KBTlqn25CxCIVS314np95NLjXfec6twEwahcPuVjPemvmpnoYE6+1LTeRaZu6RCXS
         H967PB7laS1zzfIm1Hqtp5NwREmcpf7FmCwcKzCwuKn+CSWMNQYsBZmZs/oB0zI436kC
         SGppq1lMIin12nDSEKxHY9fmucawOSl9rnjv7xEAHJzfIcGSQFQ1CX7T7rZTKB26vuSK
         EheXFnlNNZR4Zv1t8zVS9mwseMJSlmCHI2ypxrjSGRGgOd9/RFHwTd/xAvNuRTaeR1Py
         IJJw==
X-Forwarded-Encrypted: i=1; AJvYcCV47nkH6yFOj3WRphcvRzdJIfkami4VX7/GojvphrGbYNjqIOKbimUtWsn3CYQ7l297ghWjWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0pbOmPrDsu/gZXECgpo9LQczbJP+21wIBDn++fsF+dkccgrH9
	AkMh0OrwiwN0fQwnHgPYREksEF2YxZsz52KuAH9UF/sjs7DPnrwdlriLWe8MgOsZx+rY57hizwK
	7da+1OA==
X-Google-Smtp-Source: AGHT+IGmJf5+70mstVkzYNSRFS4u46asIcv4vmF3QPlJsewm8h4FN3p0mxWoexnQlkXY7f0461xV86Ew6Co=
X-Received: from pgll188.prod.google.com ([2002:a63:25c5:0:b0:b2c:35e1:f278])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62c1:b0:216:1476:f5c
 with SMTP id adf61e73a8af0-23812b50d6cmr36295824637.25.1753130193273; Mon, 21
 Jul 2025 13:36:33 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:23 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/13] net: Call trace_sock_exceed_buf_limit() for
 memcg failure with SK_MEM_RECV.
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

Initially, trace_sock_exceed_buf_limit() was invoked when
__sk_mem_raise_allocated() failed due to the memcg limit or the
global limit.

However, commit d6f19938eb031 ("net: expose sk wmem in
sock_exceed_buf_limit tracepoint") somehow suppressed the event
only when memcg failed to charge for SK_MEM_RECV, although the
memcg failure for SK_MEM_SEND still triggers the event.

Let's restore the event for SK_MEM_RECV.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7c26ec8dce630..380bc1aa69829 100644
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
2.50.0.727.gbf7dc18ff4-goog

