Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44A2500DF
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202160; cv=none; b=JOz2lD8/CSOmfV1ThNgIuE725ErNDlU/j0T0lCwSH52HRplkn+rIO2wbE5POEUbf0oDKIH7bRCNX4iB2MAnob0thwkmL33SIW84YGQJn/m5tl9/BB820taFuRwv3nSfdCnV6kLSGqwxs/YmAAeTeUVfIxKewDW6YTmKGekH4g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202160; c=relaxed/simple;
	bh=XyVZJFZzKfSSIkf/pvmLmwKjraQN8W4KgjzemH/XGU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+Hn3YDGT/XRpwhpMSUQSA5YMF9N8M3H+DN4x/suH1gZhIoGZDjlJX5qhmklqs0ZpuPn6HX6HTIFsgEBPQTOiziPwuZVednni4w6x8K9SKxA+L/k0vWmGEufVa62R/RK0Qh5dXWE8i6pd3MjDVHc2wdkHdpkzA+yHiSZhdn2uL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhMlBfnl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhMlBfnl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266b41f5so2682285a91.0
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202158; x=1755806958; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=EhMlBfnlLM4d5XBz+lLiawNUniVMZ3TLPGPxt2BiQuimU0ST138O7VPRUR+elCLC3h
         DKMFXGbdGVbFvpyr7C1hfThW/CfEtR/X5a4ki6vzzIsYgyhCE7wNpxssDBxN1wuwbRzX
         NbQn3EDBH36ijHaYzkYHkeauoyEkBc+gIMoZtlwKYNuCl3MC0kOcSJUsdyLEM777XSRB
         LXIS+YGF3b5BUgi5KoBjlJ6eVBh9SNPNMOhlTXQBCXho75Q+ghxdKUGURYTBpyqKLlX8
         2aEZQ4DVmVONL9IYXmv5L52lTYdX3/1ayPMxT+gk+ceKDysDavY3/yQajDCgD20+HZOU
         iEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202158; x=1755806958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ4QavREfrxYYp51rWZ/EL+zSiE81x3iM7eRADON/+o=;
        b=ECGL35H5jxsfTHBigA2FhYlkf1PrmZeKcQWWZEA71TkxkygiSzCTfe1EVx8ej73VRJ
         P8UHqmEBvl5LBevXsslYamBLNq8wLUPbzns1xAuDjlUJl0bMmSQUia6YJMv4VAicOEPx
         Q3UJq66rm9iL1+VZ3AyAYROqKgqad6lY0nh9zDeeOosNOkvqYpstY7ZLEN0CZhwK08ke
         yBmrABplvh/xEyGb/Du43O4CopDX8/dcrh8biw5xAUa5KtWg5vEk6sF5NYt60QMDiWwZ
         rKeNw1Uhh8VA7I2BZG2VXHhqA050UYzxJezT0vBYqWTifIZxp6f3GiugFCrtiF1/688D
         0PSw==
X-Forwarded-Encrypted: i=1; AJvYcCXJu9APA4ecg6Slwsl82ciwcYzu85rdQYcaLCBEAKUS33jgm3tInf4w4HX+uTCDXHB2J+ygbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ552sWf25jzhk56ojMrUeDEHF6xMwWh+9faLNYkKMR5mgwJrd
	7qGGKP+fOmObCC+VJ8yJvwsK8NuJ84RK6olwSMYBmjHEtpNp1rhqMIN8y2LakPfU0fUo5T83KnK
	aJDSaCA==
X-Google-Smtp-Source: AGHT+IHJqj8OCBO957elyCb7Tb9EvqaiAKT/a7fghGIK2eeAw95lJXxXFobtfukkiYu1/mXizBdvqnwNOyA=
X-Received: from pjbqb16.prod.google.com ([2002:a17:90b:2810:b0:321:c300:9aac])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0e:b0:31f:16ee:5dcc
 with SMTP id 98e67ed59e1d1-323279cec2fmr7690481a91.14.1755202157953; Thu, 14
 Aug 2025 13:09:17 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:34 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-3-kuniyu@google.com>
Subject: [PATCH v4 net-next 02/10] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
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
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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
2.51.0.rc1.163.g2494970778-goog

