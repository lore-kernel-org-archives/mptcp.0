Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1733C3
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656342784; x=1687878784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xJP9OefAMxCTgdzZDCaOuKXFij4QIj41i5jxXMS1AdM=;
  b=LvRGzLjcGYY0Nr50YYBbypz8vukHydOo5wS1A5JsmEyEWoSLlQel+YTl
   4UaDzGU4EAkCGLXJtuVtsct9HI33j7//o+Fz2B6ChYmh4oHat6pTYn7hm
   by8HyTuBCQN3B6pcuP72fprJwaBRGsEQC+sQobsEaZdWAnkbhoOqcR/QO
   HKVLYGvgw1AN+EZKfp2HfFKyIcy7qJzLftsvFOJknha2pJTtNCEfwUFrO
   qd8gEiXg+ZshiVK2NnSuol03B1IqPmb+IH9al1mWVq0dkrPf+Fw+7xF0J
   aRoZ6Y74yU+9xBTrcD0e8xc+fTDz8jWFNTSB3c018MNyQ+c7bxbid8gGb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="345468882"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="345468882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 08:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="766731304"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2022 08:12:58 -0700
Date: Mon, 27 Jun 2022 23:12:58 +0800
From: Feng Tang <feng.tang@intel.com>
To: Shakeel Butt <shakeelb@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
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
Message-ID: <20220627151258.GB20878@shbuild999.sh.intel.com>
References: <20220623185730.25b88096@kernel.org>
 <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com>
 <20220624070656.GE79500@shbuild999.sh.intel.com>
 <20220624144358.lqt2ffjdry6p5u4d@google.com>
 <20220625023642.GA40868@shbuild999.sh.intel.com>
 <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com>
 <CALvZod7i_=7bNZR-LAXBPXJFxj-1KBuYs+rmG0iABAE1T90BPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7i_=7bNZR-LAXBPXJFxj-1KBuYs+rmG0iABAE1T90BPg@mail.gmail.com>

On Mon, Jun 27, 2022 at 07:52:55AM -0700, Shakeel Butt wrote:
> On Mon, Jun 27, 2022 at 5:34 AM Feng Tang <feng.tang@intel.com> wrote:
> > Yes, 1% is just around noise level for a microbenchmark.
> >
> > I went check the original test data of Oliver's report, the tests was
> > run 6 rounds and the performance data is pretty stable (0Day's report
> > will show any std deviation bigger than 2%)
> >
> > The test platform is a 4 sockets 72C/144T machine, and I run the
> > same job (nr_tasks = 25% * nr_cpus) on one CascadeLake AP (4 nodes)
> > and one Icelake 2 sockets platform, and saw 75% and 53% regresson on
> > them.
> >
> > In the first email, there is a file named 'reproduce', it shows the
> > basic test process:
> >
> > "
> >   use 'performane' cpufre  governor for all CPUs
> >
> >   netserver -4 -D
> >   modprobe sctp
> >   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
> >   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
> >   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
> >   (repeat 36 times in total)
> >   ...
> >
> > "
> >
> > Which starts 36 (25% of nr_cpus) netperf clients. And the clients number
> > also matters, I tried to increase the client number from 36 to 72(50%),
> > and the regression is changed from 69.4% to 73.7%
> >
> 
> Am I understanding correctly that this 69.4% (or 73.7%) regression is
> with cgroup v2?

Yes.

> Eric did the experiments on v2 but on real hardware where the
> performance impact was negligible.
> 
> BTW do you see similar regression for tcp as well or just sctp?

Yes, I run TCP_SENDFILE case with 'send_size'==10K, it hits a
70%+ regressioin. 

Thanks,
Feng
