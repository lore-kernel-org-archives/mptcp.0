Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053D7A
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 01:53:49 +0000 (UTC)
Date: Mon, 27 Jun 2022 18:46:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1656380820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ORdLe5wVx7GzxxMtzEujYJBVbDhPT8vtTYMDRzc+hUM=;
	b=ctCXHWlV79XK06hz0/egR14h1WrQtW6OqdpoYuhXrwnV4k6ahAaXCUNyw4vskHn4vKSf+m
	3WlYbBfaHxPvdtR+zayNdLZiOJnjqFjG1N23ON6FHn1abZfSgM5OwfnZqbiWeASScl0i7c
	LMyQj8wvsIK0gksoQYXXMp5JpN1W4y0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeelb@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Feng Tang <feng.tang@intel.com>,
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
Message-ID: <YrpdhDx3DDXtxx7b@castle>
References: <20220624070656.GE79500@shbuild999.sh.intel.com>
 <20220624144358.lqt2ffjdry6p5u4d@google.com>
 <20220625023642.GA40868@shbuild999.sh.intel.com>
 <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com>
 <CANn89iJAoYCebNbXpNMXRoDUkFMhg9QagetVU9NZUq+GnLMgqQ@mail.gmail.com>
 <20220627144822.GA20878@shbuild999.sh.intel.com>
 <CANn89iLSWm-c4XE79rUsxzOp3VwXVDhOEPTQnWgeQ48UwM=u7Q@mail.gmail.com>
 <CALvZod60OHC4iQnyBd16evCHXa_8ucpHiRnm9iNErQeUOycGZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod60OHC4iQnyBd16evCHXa_8ucpHiRnm9iNErQeUOycGZw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev

On Mon, Jun 27, 2022 at 09:48:01AM -0700, Shakeel Butt wrote:
> On Mon, Jun 27, 2022 at 9:26 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> [...]
> > >
> >
> > I simply did the following and got much better results.
> >
> > But I am not sure if updates to ->usage are really needed that often...
> 
> I suspect we need to improve the per-cpu memcg stock usage here. Were
> the updates mostly from uncharge path or charge path or that's
> irrelevant?
> 
> I think doing full drain (i.e. drain_stock()) within __refill_stock()
> when the local cache is larger than MEMCG_CHARGE_BATCH is not best.
> Rather we should always keep at least MEMCG_CHARGE_BATCH for such
> scenarios.

+1, really good point.
