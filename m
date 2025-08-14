Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8582580F9
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202164; cv=none; b=apTGn21RcqoepndipPD5ewzXTPRsTkiT4GzGqnB0Y6w6r3KWa3GQxsCsuHU776PTi08FthzmJy8+kUugjM5Pxwy0gsvFTuyP1ewrkJHVl5RIFhAl+/1oeJ5+F7Vztu0KkSguxt+B3IjrkFvoyyb4EyZKqkzUAbUkgh2xsLuoXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202164; c=relaxed/simple;
	bh=49AUVqRZ9QX0gApoGVu2lLYolROcKxAhbfDoW1MZFwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ksNnaDKU48cTTky3fYxtAofOg3qh807TQCsG7UK0sBLDbBgqHESy3+LSyG3QA2Q7EpzWlrWFZQsg1zZkLQGhMt6XKhodBjl8nHk5usd/c/LcF7Q4Lx3BNR3/Po2o+2vyS2/jWKbsFMtf2k1thUDPrpJV1YBNQA3Ucw5ux7RBFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeUpD7xA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeUpD7xA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e2506aso1343980a91.3
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202162; x=1755806962; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=HeUpD7xAvujZv8a9EuNYulugW1qPffbWbEwN5HyrT1hLiTZFT++1sp8oZKXstAXMwD
         yjSS935JsKCXzT/ZptbgGvyy1JEPnXNdUs9LMEzUPpGDoCEhVqSjX4uZVYj/qFCroH9f
         aOOiAcvEkLTqAR886tF2KYdnI/ct1GeEiGFuQZgQMWxS7JoWx4B1TmyexwHqagcSVdZf
         88atdrB5VlTbishZS99fPBoneb3WUn0heC2zHufGHfrRDlPds15TAMViDkWj0lEGpSd5
         4MG5wNruqP74ANdntMZ0MAOtZuE0lUsCmAieTlz57MB5LqL3kTFc1ic7EnAJ7xys/jS7
         ZS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202162; x=1755806962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLtDPiqLV2EwRjVXqP4rO8+jmE13TnvcBQt499JidQE=;
        b=dFE1R+RyvaNAlo1VfwBcPVvo+x4yXjUtlGnafwRC2qvclCs0aUo5yyTfUXgMTyVCWI
         ZzVlDAS0DjsG4jpSL4zz7V6Q+5Mtu5F0uS07tOeVHLd3RbmSresvEfJbReYsDWh7Wa8a
         9r5Ur5+2kQZ/vPTZKJHeP5XLoVPOPyRgFTnP03zyWKUI1pL/z9NE/N5Jolnsj5ORFPRS
         nA/k9kewq7AfKhFhCp/x9gVKNVJyZVkH4CI5nEiE07amukIvraAiZEMhIPx0t64IIQPx
         nn0WCrqzE0TRNPp+00rd/CzkAcY66rkz1vFSPcMh/iDlblpBi2xAcmHJHl8I24clSH5H
         xUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbYD5a9PGvL8ZkrlltFC3+yxKCrEPdZ1Q2IK+yhykAP29L7nw8jLR3Py8JLAyRrFe7uL3W5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzpjbGtT4Xyhbs5n9YswDLk8W/Kml1AdtW6AKMb7ETzf4dxU4C
	AfOvIpUEHAdGnlZqaIY3pM9QW/N4sdiLsUoZ5rVi28q7ThBdkXaKVsrQyzD0N8oIsFOGqoDqyiz
	LL6hFhg==
X-Google-Smtp-Source: AGHT+IEnzVgsHouLcYJ3DbTYMYM7D5PJ04rrOa932tYqe/x5EOD8K/0yHeBrLPiiLhvGRF5AWh06+mbah1w=
X-Received: from pjzz12.prod.google.com ([2002:a17:90b:58ec:b0:321:ab51:e32a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5246:b0:31e:d4e3:4015
 with SMTP id 98e67ed59e1d1-323279a165cmr7184331a91.8.1755202162465; Thu, 14
 Aug 2025 13:09:22 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:37 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-6-kuniyu@google.com>
Subject: [PATCH v4 net-next 05/10] net: Clean up __sk_mem_raise_allocated().
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

In __sk_mem_raise_allocated(), charged is initialised as true due
to the weird condition removed in the previous patch.

It makes the variable unreliable by itself, so we have to check
another variable, memcg, in advance.

Also, we will factorise the common check below for memcg later.

    if (mem_cgroup_sockets_enabled && sk->sk_memcg)

As a prep, let's initialise charged as false and memcg as NULL.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 380bc1aa6982..000940ecf360 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3263,15 +3263,16 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	struct mem_cgroup *memcg = NULL;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
 
-	if (memcg) {
+	if (mem_cgroup_sockets_enabled && sk->sk_memcg) {
+		memcg = sk->sk_memcg;
 		charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge());
 		if (!charged)
 			goto suppress_allocation;
@@ -3358,7 +3359,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg && charged)
+	if (charged)
 		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
-- 
2.51.0.rc1.163.g2494970778-goog

