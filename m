Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEE5391
	for <mptcp@lists.linux.dev>; Tue, 16 Aug 2022 15:55:54 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id a8so10099096pjg.5
        for <mptcp@lists.linux.dev>; Tue, 16 Aug 2022 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S0TjqgZ/cpwhvqIRclTaRgLLFqhzUsXjGRreU5l1Dao=;
        b=qTx7jEv4/nwmvCExtD6R89Dm1SBJ4SkhasuOIfOrwWZ6K1t2Zr0EaCkQWcJCS/uim+
         8X9WP8VRmTcp17JN0SF1dTFzd9Oh4JZoisOJYrLLcIy4MM3xb74oG5Mscfg6rwcrXhJI
         hQdCdNpKMiGt/+1SGkofKjc4IhOG8u/ztqpv2yctdU8Nuk2IMbHx6qI6TzuQQ0klWjGq
         aFceiAkHInK+h5iWx+IC90K1AiFSPR3Plz+cYfA1om82VYY1xFn9WCIj5pzWRvWr0cZB
         /NocanLC50/KXHrrK96ND8mMKm9IrEstRN/hRIk2ALjS9Xwx1q7bVX56kmoPPF2s2jMo
         tW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S0TjqgZ/cpwhvqIRclTaRgLLFqhzUsXjGRreU5l1Dao=;
        b=b4RoldxDzkScowh8txmhlohplGi8VzXcbimZN3tPAMTyDmT88BIvW1OItQID+xGjLs
         9U4nM2KD1hL782I1dBBq8TItk9NHSlosU3cIL/54MSZkZEfYuHbVOFPH9whwwYr4HHF3
         ssUqFOBALomhWUISSwJ77WdPbnf4pSnYz9XPLT/PeCoRVbX8VHLv3MVkMz33i4LNkjSe
         q3dcy4hKyQRRccFR+NKCW3x1vMwoC+bnUnx7MULe62hYOdIcOy5pUEU+MIDhtVkWn8Q3
         9rRvZ7QavaRoq3HGOTq/q1g8coeVA1W7HtOkOOWgJ9s8ucub3wA0ebZZhFu2jNXnEllu
         gagQ==
X-Gm-Message-State: ACgBeo2Bukbk/e+11EJws+tklgUclYInmkskwvCOmegUIxiOw1tpn1By
	AMmfvIap7Kye6FTtaVzFUsJVA1tReF3UMZJhqNtfjg==
X-Google-Smtp-Source: AA6agR7rNOEKD6nRN5Avv+ABuxkIhBYlnMLShbilL+t09HuhZ24Kqp5AE/3faQMwTl37shqIo4Nw0wBbJ21Udr/teco=
X-Received: by 2002:a17:902:8683:b0:171:3114:7678 with SMTP id
 g3-20020a170902868300b0017131147678mr22420060plo.172.1660665354218; Tue, 16
 Aug 2022 08:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com> <CANn89iJAoYCebNbXpNMXRoDUkFMhg9QagetVU9NZUq+GnLMgqQ@mail.gmail.com>
 <20220627144822.GA20878@shbuild999.sh.intel.com> <CANn89iLSWm-c4XE79rUsxzOp3VwXVDhOEPTQnWgeQ48UwM=u7Q@mail.gmail.com>
 <20220628034926.GA69004@shbuild999.sh.intel.com> <CALvZod71Fti8yLC08mdpDk-TLYJVyfVVauWSj1zk=BhN1-GPdA@mail.gmail.com>
 <20220703104353.GB62281@shbuild999.sh.intel.com> <YsIeYzEuj95PWMWO@castle>
 <20220705050326.GF62281@shbuild999.sh.intel.com> <YvswusNaC5yr+HwT@xsang-OptiPlex-9020>
In-Reply-To: <YvswusNaC5yr+HwT@xsang-OptiPlex-9020>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 16 Aug 2022 08:55:43 -0700
Message-ID: <CALvZod66HFiBX2N07gmCYDk_iH0bf4U+O=0DqUDmcebpOSyvwA@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: Feng Tang <feng.tang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <songmuchun@bytedance.com>, 
	Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, network dev <netdev@vger.kernel.org>, 
	linux-s390@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>, 
	"linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>, lkp@lists.01.org, 
	kbuild test robot <lkp@intel.com>, Huang Ying <ying.huang@intel.com>, 
	Xing Zhengjun <zhengjun.xing@linux.intel.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 15, 2022 at 10:53 PM Oliver Sang <oliver.sang@intel.com> wrote:
>
> Hi all,
>
> now we noticed this commit has already merged into mainline, and in our tests
> there is still similar regression. [1]
>
> not sure if there is a plan to merge some of the solutions that have been
> discussed in this thread? we'll very glad to test patches if there is a request
>
> Thanks a lot!

Hi Oliver, sorry for the delay. I will send out the patches in a day or two.

thanks,
Shakeel
