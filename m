Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667111;
	b=iOkN/Kc76PVMxsZ1quoruYBYGrlxyK3LcVXzJYj6zs+pYFGKzzBkG90W5KRUMyz9TbkR
	 K7B5s/DvyJkM/dFqudnPTHc8PcKVJRnolON4qT/qeqFKWPB9J2ifc5h7zJpJfLkhW/eWM
	 pLkCuUgmJps4AJZrJ846frsWnID3FgXvCMzz1wfHPlM8iEeYs//whnHQsNRq9QOlLXV4W
	 uZ+4y3SqEEedLayrH4PcuNUU3vCohQKj0bqx/Hqoc48aaa5OMK2dY63t4SneZaZhkrWcj
	 3OdNaZIFNLutAQNEDQCFy+STkkw+yMMU/sNZrfPBOav3n50E26g1epWmj4JHDhMPZJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9NGRkYSpVr1rV/Jv/r+XGqK1KJCqYa/beS3iVvgqf6w=;
	b=kYbsQtCtYDkMvvFiSSnLHCzTK7OF0eO8e96RyFIgUtTsbWTqW592PdH3GIurQX9Zb78o
	 GsmQUkKbbsdLOuS5mHRVmozL5mt1CwsrsQOR64J7DAqlSryfI4o8mvKWTJhSHoVf4V0pn
	 yBBmWGZmnHbgOLW5/qwklZ2yPeu1KXK738sBZmMuPR0g5KOWE1yASl3TO9qoFj8jXk//9
	 MfHfKiuc20YpFVtHBkHLAOgkAzyGhmQaAXgWglxGudGDJhizLUQ+yBUfAsdOVL65ZMRuc
	 wd1cro4gkgK1bcgRxMpydiPrEpgqfWTnlDqVVE/pAFk0pvnmNj/UADBGTOf5MRmYF7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AqrfFAM1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B6606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 11:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0B6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AqrfFAM1
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso308520e87.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 04:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792667110; cv=none;
        d=google.com; s=arc-20260327;
        b=WH1JftwwhkY9v1cIXBtR6CE64+6GU5JQxC835M1AvNgSHqDPOUV8SfZPP2V6Y7QSK4
         qVe5nDDE7unoNijNhX96fscS5cOVzF2+Bmr4/x+DE1eCn+JfGGrKfKvQQJjvLtNiMtHz
         4lyTGh9PLMG5ZxGMqdgq2/pCSkY86vD1w6UkTSX6sv0+EQVNE10BvLY7RcNzKBa6XNDB
         gdQkCsW+FgXhWKujjHvyWPkGC7g2ZQIKBQQ1MZilimyg6GVim3pvTSejKvJwP9oPyuDC
         gWggddGHPc/mOOFmBB4zf/F3TV7mp2FHhKYN2Sr3TSNON8fZrcs8Rxgul9dYxwSWXOYF
         pguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9NGRkYSpVr1rV/Jv/r+XGqK1KJCqYa/beS3iVvgqf6w=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=l9ifpmajaZAeTnDQluoOA9FCh7MCtuXGYLuNEIftWj54/zhoKIXEQzOECn/giIe1/H
         L3+6y0X4KVt3P8x1C2MdjGcf2yxetItnvhqUSzMny3ZUndUWv19Ms5vo3FixfAAf6FXj
         UTmYzCXWbGW6k9uj9/ryOQzfBzXRCchZEIhMe36dQJoM8M1kKqtbZ+j1/PDWp7Vfg2m0
         vdpPHkwW09WKoMbNpHx7Z4Guh2M+4MxZrLg8AEnZ8pgEythswKuIV9IGwoZJVkRbbmyl
         j6TGJY9ldAEOt9/WH24h8zLkLOFVM4I+EZ9xNrCStrz1M2Wvc9L389NoeyJJejABQeso
         K73g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792667110; x=1793271910; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9NGRkYSpVr1rV/Jv/r+XGqK1KJCqYa/beS3iVvgqf6w=;
        b=AqrfFAM1TK5mY4oWcTcrPnBD5KQfPdLaNxunGJXSwuVE1hWtv2gbWudpfp8w3YNbIh
         cf2cyIl8JRgcIBsJJuL7M2ktT4zuSoHjtwyS4zMyqLM6qCDZGtLgsYCFdOwNdegNe48B
         Je6v6GLDzkAaUUnfJ5FOIxe8WewtWKBHDIPliQmGDx2agYJdYu+pcaAqp7y/XVIV5xvx
         SJ2qVjdwDB8KS3w8xlbxt9nITlE5FvggNPU7h3dU2eOR/8g75/FhNz+7xXyNkwi0hPxR
         V7XdYKtmwPbVzRnwSrBaSjaD2SmXr0JM2kNHtm0GxEmYexsbRMFxrsdrGrhcaG2O4+pt
         GHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667110; x=1793271910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9NGRkYSpVr1rV/Jv/r+XGqK1KJCqYa/beS3iVvgqf6w=;
        b=O4Wz6Od7ykWMy5N1yyIbEW0UJm9FKKGVxjbgZgbKwFMbr0BtBd2CsJTBHz1RpkAME5
         Pvh+g5Pf3LY+URUgdHEZ1qMhq2T0M5yskcw7Ou2SiMi4mau3e/NquByZshEvLmqXTWpz
         LLTkB9FG5dBOFoHQZLpdMWZMfhW+9xVBW2mbNvkzrENjFy1slr+n3GeerKsobzze0obf
         XDmlbsnAXq8g3Ejbhj9CtwK/RSxj/SklYhzxdPLTATX7YSYY0oEyjarCo8Sav9IPN03Y
         vSozKSTdZaBmRJcuR3e5Yw1tfs0gqr0LAhn7v8EIafsBoos0/38ftDO8EEsvr8pYmbca
         hwuQ==
