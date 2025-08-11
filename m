Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A822D480F
	for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933497; cv=none; b=ZgMHAxW26WIAESs9SXLbD0185eBOq0HVvyuo9lT/AImubU36JgPIpTCbFORc6ZyYRSQQTEYU9EQWvZXgXi7xX23+JJwfCUrNcN5jPhCw4QMLXleep4ldrVk6bWRVMTi48cdULsJQejKDvNqnIGkVQgdKd2kAXIL1l666P9qL/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933497; c=relaxed/simple;
	bh=cucv/ThaYCwJefTQd8IcFflX9agEM1pAaEXctYSSzBY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgHfw55Zuel4SZKCymiiNVwxrB8Z2osF/QYPYXLIUPlrG+FuBYZSZaSaM6x0nfCdE+apJjO2yj3zM5B//hH+djFv2O2v+vBYvGLKU0u+QBm4jzhA6bQw5dAhyZCnNNdg5nMc7laTD3kL7eISoF7f9OFF/yz6WR8TTYSCmCm2ZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPra4fGH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPra4fGH"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76c19d1e510so4302227b3a.1
        for <mptcp@lists.linux.dev>; Mon, 11 Aug 2025 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933495; x=1755538295; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbWyNjhRffdizOWiIb7bDk0DH91Nu7zFnwGTY/wxrLs=;
        b=cPra4fGH7brWPVRswYWwCxBJFn9Nib8hdoEk8v2BcE5NpdVyxw0SXO3QDsVbmoIVHQ
         REdVCZVhZd3FIAOQSfa1GcWM35E9vU4ZG4ukt9FwAzdFwHOAU6vMXJCTwJyiQcxftMtH
         ogmbPOc9QfBwT3tbRGMSLSRHb+zi25eLDCJHaQwhnBmLPNFMC/dM3fawscU3Pp50wRpx
         +LP1p+sljlepU9zeGl7m3VDxUnLyLqHkBgySWI7xgOv+FxxOQOseTrAQKHkQj4rDZirR
         4GE9Nuo2zPjzc/5tIxxqOj44B8KJGooX5JEUMgu+XN+bupIjsGB0vFXbKo+AKk/YOmjt
         vArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933495; x=1755538295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbWyNjhRffdizOWiIb7bDk0DH91Nu7zFnwGTY/wxrLs=;
        b=o5Y0a3rRPTySNoSFjZuAGl0UXOSotCocDjRvP7kaK+cigFCiZ6lqynWhVZGaN4aNoh
         e4P0T6IUVB9LTmLYx6bC2u3bKXfYdizMRGpDUhIYUqyNa01bymRux1Peu8v9bO1gTA4h
         B3v6wiHy9MJ5NV5eECAv6NnawaxmMRlTL1rggivS37mndhtOe1WdX9EAAVD2sa3uNIoj
         20zxpnovAiwzUWb5Ci5+zADM92uwq7uGDqt/8t3i2fhrenOjDtW1+1DuxhQboH1bT4jp
         szY5Nf59WiJVucUqIsO1ErItDuQwg4wDE1oGgsWgSyJRodLiCUBs584D6WSgLzrJDOIJ
         7VlA==
X-Forwarded-Encrypted: i=1; AJvYcCXyTGHk2GgpfkpAtH0edG23uPVnFoaxiiDHT41ml07TEZFkApRGUgHxToaBh5Lop3RxtFZWXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuYlTZk/vfh68b+s16NYznWxt8oxqDCSlIFW6eQO5o3Z3eISYC
	SUmT6iuy82EWiI5Iiw65X+oXecmuU9gxter2JkHpCJQb9SfjEJnGmLnUVFqLnqORcEAq11iHjEj
	YBv+0lw==
X-Google-Smtp-Source: AGHT+IHxJ97+AwE076KxPYX/sWcCDY1XqeMHaZ3AGAq4oCcRt8YytBHiFg6jXlxoMu/lw9gst4WNB9FALdI=
X-Received: from pfblh2.prod.google.com ([2002:a05:6a00:7102:b0:76b:8c3c:6179])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b46:b0:76b:f01c:ff08
 with SMTP id d2e1a72fcca58-76e0de2de8emr552627b3a.2.1754933495361; Mon, 11
 Aug 2025 10:31:35 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:31 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/12] tcp: Simplify error path in inet_csk_accept().
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
2.51.0.rc0.155.g4a0f42376b-goog

