Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D47F
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651673127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KePHkc18bjxPgySU/JbdmZ0mA5kRFRbiEG8X0A+CK5Q=;
	b=PnX6GGMxGcmaDRrsN0tAndQVa+ujTPrGqChvpUIzClcet4YSvju6h6+mUO1ypl4a6TxwPU
	BoR2R/sEGOP6dcGai03WRON4rMN6cNkrvUJgdsDxYeYGlAiPK6HarqK8TMp63CkCGIXCjE
	clFhuWyn5YqVfCI1GEGgzvX7IeVwzrA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-LYGg6UlyPlWhjcXWd26J7A-1; Wed, 04 May 2022 10:05:26 -0400
X-MC-Unique: LYGg6UlyPlWhjcXWd26J7A-1
Received: by mail-wm1-f70.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so695244wmi.8
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 07:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KePHkc18bjxPgySU/JbdmZ0mA5kRFRbiEG8X0A+CK5Q=;
        b=I6TEFh0GhSPOro7E5sq5fd53Uwrcp/Wn56KhAq5M1DxDS0rp/TsFH/8UvsZgGx1Vp1
         bIvyc86Gb94jDHTdvFGkFbXUJ0AOP4RbTsrk+L+C2xCUdzf3aLJWTSr6a6o3DqNw+VS1
         vXgR9qUz3bcHM+RR8Bl94XopTcr1yiRaKcsihlzwwkkMXqJiwu7U1bHZc0XX9RYy8tbN
         rGkhWW98jsq++1N0GQw+6CjNYi6p5VAodK3bvGYWZF0E6GTT1FRUiPaHSs2/92fl0kSk
         QTih/BeeqyeaUu8fNCc0oF8KRnWhE5qMwDsVsNjQwz3JaORKT7odgmSRCP1as8h0WU1y
         7PCA==
X-Gm-Message-State: AOAM532TY6nrp1jornyXwvKvBsUwIRIgWRMh399TzkJSsDaJXd4kuGlj
	XhX2LR8Iqb+Mn7TwuWcb4FXhwr7WaM8yUtyWTVOslPFJLw6sJa1gb/2/N8aQ3O95egsoIi5Fkoz
	hUn6yrrA/llXY60s=
X-Received: by 2002:a5d:598e:0:b0:20c:57ef:6083 with SMTP id n14-20020a5d598e000000b0020c57ef6083mr14824831wri.457.1651673125666;
        Wed, 04 May 2022 07:05:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg4HWxIxAukm4Fz8+mFy0ZD8EwnGrwUvAITjlrbCOMXpW8qBXL+hyIJUmcgN0gUcJ5EzKLEw==
X-Received: by 2002:a5d:598e:0:b0:20c:57ef:6083 with SMTP id n14-20020a5d598e000000b0020c57ef6083mr14824812wri.457.1651673125358;
        Wed, 04 May 2022 07:05:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003942a244f47sm4592529wmk.32.2022.05.04.07.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 07:05:24 -0700 (PDT)
Message-ID: <f27a5f8af0ff5217c1255a1ecadcd28647fd5989.camel@redhat.com>
Subject: Re: [Weekly meetings] MoM - 28th of April 2022 (MP_FAIL followup)
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang
 <geliang.tang@suse.com>
Date: Wed, 04 May 2022 16:05:23 +0200
In-Reply-To: <CA+WQbwuGakz4Ytj2zr6OAQu++p1-QiS5F+BsCFTHfetyT8T6OA@mail.gmail.com>
References: <6052111-39d7-1037-d711-59a3929db477@linux.intel.com>
	 <8c369784-1387-887e-6aa-60d631897690@linux.intel.com>
	 <CA+WQbwuGakz4Ytj2zr6OAQu++p1-QiS5F+BsCFTHfetyT8T6OA@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2022-05-04 at 10:44 +0800, Geliang Tang wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2022年5月4日周三 04:41写道：
> 
> > 
> > 
> > On Thu, 28 Apr 2022, Mat Martineau wrote:
> > 
> > >    - Features for net-next (next):
> > > 
> > >        - [8053fb8d49ed] selftests: mptcp: add MP_FAIL reset testcase
> > > (Geliang Tang)
> > >          - Two pending issues: open issue regarding multiple MP_FAIL in self
> > > test, and dropping of bad data.
> > >          - Prioritize MP_FAIL fixes
> > >          - Follow up on ML to make sure Geliang is not blocked [Mat]
> > > 
> 
> With Paolo's commit "net/sched: act_pedit: really ensure the skb is
> writable", all pending issues about MP_FAIL have been solved.
> 
> > 
> > Geliang -
> > 
> > Were the two issues to resolve before upstreaming "selftests: mptcp: add
> > MP_FAIL reset testcase" these:
> > 
> > 1. https://github.com/multipath-tcp/mptcp_net-next/issues/265
> > 
> > 2. Waiting for feedback on how to drop data on checksum failure.
> > 
> > 
> > For #1, Paolo has been making a lot of progress there. Since the bug is
> > tracked, it will be clear when it is closed and no longer blocks
> > upstreaming
> > 
> 
> Now all these '2 MP_FAIL[s]' issues has been fixed:
> 
> 095 MP_FAIL MP_RST                       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          sum[ ok ] - csum  [ ok ]
>                                          ftx[fail] got 2 MP_FAIL[s] TX
> expected 1
>  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
>                                          rtx[fail] got 2 MP_RST[s] TX expected 1
>  - rstrx [fail] got 2 MP_RST[s] RX expected 1
>                                          itx[ ok ] - infirx[ ok ]
> 
> No '2 MP_FAIL[s]' issues in my test anymore.
> 
> 
> But I still got another type of failures (0 MP_FAIL[s]) in my test:
> 
> 002 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          sum[ ok ] - csum  [ ok ]
>                                          ftx[ ok ] - failrx[fail] got
> 0 MP_FAIL[s] RX expected 1
>                                          rtx[ ok ] - rstrx [fail] got
> 0 MP_RST[s] RX expected 1
>                                          itx[ ok ] - infirx[ ok ]
> 
> It seems MP_FAIL is lost in some cases. MP_FAIL is sent, but not received.
> 
> I don't know whether Paolo is also looking at this 0 MP_FAIL[s] issue,
> or whether it is necessary to open a new issue on Githut to track this
> issue.

[browsers!] I'm not working on it right now. I can have a look at the
end of the week or the next one, if the issue is still pending.

Meanwhile, I suggest to track it with an individual/specific gitlab
issue - to collect all the relevant info in a single place.

Cheers,

Paolo

