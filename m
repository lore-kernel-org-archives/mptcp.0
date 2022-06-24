Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BF1FD1
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 06:34:26 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so4823300pjl.5
        for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71jGypN6c61twJSnmBdGUmoPeKpzoJtu/qf5Lc4Vgtg=;
        b=GQWOciPs4SH+KIoLH/4jvpooIeGL/uKMB5IIRmqHwKrVMCLTNkhEHTFWG3stILKRer
         cinAgcMsxDf4RTBxejYoy941btEr/eLYCO+GF0ql1oaFb5jWx60AuACLQuEvlaLYrFZf
         UgRAAkZWXt6lWFMzYjbN06dquy9miTA8f1PyXmTEZJcjuxIApu2/k+3F3LqT6WPZStaK
         L7ajnIeNJmeLEocSQsgypUZxz1YBXMny857DRCdVvb2g8M2IoTpQy8wBz8KkiaITpwjR
         N+Jfv3+DvM/5n9lutIQWyD9cIG3lm6BebIyNWT6S8ze0LdBcVOk9Wq+EciVzzoisMPoO
         SYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71jGypN6c61twJSnmBdGUmoPeKpzoJtu/qf5Lc4Vgtg=;
        b=XqAL7MGsDmQTC7KBKKFDfZ9WVDKbeM69NsWc5i0QsJLazpDFfSiygNLD5qafebVtzA
         RyUj7Cf87lFODGpXv/F7ig30NeECNlxyuXYLSGp+5AtR9r1SMTGrWF64vibsNdsuYZpg
         JOCAoPZzx9OB73yNAv6FVgsvBZCdWTzUm7bkPv+kIY2Ts3emHHpfdgc6G8EQv7jquAe2
         5yFsmxZVKiXiaEBDwFqNWumeQoi2tXqTcXzcns6Mg4Yli9t96vMSTFRVGiLnZDaj3R9b
         B7K6TIotsHo2Vqpc8QNwEWv472P0htcQUe5c7KHYTjZebor3x5V5Mp045O9dXf/5ic4I
         1A/Q==
X-Gm-Message-State: AJIora/XGUe2djh3+pVI4MgYAg0dSAecbhZENSNVAIUtw/eoFB474C4i
	QXG1c7IFm13VjOjSS4I7SLoUfCIc/j202CApjStGmg==
X-Google-Smtp-Source: AGRyM1sH/6oaYCwlqeMz2fZ1ORa63Fgtzz9yKrkfpjijNf1stMa7F1Ub33v8l06714/cZs/6t1k6jgJJALnl6rgV8ZY=
X-Received: by 2002:a17:902:f685:b0:16a:3c40:e3b5 with SMTP id
 l5-20020a170902f68500b0016a3c40e3b5mr15658634plg.106.1656052466148; Thu, 23
 Jun 2022 23:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220619150456.GB34471@xsang-OptiPlex-9020> <20220622172857.37db0d29@kernel.org>
 <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com>
 <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
In-Reply-To: <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 23 Jun 2022 23:34:15 -0700
Message-ID: <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To: Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <songmuchun@bytedance.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, kernel test robot <oliver.sang@intel.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	network dev <netdev@vger.kernel.org>, linux-s390@vger.kernel.org, 
	MPTCP Upstream <mptcp@lists.linux.dev>, 
	"linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, lkp@lists.01.org, 
	kbuild test robot <lkp@intel.com>, Huang Ying <ying.huang@intel.com>, "Tang, Feng" <feng.tang@intel.com>, 
	Xing Zhengjun <zhengjun.xing@linux.intel.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"

CCing memcg folks.

The thread starts at
https://lore.kernel.org/all/20220619150456.GB34471@xsang-OptiPlex-9020/

On Thu, Jun 23, 2022 at 9:14 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 3:57 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 23 Jun 2022 18:50:07 -0400 Xin Long wrote:
> > > From the perf data, we can see __sk_mem_reduce_allocated() is the one
> > > using CPU the most more than before, and mem_cgroup APIs are also
> > > called in this function. It means the mem cgroup must be enabled in
> > > the test env, which may explain why I couldn't reproduce it.
> > >
> > > The Commit 4890b686f4 ("net: keep sk->sk_forward_alloc as small as
> > > possible") uses sk_mem_reclaim(checking reclaimable >= PAGE_SIZE) to
> > > reclaim the memory, which is *more frequent* to call
> > > __sk_mem_reduce_allocated() than before (checking reclaimable >=
> > > SK_RECLAIM_THRESHOLD). It might be cheap when
> > > mem_cgroup_sockets_enabled is false, but I'm not sure if it's still
> > > cheap when mem_cgroup_sockets_enabled is true.
> > >
> > > I think SCTP netperf could trigger this, as the CPU is the bottleneck
> > > for SCTP netperf testing, which is more sensitive to the extra
> > > function calls than TCP.
> > >
> > > Can we re-run this testing without mem cgroup enabled?
> >
> > FWIW I defer to Eric, thanks a lot for double checking the report
> > and digging in!
>
> I did tests with TCP + memcg and noticed a very small additional cost
> in memcg functions,
> because of suboptimal layout:
>
> Extract of an internal Google bug, update from June 9th:
>
> --------------------------------
> I have noticed a minor false sharing to fetch (struct
> mem_cgroup)->css.parent, at offset 0xc0,
> because it shares the cache line containing struct mem_cgroup.memory,
> at offset 0xd0
>
> Ideally, memcg->socket_pressure and memcg->parent should sit in a read
> mostly cache line.
> -----------------------
>
> But nothing that could explain a "-69.4% regression"
>
> memcg has a very similar strategy of per-cpu reserves, with
> MEMCG_CHARGE_BATCH being 32 pages per cpu.
>
> It is not clear why SCTP with 10K writes would overflow this reserve constantly.
>
> Presumably memcg experts will have to rework structure alignments to
> make sure they can cope better
> with more charge/uncharge operations, because we are not going back to
> gigantic per-socket reserves,
> this simply does not scale.

Yes I agree. As you pointed out there are fields which are mostly
read-only but sharing cache lines with fields which get updated and
definitely need work.

However can we first confirm if memcg charging is really the issue
here as I remember these intel lkp tests are configured to run in root
memcg and the kernel does not associate root memcg to any socket (see
mem_cgroup_sk_alloc()).

If these tests are running in non-root memcg, is this cgroup v1 or v2?
The memory counter and the 32 pages per cpu stock are only used on v2.
For v1, there is no per-cpu stock and there is a separate tcpmem page
counter and on v1 the network memory accounting has to be enabled
explicitly i.e. not enabled by default.

There is definite possibility of slowdown on v1 but let's first
confirm the memcg setup used for this testing environment.

Feng, can you please explain the memcg setup on these test machines
and if the tests are run in root or non-root memcg?

thanks,
Shakeel
