Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792685548;
	b=drVI7+PxOxtcPWmV8ff1+grIy3Gj7V1hckIC7rHalAA/GS1Klwv19xVCmSj5q0wGN0xT
	 WujE8G4m39jteMTxxHD7j9z+wIGVRHdYLiygXEnrUEN1mPyPF7CQ26coGxO8gN5LR6WCY
	 AdU+LTxdl7cCeU0OIUXhpYGFyciO7imwwSuZ011QiEk/tFd+j78fodWmblmXGOS5fGT4F
	 NMD4mmx3AQa9BE4JwpCAeLzmPtu4zSkunSMGSN5RkKDQmKnSZ9bi1eJvwmiydhQiHiaZl
	 76OKQaV4nteimjj4IhVRXsTEZoAsn3hBWT++SBzYhggpoH/snhtTctSZodtFMkTtROA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5WwIxdYFH67PqBMmyhHK+jGuHDevtRoMU5aVGjw4di8=;
	b=4ThEc+akRaDz0EgsmFv9KLJ2gfedB7sGagczdffFq/1HcineHit7N4cDaTGdSbzFEqxh
	 YpxUDb1O+wR6caszjaOkKjJcUWEU6FKx9bqVzh/fzJYy1aFsBkjyDckm2dFohN8o3sgKr
	 NIScgdvqVuoKjVXlR31U1UI4UFcD6amaLEBRe2L82QQ/lpf3SOj0o4XDDZCBktvpfAA2H
	 UrV6iiKyNrjwyiTwei3f7MU9ficPPJAI0AvRhs7VXc6UxB2UKrPm14Dg/OWf0ARGhy9Ag
	 CZlY28H8sKEWK3QfLypEzC4IxVxiEJfaa3Jav12EBeDCsJCvCUQArc9JwdykTjrGIwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XVq+4kuW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D611606A31B
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 16:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D611606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XVq+4kuW
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab4354db11so15142791fa.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 09:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685547; cv=none;
        d=google.com; s=arc-20260327;
        b=HWPbYvCJOfrH7kOLJo9K7WKfrTKhZMcCW16hMYzY0uQoY61m5CbzDz934JJ24ks5Bk
         qZtouckPsgsWigB4Gd5+FRiBrpXnl91ASM8xj3miyB0KcKhz+vrXQb8twy1yq/Zcapox
         75pvKobn/PjkwzmOgYmBn2RioFxzHoCPCNMYS49xSR3QRuj5d7kDs93DhliE4JADd0J3
         Sh73HP0LCjoUtJleFognXj/Vu6YECsKauGGL2gvNwgHmkaYt0ColJaUD5Ozv44RI3EfP
         KmA2RYGOrf46G0RhTZVHEbD+ZrIIasM5mC37t0UeqKXfiKmiil4APkS+0hW+3AkoXDYX
         sS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5WwIxdYFH67PqBMmyhHK+jGuHDevtRoMU5aVGjw4di8=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=s+fFbDkeXR9p1E+ptyBYmCei+KbodAmRQO4KxnwEn35duJylhqx2ZbhqXoF3vlaCyM
         gaXMayAQhovM/1jtVFN2LmiB/ybrJtTXW8Wuz19kFliSYnya+aVrU3ccsEk9au5WO63T
         hSPBZyWBlIgXxjB8vnZllq2LSK4SrgAdVBQmlIJu8ogqaF6W7YjBZ1yDdx4y6t9dC8Uq
         Nl4BNDZcXtt3G5p1F0MC+coUmlsNJqdKj2HAy/7KOOSHjnATXbKILImU0GxCV8+Vc7f4
         iIIOxHFr34isBS3CSD7OB/+i2BmYdigVqh+eV+TTGTMqQcycraoLd/d6mJEtWw8eV69J
         39wA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792685547; x=1793290347; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5WwIxdYFH67PqBMmyhHK+jGuHDevtRoMU5aVGjw4di8=;
        b=XVq+4kuWAOUGZorjzKVYogVffOFYBx4aGjv/8OdkK9zlO0Z73eN/92vbg4u0Mz7N5r
         EvXQk9mxGcIbQKc6Y/ZQ2g+6F75dEyqC0FBRfOQUvIzVg5KyoCWj3uWYUGaZOTy6ovAt
         YiqBjzlXt7Y2nHw2MVbd1L3hSrkD0aAZXsN99diEAmVhfn6oiqPhwMGj/kjC/bwhwHxb
         6khhA2OxvPIz4cEbuONR+WPQFnOGGWYNYAjiQefYf1/oTBTyfJBNcyGoC1ekLD8ANC4t
         d5mKNu0Kkua6w7SCfvxvqk1olG4gvObp8jsCUPomaXeAsmCTD+ThryywK5OMVKS241jQ
         CztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685547; x=1793290347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5WwIxdYFH67PqBMmyhHK+jGuHDevtRoMU5aVGjw4di8=;
        b=zb4v3W7lPVQJTFPjGe6phpHX3b0flXix/RLvNM4Z54BOcqw9W6GOU59QIzrnZlB/hj
         M/w5T5fRHDInC6AJlRL5txJi4PHtyo2LeBfEGXwNnhd/iirjv46vs9HuTq3aMmw9yhWA
         wAMukPfIwOnobvF89VdFlC8lARQ0BO5WKe9rcABaz6K4ZSWvz3ctke9aRzT+TwrYuqde
         axIYu1z42IUmfn5VERqm6CQl0X9JRF3ULjcrxXYQMxF3R88dsfXDJsqZLwQONj/Sf1zg
         S7TXewH6yMyQ8hsB0kVdBC9z228pvWCduMfoWkrtP4eiecXNGB+pLXX8Uz9g2qHfdHKp
         yz2Q==
