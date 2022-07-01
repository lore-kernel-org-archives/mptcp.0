Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7403C1E
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 15:47:41 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id n12so2870131pfq.0
        for <mptcp@lists.linux.dev>; Fri, 01 Jul 2022 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yv6QUWYDmgQjKt1P93gNeGHmUq3W/So/sIQeZFHIcA=;
        b=rqzfXCul7tw0OtYOnP55pVCB7g/W9r+ESLzhXTbbeXFyAb7FsPVhGwWf1o6kj4AEw9
         yy5yMHnLr97j5o8rrLFjKXtvNiVn9FBMx+OuaStaeI4VtIuzSQQMCYCKdG/m5/+ZvbtJ
         mgVJXlM7Ih3nxS4V9lsQKs/m0R9tyRektkxlV6RlzNAGVnt03mZ7EX5LY/pDnGeggzJW
         5yhjTlYGbhC7Tjeh7iltQpmTBPc0/ob4Ek3moFpXstDBXYsgrX+l1Ee4H94nhyirr8kt
         PXIyVeGHxqvtHBp9W92BVREWrxfsXLcvqjppHbdeBuO4CTDShzDE2h5XITLVdfm3eTZi
         0t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yv6QUWYDmgQjKt1P93gNeGHmUq3W/So/sIQeZFHIcA=;
        b=UhA7VgCaGjzXbvXy7CwXxPyp2gBRXIcn7azDNJRb0v1CM3TflGjCHyLqykZ/xPmJer
         xhseG94uRXi75kRm80l3Nyjeaw6JNQ2NE1Gu0AOUHn01oC2y0dhflu1d8haGrJpi5+TA
         rcfIbquPQyWa/GffPOBxUWOPSSQUK6vUmq5j2gU0Pa9t1QAVxqTfMu/W+fV2oYN2SoSs
         1DsX03Y1dps51PHnl9rQWVCMwiYm1887RLg2eFvwXIXUZXjSsiHXhHXiZYyFsXZCeTMn
         eq8y9oiZcBnxo+meHEk8Mm9sZjboprDk/utFgUZjKUWOFJYhAzFDB7IrgvRZ6OsZc2iO
         MM+Q==
X-Gm-Message-State: AJIora9jXxoEhw7qI8UmRagpm+GN3MIoNzWiTJR0xTzuTqXPcvd2d7fS
	ddzOFqWlVD9KZvenojo4WMVhTv3Js4XiWBl6aEh2Jw==
X-Google-Smtp-Source: AGRyM1vA2J1Zo47ff1Z3g/0fDruleRJpKHeRmLkW3pftAi7eIEd7S1S7hhAlQL2NFpy1Yupar9lBK8glaB0jqxoYpPM=
X-Received: by 2002:a05:6a00:3307:b0:527:cbdc:d7dc with SMTP id
 cq7-20020a056a00330700b00527cbdcd7dcmr19540188pfb.85.1656690460501; Fri, 01
 Jul 2022 08:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com>
 <20220624070656.GE79500@shbuild999.sh.intel.com> <20220624144358.lqt2ffjdry6p5u4d@google.com>
 <20220625023642.GA40868@shbuild999.sh.intel.com> <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com> <CANn89iJAoYCebNbXpNMXRoDUkFMhg9QagetVU9NZUq+GnLMgqQ@mail.gmail.com>
 <20220627144822.GA20878@shbuild999.sh.intel.com> <CANn89iLSWm-c4XE79rUsxzOp3VwXVDhOEPTQnWgeQ48UwM=u7Q@mail.gmail.com>
 <20220628034926.GA69004@shbuild999.sh.intel.com>
In-Reply-To: <20220628034926.GA69004@shbuild999.sh.intel.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 1 Jul 2022 08:47:29 -0700
Message-ID: <CALvZod71Fti8yLC08mdpDk-TLYJVyfVVauWSj1zk=BhN1-GPdA@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To: Feng Tang <feng.tang@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <songmuchun@bytedance.com>, Jakub Kicinski <kuba@kernel.org>, 
	Xin Long <lucien.xin@gmail.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, network dev <netdev@vger.kernel.org>, 
	linux-s390@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>, 
	"linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, lkp@lists.01.org, 
	kbuild test robot <lkp@intel.com>, Huang Ying <ying.huang@intel.com>, 
	Xing Zhengjun <zhengjun.xing@linux.intel.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2022 at 8:49 PM Feng Tang <feng.tang@intel.com> wrote:
