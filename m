Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09475283C9C
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213764; cv=none; b=DEpH89RuEIw9INYJX8X+NEv8NG2vHvmpSMHxmLR81f9tu965fyihjsY67jXGpY6d9DJUKf+o7BQSvIKaoAheIcOaaDinOXK96b+v67uBoAePgh5IcB5UHzf4k5DqJVcbJko60tD2zH89bSn+J/lAQZptnS2iTQqnM010+jvozfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213764; c=relaxed/simple;
	bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGT18FKappBkmfpVhsMg21AhrBvkeSQeQzrnhcSWJ6QkqC0Kq5vOgCtpe7nem2OjhDLWQqR8Ft0aLDu7srZA0rJ2TEcEcTJ0UKQZtLbbceXp9v26L0Kzlf8uSFFb69gimW1jaUx1RPTou5qOGJcBmf7TAGAO6wNJKT2HlweZx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8aHQ+XZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8aHQ+XZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445818eb6eso12253605ad.2
        for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755213762; x=1755818562; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
        b=q8aHQ+XZHIz7EdLf5tejDy4Pn5sIbbd6WAzzpmqQ62S70yNw2+BqmdL1pvWS3IsOq7
         8i4azgu/Tlq7dGIQWOvaKCd8N3QohcgK1TtTtMnysh7YmGSLFOH1YtIl97uN2FK0Z/CE
         f4pLHHJtZy86+4a8iyFokI79K/xpRXKqBf55+3vTGBeY4MU9t2X0HORiH1G9VqrsHMX0
         hNSMwzCBTRLtAp4UEUgFiiNqAvdpFMgYKx9vEQke8WCgIhUtEozuKT93LNJ/7SQpTNZe
         OMMug8SG5hGRVAPGpoWM8wWAvnL485OPAduBYdKUU414i4NdNikxZh8jKO4QgrtZigbE
         ISKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755213762; x=1755818562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
        b=JTiQ4ESe4wA4P8gSbU5ZqOzVb9HvoBKxj7+olL8SEfcra0OJ9Q+GIOOuQqJkdaMR7H
         NchPMy2WkbpbQsk1HUhIBfMVsNEaPbwfDzGle50+2Ga6hrmvhntE8/GmIG0glQ/JK2NK
         kTCbTQ33JORlVX9g+6lhmtTj6yWwUOThjnsByg5/r+myHIUxmH5E0esBhqaX76h3fRjw
         Bwv+QRwv0ocKqHYibkuFAWa/0MKAFlWJgDNwVEVaAL1/fgsiJPg7xLX6yJvM4E1XTV8a
         3TZOQYVSK1yhh5tomIaeBsWTh3hEHU2vf9OTfvQbqJZtC1h2UeigsKEEoe0XROX+Up1j
         0q+A==
X-Forwarded-Encrypted: i=1; AJvYcCVp7NHf8lGqOJ8oJhgJhOEIKXum+8e7BOdEq2UAf7ktLhXJm13cXMiR1+btgU0Vwvv6B0AUqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxu+VAq/M5je7rF4tbW4wjr2kt3P4fhK7UEVs6MPcK8ITeXhb9
	yhJRgoY//tkMqspFrIDQbyGHVPFxPLyjAOqicQqkwQJQ5Iig7NgGVcXmHxWhOI0SRRp1QqwDH0S
	UMmIAQ0XOaHVvRT+g4MHx76Vf47P+SpdyrWlmkR4WYIXbPONsQra2Exy3
X-Gm-Gg: ASbGncvEN0gGJB6eWCBYpGJRHjAO7Yq+vJOqNaRWg2bhDmLQiUJX4j0lgROgZwHrUMi
	i9CzF1VYWmviXbiBI/cHb7aJ3XmdFwWCIjnLYVoW9unbVvKDwdbKM4U1Fhy4+tLmL8F+Ek/59nd
	LCzVJGICjv0zp5v22G3pMCyuc+cjwUHbfRQtG66Zy9AT/3Sl35lgbzjasUh1P+F3qo7Ri/sm4rL
	HE1FUHE3iZA4AgB1A/ORDwtUP6Rkvay7LxoBCsNcwejgNuvYyocaWtt
X-Google-Smtp-Source: AGHT+IG+GzkTFoWSxjI/UBpeB+AhhE8U81bSEVut4K3CLnycOTHj2PFasfm2kLor4XHXf2jf8tiH2o7md6AgbgQhI+o=
X-Received: by 2002:a17:903:2444:b0:23f:c945:6067 with SMTP id
 d9443c01a7336-244586c3d33mr71675685ad.41.1755213762138; Thu, 14 Aug 2025
 16:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-10-kuniyu@google.com>
 <pl47mmcmxu53ptfa5ubd7dhzsmpxhsz2qxpscquih4773iykjf@3uhfasbornxc> <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
In-Reply-To: <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 16:22:31 -0700
X-Gm-Features: Ac12FXwLp2y7n2f70IACCfZi6vRBARC4QHPOIBg0j8Z8siCHACfmll_htqDpnyQ
Message-ID: <CAAVpQUDxXZaYz98hen3ariCek4s9TQ9JxWqS_zRoDK=ON-asbQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 03:00:05PM -0700, Shakeel Butt wrote:
> > On Thu, Aug 14, 2025 at 08:08:41PM +0000, Kuniyuki Iwashima wrote:
> > > We will store a flag in the lowest bit of sk->sk_memcg.
> > >
> > > Then, we cannot pass the raw pointer to mem_cgroup_under_socket_press=
ure().
> > >
> > > Let's pass struct sock to it and rename the function to match other
> > > functions starting with mem_cgroup_sk_.
> > >
> > > Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
> >
> > Please keep it in the memcontrol.h.
> >
>
> Oh is this due to struct sock is not yet defined and thus sk->sk_memcg
> will build fail?

Right, we can't touch any field of struct sock in memcontrol.h as
noted in patch 6.