X-Gm-Message-State: AFq9FYJ69fM3kfzrtvMkIrd1EnqtvBx/TKFUqagOJdbJZJebJiG6YXml
	3JzQaT6oEYTG9C2qG6uh0IlDdxIx74mwu1x73mjpGzAAzs325iBuUoigBRsjMXp8c+oeK7kVfQY
	g+t6fXypZskKHV7ImLnyAaGPNhS8Du4i3Ta1h
X-Gm-Gg: AYBFou2kMCIHbrh7LaT+R92LYPnVky8rCLyaOYBFJoGq0KNdCvxhaC4Ppd/9KFkL3Hc
	Lm8hkF+M7HQ6ypgIVKzBRvTAimWs3LCLEIvXiq5Th9OihA7NlClXN63yi/DE/yMjpyX35W1BQV1
	EpD5VJe8N5ipw6AafXJQADv5C3+jYYm5RNC0u2hGjxS3nAqtyc9jCOKgtHpw5D7+x7k9hgTEL15
	8/MvInz3ULO19v+W2StjvZOQqcci47vSDiSvH2M126vnMMhefJkNemh2nAFSEu1a3VTLNy+LZC8
	F+WdcbO5vpXYMKrb7MGFYL72ZQXeEYA04s00c1DATKckBi1FvxRpzJNYpUSivjKllE0MDbyrFJF
	P+2FJAiljm4/91WLIdGzrBQIeFP3lJiu1xpzd
X-Received: by 2002:a05:651c:1509:b0:3ab:fecf:51f5 with SMTP id
 38308e7fff4ca-3ac44179476mr16290131fa.14.1792685546307; Thu, 22 Oct 2026
 09:12:26 -0700 (PDT)
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
 <07243418-dc96-43c6-beb6-ff220234bdeb@kernel.org> <CAG0Mgm_iQmH2uuP8x8dd7M9qDZm7G_ySp=XzqxsHhuXaFC23Cg@mail.gmail.com>
 <b6eed470-af86-4554-b89e-2edc702521e9@kernel.org> <CAG0Mgm8V2HjYMV8Naa1A2TAjoXDG=AGXA=5f_4x5tyEW=Ucs4g@mail.gmail.com>
 <2ce6ae1c-e023-411d-85df-350367ae30ef@kernel.org>
In-Reply-To: <2ce6ae1c-e023-411d-85df-350367ae30ef@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Thu, 22 Oct 2026 21:42:14 +0530
X-Gm-Features: AclHuK8wZoq2c1MiC27neD7xzTGJt_bFh83f7bnw8mX1gztGmpQ8n13nQfKg4v8
Message-ID: <CAG0Mgm-W4bZJwfmrL79_xRXP-knpRhBU7c73+QAgod295r6wOQ@mail.gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Matt

