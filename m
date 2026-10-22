Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792661057;
	b=ryRrmJVDypFeLcrnopbmuVlZTDT5qMD4tFl1zj1XSmfCA6kXeKS+hZIRG4sFH83f5IBe
	 28bBL25BIExIrQXW62jHhbqSTuwTJTA2ZK8b7tccPZ1ut6qjShb9Kk2R9vYyhNRU8Xkqh
	 1JQEZ24KuAtlRgn8ma/fR+smmuxtdwp97VWBa8f2hPaObW+te0KlWYw4Juakf7jiKN9yK
	 Y/izXtYkU/mj3X5g1CtI8z53W22/nty798oXoVuRzXy+sOG//Kmj+m59mnRwlXdhDZRhI
	 OprKTSnfnrNHwi+nKw+sbCIQoFMBaf8Us5qESYC8XDd3CJAEgUEJBtbJpTDSC7Bk1gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7qrsopBdEKb0SZDAnr+WOytcfD1CHG+HPMeBfC2+1aI=;
	b=pQjamfXJT4JlhOvAMXNg8pRswYbp1a4LxcrF/wArh7g3E1mNU1Sgp9dxHaLA+gUtDflx
	 nOyf7hG+w0bBWT/LbsZ5edcWlCxhTU2Aj+772v89iG0Z/1NUw1ke1OZ4VwrqycIi3sQW7
	 iRcO5m+LFJ8ywY3U8aDTow51hoRyDVIkRl9PLiSaCLai/OOeiVoQoPBy0e/TN713HEMud
	 LTUTVIJoqZdZYjzhCl3zo3YEdDlDZRYN9soZkFH6cxcgc/NpHJXTR7z6jfV1HgyAg3C0l
	 hD1H4uaRjZrRzPL9Ys7rQRqSsQ7IJdjtaWFi8oLPF9uHUFbjQCVvlU/JWtT5i1TndEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pfOqIWge;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8001606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 09:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8001606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pfOqIWge
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a5a26c8412so16535701fa.3
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 02:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792661055; cv=none;
        d=google.com; s=arc-20260327;
        b=rO2g/1OR5x4EM1z2c8Is/jQKtzyC4jp9/yPHdfNgy6RF6luftUcEs+thRji409gt0G
         o8501Xttfo8vBU0gLQqC/b+TwdOPFuvdrmURf+yI9zMejybz2UZ2l86vUuNnwV5bfKb8
         8LhqGYr/07UCtaj/r/SOyQay/z+NWo1YFlhbxodVWuBJe2xKqYYfC1GKiJ7bDy0v8Y2w
         mVxtIQT6+XTpXBsr3DkqF8W8/gpxZleL2ml4riEEDrK+bDbpbtXjQ6Yo17zAU4Zti+Yd
         p1bVlS+dFRxBxUvhAfcgT+hz1JCDpu+ccQxxlrY1JiMaeZmVW2crF7w+Q4n3rTmuy9Bi
         CLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7qrsopBdEKb0SZDAnr+WOytcfD1CHG+HPMeBfC2+1aI=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=GqmtOJv75K/tGOkhEBIpuBp5zZI7xgJVk8VQsBd6Ip1XJg+ysZKt+WJ/U/TTyLwEDz
         1AUlyyd6uxvRmPxok1JPNsRpZmlH5P9/R73tylpbFvvAJaHQDrarHan0MEhfMxzCLXnK
         Cn3OBohohqoRIWua4qY+ZhdF5UfWMPuhvUMqWATqZLuLFGTXFugJ4s50F/2PISlhDXwM
         3A9Ku0EptIb6cL14/zDfpaEDo6Y+6cqCoHtK5m+NlhcEQZNTAFLoaDfqfWdXUQi0hIjC
         9Kw09OvACfhOrVKpDgCaCKlNbIflSN1NcCbNYy1+3uCOEiGdrx3dGbPSTS0bv5Kcz4jv
         zGQA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792661055; x=1793265855; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7qrsopBdEKb0SZDAnr+WOytcfD1CHG+HPMeBfC2+1aI=;
        b=pfOqIWgevU24v5XaWB9vGqOgTtjTbw5dOCTioZMmElhqz63NwwnFkKjFOZVZkH4F4f
         SleRyXwemO5ZCeKu6GDqZWhwUjgPXUHbk0qT2N60sNnluzIxTHLENYn3QTtsSQ3KPwGk
         q1YK1GSrR7+dvloDCcr/F3W+S2afThcQydoBzJX6tyJK1kQpTWJGiat8n51R7/tAiMPT
         e+cOGtSsXmZEcyHv83nWRZTZ38hD0RjxDx2pEIaG3vMwDTVanfOt34fhURP6ncerS7r0
         K6id5ijnRG3hqcajo5F0thcjWkwA5Q9yWmRzpcdlFbbiqZGZi4t+Fg5GxKLKo5GMMEEB
         +rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661055; x=1793265855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7qrsopBdEKb0SZDAnr+WOytcfD1CHG+HPMeBfC2+1aI=;
        b=rVh39fZgpudOZmhMz9ZfyUeM89ERtJE992Qv2AdGG80Q2lpCcnY2Bxzmcu+vHQJFh9
         HfulXimA3vUiNOhiR6pmUnUnvUoezsIeTUmNiTzcI0YoyQLMnAb2DCa4QAkGMqDFFsd+
         P6dXTRdAQaiYnFrf9tVFdxUqucNAnlUiw12UvvMIQuCVG33m3tXhiudnV07ORlu+2E8P
         Np3yKp2wCLVxWfGDFYbhg7jbGlHwl5h3O6G7IFfdRk7DtIj91TD+cWZ44lF+WCmkU6De
         5mzZSnx4F1l52b96arGuIIjp7IBisQQr7qXxRtYNtu27q5usEtlmwVYQtKnegZGbPKGv
         K1rg==
