Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7E2BF3FB
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289060; cv=none; b=DwjXz2Cop3ksUCPVfPeqMXL/HeEEHFLgIV0mv/FO9TaFkGVRyh+3DNq/UYpD3Ee/aRoEDJ8N9Ih0Vk2MFGOKsWM+4RntRQMaKPQ3J5ouUVk7iktpw7iDZNLK3f7NS/JKDeyhiJabaDwiFbc+tJ3ueVSSaKwLsivn9smfGVFR+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289060; c=relaxed/simple;
	bh=kNCka+5/ble2uhxoCvBkpMNTXujkGV/J5QaB+v82p+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GeVXYtyeelC6IGmhX+upN2INyoT6HNN6QHDIRVf9J/Kej2fngThU5iMX7AuTfpm9Sfo0IOVLP/PyvGrIAAXSq8rb8ZgTgz1abHxr98ExNgOZBjrxGX18Oux67wUtL76m6+3tKRn1eoBFciisjP4ztWwfz320FGXsdpfZrgcEhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKZ2yJ2+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKZ2yJ2+"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e8b4ab7so1883570b3a.1
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755289058; x=1755893858; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=kKZ2yJ2+5cpYOF8f7kKJ5E9YA6A4ZihyWCgwMIUqNE8NM+F3LWJO9yP1JbcEqqXDYm
         lOUGio8ICKQ319rlfObeOYjnSJs3VEdwiMdTWtse32udoQfNpNHSC3g9UC9Td3MJ0kxD
         zG+CojfNHCuSrWm5earxh9x0guwfsxHHv2W3v2BX6N6O4cviTNoVTpWOARZDX+X7mabG
         U9FBgI4rDZVkDguo1TOa5jlqUr56LxRTbSWMwjUIXT366sShUZ2Qj24K1+ZVNKFhDhD1
         38Y/WHdvLe3at/uXoHrTyS0BoVAZIj2a+8/lTyKQGywtumlAQ30/Fy9ueh6WWVJCEKty
         WroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755289059; x=1755893859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wKL4ZYGX/K8WXuwlgtNOGDh1yxD4Vkofr7n0sxP5Do=;
        b=B/nN37i5H67XNIjkWToKrQb426YndpmybYQENOlb1oBiBaHk1DqClwTlxSU6rtN9CW
         rjqMfsetpLWtn82IbihrpA3WR4lEtE/d+BXlj7lnLvNlefYanF44xP/zB4MebTGOVa++
         h4qhFoFH90FMKXOtrOgMw+i2SpWFbopQ4sKMzLC3MUyh1yCmxWkYdSTIZ/2MEG0OZ9Cn
         b26iYuatBtiPaWMwkhVUjWgZQLsoGrqtp0JajfwFmey/e14UKbcfCcrJIlqu+/ZO7jfF
         HJGORKl8AstqG30RLZ2IBcllTMiYdptUuymSOlPLW12ToCKTGefEKZHy4iQlvViszvhf
         RdHA==
X-Forwarded-Encrypted: i=1; AJvYcCX4PhGLRuxALntwpXeX+tSpam0hMzYIxL2fxrAmsg3aqgKBDXtHIUw90vUDxLG92QQvYQhn/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxethr2UnJyl1iVQzvtsaMaVUK+1eLPmjkNqdHE6idZz7bymuGa
	VYlXdqze46RpO8pBr/dcYx4A1YJ1NdsAjiMcpLsGq1aXAAtsEZ+vGmBvD56Oigz20LtGBB/hna9
	JJohaow==
X-Google-Smtp-Source: AGHT+IGfFQhxVrC0MRMQ+CGQK5l5v2DySu8ZxAiDgHkcBvf9T0+txoiH03BQJJ5/iyzxBM/IkoVynChoTcY=
X-Received: from pgbdk2.prod.google.com ([2002:a05:6a02:c82:b0:b43:6adc:24d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a1:b0:240:1327:ab3e
 with SMTP id adf61e73a8af0-240e611783amr454188637.9.1755289058544; Fri, 15
 Aug 2025 13:17:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:16:11 +0000
In-Reply-To: <20250815201712.1745332-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250815201712.1745332-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815201712.1745332-4-kuniyu@google.com>
Subject: [PATCH v5 net-next 03/10] tcp: Simplify error path in inet_csk_accept().
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
2.51.0.rc1.163.g2494970778-goog

