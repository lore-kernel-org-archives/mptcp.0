Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC228E8
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 04:22:54 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-317a66d62dfso13437267b3.7
        for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrpVbauQhlY6sbHoa1+haYyof5/5LMZu+rrUVujXJmY=;
        b=DVqUHWwjqfSyUrKEEmRQ3laXS5aZCV+h8P/IkyQC8m5k2r+n3tUMsOoQKXSoh9WRlI
         m09tKWwK3GiflUWF0Dr20XIr6c7X7GVgN3HpaTX/FUe7X5ZdSfJ4ElUGmC7149/pIdQJ
         9o0+iH8IHPVcRhmTCZQMzuuMazOytWvgsLgpPgHhvHqc3gB5h6ZXqeagU/N6bqv7xKHW
         U5kAm0QEVu6jjxLZp8nNu53bqGtb1ImVP9XTBXqxr0HqrLOQoUvfXuq/KF0SsTK5lMEB
         F8UaqHOrxK2yqpZS0IusbDmoUsv65akGOoFjouvrzFa14L3TLe/6MHJKyUHyZ6f5eNMe
         WH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrpVbauQhlY6sbHoa1+haYyof5/5LMZu+rrUVujXJmY=;
        b=yTE4QTHk1WmOMZrdE0DMgryfBiwquDyiYZRo3Tgyb24+yll4fmw8grxMJUPJYMQoax
         77C4WjN4cXhkK/vmxqRMKa11rRdtV0W4V3gfaDAF0GFX+mzj7WcCBz+P38keewVaI/f8
         T8rB4p1D6nbf0EAH9sUuFcpjTVvYiWpgPl/vzrv/HQ+tM/M1CF0uEv7w6etRUKCVntNk
         pt6SKk+Kf7TjswdvbpJpQjQBlz07ILg3o9Z+9q5aVnHD0tzZ7xTCUZ1I3HoHFzLqqnUu
         sh7Y1MSQZvtHBLBmeh1SqGZ7dZgRekyURwnW8Yv100sjdSpmcxrIqrJT37u6BIMBHwkM
         c4sQ==
X-Gm-Message-State: AJIora/NhDSjZ0ReBqonqbnKGxcMDlcpWtgTzpXV85hP7jGwY/iw7yn7
	8QTCDbNrj/gkhFqIPylpnUun+zk5M4wLM1DUpxT+Tw==
X-Google-Smtp-Source: AGRyM1sL30OODStpdjLZ8dh2J46BQTAQn1IcN8JlLsvqWmybh46yRWiK6BObk+Guv/QOX5qo3870LRterozi/iWkdf0=
X-Received: by 2002:a81:9b93:0:b0:317:8c9d:4c22 with SMTP id
 s141-20020a819b93000000b003178c9d4c22mr14652446ywg.278.1656044573688; Thu, 23
 Jun 2022 21:22:53 -0700 (PDT)
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
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Jun 2022 06:22:42 +0200
Message-ID: <CANn89iLZYGOjTFThvq-J678BtPtqsywwxFekt9XTcPxk_La8eg@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, kernel test robot <oliver.sang@intel.com>, 
	Shakeel Butt <shakeelb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, network dev <netdev@vger.kernel.org>, linux-s390@vger.kernel.org, 
	MPTCP Upstream <mptcp@lists.linux.dev>, 
	"linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, lkp@lists.01.org, 
	kbuild test robot <lkp@intel.com>, Huang Ying <ying.huang@intel.com>, "Tang, Feng" <feng.tang@intel.com>, 
	zhengjun.xing@linux.intel.com, fengwei.yin@intel.com, 
	Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 24, 2022 at 6:13 AM Eric Dumazet <edumazet@google.com> wrote:
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

I guess the test now hits memcg limits more often, forcing expensive reclaim,
and the memcg limits need some adjustments.

Overall, tests enabling memcg should probably need fine tuning, I will
defer to Intel folks.


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