X-Gm-Message-State: AFq9FYLsnOwInrTtm15aEREhRMRSTYlC+2WicvxLtfdQLdECznLcZ6Dh
	R7ce+rxRCSAA0pVpqYOg2gal0c7Ao15TDFbm554UhtnKHob29mpS41i6fbySFWFuBHJzTBh445C
	EZmJcsj+vF+65jG2AdFu61/pshoAOsdni9fWR
X-Gm-Gg: AYBFou3a7H8jlJQ0Uoc2T+QjAK0dUswl8F3ailX7I/zDAXqdz9zWd+oYQpGGEhtB7v1
	jjb8/+Z3OIdFUBbAeXE1H/dI/v9ZOmWu2f/0oU3PN8124Vl/cN1IDuY1bkYK4GQfpDNztS0kjc4
	3AoNKJn6Q7ObaM6tbWcPWA5F8Nmr3IZPV5UUHIHWGUltDMC420Ii5yMpfgnzzMzDoNW1lmD18nG
	NYQRlMJcrkqcGNOlGRuahEnh0qCk/KmBeCegcAyJpQ7ydfV7aFccj20oh8yvqRuIe5M1mMS3XR1
	5U2N3PFvYG7PuK/mqr8iRPmMKuYnyXbxXKksHgdCDgqET1eUoIdkep+Vaao/V58jWv42XeJHTUB
	6GOqtqTfkdOUZ7Os1UGzoQLB8lLfgIhhdjxvICdKJ8Rj/PYk7y1fb55mIZA==
X-Received: by 2002:a05:651c:19a0:b0:3aa:f8c7:d10f with SMTP id
 38308e7fff4ca-3ac440a2bf5mr12057781fa.3.1792661054591; Thu, 22 Oct 2026
 02:24:14 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-3-anilkaushikwireless@gmail.com> <b150dde6-05f1-4e7b-9440-360b7ce17eff@kernel.org>
 <CAG0Mgm_uj70o=R5HnEb0GkTy4FTQK6cy6GHWuO7y2FitzwnucA@mail.gmail.com>
 <7c7308c5-c150-41a1-9d84-9981acfb5962@kernel.org> <ffc98c40-09d5-4299-8128-72cc0ed6beae@kernel.org>
 <CAG0Mgm9ShHdApcKAUj_PgGdm_A+w--FKpSpJq=nTJ=DkRcuACA@mail.gmail.com> <4180b794-8877-4516-9400-afb0894e8f49@kernel.org>
In-Reply-To: <4180b794-8877-4516-9400-afb0894e8f49@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Thu, 22 Oct 2026 14:54:03 +0530
X-Gm-Features: AclHuK_RCQ1LS7xpTL9NAB5RseC8R1LNqa1II4YqpCXE0i17h71qxnaNUUroZck
Message-ID: <CAG0Mgm85JF6bFs2Nwije+2cbFjC-DmUNLeanwSCqOXxU=c1piA@mail.gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

  Thanks for the review.

My response inline.

