Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E62F5B
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 14:53:06 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id r66so9352763pgr.2
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4nnCuaaqVKXnI7zfu4XEe/EidzYbOyoiaXDjkUN60I=;
        b=gM2IEHiWITi7+4u4kxy5XXhdNF32YfAWT9wfPYpqKED+86BqP0njb8qUgEGsh9TRYl
         FRgvQrSgG3jwRpHz/uynTtwGUcE/VoJkOuXWiry7nkDqDl2zZnQnFn3X5plbLx3+56e4
         hC0V9xPTZ2U0O8Y2L8ACjYHGOIzt7S5t8FpBOYyrGUe0ZInCXT+oy7CDYYs4Sf2DvCNY
         /KqagQAvzNqW1Eh3DsFCZ96+/e2yMMrqBvrtESk0Lw5VH/OFNxJ6iHniPwWMHoDSuUmt
         CAb+Lssqwd8d5t2N1o+ikpuuiFm7ysYla8g2bWw1dyswpjy7jf+F/+zei0aPAiIRJoaM
         cDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4nnCuaaqVKXnI7zfu4XEe/EidzYbOyoiaXDjkUN60I=;
        b=QwGRc6rPs5eBkTz8tY4vUeRUJvUhkqPu1iAE1jcE4a64oPyQPc3z7/qs7Tgq/pJKFZ
         p74krdR1pX5GRn9bBgzUy8LU2EYKdjfZi/yjzBKE1cIRUZLst2xaBUEZuldpfV+EkBRT
         RePGaZ4CLyd8gvg6hLiaUbPC/9s/iuQwnaRfHtgLxiCAh6SHRyXjugO6+/hE4Hlba6ep
         0Ew+jL+XRdhekwN2eK03fhYzjIdbVdp93m8mB0ogJqV0CWHv5rolORnwZi7/F+wLQRH7
         o2yBcRNkaxXpiFb2y48URCdhjnntn5A1YgfeOKCxy974sEc/NIDA6Q9p83GqPbVt2CJU
         E7ZA==
X-Gm-Message-State: AJIora+iZ1QjFDapmkBU6WHtHSRI15ROG4azDJoCYZ0NNol/2NvPohq+
	Zk4zSA2qmbbkPdQN/ERUpZTqDrXTDKXK0Sxj6cBcGw==
X-Google-Smtp-Source: AGRyM1vzP61WGqfu7fwvpR2g3YBsLeDPE49vmrsIKi0PKEuVDFQCZdthzssP0xkUNMYVlYw/hBLgJOeoW+fBSDeuNHo=
X-Received: by 2002:a63:6cc8:0:b0:40d:e553:f200 with SMTP id
 h191-20020a636cc8000000b0040de553f200mr6417592pgc.166.1656341586171; Mon, 27
 Jun 2022 07:53:06 -0700 (PDT)
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
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com> <20220627123415.GA32052@shbuild999.sh.intel.com>
In-Reply-To: <20220627123415.GA32052@shbuild999.sh.intel.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 27 Jun 2022 07:52:55 -0700
Message-ID: <CALvZod7i_=7bNZR-LAXBPXJFxj-1KBuYs+rmG0iABAE1T90BPg@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 5:34 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Mon, Jun 27, 2022 at 10:46:21AM +0200, Eric Dumazet wrote:
> > On Mon, Jun 27, 2022 at 4:38 AM Feng Tang <feng.tang@intel.com> wrote:
> [snip]
> > > > >
> > > > > Thanks Feng. Can you check the value of memory.kmem.tcp.max_usage_in_bytes
> > > > > in /sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service after making
> > > > > sure that the netperf test has already run?
> > > >
> > > > memory.kmem.tcp.max_usage_in_bytes:0
> > >
> > > Sorry, I made a mistake that in the original report from Oliver, it
> > > was 'cgroup v2' with a 'debian-11.1' rootfs.
> > >
> > > When you asked about cgroup info, I tried the job on another tbox, and
> > > the original 'job.yaml' didn't work, so I kept the 'netperf' test
> > > parameters and started a new job which somehow run with a 'debian-10.4'
> > > rootfs and acutally run with cgroup v1.
> > >
> > > And as you mentioned cgroup version does make a big difference, that
> > > with v1, the regression is reduced to 1% ~ 5% on different generations
> > > of test platforms. Eric mentioned they also got regression report,
> > > but much smaller one, maybe it's due to the cgroup version?
> >
> > This was using the current net-next tree.
> > Used recipe was something like:
> >
> > Make sure cgroup2 is mounted or mount it by mount -t cgroup2 none $MOUNT_POINT.
> > Enable memory controller by echo +memory > $MOUNT_POINT/cgroup.subtree_control.
> > Create a cgroup by mkdir $MOUNT_POINT/job.
> > Jump into that cgroup by echo $$ > $MOUNT_POINT/job/cgroup.procs.
> >
> > <Launch tests>
> >
> > The regression was smaller than 1%, so considered noise compared to
> > the benefits of the bug fix.
>
> Yes, 1% is just around noise level for a microbenchmark.
>
> I went check the original test data of Oliver's report, the tests was
> run 6 rounds and the performance data is pretty stable (0Day's report
> will show any std deviation bigger than 2%)
>
> The test platform is a 4 sockets 72C/144T machine, and I run the
> same job (nr_tasks = 25% * nr_cpus) on one CascadeLake AP (4 nodes)
> and one Icelake 2 sockets platform, and saw 75% and 53% regresson on
> them.
>
> In the first email, there is a file named 'reproduce', it shows the
> basic test process:
>
> "
>   use 'performane' cpufre  governor for all CPUs
>
>   netserver -4 -D
>   modprobe sctp
>   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
>   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
>   netperf -4 -H 127.0.0.1 -t SCTP_STREAM_MANY -c -C -l 300 -- -m 10K  &
>   (repeat 36 times in total)
>   ...
>
> "
>
> Which starts 36 (25% of nr_cpus) netperf clients. And the clients number
> also matters, I tried to increase the client number from 36 to 72(50%),
> and the regression is changed from 69.4% to 73.7%
>

Am I understanding correctly that this 69.4% (or 73.7%) regression is
with cgroup v2?

Eric did the experiments on v2 but on real hardware where the
performance impact was negligible.

BTW do you see similar regression for tcp as well or just sctp?