X-Gm-Message-State: AFq9FYK2o5L06nd0T0MN7DbAFVeyij/7kdWIAATHIZOl49f5csYplfUR
	+0OEe4PKy5h/qmfkgYkxjquAKFIB871MA5nMWJvoKE1xY9OgCso46eyRb49qbToPKRgGrBo/FyA
	suK+N5pzF/32HPJ/qLooUn+XU6EitxhjWuiqQ
X-Gm-Gg: AYBFou23hSCUIrhfKB3yAane86cz4ekYuT8jaVegHG5as2g5XVm4BZHXyb3mPwZ3lCF
	xLLTgTrk3B7v4rbLr6vbJy3BfDvGuVkfid9BXYwVEleL8fNmmWFWKOzwpCdFZl49WOq8Ht9mI1V
	ZExtUYRWmcRtdUtvZworOqkjw5hXvWlPSUCGL4EuR/3eyDCeRmCk6mnrkUUREU7eYYYiXXzD8Rb
	Bp/HKRYtSXrvQ6E/SvxaB/tYA4F9wKAAm8+/b3f1brpqHkHRjeLsNwMNDizGjkrPNIWKZjoUsMQ
	APu2j5jJZAJtNKLU0H1EMiQQ4xq88sVAFxN2TbX8PGq00CtmWIiCB+s8U16p67TxDMcx5yye/xJ
	TrSUdkZdTzme9Sli3MgA/6tIgSH6P3eBxdvYzdoyPPA4JwY33tfVWIjTdiw==
X-Received: by 2002:a05:6512:3b2c:b0:5bb:7b64:340d with SMTP id
 2adb3069b0e04-5bfa1bfc1b3mr1842959e87.28.1792667108821; Thu, 22 Oct 2026
 04:05:08 -0700 (PDT)
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
 <CAG0Mgm9ShHdApcKAUj_PgGdm_A+w--FKpSpJq=nTJ=DkRcuACA@mail.gmail.com>
 <4180b794-8877-4516-9400-afb0894e8f49@kernel.org> <CAG0Mgm85JF6bFs2Nwije+2cbFjC-DmUNLeanwSCqOXxU=c1piA@mail.gmail.com>
 <07243418-dc96-43c6-beb6-ff220234bdeb@kernel.org>
In-Reply-To: <07243418-dc96-43c6-beb6-ff220234bdeb@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Thu, 22 Oct 2026 16:34:57 +0530
X-Gm-Features: AclHuK9R3gBeEiHPXgwSi9vXnUrDwnmk24fjHG40O8ip4zkzNOUctmComL-ssxA
Message-ID: <CAG0Mgm_iQmH2uuP8x8dd7M9qDZm7G_ySp=XzqxsHhuXaFC23Cg@mail.gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

 Thanks for the response.

