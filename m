Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BF1EF389
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146055; cv=none; b=NBsWNaHvh/45jPXu6IaTchOcauS9puioren1+NIto80+o3+YFmiPSVDYlNQHIZOGtdQ9FkraZu9+8xvOtuy0FLFqI5qd4i7CHQg3GBBvJ92nX3NzTU8w0vXBMGp2AdDlfycaqnLgQnL8vJ2A8nJhoULQllVuAyRi+jIT7nPdiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146055; c=relaxed/simple;
	bh=1jpYMe9Rs3tolynO9B73W/0DpudggFG/LEClC4JR1AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAp5A0s+tkwdnIc5a6/RI6afANkjKgIE3biTONANf8QHYU4MD3XRQPJ2w6qQLJUufNWeudmt4eAFSdcLZUd+jkY2t10mx201GhShWoJSr9/EuiA8fjr6m9vA4dBALMliHr5smTIMwGc387m/IfI1EmYcEHYrRj3rHC6bTrJfiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brzl2ikM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brzl2ikM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244581caca6so3602015ad.2
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 21:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755146053; x=1755750853; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jpYMe9Rs3tolynO9B73W/0DpudggFG/LEClC4JR1AM=;
        b=brzl2ikMsqP3jqgXnlyihnnPhEtyJeif3gMK+MaiFx+0jbaVNiF5tk/vJAIHXiw/Zk
         zE47V/6Vi5gLv1mNC2xLLNTIWXRfbqgDq30+MV3uELQkmNd6jCwzLeFG1FRNJvUnZO3O
         jAz5spzMpGT46wBh0gXIfRAez7qxpMVmVthL1Jy8WuJryLDs1mcizd3IMyaCsonBknJD
         Y5eRxhbxlkNe1LZOL+FadodYreqMuPN4ZDaeNGsvRf+4p4IB0bGy8Hvk4CGNM0UxfWeQ
         FSjgqXkQFPyH4dAe8OaynRyD60pxUqfI60EOfbY6KTcGlegD0fcM1O6E7l/Q00k8cLAJ
         BpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755146053; x=1755750853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jpYMe9Rs3tolynO9B73W/0DpudggFG/LEClC4JR1AM=;
        b=P4eEUh8epJFqaAHxAuxrFs7VvagLy8pQ4LTWwRMs/5eC3TkcEV/Zc9WsxkpklItSlX
         Pj0iXSVdeAD0iSiAiP63q9dgz3flUl/oOd/4HIybtNsd8mJoC0W7gkAtJasPG3o3usKw
         gXQWoto2c9g8M/wbJTKl4lrQQcqxl13GWagRm+sWsmIJvX9JQPqvJxFqH1oaht1TnzW7
         +2n+DoCwHW9KlBfDPy2wHJbvW8grxizlHjGneVkH9KzjBF3NBsNPJqtMJ2jaGv5gMf5d
         EGOyeWXMlotPrJVahD3GmLaoesk+niI7/xQ/BnSMKtU01BvQYHOh8DTXdURqohUdxtO4
         D2gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX2KDu/FhIzEOwxWwY4bVGZL/gkDPaY/v116pYvKGcdNURKOYq5VaJQdGTGtXjDrlb8MOd/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH+EC6e1+d8OtZOXSzkKQxxxFwNZvJwkbEU64iCAMUIEClOKJW
	alM5Y0sfcsFoMa5Bb37yl6lYE12K2ZuoWGjejBqfQSkcLHDi0EpTmj+mTooK2Hb4hoAP1ULjjyJ
	bDpBm9t3Z+Jxfi+xrF7pGNAi2OvOArzhL1WEi5Dd/
X-Gm-Gg: ASbGncvoRQgyASoXrGISLKGBrwGanjUNOo0LQbBm6U2Ar0NAjzhH5LRTryo3v+f4hZe
	suHch+t0LUgWtmqxcUZpYrkAzya2jpfw/tLScb47t2BgFM0p57/rlo72UzIQIOoF3A8ClF8LQ9w
	XnN+rfsvBGfBo7riKfqxDAFooUV1O09Ueo+JDI0BiFDl+ufJFfITSV0FPJanE8preqqhCDecFAK
	ejtuS5fnOhJYbpPYVTfSRXHACsCnKH2iwArwkebR3u3XCCSNIe6UOzFnA==
X-Google-Smtp-Source: AGHT+IGwKj8+FeXsQR4WunSW0QBU4S01IHDhpLwKH7+wQspVHInHE5tXI45S3ELL33wWwQ08lPI1qcfPuEc+19ZHTWs=
X-Received: by 2002:a17:903:19cd:b0:240:5c38:7555 with SMTP id
 d9443c01a7336-244584ede2fmr22257795ad.5.1755146052777; Wed, 13 Aug 2025
 21:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com> <20250812175848.512446-13-kuniyu@google.com>
 <w6klr435a4rygmnifuujg6x4k77ch7cwoq6dspmyknqt24cpjz@bbz4wzmxjsfk>
 <CAAVpQUCU=VJxA6NKx+O1_zwzzZOxUEsG9mY+SNK+bzb=dj9s5w@mail.gmail.com>
 <oafk5om7v5vtxjmo5rtwy6ullprfaf6mk2lh4km7alj3dtainn@jql2rih5es4n> <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
In-Reply-To: <e6c8fa06-c76c-49e7-a027-0a7b610f1e9c@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 13 Aug 2025 21:34:01 -0700
X-Gm-Features: Ac12FXwCislSz3BViv-OIQ8p6QupR93n7L2582VKpwYhsHhniE6ipCNyQvXHe4w
Message-ID: <CAAVpQUD6hCY2FDWKVnoiQ59RmovLizTPCC+ZNqB=oyP5B4-2Aw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 12/12] net-memcg: Decouple controlled memcg
 from global protocol memory accounting.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:55=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/13/25 1:53 PM, Shakeel Butt wrote:
> > What I think is the right approach is to have BPF struct ops based
> > approach with possible callback 'is this socket under pressure' or mayb=
e
> > 'is this socket isolated' and then you can do whatever you want in thos=
e
> > callbacks. In this way your can follow the same approach of caching the
> > result in kernel (lower bits of sk->sk_memcg).
> >
> > I am CCing bpf list to get some suggestions or concerns on this
> > approach.
>
> I have quickly looked at the set. In patch 11, it sets a bit in sk->sk_me=
mcg.
>
> On the bpf side, there are already cgroup bpf progs that can do bpf_setso=
ckopt
> on a sk, so the same can be done here. The bpf_setsockopt does not have t=
o set
> option/knob that is only available in the uapi in case we don't want to e=
xpose
> this to the user space.
>
> The cgroup bpf prog (BPF_CGROUP_INET_SOCK_CREATE) can already be run when=
 a
> "inet" sock is created. This hook (i.e. attach_type) does not have access=
 to
> bpf_setsockopt but should be easy to add.

Okay, I will try the bpf_setsockopt() approach.
Should I post patch 1-10 to net-next separately ?
They are pure net material to gather memcg code under CONFIG_MEMCG.


>
> For more comprehensive mem charge policy that needs new bpf hook, that pr=
obably
> will need struct_ops instead of another cgroup attach_type but that will =
be
> implementation details.
