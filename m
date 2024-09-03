Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D3E18BC15
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376913; cv=none; b=G1ir1qxKFCN4vHh/3PBoDebqsv7rxpuo6/Q+j3YJwYlXnKEAVkNJuASzBbTPaG5UjhJs62ysjhsSxTL99Grb1MrolPgV7jHyAFv93oUB9PI+FhImt5q48hK4YMmnhqqZMykffDC7wtC2Px8l+sqVX9dyB8nwQngI8fG5CgXPJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376913; c=relaxed/simple;
	bh=L7bzO8sduRuORxv+9b1sBD9W3ikmOj57/gzaaY42NB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dta5bJ0SDhldeK/MsSh1tFMZGA7MyEexMD+i0w2g1eHVShRk3FVplQIh/ou7QEDQHlcuSFz+3cIcy/umUTPi8ezXuOFVX9GwlEJXBFQhOehu/OCwK1I0MN6VRDBcInqtXoxUAMQ2uceT/2cyH6u9xiIqIdLZkZq6ciPNAIpHbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it; spf=pass smtp.mailfrom=student.unisi.it; dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b=Q1qp9ENc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b="Q1qp9ENc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-205909afad3so15641015ad.2
        for <mptcp@lists.linux.dev>; Tue, 03 Sep 2024 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.unisi.it; s=google; t=1725376908; x=1725981708; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wM4j4eN2EqDuyONzWWAh8Mjq8Wlx8Xbue+qszgqh9l0=;
        b=Q1qp9ENcVsaH5E2WyT711EgKe1FFaYn0t0pnT6hBSrISi9Pj3UYorWCGNoesxd+G01
         5/x/+j5KPOPa4unCJBFFJEUf8u5C3viJOb3BsSq3OaWCP28TIC3G3nbbjOaJelhIetC4
         /BIHYhvnA10PVjomOcm0cilqO18VG278TuwAsZC1P0TDzEsU5hTnbSnVChzU7nZtE/ih
         bYk8ghBoGBVPry+kfcTd40U31+VKaWs18kGnpN4+LQpZdKxSHBilp0fT5ojHAWzg3dX1
         vxwR3V6AYAWEeHhGhz3vceG49zeWKIR9wQ4ZO1rxHHs2WydP8kgDETtpbY1tfABBh+oc
         Toaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376908; x=1725981708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wM4j4eN2EqDuyONzWWAh8Mjq8Wlx8Xbue+qszgqh9l0=;
        b=pjcSgCfmpKakLYoxmTfiPPERorYU8k0yPWNipMig4WlN2fE3nddF/cSThzDjn/kI/c
         ideyC7Xy9S8yiXDvmVRJ1ylYW5cDPeeiLB0khVoe3nboTVlhWW0fdPn0Ynm4MBFnBqLf
         9LyEp2BSvUeljVZXSEeHyCN/A2AjCvyQzfoqXBZogsp54iwJuVStPx8JDj1YTjZ1Sdja
         MI8g+hCS5aTx7tQkOSYGRka+MOSv+mm+TyWzTlrzDQMIcyFINFtGvB438vqIrH5kTnDQ
         tw8jubUu0a5CZfn+Xy4ur9NsJXyiVUtIbkMqxHU9aBHBPSsJct846suzl+bU1eMwX6Zg
         1mtA==
X-Gm-Message-State: AOJu0YxVGsClLmz74tV77PtVWRA+csOaZ2CtONN0PH7FwcOjZKV1THAu
	aUbDZpCmcpsxiMl51gX/7BsjMhTsOtT9vVFDzUIrknaLR6QPTjL0t/3wsYvCGdOEyMwG93Y+855
	vBaZR6MxGDyKnnSedoxTNoL9LBbRVgyhF9RkHttHTZUQZ3f+j2vvmA5inW+xBuCuMP/2Et+V5Tv
	goXkvsPgCcACJuxpmhXOVhsjIPes9rAIf6jg==
