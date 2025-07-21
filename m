Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088B23C514
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130193; cv=none; b=DBt0x/C5zlkNNTM9HYOsu9d9Vo2w1s+ClUZpmWzoMFmlB1jBJKAumnVAmuhI04fOwn99geq0EIOE0G/Qqzv8qY4XtVg4swXcm4NGQKGiJsnsH4inDDYzK2bZmioauHMD4uZfqSfeC1gqsNdVeZDx9LxnjooVr2GSMTzkG1YeD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130193; c=relaxed/simple;
	bh=j5N4aCPTqWCMs7i3WRNZ2KVBnmcFjVWd2rdC7aOLvuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TP5F+4BxLK5rQplJwPoAcL+BCHFjwfnspc6FJu8UJgpOFxIP4uJYyhFuFs2ORj/p25wvU6Dk7WNcJMXY/Al31S7A3Da4ew1Bc/bX7rAw4YcdHHcmMpqr+/cjY0PgFd2aTw+/8LNhHnobVEOHnOSmEVpaA67o8HUFg/3FCQbzAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hoGSMrK7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hoGSMrK7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so3949796b3a.3
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130192; x=1753734992; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpwn6QQouhXynO23Cu972bLk01/99pIHsLHoJU/mo78=;
        b=hoGSMrK7dTFMP2MI1nMiFlMYpBVFTX47lni/RtblAirHL5qGlyWuEdWFnCRkbXQqPA
         hEVr7E7eROGrHRyXtNAYfo4v/6Pzl7wQG9LSQlZIWbvCILbyfnlp/ZK8ZFZWz0/7m36z
         MuxpZWV4JKalJVFvusFdneT6BxZwwWOiRcoJyC5o+fwhp4KEmjGU6Ji1n1gVSMEwQ2Rx
         ln44VWhKjBP79Hx/nCetYJGOg12XZG9s/uo3fnxI4zqpMemBDiiOJV8/YpKVx3Ex7/OJ
         dMArnPVWa/Om/kJo7tUyqV3mhdNKYhrFVi/MZ9JPERKi8JEnRd0DBd3Uypv66wyaSd/E
         aTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130192; x=1753734992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpwn6QQouhXynO23Cu972bLk01/99pIHsLHoJU/mo78=;
        b=Ut23lArIE2R+ZZ4BpxdXgEQT3yvYs9VWv9RV7BYS6T/RLHgFEBHYNwFleVa4yUyhsQ
         LTRPCl+ZwxJwOXSCMiKdDddDlxDQSZIO4BMXo94WyIwn1oFPflEEAQa+iNorw0ZqLgJU
         xB+eQs3AD0XzwK0xlo27k9CBn4D/6STaFvRBIYyZe9NKvqU2spnQ/dDvhm+woHEbjAlr
         O2y0hH9XdeTBiBwlF/Q1oZMjzmhzH08yLAb7SXbPLUA8nWhL89Y4krfPeScuJlpXCzJ2
         khPPa5saT40gAzKImScTxbBNostlsJNTW5wOmZYrKsGuCwOZtxA/+APbnpcvjDbc3LI9
         iMow==
X-Forwarded-Encrypted: i=1; AJvYcCXjqcbP9hO5YHiHoPOJfT4Xfr4gIbCJxn08jKHU64200tNKv71r8F4twuQdkT+OdlngECSlDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKiq3pGe2NvGSivWnNEhGe4r5k7smapZDIFY38d+N3M8adjXcN
	hr1aHTvhNUox0/09uRf595bHBpBZp2lcm6bcGwAcI8z0b9/EZZQhlUzE6dK/Z6DCYrclCi1UbiM
	JIXnKPQ==
X-Google-Smtp-Source: AGHT+IGOSqwwC3mh3GOf+Pwdhi6WvfqKoRK+i/P5LIuBAbC+/yAfslPdXIv1OdhrmQiErVu217W2zT+wZxQ=
X-Received: from pfbml3.prod.google.com ([2002:a05:6a00:3d83:b0:748:e00c:4e66])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9f:b0:232:7c7b:1c7b
 with SMTP id adf61e73a8af0-23810d50911mr35590008637.14.1753130191720; Mon, 21
 Jul 2025 13:36:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:22 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/13] tcp: Simplify error path in inet_csk_accept().
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

When an error occurs in inet_csk_accept(), what we should do is
only call release_sock() and set the errno to arg->err.

But the path jumps to another label, which introduces unnecessary
initialisation and tests for newsk.

Let's simplify the error path and remove the redundant NULL
checks for newsk.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/inet_connection_sock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 1e2df51427fed..724bd9ed6cd48 100644
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
2.50.0.727.gbf7dc18ff4-goog

