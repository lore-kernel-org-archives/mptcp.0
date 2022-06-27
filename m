Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F033E4
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 16:25:32 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3178acf2a92so90928407b3.6
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iAKbjN/cfvJPKH/ugt3ybbCNo8kM3ZVPMiqHDruEifg=;
        b=RbOhXfsOqEDMRENO38mrpSrXxxDYigIIL0iGHtE8xCdU+DUoAXKdt3N63SVhhS9bj+
         vE2UFnU2Zf22D0Ic4nq6JinMhf0Rjku6ueYypwbmUvx4P4JuaSisipOX5K8x7shK1He1
         Sk/Gw+rOyqohify/KsKnjlLAviBaC9Vo8OtebbrJ5fNeCpt6gqGuma5db02XQdqbiN/9
         1Ag08g5+15n3bnIIqqmQnHSAO7DPvRcyWTP8d5sJSPb1SSC2xw97478ugS1gXgiYTaO6
         gI/ywCGguebiSzo0OFIw5YW2u7W3NCNfDYEl+SNNPS0N8N6VKJwV+q1Cupj+aXeASM/M
         Lang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iAKbjN/cfvJPKH/ugt3ybbCNo8kM3ZVPMiqHDruEifg=;
        b=qHflplHrPiuTjltH2JMqOGEDsOwhulb7rxgv0JgR6IuG7p0x0b9+QuYBl/bQUEbGju
         XDwt8+M/rupQ51cb8C/XSA/aifBJRnLUbpuCxLRzp+I2WAGGDkb7q+0f/DzNdLShSSmc
         ZduqeWFdI7hDXQuh/CyT0wWuuQh5uYOpGh6OWLUTRwjCL4nUZltP98d/3Mo2OBVrgmVN
         7RLsLWK90lfAmRjXlFjOQJe1or+OTZVX/5nSb2ppxdR/zVhv5M0mM/WXLg+vvAQo8CIX
         JjrEQCnbnm8LEDo19ADlBEiLmXDOvao4XjtNZi+RjBkc4nBtIG+dH/iaXien14jCD9w8
         U0RQ==
X-Gm-Message-State: AJIora8RA4OcmM6pAK5nhbynDnYPHi3qEIDxwFj1ylykpYlo1Jq45tI+
	SjVcGom5wea6BuA7j2s/FK8b+b6iICtxXkbtLbv0BA==
X-Google-Smtp-Source: AGRyM1vH55ursM9GjUkBbRtmBX4QDoHDlEEpNJpUs5A6vX12LOpEiXhq4y8+47q5BzoyFRCpabSxvoZUSxVB0BpYoPY=
X-Received: by 2002:a81:bd51:0:b0:31b:db72:88a1 with SMTP id
 n17-20020a81bd51000000b0031bdb7288a1mr3087923ywk.208.1656347131154; Mon, 27
 Jun 2022 09:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com>
 <20220624070656.GE79500@shbuild999.sh.intel.com> <20220624144358.lqt2ffjdry6p5u4d@google.com>
 <20220625023642.GA40868@shbuild999.sh.intel.com> <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com> <CALvZod7i_=7bNZR-LAXBPXJFxj-1KBuYs+rmG0iABAE1T90BPg@mail.gmail.com>
 <20220627151258.GB20878@shbuild999.sh.intel.com>
In-Reply-To: <20220627151258.GB20878@shbuild999.sh.intel.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 27 Jun 2022 09:25:20 -0700
Message-ID: <CALvZod5fxjZSWp=ikxhKN+JRaoWA4_ErNaJg1fieci3LY+-7qg@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 8:25 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Mon, Jun 27, 2022 at 07:52:55AM -0700, Shakeel Butt wrote:
> > On Mon, Jun 27, 2022 at 5:34 AM Feng Tang <feng.tang@intel.com> wrote:
> > > Yes, 1% is just around noise level for a microbenchmark.
> > >
> > > I went check the original test data of Oliver's report, the tests was
> > > run 6 rounds and the performance data is pretty stable (0Day's report
> > > will show any std deviation bigger than 2%)
> > >
> > > The test platform is a 4 sockets 72C/144T machine, and I run the
> > > same job (nr_tasks = 25% * nr_cpus) on one CascadeLake AP (4 nodes)
> > > and one Icelake 2 sockets platform, and saw 75% and 53% regresson on
> > > them.
> > >
> > > In the first email, there is a file named 'reproduce', it shows the
> > > basic test process:
> > >
> > > "
> > >   use 'performane' cpufre  governor for all CPUs
> > >
> > >   netserver -4 -D
> > >   modprobe sctp
> > >   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
> > >   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
> > >   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
> > >   (repeat 36 times in total)
> > >   ...
> > >
> > > "
> > >
> > > Which starts 36 (25% of nr_cpus) netperf clients. And the clients number
> > > also matters, I tried to increase the client number from 36 to 72(50%),
> > > and the regression is changed from 69.4% to 73.7%
> > >
> >
> > Am I understanding correctly that this 69.4% (or 73.7%) regression is
> > with cgroup v2?
>
> Yes.
>
> > Eric did the experiments on v2 but on real hardware where the
> > performance impact was negligible.
> >
> > BTW do you see similar regression for tcp as well or just sctp?
>
> Yes, I run TCP_SENDFILE case with 'send_size'==10K, it hits a
> 70%+ regressioin.
>

Thanks Feng. I think we should start with squeezing whatever we can
from layout changes and then try other approaches like increasing
batch size or something else. I can take a stab at this next week.

thanks,
Shakeel
