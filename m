Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE7D182D3
	for <mptcp@lists.linux.dev>; Fri,  1 Aug 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065649; cv=none; b=XGKrsifg7lHLchpvGxTUtcTvQZ2TarHQp7hegx61osHjWfWex31SdfDhGztDULiS34FgSGRJWdv29XFgJeRVS6Vu47j0KsmqqG2ti+BdEuywnpaVDjcBNkMVsWCZcbS13wrdOFdMXwF0neEDclHJ6/ud9XFJps6bV8lSeZXDJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065649; c=relaxed/simple;
	bh=LmwQUupYSQ5c5uv+Wg0TpH9+lHYtlOJKe2aOVLGnTKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIs5JwoTP4P9E9zapZtnP0FD2+jD8iyGACEnuLYS6TxTFcCGBQ9oxxyIKqVmZyJ9mDFvqGQ73xZhFH6SuHzqTehJB8HcF5W+L1IIC192kXc8Jslpbm/Sq/yvHwMpKC08nI+HvyG8ZjVlUvTgtoZoglWNEmay/qhFGXP2Ks94kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTVH8tFB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTVH8tFB"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so1912370a12.2
        for <mptcp@lists.linux.dev>; Fri, 01 Aug 2025 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754065647; x=1754670447; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPlDNUMymhsODNFmsd1JRKJrfbGJJsVHVjtAtmZ8nro=;
        b=dTVH8tFBIYdLDBEQDvhLnGjkC6CNG4CUdd+gh/zL1P/0tcX1xAdoR0ybq0LIIdxGMq
         L3aMW1xcx35DgsjDBxojmPsXWqSL4/uGrffjRbpFDVw7EZY15Z3yBUPO4jljEsc7fKKW
         hjavDXn5XhkAZxMrKh6LodgtQL/20kukYdNAiBqX+uP2I/BZaPlFxhEcp85E1gt8JBIp
         WjDjaGGUdwsfOZOnZzV6OapK8TlNFtieiMF4E4Xusx3DQOvSHYC4Synl5pOpwnqZlPT1
         TQub0BEsTj42CmYW1a6Jo0RGCBAtyrYYR+jGh0XQ1vQTW0ia61x9rkhMlhX75Gv72EgS
         +tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065647; x=1754670447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPlDNUMymhsODNFmsd1JRKJrfbGJJsVHVjtAtmZ8nro=;
        b=ZDoI7EvppZXY9SOnx9YO3I6kX3SP2jnNhHq5wg13QeD5nlswQzh5Q5xbO42uKZaXHo
         UbFYVFlRrM7LoDa/HamxS7jJYM4nKoohh+lxGA63AwcYenAUaU+T01rzVmrgE5JhZX5n
         tGnRj5jA/dgrEa+mNq3J2YPdoMptolveR+YPMaNi+Rrsr4DmZXn/tk6T23cUEqoVSzeY
         I8QbA9jxkmVTAmGJyJKsJFkJKzlhzk1qoCCzhqbf8jF7iNK0Rbzg9vYFdLkb7P35Ig+p
         P/t3SlfNUnDCLx3VBdiutaVUzNpCKM1+MaqIF9Jy3hP3uDvom8XskxJTC/SyEUShNbds
         rmYg==
X-Forwarded-Encrypted: i=1; AJvYcCU8kfkK1qYKCaMINRQdQmOOpZqG1BVuniOzstRI82DAxws/r0VeGRk1JCc5EgFExGOZ6xXgaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmNrfDJqrnGp537rjbv75XQvKfFa1VN6iT4GAMQIOpDGDx3d9s
	lCaFfcm7m3tpAptDXpq5eGPmcf9AAFqwWtwKwo2CSDosHLBXzjAohvIk7r3izVHTf60nJ9Ic53/
	jfhmqG+5UvXD9Mvh9DNbAdo8hNKA/E3LArfh3YeFU
X-Gm-Gg: ASbGnct8SkUTscWij4qE67+EYQoZJP2hhKE4xYRWGMR2sPVeGVeNV8c14sS7K5GxAq0
	iP9gjCJM+UGE1c215dJ1sSdIqu7x+vUSNXCSR/1K49BsCgveaD6sQG961szarZfnNRrM77UUa2e
	EDPDi67ghnwi795CE9h3U1ZgnV20pRqOcxu17VDJomvu9BTc/UK5MpOQ79nG530lmdNdH5tylZp
	dbGcTfIassDIkJSyrsPtWXiz+dErecRxUpd8KmLdETwfVX8uKI=
X-Google-Smtp-Source: AGHT+IGrbCrNLGqTtBuWiAzE0+U3e1NMQB2FNpi+8gjkEuVtCmtDODuiea5OBd3jquswfNAUuJ4/jdmM5dWBSs9hwSU=
X-Received: by 2002:a17:90b:4a02:b0:31f:20a:b54c with SMTP id
 98e67ed59e1d1-32116115530mr791605a91.0.1754065646975; Fri, 01 Aug 2025
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
 <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com> <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
In-Reply-To: <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 Aug 2025 09:27:15 -0700
X-Gm-Features: Ac12FXySWBq5tqGpyUdEEo4tML_igvMbcYh9DoXD653V26VGI_HquHEhRn-c55o
Message-ID: <CAAVpQUCf=xHc7nx5Y5rZ4PcPt+PN9kdWvGo5jzRyNkubq-sRYg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:00=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jul 31, 2025 at 04:51:43PM -0700, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > Doesn't that end up implementing another tcp_mem[] which now
> > enforce limits on uncontrolled cgroups (memory.max =3D=3D max) ?
> > Or it will simply end up with the system-wide OOM killer ?
>
> I meant to rely on use the exisiting mem_cgroup_charge_skmem(), i.e.
> there'd be always memory.max < max (ensured by the configuring agent).
> But you're right the OOM _may_ be global if the limit is too loose.
>
> Actually, as I think about it, another configuration option would be to
> reorganize the memcg tree and put all non-isolated memcgs under one
> ancestor and set its memory.max limit (so that it's shared among them
> like the global limit).

Interesting.  Is it still possible if other controllers are configured
differently and form a hierarchy ?  It sounds cgroup-v1-ish.

Or preparing an independent fake memcg for non-isolated socket
and tying it to sk->sk_memcg could be an option ?

The drawback of the option is that socket is not charged to each
memcg and we cannot monitor the usage via memory.stat:sock
and make it a bit difficult to configure memory.max based on it.

Another idea that I have is get rid of the knob and only allow
decoupling memcg from TCP mem accounting only for controlled
cgroup.

This makes it possible to configure memcg by memory.max only
but does not add any change for uncontrolled cgroup from the
current situation.

---8<---
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 85decc4319f9..6d7084a32b12 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5102,7 +5102,8 @@ static void mem_cgroup_sk_set(struct sock *sk,
const struct mem_cgroup *memcg)
 {
        unsigned long val =3D (unsigned long)memcg;

-       val |=3D READ_ONCE(memcg->socket_isolated);
+       if (memcg->memory.max !=3D PAGE_COUNTER_MAX)
+               val |=3D MEMCG_SOCK_ISOLATED;

        sk->sk_memcg =3D (struct mem_cgroup *)val;
 }
---8<---