>
> On Mon, Jun 27, 2022 at 06:25:59PM +0200, Eric Dumazet wrote:
> > On Mon, Jun 27, 2022 at 4:48 PM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > Yes, I also analyzed the perf-profile data, and made some layout chan=
ges
> > > which could recover the changes from 69% to 40%.
> > >
> > > 7c80b038d23e1f4c 4890b686f4088c90432149bd6de 332b589c49656a45881bca4e=
cc0
> > > ---------------- --------------------------- ------------------------=
---
> > >      15722           -69.5%       4792           -40.8%       9300   =
     netperf.Throughput_Mbps
> > >
> >
> > I simply did the following and got much better results.
> >
> > But I am not sure if updates to ->usage are really needed that often...
> >
> >
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.=
h
> > index 679591301994d316062f92b275efa2459a8349c9..e267be4ba849760117d9fd0=
41e22c2a44658ab36
> > 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -3,12 +3,15 @@
> >  #define _LINUX_PAGE_COUNTER_H
> >
> >  #include <linux/atomic.h>
> > +#include <linux/cache.h>
> >  #include <linux/kernel.h>
> >  #include <asm/page.h>
> >
> >  struct page_counter {
> > -       atomic_long_t usage;
> > -       unsigned long min;
> > +       /* contended cache line. */
> > +       atomic_long_t usage ____cacheline_aligned_in_smp;
> > +
> > +       unsigned long min ____cacheline_aligned_in_smp;
> >         unsigned long low;
> >         unsigned long high;
> >         unsigned long max;
> > @@ -27,12 +30,6 @@ struct page_counter {
> >         unsigned long watermark;
> >         unsigned long failcnt;
> >
> > -       /*
> > -        * 'parent' is placed here to be far from 'usage' to reduce
> > -        * cache false sharing, as 'usage' is written mostly while
> > -        * parent is frequently read for cgroup's hierarchical
> > -        * counting nature.
> > -        */
> >         struct page_counter *parent;
> >  };
>
> I just tested it, it does perform better (the 4th is with your patch),
> some perf-profile data is also listed.
>
>  7c80b038d23e1f4c 4890b686f4088c90432149bd6de 332b589c49656a45881bca4ecc0=
 e719635902654380b23ffce908d
> ---------------- --------------------------- --------------------------- =
---------------------------
>      15722           -69.5%       4792           -40.8%       9300       =
    -27.9%      11341        netperf.Throughput_Mbps
>
>       0.00            +0.3        0.26 =C2=B1  5%      +0.5        0.51  =
          +1.3        1.27 =C2=B1  2%pp.self.__sk_mem_raise_allocated
>       0.00            +0.3        0.32 =C2=B1 15%      +1.7        1.74 =
=C2=B1  2%      +0.4        0.40 =C2=B1  2%  pp.self.propagate_protected_us=
age
>       0.00            +0.8        0.82 =C2=B1  7%      +0.9        0.90  =
          +0.8        0.84        pp.self.__mod_memcg_state
>       0.00            +1.2        1.24 =C2=B1  4%      +1.0        1.01  =
          +1.4        1.44        pp.self.try_charge_memcg
>       0.00            +2.1        2.06            +2.1        2.13       =
     +2.1        2.11        pp.self.page_counter_uncharge
>       0.00            +2.1        2.14 =C2=B1  4%      +2.7        2.71  =
          +2.6        2.60 =C2=B1  2%  pp.self.page_counter_try_charge
>       1.12 =C2=B1  4%      +3.1        4.24            +1.1        2.22  =
          +1.4        2.51        pp.self.native_queued_spin_lock_slowpath
>       0.28 =C2=B1  9%      +3.8        4.06 =C2=B1  4%      +0.2        0=
.48            +0.4        0.68        pp.self.sctp_eat_data
>       0.00            +8.2        8.23            +0.8        0.83       =
     +1.3        1.26        pp.self.__sk_mem_reduce_allocated
>
> And the size of 'mem_cgroup' is increased from 4224 Bytes to 4608.

Hi Feng, can you please try two more configurations? Take Eric's patch
of adding ____cacheline_aligned_in_smp in page_counter and for first
increase MEMCG_CHARGE_BATCH to 64 and for second increase it to 128.
Basically batch increases combined with Eric's patch.