On Thu, Oct 22, 2026 at 9:20=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> On 22/10/2026 16:31, Anil Kaushik wrote:
> > Hi Matt,
> >
> >  Sorry my earlier response had html content.
> >
> > Resending my response again. Couple of more points too.
> >
> > On Thu, Oct 22, 2026 at 7:00=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> On 22/10/2026 13:04, Anil Kaushik wrote:
> >>> On Thu, Oct 22, 2026 at 3:58=E2=80=AFPM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> >>>> On 22/10/2026 11:24, Anil Kaushik wrote:
> >>>>> On Thu, Oct 22, 2026 at 1:02=E2=80=AFPM Matthieu Baerts <matttbe@ke=
rnel.org> wrote:
> >>>>>> On 21/10/2026 20:20, Anil Kaushik wrote:
> >>>>>>> On Wed, Oct 21, 2026 at 11:18=E2=80=AFPM Matthieu Baerts <matttbe=
@kernel.org> wrote:
> >>>>>>>> On 16/10/2026 10:43, Matthieu Baerts wrote:
> >>>>>>>>> On 16/10/2026 07:49, Anil Kaushik wrote:
> >>
> >> (...)
> >>
> >>>>>>>>>>> modify icsk_syn_retries instead [...] WDYT?
> >>>>>>>>>>
> >>>>>>>>>> Good idea, I will do that: one new subflow per failure, with i=
ts SYN
> >>>>>>>>>> retries set from the new netlink limit, 0 =3D disabled. It als=
o removes
> >>>>>>>>>> the socket reuse, the retries counter and the 60s check.
> >>>>>>>>>>
> >>>>>>>>>> One point to think though, If ICMP unreachable stops the SYN a=
t once.
> >>>>>>>>>> I would not retry
> >>>>>>>>>> again then. Is that OK?
> >>>>>>>>>
> >>>>>>>>> Good point. In your specific case, what do you observe?
> >>>>>>>
> >>>>>>> In my tests, the fiber outage is a silent drop: the SYNs just tim=
e
> >>>>>>> out, and the subflow comes back once the path is up again.
> >>>>>>
> >>>>>> Interesting. Out of curiosity, how long are these outages typicall=
y?
> >>>>>> Less than ~20 minutes I suppose?
> >>>>>>
> >>>>> It varies. Short ones are a few minutes, but when the fiber is cut,=
 the
> >>>>> repair can take several hours. So a longer default would help.
> >>>>
> >>>> When the "fiber is cut", do you still have an IP address or is the
> >>>> connection still up?
> >>>>
> >>>> To me, if there is an issue in the network, we generally have two ca=
ses:
> >>>> either we are closed to an end (client / server) and the host should=
 be
> >>>> disconnected from that network, or it is happening in the "middle" o=
f
> >>>> the network where BGP will reroute the traffic.
> >>>> In case of disconnection, I would guess the IP is lost and the
> >>>> corresponding MPTCP endpoint is removed. The userspace will try to
> >>>> reconnect, then re-add the MPTCP endpoint, and the PM can restart th=
e
> >>>> subflows.
> >>>>
> >>>> But that doesn't seem to be the case on your side :)
> >>>> Do you know why?
> >>>>
> >>> Yes. MPTCP runs on a gateway in front of the fiber and Starlink
> >>> routers, connected to each of them over Ethernet. The fiber cut is
> >>> between the fiber router and the ISP, so the gateway keeps its link a=
nd
> >>> its IP address on that side, nothing removes the MPTCP endpoint, and
> >>> the packets on that path are just dropped. There will be mix of
> >>> deployments like this.
> >>>
> >>> Any thoughts?
> >>
> >> So when you have an issue between the fiber router and the ISP, the
> >> fiber router keeps its connection up to the ISP, and no ICMP network
> >> unreachable are sent?
> >>
> >> In such setup, and if the fiber router gets a notification somehow in
> >> case of issue, I would find it better to forward this notification to
> >> the gateway to disable the MPTCP endpoint. An alternative is to have a
> >> simple service monitoring the links, and removing/re-adding endpoints:=
 a
> >> simple "echo" service in TCP (or ICMP echo) with a server somewhere, o=
ne
> >> per link. With that, you have more control and can eventually ack quic=
ker.
> >>
> >
> > Yes. The router still has its default route, so it does not send ICMP
> > unreachable, it just drops the packets. And when its WAN link really go=
es
> > down, it has no way to tell the gateway.
>
> It could eventually turn off the link to the gateway.
>
> > Agreed on the link monitoring. A small probe per link, removing and
> > re-adding the endpoint, is a good idea and I will send a separate RFC.
> > Let me know what you think?
>
> That's something that should be done in userspace, no?
>

Yes, in userspace. I was thinking of a plugin for mptcpd, that probes
each link and removes and re-adds the
endpoint. I will look at mptcpd first.
If you have any other thoughts, let me know please.

> >> Yet, the series you are suggesting here still makes sense because that
> >> would help people, or in case of issues not detected by the network ma=
nager.
> >>
> > I will send v8 with the default set to the maximum, 127.
>
> Thank you, I will try to have a look.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Regards
Anil
