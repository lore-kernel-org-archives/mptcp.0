Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE07187F
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 14:44:02 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-3187c3e8751so23530837b3.2
        for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4626xia5d5LkF7af7H2/cvkuUYPcK6Kx8h2FacVJFEk=;
        b=th1qe6nCen6zmaCB190GBZfnRnMr8qckPf7xXdSq0EVD8gYjLt6WzhfTitRavGwMgd
         vXilcNgCDBJRRUwP86/NE2cFk2yt4LhrpvKbk+OSVaOhZ9QX7RoXNrnjse0RW8wrov0A
         e/AjVrKc+b2APqiS3MmTV8TXpGYJnfibLdZbRt8tPJAQ4VejcBVaHjm3xiHfRthqt3hO
         14SO9lJx7tqftr6orGS/SfyVF/xr5P71GTXTgmaE3fA6eyIJ4dLNQMv3/dfvge1guWtE
         73rzZBtWVKfBk7sNXfxQEVTU5QpWxtJpBQ75xhUnQaYU9jnnZSOcZn/PcgtTEVHgJAUL
         xvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4626xia5d5LkF7af7H2/cvkuUYPcK6Kx8h2FacVJFEk=;
        b=SpnIpdviPyg0YVaXVW/YAINGi50oXf1SVTKtJLcUofOrS+ixmC7ZtREqVqh24VF03a
         /AiO4DJhEgk+aQQxgK6MDtdJxSECIbB61OtmIRelCy/CgwXGU61skB8vP3wFKupT9A1l
         Nsm1mXT8YE0I4Z5jar8Ly3tTn09bQ6803JQQburUPPT1V9J8z/mrTMhDxSTcF+yybxLR
         NYguIWTXCEAYJQyDEZ3l1cPyS6Dtyb0t71pomF01Beo3MKxWfBtpsM7MtGwIUFfRxS5E
         jwva826Z9RMb46ISQVDOgw/tLBhVxlQfhzTbrJFrdt3tHjnmKhE4PUaEZkQkjxS4L7sS
         rnvw==
X-Gm-Message-State: AJIora/NHR+fwaj0PvqZ2Tv7XT6gRrVKRrxVt2pounkNgrgR1OjE/7e1
	LC8LTG8X9U9sJPmSbhpLxNgyjL8xbtrg1g==
X-Google-Smtp-Source: AGRyM1u8PEp1pM9/KxJIfa3nFsPEcGkFKuipmMhOWQIlB56Ud7icllIM9M0fY7r3dfrgjjZsEQIIA/WAW9Z2GQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr5658217ybb.447.1656081841097; Fri, 24
 Jun 2022 07:44:01 -0700 (PDT)
Date: Fri, 24 Jun 2022 14:43:58 +0000
In-Reply-To: <20220624070656.GE79500@shbuild999.sh.intel.com>
Message-Id: <20220624144358.lqt2ffjdry6p5u4d@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20220619150456.GB34471@xsang-OptiPlex-9020> <20220622172857.37db0d29@kernel.org>
 <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com>
 <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com> <20220624070656.GE79500@shbuild999.sh.intel.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
From: Shakeel Butt <shakeelb@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 24, 2022 at 03:06:56PM +0800, Feng Tang wrote:
> On Thu, Jun 23, 2022 at 11:34:15PM -0700, Shakeel Butt wrote:
[...]
> > 
> > Feng, can you please explain the memcg setup on these test machines
> > and if the tests are run in root or non-root memcg?
> 
> I don't know the exact setup, Philip/Oliver from 0Day can correct me.
> 
> I logged into a test box which runs netperf test, and it seems to be
> cgoup v1 and non-root memcg. The netperf tasks all sit in dir:
> '/sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service'
> 

Thanks Feng. Can you check the value of memory.kmem.tcp.max_usage_in_bytes
in /sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service after making
sure that the netperf test has already run?

If this is non-zero then network memory accounting is enabled and the
slowdown is expected.

> And the rootfs is a debian based rootfs
> 
> Thanks,
> Feng
> 
> 
> > thanks,
> > Shakeel
