Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679506;
	b=KLNphstk8Wbldcx7OFJdV83xMfDm4kgJBbrdsMFtT4L21bslbLIme0XNu4QlFaAzA+2R
	 s/RW9bR8OzifL8fwbtff1luzXcS0q0tj+ML8/zAbiAC+8iNxyGi3KZw2Mp0Az1hAFKX9m
	 0KHYQkgAG79HTQxNAd3KDPRUwgiIo3rsN7mGnzvfUOrm7zMO06WL4XoInLVTkScVGyB8W
	 1JAdJm8hYBk7oA+mYZwBd9aCKeTs+dUxey92DtEOBxRY8UMFbdrf58CHSW2Q3X03d0NjX
	 wlYuhuurFJcV5RGZequS9PlXsTmGDEzGm5yOGWxkHZiigE34wxfhu5jdloVvO4EoHnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bZkg2BssG4gsO8hlRRWfsSXvbI5V1MXvxUMnTcn3IrU=;
	b=h2QCZESjHEWQV/zcGDWcHPukY8PObgUUGCr+KhAHoT/gm5gK33i5U+Maj2j/D0o4H9WP
	 OmVnMOrYmyd7D/V3KvovanYiXi2xalMOru5pwl47c2Vosem0XhKY82VSJ45Ns7VQjeKX0
	 ein/9JbgyItIdqN5KkTzP1iPsg3dWJiWxwxC4sJq3xQ1n8jBq/GkLRmxnbvfCa77kbErJ
	 19XxP0DHVW5v7kmDMZ3vpvMhyJFFVV1g8zzs3/FZzQuTtIvhHRL5kMDNRBr3ICu3dqZXg
	 DXIsszxcvjEUa2KFy7HPvi2o1cqu3w3HbZERcIEpFAM3Hnz2MPyGJm3MjODTWjUtGiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTp7Excs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12C606A322
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 14:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A12C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rTp7Excs
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2278909e87.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 07:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792679505; cv=none;
        d=google.com; s=arc-20260327;
        b=VlYr6kll1U8I1P94uLGq+16Fus+x20VTIxka+jTbxiRGvS2WoUsjRTsn4WZ3UzktAH
         lJQ4ySCF/gVuiKm84XE4D8zdIPI8fn8tMVHpc7967kHdGL5+xfajHbCKlTH6VtdKnVv4
         Zi7io4YaTPLadWamYG8h1uTrwZH5NvD/1cc9vr3L0/+Bmeey6U3tw3RBCPGpsUp29I30
         NXiN82nMWrd3QcPHJgIp7HgX2y39HboK1/MSoVA66pRlyGit4J7XkICcCSgR8F9DrbKz
         xJNsHXcS569pJU4JshQM8umwkDZiXuVQgEIuJxXEtXLVctzy8/lwRzfQ5ErKVZrZweTc
         0/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZkg2BssG4gsO8hlRRWfsSXvbI5V1MXvxUMnTcn3IrU=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=YovHqQm7KUQxiJl1vWB3NgHK8INYCwpkmk3wdsoH62zBOHQyR+EECcMkjJqGDp7msH
         E+JNexRwKxypCMYA9fPioQEXc/ScsNvTP6fZOdKjKhh07kTP3pT1WwSX79dodLfFR7cb
         A8NnPi8ZvtVeQWfBzLHi1fr0vhrTmiZOe0hKs00EG17ZmQePaCi0V4wCVtLHPeycSZk9
         PFb2xwdeE3DUcPEMGf4B4/aSL6gmIXtbFDqKBYhRDq6J4Z1SvPzUHWY6o+/8KaftwXR/
         2U18RwtUA6rS9iwqCowYlLZRYQz1uIEEFjMVP1k2ZrhBtGPfyi6WvlBNMwTxdZ82LEJh
         bqpA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792679505; x=1793284305; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZkg2BssG4gsO8hlRRWfsSXvbI5V1MXvxUMnTcn3IrU=;
        b=rTp7ExcsNLLpG3byf4/VWObB5BR26coBJCk3ZezCJB5UfRkAtkR8Vl7uI9lwojNvLQ
         W6BokECFl167rKaZG6XZlTkua4LuUaewC/O8mUlKv/QFH0oy0IDIZo0zIvztx6JvoZbK
         Y+lgZOsFnWi4DCmr0evA/0xofIyn0QfUQiWbZPItXoNh9C/ScWvlOR1XikklfLqBaGxS
         bIbCJXoM9tt068tGBaKkAA3W++VwB+9oXzXwEBoObHFoxEmEkl2q+HgVB0DHLnbbxq7u
         06pJbryP2NZagwlLtiPWkDUDc/7h/5vplL+ze6nh88CIsKUOWil6rQpkVYbkcJWQUQP8
         J+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792679505; x=1793284305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZkg2BssG4gsO8hlRRWfsSXvbI5V1MXvxUMnTcn3IrU=;
        b=S+RswhE0S+Tg5CSovqERHq/hhmeRjo9AFnHWvWOwygeWPvmkU4NuJJpHO1O4zOr0AK
         aL/mSUhQOJ39Egj79oyQc6V9BfS5yHIOpj/NjbrT4+PZN7fZWbkQWlepx3tWAuXSykuY
         tTvpQi3LLcDZxyxl8Ty0gXv3VQtGsloF7nl0mUqkB6/O3mKyazH6kbkNcFFQ8H3F9iP7
         SlSiRhBzkXKwVGrbGyZ7R1U/ZZTXnu9qHaSNU6+tC5itlUDEk4BiRDAtri40C+b06mh7
         eKyM1GIS7y0rRzcGCn0U1QZusjg06Si/Pl0dBWx/rFo6FFGeYwO9RD/0ZvquMqMYQ8hr
         0dHQ==
