Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65090208AD
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199068; cv=none; b=aUK6AmaJdZ6RC0z0+vXp1B40PTog3dY17gIO8seKCez8Xxo1KmZFyZ2GVMrZATOmJ5VjWKJV/diCww5U7/Jy5oFtksuFlIKw0IRm/WK02iclywFuXRfXkHUPa9TM+BzjN1xr0tVw1J8MYcGycwvX2oSobm+zTGsRAI8LIpFb8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199068; c=relaxed/simple;
	bh=awEaZbjxkFozeRm37/KeFdBbp4mPVN49NJTeUmccMIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hb5dl1JsYMhlBBdpvsfc/nhZTyjja/IOyk6rq2bzLoOXqC/p7/MmQdWDkpYDMMK8cIBocVzjlZIMtDjFMXk7+xuSOwdN7anR7w33o6XI3RBA0uTdvztK44FAkXvmDWDQMZ4IInNWsaIJ3pK0gqNH/lMcwgieJpTMJk+0TGgegHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2C7Y0XD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2C7Y0XD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so1751381a12.1
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755199067; x=1755803867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZza0Qr24kX4zeRfch0J1JO+Vr53b7hyjzL3yynCoQA=;
        b=k2C7Y0XDkig2Gz9khasOeClZNgESKq97NIn/NMjExkoMhtCeHc7RUBW/WAM1HUGWwI
         gNchhu4BhsLeHT/O1TxoOr4hMrtVDnWJmPOyLM2t04iqrBcHGCFBi9AkODUqHyWCr6ar
         oSgxIRXntoZuUgYkrzQCokLjgHqe1Zbw/ngiekZvxFNC1vLexojSTOYeljBZBs49ZYB3
         c8tuGkm+6taI7uGwPxafH8DeiDvTVftcfSKFGgFVv/pcFd0ZZxyd3gV5M9YN29nBkdsn
         t7ecCVfORo1c0Mp6i6Y4PyyWzEBopWhzppe8F7B/GEY0czgJ9+Tn3QTc8ph+WFvDYo7h
         dqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755199067; x=1755803867;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZza0Qr24kX4zeRfch0J1JO+Vr53b7hyjzL3yynCoQA=;
        b=D+I7mq09NlIV4LmoHDLqhaxAs6Ycf+xw1tJKWsIcfabuTnSR1RYZMdKF1Yom4EEcK3
         +sRqYf1eTZQIfY8D3CE37nsX28a6j3Wn31g6Vyx9juAey1ljFV5fTJTognTpceKLezyC
         zt+hoNGrzP6A8KfURojkTu6duL+maWXFL5q1C3MYEReGLWRLvPdlCP06i439aVWRx8Z7
         mdTwRB28egNTGbwNIQQj5bT50EXhsc7buzvFYlI1mfXFLb8b1WN1IyObymB+5Ig4lJO6
         9fZwWirIbqXDd8W1Du/HilrQsvNQ9WctBUHvGhAvaUCruxqskX+RQScFGA/GBjxSITss
         AkBw==
X-Forwarded-Encrypted: i=1; AJvYcCW/1oX43TpLAEL4u1O28OfclrlFkosl2BcbWgE10gc7toRfWCAWxcGo3ygzEOEUad/085kC/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNz9NUBWzAqjv1omlqL15Bf1weZfWnfzgk66s/lt8YtVzFeDMq
	FpjihbSSENKepTa6ncpUVISMaEZEiGDzhkzk/NzAZf3WsZKYOKrugZN0mud36ry8KEuNEoSVZsg
	WpkdDMQ==
X-Google-Smtp-Source: AGHT+IF8M48EbLNDh3PUuZR9X+h4b9X+7Ma3XKAwBjlInmKrGPQbmdm3UVCpaMvvU/zhWWLLunWDR1msQ18=
X-Received: from pfbdf9.prod.google.com ([2002:a05:6a00:4709:b0:76e:26c9:b2a9])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a8:b0:23d:d9dd:8e4f
 with SMTP id adf61e73a8af0-240bd238d7dmr6038674637.28.1755199066655; Thu, 14
 Aug 2025 12:17:46 -0700 (PDT)
Date: Thu, 14 Aug 2025 19:17:41 +0000
In-Reply-To: <ukfrq6ybrbb2yds5duyj2ms6i7xgssjsywzgknxctfgkpzupor@tjxbuiil5ptt>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <ukfrq6ybrbb2yds5duyj2ms6i7xgssjsywzgknxctfgkpzupor@tjxbuiil5ptt>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250814191745.853134-1-kuniyu@google.com>
Subject: Re: [PATCH v3 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: mkoutny@suse.com
Cc: akpm@linux-foundation.org, almasrymina@google.com, cgroups@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	hannes@cmpxchg.org, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@google.com, linux-mm@kvack.org, martineau@kernel.org, 
	matttbe@kernel.org, mhocko@kernel.org, mptcp@lists.linux.dev, 
	muchun.song@linux.dev, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	tj@kernel.org, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Date: Thu, 14 Aug 2025 14:30:05 +0200
> Hello.
>=20
> On Tue, Aug 12, 2025 at 05:58:19PM +0000, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> > sk->sk_memcg based on the current task.
> >=20
> > MPTCP subflow socket creation is triggered from userspace or
> > an in-kernel worker.
>=20
> I somewhat remembered
> d752a4986532c ("net: memcg: late association of sock to memcg")
>=20
> but IIUC this MPTCP codepath, the socket would never be visible to
> userspace nor manipulated from a proper process context, so there is no
> option to defer the association in similar fashion, correct?
>=20
> Then, I wonder whether this isn't a scenario for
> 	o =3D set_active_memcg(sk->sk_memcg);
> 	newsk =3D  sk_alloc();
> 	...
> 	set_active_memcg(o);
>=20
> i.e. utilize the existing remote charging infra instead of introducing
> specific mem_cgroup_sk_inherit() helper.

Sounds good to me.  sock_create_kern() is much larger than
other set_active_memcg() users, most of which just wrap simple
alloc() functions, but probably that's okay.

I'll use this in the next version.

Thanks!

---8<---
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
---8<---
