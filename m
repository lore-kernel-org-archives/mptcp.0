Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62423A1
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 05:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656047638; x=1687583638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QYBf8oflbgBC/XBfAzL41uZYcigxxwAfRsDKymMRo5s=;
  b=mV5huTfdQlIg6h8N6+SmYhudg33yAbTt+yNVDkIc0/GIsgCd5B3fUr0v
   WDrEox+P7PKG9bMbnM+RuYEANk3dCqceHSsQo2ALanK8iKwqQOKw6gx6A
   yRFgZKGxYL1QrAh89FUsbJqK7igRsmpyPyBo4eVv72EHYcKZ8Qd8FHXxj
   bih1HvEWoliaeCNM8EYO+5PZwiXpc+oVfXngtoqicr6HAjVHyh3fd9xI5
   JvmBfOra9xZqLb2ztrFgHP0Qnzw3CYsss2pwgOs2un+iVQbwn3YqMmQzI
   ePclp7EKVnHBcelTYJhtzeyQsPBBw0kuHpgdUwpKmkisislt16qNN4DIx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="342612317"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="342612317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 22:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="678398213"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2022 22:13:52 -0700
Date: Fri, 24 Jun 2022 13:13:51 +0800
From: Feng Tang <feng.tang@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	kernel test robot <oliver.sang@intel.com>,
	Shakeel Butt <shakeelb@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	network dev <netdev@vger.kernel.org>, linux-s390@vger.kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	"linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
	lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
	Huang Ying <ying.huang@intel.com>, zhengjun.xing@linux.intel.com,
	fengwei.yin@intel.com, Ying Xu <yinxu@redhat.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
Message-ID: <20220624051351.GA72171@shbuild999.sh.intel.com>
References: <20220619150456.GB34471@xsang-OptiPlex-9020>
 <20220622172857.37db0d29@kernel.org>
 <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com>
 <20220623185730.25b88096@kernel.org>
 <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>

Hi Eric,

On Fri, Jun 24, 2022 at 06:13:51AM +0200, Eric Dumazet wrote:
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
 
We can double check that. 

> memcg has a very similar strategy of per-cpu reserves, with
> MEMCG_CHARGE_BATCH being 32 pages per cpu.
 
We have proposed patch to increase the batch numer for stats
update, which was not accepted as it hurts the accuracy and
the data is used by many tools.

> It is not clear why SCTP with 10K writes would overflow this reserve constantly.
> 
> Presumably memcg experts will have to rework structure alignments to
> make sure they can cope better
> with more charge/uncharge operations, because we are not going back to
> gigantic per-socket reserves,
> this simply does not scale.

Yes, the memcg statitics and charge/unchage update is very sensitive
with the data alignemnt layout, and can easily trigger peformance
changes, as we've seen quite some similar cases in the past several
years. 

One pattern we've seen is, even if a memcg stats updating or charge
function only takes about 2%~3% of the CPU cycles in perf-profile data,
once it got affected, the peformance change could be amplified to up to
60% or more.

Thanks,
Feng