X-Gm-Message-State: AFq9FYKTtFN7AvPCLyohEMSJ8QvbuRG2x8KMjIVEJRAMicBi7blZrIbK
	UrY55w+mRX0s2DyaqKHP+BAM9x9iuJJSO0p5+XzuXmowdX/s3CkGOqJXwT3Lf/6f09PiR5uYUjg
	4gYIQAPwLn0Tb21cJyUkmyILRF7H0WUI=
X-Gm-Gg: AYBFou2L9hQdB0uCQGBfk3ysENzh4zTkVCNhQ9MZ16oLbVNV3pNkwZ4DUO7rWpS9tEr
	csBeFsf0et7+N2MYli8wQMFSj6bpiu4PGtsFtYQTERIO0fA+XlTPnlbi2lKCUTz5M1X2pxC2qoi
	PeJd4I1DAuSyfmNDIYkoi58ibJiSaUTT6937rZiDcKt4G5hD+XNRvgFujFU6ix2TePGxk30i+lc
	/2PWmTaFzc3/22JlHDgBsH80V98Y+aMcNTa9hzcqSf97gTcoxBZSZi/4JZAigwslCvzHWkf1och
	e+RaMsgkt84IzW/CLqLNcreVSNbrpAEtdzHDvudUe2Vci1Bfi88SOpSYTQI8QFyecTCbmCiFAxY
	l2Fwincc5rl0xmTvU6lzZAlMLBCKZAaswIopE
X-Received: by 2002:a2e:a987:0:b0:3ac:429f:6d99 with SMTP id
 38308e7fff4ca-3ac440a17aemr15263401fa.2.1792679504558; Thu, 22 Oct 2026
 07:31:44 -0700 (PDT)
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
 <b6eed470-af86-4554-b89e-2edc702521e9@kernel.org>
In-Reply-To: <b6eed470-af86-4554-b89e-2edc702521e9@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Thu, 22 Oct 2026 20:01:32 +0530
X-Gm-Features: AclHuK-BdWzLwjyQ7hC9Z4uFISBUF2kw_-R88Cla1mT5FiJxIfLDVzsNR0mF8jQ
Message-ID: <CAG0Mgm8V2HjYMV8Naa1A2TAjoXDG=AGXA=5f_4x5tyEW=Ucs4g@mail.gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

 Sorry my earlier response had html content.

