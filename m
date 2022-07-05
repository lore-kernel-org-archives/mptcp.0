Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BF7C
	for <mptcp@lists.linux.dev>; Tue,  5 Jul 2022 05:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656997422; x=1688533422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0sKczz/MzrkciaGHBhWNdrcBmOzdmGmWF8CNerI1VBk=;
  b=V5M0msSwvzO2oaJSQWQoiuifKfVxTDtMT/rCezKywLK78JjAYGMf5Dy7
   SStBwduozk9/zfWELNPcwHR8TiAzPlBKsiLZn5RFzy3CFI82vmwipQ2Mu
   DpNqZJXS4kMEvfNTdarwQFXyy6sNq3u+eWPIK1BE3PyWGpA/Yk79GMPrR
   QrcrM0oGtfX/7CahYX3dhlz13TQlZ/LAK76aJfJprnmV65CUhsAlKp9+f
   Gy0TgmuIY/9nMnylUSIDj78hxnTyr+ZFyDo3Ed8ho6XvMueeyF4xxDxLU
   rswXAdadzIrADh/ljXHAdSL0uZKqQqeqVzE0Rmf6WrsyR+6bLpGXH1Vlj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283280446"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283280446"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="625312910"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga001.jf.intel.com with ESMTP; 04 Jul 2022 22:03:26 -0700
Date: Tue, 5 Jul 2022 13:03:26 +0800
From: Feng Tang <feng.tang@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>, Eric Dumazet <edumazet@google.com>,
	Linux MM <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	network dev <netdev@vger.kernel.org>, linux-s390@vger.kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	"linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
	lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Xing Zhengjun <zhengjun.xing@linux.intel.com>,
	Yin Fengwei <fengwei.yin@intel.com>, Ying Xu <yinxu@redhat.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
Message-ID: <20220705050326.GF62281@shbuild999.sh.intel.com>
References: <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com>
 <CANn89iJAoYCebNbXpNMXRoDUkFMhg9QagetVU9NZUq+GnLMgqQ@mail.gmail.com>
 <20220627144822.GA20878@shbuild999.sh.intel.com>
 <CANn89iLSWm-c4XE79rUsxzOp3VwXVDhOEPTQnWgeQ48UwM=u7Q@mail.gmail.com>
 <20220628034926.GA69004@shbuild999.sh.intel.com>
 <CALvZod71Fti8yLC08mdpDk-TLYJVyfVVauWSj1zk=BhN1-GPdA@mail.gmail.com>
 <20220703104353.GB62281@shbuild999.sh.intel.com>
 <YsIeYzEuj95PWMWO@castle>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsIeYzEuj95PWMWO@castle>

On Sun, Jul 03, 2022 at 03:55:31PM -0700, Roman Gushchin wrote:
> On Sun, Jul 03, 2022 at 06:43:53PM +0800, Feng Tang wrote:
> > Hi Shakeel,
> > 
> > On Fri, Jul 01, 2022 at 08:47:29AM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 27, 2022 at 8:49 PM Feng Tang <feng.tang@intel.com> wrote:
> > > > I just tested it, it does perform better (the 4th is with your patch),
> > > > some perf-profile data is also listed.
> > > >
> > > >  7c80b038d23e1f4c 4890b686f4088c90432149bd6de 332b589c49656a45881bca4ecc0 e719635902654380b23ffce908d
> > > > ---------------- --------------------------- --------------------------- ---------------------------
> > > >      15722           -69.5%       4792           -40.8%       9300           -27.9%      11341        netperf.Throughput_Mbps
> > > >
> > > >       0.00            +0.3        0.26 ±  5%      +0.5        0.51            +1.3        1.27 ±  2%pp.self.__sk_mem_raise_allocated
> > > >       0.00            +0.3        0.32 ± 15%      +1.7        1.74 ±  2%      +0.4        0.40 ±  2%  pp.self.propagate_protected_usage
> > > >       0.00            +0.8        0.82 ±  7%      +0.9        0.90            +0.8        0.84        pp.self.__mod_memcg_state
> > > >       0.00            +1.2        1.24 ±  4%      +1.0        1.01            +1.4        1.44        pp.self.try_charge_memcg
> > > >       0.00            +2.1        2.06            +2.1        2.13            +2.1        2.11        pp.self.page_counter_uncharge
> > > >       0.00            +2.1        2.14 ±  4%      +2.7        2.71            +2.6        2.60 ±  2%  pp.self.page_counter_try_charge
> > > >       1.12 ±  4%      +3.1        4.24            +1.1        2.22            +1.4        2.51        pp.self.native_queued_spin_lock_slowpath
> > > >       0.28 ±  9%      +3.8        4.06 ±  4%      +0.2        0.48            +0.4        0.68        pp.self.sctp_eat_data
> > > >       0.00            +8.2        8.23            +0.8        0.83            +1.3        1.26        pp.self.__sk_mem_reduce_allocated
> > > >
> > > > And the size of 'mem_cgroup' is increased from 4224 Bytes to 4608.
> > > 
> > > Hi Feng, can you please try two more configurations? Take Eric's patch
> > > of adding ____cacheline_aligned_in_smp in page_counter and for first
> > > increase MEMCG_CHARGE_BATCH to 64 and for second increase it to 128.
> > > Basically batch increases combined with Eric's patch.
> > 
> > With increasing batch to 128, the regression could be reduced to -12.4%.
> 
> If we're going to bump it, I wonder if we should scale it dynamically depending
> on the size of the memory cgroup?
 
I think it makes sense, or also make it a configurable parameter? From 
the test reports of 0Day, these charging/counting play critical role
in performance (easy to see up to 60% performance effect). If user only
wants memcg for isolating things or doesn't care charging/stats, these
seem to be extra taxes.

For bumping to 64 or 128, universal improvement is expected with the
only concern of accuracy.

Thanks,
Feng

> Thanks!
