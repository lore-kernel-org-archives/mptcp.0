Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F5245021
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202158; cv=none; b=HI1RJGjtSJCA/wSb2oni43P19D4BHzyKVo3/M0bVnEfizxFltb2V7kQfmYJiPiJ43u3tyKN3likmHRoSl0G5rQdluijnz6EzI4b9AW7pNRsWpEuMYt4UsDk1qdiBRkDcbmn95Zmxcl3eGvQZfphhkpn98WvtkA040ZvRgZ6nzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202158; c=relaxed/simple;
	bh=fvAGsFxK8Q6F6blwPxo2ye39EhyRt1qY7ZzQ7uTcLDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3hwYmqo4ySeudMZc6+0OfBnOzRawl+xqxM+CPjeOMuXxA646SOO31DWk6Vq4iFGuhacroBI6LKwjHthwZFVjCOuSnwuqMs5oiTFZjxjO48xxjf4uapPIlcsdx/zUJV+not2LyLUDiiXKNL1EJ4rziZY0xTDHOxC8r5H9iu8bOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piy8Y7tJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piy8Y7tJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458297be0so27084685ad.3
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755202156; x=1755806956; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+lbZziEhh3LGkLKxCxKqhss+KocSzVWnXytm6X5LtU=;
        b=piy8Y7tJ6eFzqOGe772vrJFE6y3m4WxMFbOzAUtj0MeowPXB89gmSIUIEEgu27qzkV
         9XxmGAFb4I6xxoUpZHUv7qIFD3bTno8trhkJikshqyZrSfPLYMllObuTKXd7Hcpbu00y
         n+lH2//YqdaH7BPbO8DmVooCnNhkszbXPb4jyIXpIAhEMiqxy7K4sTcqg/d7T0ALe3t0
         Br2k9UL67LhPe62hVmF2biNdtOhI92FU/hXKMBOBm/b36CkpE9rzkwgcRN6PGdOMoxjs
         2zLduJPACzOeB045p3QdUHb0WU0nGwtzKbvKesx19BH6H0HdmFc54Zg+YaBp7B/rwl1a
         ANnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202156; x=1755806956;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+lbZziEhh3LGkLKxCxKqhss+KocSzVWnXytm6X5LtU=;
        b=fFyErKSBu3YkygD/NndbxcrSpIcxXJEUOEyNzDjqeRzxnSEkI+6n3aXuuaWXXZ8SDZ
         9InsnBE3b412UPb+JJQZyYGftq/rmHzHTP4pW+f702sFm7qUQee7/gUpVUMxoaEBeFRO
         aEXD2X7eWc3+rMSvs7wMKDs6gSdv91O5F5cAiMjM/b4Nkl9NsjJg17c12p3q4ugDd9sh
         gx+N2hI1v9scP3F7BK1q9VeifIpqYbCNb3LO9iKNxl9MVWGuI3wiJFOs2908EOMSfjzU
         S0E0KJFbHqSf6qttD85Q1u9My0XLASphYef+j6xBwlG0djzCO1EG0YffTLsJPkIRJojP
         yRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXq7xxuziRZQ9NW2vwIYJFAivNdEUT/TPVmjr0NswqyWr3Wg1rVeiZqQr0+bSOekMQLx8A1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5RqxXlN6AMq+YhdwCFVjkxlsOkIBvqy/iH8jbioAnVMnmSDmz
	iouf7MxkVF5YFrRzu75SkWhHfm7XmOhGZ9ld3/9mK7UiDRqZwmQSFg9SHqzxAy8VEGQDmSDB1NY
	vIgJSOw==
X-Google-Smtp-Source: AGHT+IHNfSNaLlVBh8qJO1UdhldaL8UMFcUbGeFSWhTNIR6zr5rZyXQBo099O6LvTp4kIOMl2zLxqruoWs8=
X-Received: from pjbtd11.prod.google.com ([2002:a17:90b:544b:b0:31f:2a78:943])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e851:b0:235:ed01:18cd
 with SMTP id d9443c01a7336-2446a3c448emr3523915ad.44.1755202156412; Thu, 14
 Aug 2025 13:09:16 -0700 (PDT)
Date: Thu, 14 Aug 2025 20:08:33 +0000
In-Reply-To: <20250814200912.1040628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814200912.1040628-2-kuniyu@google.com>
Subject: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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
Content-Transfer-Encoding: quoted-printable

When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
sk->sk_memcg based on the current task.

MPTCP subflow socket creation is triggered from userspace or
an in-kernel worker.

In the latter case, sk->sk_memcg is not what we want.  So, we fix
it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().

Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
under #ifdef CONFIG_SOCK_CGROUP_DATA.

The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
correctly.

Let's wrap sock_create_kern() for subflow with set_active_memcg()
using the parent sk->sk_memcg.

Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 mm/memcontrol.c     |  5 ++++-
 net/mptcp/subflow.c | 11 +++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..450862e7fd7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5006,8 +5006,11 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	if (!in_task())
 		return;
=20
+	memcg =3D current->active_memcg;
+
 	rcu_read_lock();
-	memcg =3D mem_cgroup_from_task(current);
+	if (likely(!memcg))
+		memcg =3D mem_cgroup_from_task(current);
 	if (mem_cgroup_is_root(memcg))
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg1_tcpmem_active(me=
mcg))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe88..a4809054ea6c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1717,14 +1717,6 @@ static void mptcp_attach_cgroup(struct sock *parent,=
 struct sock *child)
 	/* only the additional subflows created by kworkers have to be modified *=
/
 	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=3D
 	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-#ifdef CONFIG_MEMCG
-		struct mem_cgroup *memcg =3D parent->sk_memcg;
-
-		mem_cgroup_sk_free(child);
-		if (memcg && css_tryget(&memcg->css))
-			child->sk_memcg =3D memcg;
-#endif /* CONFIG_MEMCG */
-
 		cgroup_sk_free(child_skcd);
 		*child_skcd =3D *parent_skcd;
 		cgroup_sk_clone(child_skcd);
@@ -1757,6 +1749,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsi=
gned short family,
 {
 	struct mptcp_subflow_context *subflow;
 	struct net *net =3D sock_net(sk);
+	struct mem_cgroup *memcg;
 	struct socket *sf;
 	int err;
=20
@@ -1766,7 +1759,9 @@ int mptcp_subflow_create_socket(struct sock *sk, unsi=
gned short family,
 	if (unlikely(!sk->sk_socket))
 		return -EINVAL;
=20
+	memcg =3D set_active_memcg(sk->sk_memcg);
 	err =3D sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP, &sf);
+	set_active_memcg(memcg);
 	if (err)
 		return err;
=20
--=20
2.51.0.rc1.163.g2494970778-goog