Resending my response again. Couple of more points too.

On Thu, Oct 22, 2026 at 7:00=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> On 22/10/2026 13:04, Anil Kaushik wrote:
> > On Thu, Oct 22, 2026 at 3:58=E2=80=AFPM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >> On 22/10/2026 11:24, Anil Kaushik wrote:
> >>> On Thu, Oct 22, 2026 at 1:02=E2=80=AFPM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> >>>> On 21/10/2026 20:20, Anil Kaushik wrote:
> >>>>> On Wed, Oct 21, 2026 at 11:18=E2=80=AFPM Matthieu Baerts <matttbe@k=
ernel.org> wrote:
> >>>>>> On 16/10/2026 10:43, Matthieu Baerts wrote:
> >>>>>>> On 16/10/2026 07:49, Anil Kaushik wrote:
>
> (...)
>
> >>>>>>>>> modify icsk_syn_retries instead [...] WDYT?
> >>>>>>>>
> >>>>>>>> Good idea, I will do that: one new subflow per failure, with its=
 SYN
> >>>>>>>> retries set from the new netlink limit, 0 =3D disabled. It also =
removes
> >>>>>>>> the socket reuse, the retries counter and the 60s check.
> >>>>>>>>
> >>>>>>>> One point to think though, If ICMP unreachable stops the SYN at =
once.
> >>>>>>>> I would not retry
> >>>>>>>> again then. Is that OK?
> >>>>>>>
> >>>>>>> Good point. In your specific case, what do you observe?
> >>>>>
> >>>>> In my tests, the fiber outage is a silent drop: the SYNs just time
> >>>>> out, and the subflow comes back once the path is up again.
> >>>>
> >>>> Interesting. Out of curiosity, how long are these outages typically?
> >>>> Less than ~20 minutes I suppose?
> >>>>
> >>> It varies. Short ones are a few minutes, but when the fiber is cut, t=
he
> >>> repair can take several hours. So a longer default would help.
> >>
> >> When the "fiber is cut", do you still have an IP address or is the
> >> connection still up?
> >>
> >> To me, if there is an issue in the network, we generally have two case=
s:
> >> either we are closed to an end (client / server) and the host should b=
e
> >> disconnected from that network, or it is happening in the "middle" of
> >> the network where BGP will reroute the traffic.
> >> In case of disconnection, I would guess the IP is lost and the
> >> corresponding MPTCP endpoint is removed. The userspace will try to
> >> reconnect, then re-add the MPTCP endpoint, and the PM can restart the
> >> subflows.
> >>
> >> But that doesn't seem to be the case on your side :)
> >> Do you know why?
> >>
> > Yes. MPTCP runs on a gateway in front of the fiber and Starlink
> > routers, connected to each of them over Ethernet. The fiber cut is
> > between the fiber router and the ISP, so the gateway keeps its link and
> > its IP address on that side, nothing removes the MPTCP endpoint, and
> > the packets on that path are just dropped. There will be mix of
> > deployments like this.
> >
> > Any thoughts?
>
> So when you have an issue between the fiber router and the ISP, the
> fiber router keeps its connection up to the ISP, and no ICMP network
> unreachable are sent?
>
> In such setup, and if the fiber router gets a notification somehow in
> case of issue, I would find it better to forward this notification to
> the gateway to disable the MPTCP endpoint. An alternative is to have a
> simple service monitoring the links, and removing/re-adding endpoints: a
> simple "echo" service in TCP (or ICMP echo) with a server somewhere, one
> per link. With that, you have more control and can eventually ack quicker=
.
>

Yes. The router still has its default route, so it does not send ICMP
unreachable, it just drops the packets. And when its WAN link really goes
down, it has no way to tell the gateway.

Agreed on the link monitoring. A small probe per link, removing and
re-adding the endpoint, is a good idea and I will send a separate RFC.
Let me know what you think?

> Yet, the series you are suggesting here still makes sense because that
> would help people, or in case of issues not detected by the network manag=
er.
>
I will send v8 with the default set to the maximum, 127.

> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

Regards
Anil