On Thu, Oct 22, 2026 at 1:02=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Anil,
>
> Thank you for your reply.
>
> On 21/10/2026 20:20, Anil Kaushik wrote:
> > On Wed, Oct 21, 2026 at 11:18=E2=80=AFPM Matthieu Baerts <matttbe@kerne=
l.org> wrote:
> >> On 16/10/2026 10:43, Matthieu Baerts wrote:
> >>> On 16/10/2026 07:49, Anil Kaushik wrote:
> >>>>> Add a sensible default value (what do you recommend?)
> >>>>
> >>>> 15 SYN retries: about 20 minutes with the 120s max RTO.
> >>>
> >>> I guess it could even be longer, no? With an exponential backoff, it'=
s
> >>> not spamming the network too much.
> >>>
> >>> I wonder if we shouldn't get something similar to tcp_retries2. But
> >>> here, with the syn, we also need to tcp_syn_linear_timeouts into
> >>> account. Either we keep it to 15 by default and, (if not 0), we add
> >>> tcp_syn_linear_timeouts, or we initialise it to 19.
> >>>
> >
> > tcp_write_timeout() already adds tcp_syn_linear_timeouts on top of
> > icsk_syn_retries for SYN_SENT sockets. With the defaults, 15 gives 4
> > linear + 15 exponential retries, about 20 minutes, close to
> > tcp_retries2. I can make it longer if you prefer. Let me know please?
>
> It is always tricky to find a good default value. I guess 15-20 minutes
> is fine for most people. Connections are usually not that long, but some
> can be, e.g. ssh. But then, what do we loose to put it higher by default
> to support more cases? Maybe environments with low memory could not like
> that, but either they don't manage that many connections, or they don't
> use MPTCP.
>
> When I look at nf_conntrack_tcp_timeout_established, it is set to 5 days
> by default, so we shouldn't go higher than that. But maybe we should
> target a few hours by default? e.g. using 20 (~10.5h?) or maybe better
> to use 21 (~21h) or 22 to cover a WE (~42.5h?)?
>
The SYN RTO is capped at TCP_RTO_MAX (120s), so after the first
doubling each retry only adds 2 minutes: 20 is about 30 minutes,and
the maximum, 127 (MAX_TCP_SYNCNT), about 4 hours.
Should I use 127 by default, to get a few hours? Covering a weekend
would need something else, e.g. a new attempt once the SYN retries are
used up, which would bring a timer back. Let me know what you think?

> >>>>> modify icsk_syn_retries instead [...] WDYT?
> >>>>
> >>>> Good idea, I will do that: one new subflow per failure, with its SYN
> >>>> retries set from the new netlink limit, 0 =3D disabled. It also remo=
ves
> >>>> the socket reuse, the retries counter and the 60s check.
> >>>>
> >>>> One point to think though, If ICMP unreachable stops the SYN at once=
.
> >>>> I would not retry
> >>>> again then. Is that OK?
> >>>
> >>> Good point. In your specific case, what do you observe?
> >
> > In my tests, the fiber outage is a silent drop: the SYNs just time
> > out, and the subflow comes back once the path is up again.
>
> Interesting. Out of curiosity, how long are these outages typically?
> Less than ~20 minutes I suppose?
>
It varies. Short ones are a few minutes, but when the fiber is cut, the
repair can take several hours. So a longer default would help.

> >>> To me, the best is to have the network manager (something from
> >>> userspace) removing the MPTCP endpoints when they are not "usable", b=
ut
> >>> here it can be specific to the destination. I would then say to look =
at
> >>> this case later. In this case, we could eventually disconnect the
> >>> subflow, and add a timer to retry later. But that's also more prone t=
o
> >>> bugs, so if we can avoid that, probably better to!
> >>>
> >
> > Sure, lets take up this case later
> >
> >>>>> Do we have other similar ones? [...] ss -Mte, would that work?
> >>>>
> >>>> I will drop the MIB counter. The test can use the MPJ counters and t=
he
> >>>> netlink events.
> >>>
> >>> Thanks! You can expose the new limit in "struct mptcp_info", instead =
of
> >>> "reserved".
> >>>
> >
> > Done since v5.
>
> Thanks.
>
> >>>>> Is it specific for your case?
> >>>>
> >>>> No, it came from a Sashiko review: a dead subflow waiting to be clos=
ed
> >>>> could be re-created after its endpoint or the peer's address was
> >>>> removed. I will try to move it to pm_kernel.c.
> >>>
> >>> What did you end-up doing for this?
> >>>
> >
> > When an address is removed, mptcp_pm_rm_addr_or_subflow() now marks the
> > subflows using it, so they are not re-created.
>
> Good, simpler.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
Regards
Anil