On Thu, Oct 22, 2026 at 3:58=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> On 22/10/2026 11:24, Anil Kaushik wrote:
> > Hi Matt,
> >
> >   Thanks for the review.
> >
> > My response inline.
> >
> > On Thu, Oct 22, 2026 at 1:02=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Anil,
> >>
> >> Thank you for your reply.
> >>
> >> On 21/10/2026 20:20, Anil Kaushik wrote:
> >>> On Wed, Oct 21, 2026 at 11:18=E2=80=AFPM Matthieu Baerts <matttbe@ker=
nel.org> wrote:
> >>>> On 16/10/2026 10:43, Matthieu Baerts wrote:
> >>>>> On 16/10/2026 07:49, Anil Kaushik wrote:
> >>>>>>> Add a sensible default value (what do you recommend?)
> >>>>>>
> >>>>>> 15 SYN retries: about 20 minutes with the 120s max RTO.
> >>>>>
> >>>>> I guess it could even be longer, no? With an exponential backoff, i=
t's
> >>>>> not spamming the network too much.
> >>>>>
> >>>>> I wonder if we shouldn't get something similar to tcp_retries2. But
> >>>>> here, with the syn, we also need to tcp_syn_linear_timeouts into
> >>>>> account. Either we keep it to 15 by default and, (if not 0), we add
> >>>>> tcp_syn_linear_timeouts, or we initialise it to 19.
> >>>>>
> >>>
> >>> tcp_write_timeout() already adds tcp_syn_linear_timeouts on top of
> >>> icsk_syn_retries for SYN_SENT sockets. With the defaults, 15 gives 4
> >>> linear + 15 exponential retries, about 20 minutes, close to
> >>> tcp_retries2. I can make it longer if you prefer. Let me know please?
> >>
> >> It is always tricky to find a good default value. I guess 15-20 minute=
s
> >> is fine for most people. Connections are usually not that long, but so=
me
> >> can be, e.g. ssh. But then, what do we loose to put it higher by defau=
lt
> >> to support more cases? Maybe environments with low memory could not li=
ke
> >> that, but either they don't manage that many connections, or they don'=
t
> >> use MPTCP.
> >>
> >> When I look at nf_conntrack_tcp_timeout_established, it is set to 5 da=
ys
> >> by default, so we shouldn't go higher than that. But maybe we should
> >> target a few hours by default? e.g. using 20 (~10.5h?) or maybe better
> >> to use 21 (~21h) or 22 to cover a WE (~42.5h?)?
> >>
> > The SYN RTO is capped at TCP_RTO_MAX (120s), so after the first
> > doubling each retry only adds 2 minutes: 20 is about 30 minutes,and
> > the maximum, 127 (MAX_TCP_SYNCNT), about 4 hours.
> > Should I use 127 by default, to get a few hours? Covering a weekend
> > would need something else, e.g. a new attempt once the SYN retries are
> > used up, which would bring a timer back. Let me know what you think?
>
> Ah yes, thank you, I remember something with the TCP_RTO_MAX. OK then
> please use the maximum, and add "(127)" after mentionning MAX_TCP_SYNCNT
> in the doc.
>
Will do in the next version(v8).
> >>>>>>> modify icsk_syn_retries instead [...] WDYT?
> >>>>>>
> >>>>>> Good idea, I will do that: one new subflow per failure, with its S=
YN
> >>>>>> retries set from the new netlink limit, 0 =3D disabled. It also re=
moves
> >>>>>> the socket reuse, the retries counter and the 60s check.
> >>>>>>
> >>>>>> One point to think though, If ICMP unreachable stops the SYN at on=
ce.
> >>>>>> I would not retry
> >>>>>> again then. Is that OK?
> >>>>>
> >>>>> Good point. In your specific case, what do you observe?
> >>>
> >>> In my tests, the fiber outage is a silent drop: the SYNs just time
> >>> out, and the subflow comes back once the path is up again.
> >>
> >> Interesting. Out of curiosity, how long are these outages typically?
> >> Less than ~20 minutes I suppose?
> >>
> > It varies. Short ones are a few minutes, but when the fiber is cut, the
> > repair can take several hours. So a longer default would help.
>
> When the "fiber is cut", do you still have an IP address or is the
> connection still up?
>
> To me, if there is an issue in the network, we generally have two cases:
> either we are closed to an end (client / server) and the host should be
> disconnected from that network, or it is happening in the "middle" of
> the network where BGP will reroute the traffic.
> In case of disconnection, I would guess the IP is lost and the
> corresponding MPTCP endpoint is removed. The userspace will try to
> reconnect, then re-add the MPTCP endpoint, and the PM can restart the
> subflows.
>
> But that doesn't seem to be the case on your side :)
> Do you know why?
>
Yes. MPTCP runs on a gateway in front of the fiber and Starlink
routers, connected to each of them over Ethernet. The fiber cut is
between the fiber router and the ISP, so the gateway keeps its link and
its IP address on that side, nothing removes the MPTCP endpoint, and
the packets on that path are just dropped. There will be mix of
deployments like this.

Any thoughts?
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
Regards
Anil