X-Google-Smtp-Source: AGHT+IHM8Azql8dg/Px5q8ZhExxesYAW+7j4bBW0TnO5UKzqPIP7gz4ZE++M9E5ohAva1IqKvBby/SJCv/+X6DAnReA=
X-Received: by 2002:a17:902:d58d:b0:206:994b:6d53 with SMTP id
 d9443c01a7336-206994b6f3emr25733095ad.30.1725376907586; Tue, 03 Sep 2024
 08:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOU6Dw9xnP2ha8Csj47_zQQEHg7_FUrgVRW+CrTon-aPLokKog@mail.gmail.com>
 <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org>
In-Reply-To: <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org>
From: ROSHITH SEBASTIAN <roshith.sebastian@student.unisi.it>
Date: Tue, 3 Sep 2024 17:21:36 +0200
Message-ID: <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
Subject: Re: mptcpd Usersapce PM
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Gm-Unisi: student.unisi.it

Hello Matt,

Yes, the sysctl net.mptcp.pm_type was set to 1 to use the userspace Kernel.

The OS & kernel details are as follows:

mpath@mpath-VirtualBox:~$ uname -a
Linux mpath-VirtualBox 6.8.0-40-generic #40~22.04.3-Ubuntu SMP
PREEMPT_DYNAMIC Tue Jul 30 17:30:19 UTC 2 x86_64 x86_64 x86_64
GNU/Linux

mpath@mpath-VirtualBox:~$ sysctl net.mptcp
net.mptcp.add_addr_timeout = 120
net.mptcp.allow_join_initial_addr_port = 1
net.mptcp.checksum_enabled = 0
net.mptcp.close_timeout = 60
net.mptcp.enabled = 1
net.mptcp.pm_type = 1
net.mptcp.scheduler = default
net.mptcp.stale_loss_cnt = 4

I am trying to implement userspace PM, because different rules have to
be set for each suflow based on different conditions (these are still
being defined). For example, 75% of the data should flow through one
and the rest through the other subflow based on the delay or the cost
of the link. The fraction in which the traffic is split might not be
known beforehand and can vary during simulation.
So my objective is to divide the traffic unevenly across the links
based on certain rules.
Is it possible to accomplish this with a PM or is a custom scheduler
needed? Although I have seen references to shedulers in previous
versions, it has not been mentioned in mptcpd.

Any guidance in this direction would be much appreciated.

Thanks and Regards,
Roshith Sebastian



On Tue, 3 Sept 2024 at 10:40, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hello,
>
> (Next time, please share text instead of screenshot ; also, please write
> in plain text only, not to be blocked by the antispam filter)
>
> On 03/09/2024 09:41, ROSHITH SEBASTIAN wrote:
> > I am able to use the in Kernel PM, and trying to define different rules
> > to the subflows. The Userspace PM has been configured,
>
> What does it mean? Did you change the pm_type sysctl? Which kernel version?
>
> > but the data
> > still flows only through one interface using sspi PM. Screenshots of the
> > -d logs from client and server have been attached.
>
> The sspi plugin is a demo one, just to give an example. It will only
> announce addresses, and not create any subflows.
>
> > Can you please help me with a sample PM plugin file like sspi or
> > addr_adv that uses both (more than one) interfaces to send the data? or
> > sspi_connection_established implementation that can send the data
> > through all the interfaces?
>
> Why can you not use the in-kernel path-manager for this simple use-case
> to create just two paths over 5G and Starlink or whatever the links are?
>
>   https://www.mptcp.dev/pm.html
>
> mptcpd can help to configure the in-kernel PM (what "addr_adv" does),
> but its main purpose is to help to build a custom PM using the userspace
> PM interface. If you need something custom, you need to build it using
> mptcpd's API.
>
>   https://github.com/multipath-tcp/mptcpd/wiki/Plugins
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
