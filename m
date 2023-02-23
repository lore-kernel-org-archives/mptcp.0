Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800611FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 06:40:56 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id u14so7728565ple.7
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 22:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdHPnsPa9JsSktPZ91JIj0abI1B8FcfEYdJ7HepTpNU=;
        b=Z6Rg/M6aR/JpMwCWMZEPgrQvHTTj9263dfmEejeQuM1pqXd0MO4ViDmFbVFEB5DZlE
         Nx7YTeOsd5uBsppnHpswSILUt+jEBhLdVlf0TYuhC9IKMCEprA5kbNBUwcmT1tuvQ09I
         LaURJyjxsA4bZHeAO/hSpJTPdltW/o8y2mnwT0boEfdiWdJIgol76LNTsfVlNagztjVA
         1HHzd4nbzh52f5xeT1e2DCDF44NR0NOu420WASxMq9DMd/B6AW7Db6Cd792qsOU/00Vy
         tcenmmJr+5EhDqHTefgn+EUJDz+yPeDmniUBRA2oFH52sEcjpEUG/j9rJLCVzC9Gp5cP
         QRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdHPnsPa9JsSktPZ91JIj0abI1B8FcfEYdJ7HepTpNU=;
        b=LIT6qwJ5Locg7m5esqdq2cy7/4ZagvUB1vRaG2hpizDCt1biLPH2noSjOob9rd3mDz
         f6pAYrIktH8LF0KdSGQ3e/zK82ipLDiXOya7Ne8XXJbA3++ufTBvUNiVoNHFPBIo42ec
         w/uABChvkyvpR9Arcp+A5fNP0zU/OpeWTKsZgJLDIIdTWh++ekp0jiqZhUK6rzMQjp/t
         SM8cOZygPBi9RT+6Q1CDBR1IV3Qgds4Mo3R2RE+zeuGX1+QHKxydg4ZxfPmwPe6gNBti
         l7zUZtBBXosn6LkiScweoMkV+ziGRT0VprQqm7NAZQX6vL0ZeP9PJMQCspTfqPBfLUjD
         PIoA==
X-Gm-Message-State: AO0yUKUUuh71s5+g7R9+rb9uOnIhP3mhUIrH6KAwZSb6FyvdnIgXffSY
	eJqxuj2VdJkVpbHqv1RAdVY=
X-Google-Smtp-Source: AK7set/yrhf5VaDf1y4KwXxpA96cLUkHaRCV5X9oEyE38jdeud7wFxU++sG0nGsUJzPTCGS9w4qj8g==
X-Received: by 2002:a17:90b:4f4e:b0:230:acb2:e3e8 with SMTP id pj14-20020a17090b4f4e00b00230acb2e3e8mr10670399pjb.23.1677134455961;
        Wed, 22 Feb 2023 22:40:55 -0800 (PST)
Received: from Laptop-X1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a31c100b001fde655225fsm3467883pjf.2.2023.02.22.22.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 22:40:54 -0800 (PST)
Date: Thu, 23 Feb 2023 14:40:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Felix Maurer <fmaurer@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	mptcp@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: run mptcp in a dedicated netns
Message-ID: <Y/cKbW8SuPwBg96/@Laptop-X1>
References: <20230219070124.3900561-1-liuhangbin@gmail.com>
 <8781d9c2-2352-ac0b-9d79-82be8eb404ff@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8781d9c2-2352-ac0b-9d79-82be8eb404ff@linux.dev>

On Wed, Feb 22, 2023 at 03:44:17PM -0800, Martin KaFai Lau wrote:
> > +	system("ip netns del " NS_TEST " >& /dev/null");
> 
> It needs to be "&>", like the fix in commit 98e13848cf43 ("selftests/bpf:
> Fix decap_sanity_ns cleanup").

:Shame, Didn't notice this when do copy/paste...

> 
> Since it needs to respin, could you help and take this chance to put the
> above SYS() macro into the test_progs.h. Other selftests are doing similar
> thing also. If possible, it may be easier to have a configurable
> "goto_label" as the first arg.

OK, I will fix it.

Thanks
Hangbin
