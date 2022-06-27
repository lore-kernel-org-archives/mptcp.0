Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242CA3235
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 14:57:00 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-318889e6a2cso88017907b3.1
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2nkfUAYBDu+tfL2X9orUiMGatP89Pe54EDyxN988kQ=;
        b=i+OGq2gIOrj1f7wJzQ/eJW7dkmfzigU161pJ9k36Z3eExzuYM+VOxhAoq8edk1Lj6g
         GI/bPHIeILex5TIvyQUh9j5heq/SmDq7hfMD81AoulOR5oXjLHEwbRahu/0IOZ6XBzcb
         kzJH4QV57nE3AOYV6nw52zlZNjxqVQ7rk8D+tA58OeeOHf+3PtKM96u1+os+o3UFPnqU
         qfVS2dWuH5VfyxtdEiJk6Rw0iPTSMhC9CdmRxAoqt3dPzOsnhCbsa288dFK5oepKzJzI
         IFAbYUxAe2mFHV+UT4i5fQJ53K6bAoD/8IXzOQMCLsQjhBZmYNgAleopWVgDXEb9DCuU
         PeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2nkfUAYBDu+tfL2X9orUiMGatP89Pe54EDyxN988kQ=;
        b=S2wXLfIUeqhX/A58+2kRmartaU9LIskAlidAqTdXj5rtiN5eflQoyfuHRlaXNgvVn+
         qpl/KwSFgiTZlfHifOBO9C2rBX/1m9lNmVWo/7JuZQSz6I8PZ59VYB/2HCKOk/S8w21X
         0UNC1GAhvcWtdbAgNtwzq93Fk5NxWFHBRoY/WYBZs/EQ4dOVltTid9xVQZaHICPlBblC
         PeBNApjbhzoEt6wayr5jw0bVK9r9JdXcPnkDmXs5V/7oaCn3/Kr0tlPAE0T2KyZOXxBV
         aCdUHcxmuykg5DYKzkuUYSVq/7zENld7K8uSopioLCyiDt2DTO6nyZCVnnvK9gBfIOVw
         FHdA==
X-Gm-Message-State: AJIora8SPTXrdcRfPCIHlfmovgnrWgTzvuXZV12to7C6qnjnYQ4J5ZHU
	57R7Aq/XHWCzgi1cxpJBPwA9I0ePVwlObbkzlks5vQ==
X-Google-Smtp-Source: AGRyM1u8B4kcLVWeZgzZxIUcRpqFs89OsvNHHhNb/IgGIfmRs5gfWD02FqhOdPn0RnPeAh7WgtQAQ18XliZui2xrm3U=
X-Received: by 2002:a0d:df50:0:b0:317:9c40:3b8b with SMTP id
 i77-20020a0ddf50000000b003179c403b8bmr15687403ywe.332.1656341818790; Mon, 27
 Jun 2022 07:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com>
 <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com>
 <20220624070656.GE79500@shbuild999.sh.intel.com> <20220624144358.lqt2ffjdry6p5u4d@google.com>
 <20220625023642.GA40868@shbuild999.sh.intel.com> <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com> <CALvZod7i_=7bNZR-LAXBPXJFxj-1KBuYs+rmG0iABAE1T90BPg@mail.gmail.com>
In-Reply-To: <CALvZod7i_=7bNZR-LAXBPXJFxj-1KBuYs+rmG0iABAE1T90BPg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Jun 2022 16:56:47 +0200
Message-ID: <CANn89i+gKtKsNT3SUJyOc8FiF4EO74Fando7GudeXw0+CPr=EQ@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To: Shakeel Butt <shakeelb@google.com>
Cc: Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>, 
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

On Mon, Jun 27, 2022 at 4:53 PM Shakeel Butt <shakeelb@google.com> wrote:

> Am I understanding correctly that this 69.4% (or 73.7%) regression is
> with cgroup v2?
>
> Eric did the experiments on v2 but on real hardware where the
> performance impact was negligible.
>
> BTW do you see similar regression for tcp as well or just sctp?

TCP_RR with big packets can show a regression as well.

I gave this perf profile:

    28.69%  [kernel]       [k] copy_user_enhanced_fast_string
    16.13%  [kernel]       [k] intel_idle_irq
     6.46%  [kernel]       [k] page_counter_try_charge
     6.20%  [kernel]       [k] __sk_mem_reduce_allocated
     5.68%  [kernel]       [k] try_charge_memcg
     5.16%  [kernel]       [k] page_counter_cancel

And this points to false sharing on (struct page_counter *)->usage

I guess memcg had free lunch, because of per-socket cache, that we
need to remove.
