Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792606834;
	b=LKiPOypRzczxoSBS0hdFQgKuyvhhQBQQrexcGgWv7Ltss74EwvIFe6GLYi/qLyswouz1
	 La8YHbU75yBOVY6sNce419yG126Zabb9mFsg4GPK6fPMaGfbA7+DEVJHJ9laIDL2UjuXU
	 gc70djlByDaSgIun3cROqqYksgUv0IvRHb9avAQy4ZM5x3K2ckexac820DNkzTw4+8w7u
	 uxrtB7KiUjotkwxfo8sJdJukT0IWfBjpMHATt2vf7+JWFfjozPI0uAId8RnW7BqTRMdC+
	 cRq7T3roeaIBv32P+CeQB6DlGImoJOf6aOFZ6IyF90dDSP/FUE8yTgTWc6Re14VreBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=JKo6udsSQ21WTyHr47XfeCKV2YRvU7kSU1kyzYBCCTc=;
	b=0GvocKqzglIDUX9cdVg2tSOTQzP6S3JsfHKy2fsNggC+Fc+h3rQe/mysiq9tMI1g/F0g
	 w2A9uvLlNh6raBUbM9NjqeuhBRlQgNoiBHkky3ZgMP0isPCurxvRTlxUwrZWAkdgl+vwI
	 dAr5SJ9hpdAs4/B73YifPb8x6VL8zEgHJJu8svgIeL+wg2dxCxSPvHienNyaH1ZlgLOLo
	 uz3ZyoavR23jUSbqWYWnvsbbDVzyiKpghHZPk3AixcxKuj6RWdvAzbXlZtWKjI8jdvfhN
	 MUxU22iAVgXeUQJew5fn+ITLcvWL24d70/a8bDm2Zu7cKwwb+1sgZ96W+ptWAT+S74Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mTYGlxCV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B22606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 18:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B22606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mTYGlxCV
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab27e45e7cso8048221fa.3
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 11:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792606833; cv=none;
        d=google.com; s=arc-20260327;
        b=Qaqchs+47wjA1iKAm6M+POJ7WlTWeCiGVI6Z9ilAdagHt3LyvlxfsScYJwAQM8tWrO
         2zex6JlfgZ96IdvXlkf6cCIFyCTNa3Ex2Tr9q4M/Xg9bx2H0Bgo49ciehuHd5lHv5NHX
         jRgxIlPBK6wqEblUJOAy5+a99A3My0yZxE48tDJlWuRMJDBLmMYpt1gGEYBEiKL1tdo+
         pUMTM9aOe/NdtZr8JxGC6B+o4t/MCE3oRpfFWK881zEmXBttlAw5g238t9+Xkpx35yQ5
         ks9TKeMIptgILnwVIHg2KuDrCZ4CdZ3uyzFeHpCOhC1YVkf3P0EjHdN1gn9VHEw35oDk
         i2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JKo6udsSQ21WTyHr47XfeCKV2YRvU7kSU1kyzYBCCTc=;
        fh=ta3oWJNUUOGDBubb9ZsHOPUNokkPfzxKTkR8JEtaNGw=;
        b=JArwgfQt3rPaepxsdk3IImJpDvEbxsCr5pZfFwqo8qwtfYDzIwKEdeCmVCR4oX8UHc
         kRD3n3e+xq3X7BS1UKUepUIdTz5UKpnU/Tpp2Be0TyGSLiq411llLmZx43A2btqo993P
         YinvTjz98WyBLBEB3pU0A4MFjmSIhnDsf/p2dosAv3daV9zH/OQUmZ02uoIH4grKZ92X
         hJPNFeyxbpe6/0FqKgPBmmIu9erBa3LI6UKoV7LKyPiUo4o3SBGMowU70KJtjVEuK06+
         mDxOPNxROe41ralvy3T5OzoMSamlWzSXGn23ChjX3iw2fu5rLZCgBG5DwZrgnXPj9GOT
         T7vw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792606833; x=1793211633; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JKo6udsSQ21WTyHr47XfeCKV2YRvU7kSU1kyzYBCCTc=;
        b=mTYGlxCVYcpq3Sxnxe7EmooSroxS6crN2Y5llK0a+SwasAC+6XE8bYSnrYGEckVmA4
         fvRW1t2APVJpZD1b8XgIRyfLPEBzW/4QwvIx+ydMP5lGrJCcitoc8EbqgPoveL68jb1l
         c8Obob/524FO5n05V3+72fnz10x1n9oVVeQ4aic0QcSzjOmDkEFmKPDZY9Y1UqpAjcqq
         VEqdl+5g1xcCb2gskZ9VrNwh/9kimXl8+ktSYJ/oE9sMkGVecSgi+jDhgDOpnHdbMJsu
         ufSROeicRaevpspR1xb5XSPAps3Te6AUgSquNSfhI1odM2+v0qz23TMYKXTcUo8vXPHV
         Q36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606833; x=1793211633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKo6udsSQ21WTyHr47XfeCKV2YRvU7kSU1kyzYBCCTc=;
        b=B8ejGiyJf7QedL1VfcQSMEp6Qnre/f51dIqeWcDTA+F9gA9gGmQXX2XXen5O20Oufl
         d1JSLhUFedGyT2zLsnejnDJLsBmWBFICtNn4dDG/AErBlmV9RjQ4ZolccnbNwwTKxGVY
         n8KpQzhkasEo8fVJrpdgwfKehrk0jPK2KHP/AISSVdNjdjoPRCvKq/0orw+Y6BKrSp2q
         IkCYuF238tTAOsWyawoJyIcFy0YDXSe37b+XLU+PtHeL5x/UdJsqPfbj//Q3WVkujC0O
         MKVAaWLyaLbuVwO/EnWLuOEiyy/cz2H0TP4yVsnCcYlCf8FpGXQXAcIbKpUskfU15aAL
         4CVQ==
X-Gm-Message-State: AFq9FYIq1mz5ivgCt0TuxZd9+JaiofxAEQ+/ZRba3iP2MSxUGYq43f76
	sHotUASIP2dSoP+bcYvee6Ivxwx2VTgKGDvfwjmLh2wfXWdbfMaQbT4uCbqMxlWbmyvbndmqFDm
	BdYbOMKvXem9oM0hPnd4EgB2/1QCynpVJmg/v
X-Gm-Gg: AYBFou3XRADy/wexFtXW7Hz0Y0wAYucxa3AwBFPDOontkzrFXspEzpZeqMU+BMWkH5T
	uAG8Uj/Vtt/YXKvYTUZaFXVSTrGkuzZviT5Iqkwcn5jclyK/9FGYH/7WR35UqECykyTx7Ay20TN
	GS4xpvevtHeWrp51QwMcFpFQW2VAKtql8YvaNhxUI+QO6HQzk/agm6By0C8gzCFXeWQ1jh9YOEz
	A15fhAzVZ6N3tenD4s1YA+jutG3ZKbPMBDhOVFr13oAeQnQFxO3BnhikO3Nv7GLdyV9/Rggs13B
	sgE6duyYXIm7GwBxW8Z1hkTC40LqwLKI6cjx2qCywwedhzs50UrrB3YQM4FEWwhrPqOBM3+2b3s
	6DPoh1SMtEuqTu734ZkNdFxGMeBZzqe7J7XEw
X-Received: by 2002:a05:651c:1501:b0:3a9:a1ed:6341 with SMTP id
 38308e7fff4ca-3ac441634bdmr8139311fa.11.1792606832291; Wed, 21 Oct 2026
 11:20:32 -0700 (PDT)
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
In-Reply-To: <ffc98c40-09d5-4299-8128-72cc0ed6beae@kernel.org>
From: Anil Kaushik <anilkaushikwireless@gmail.com>
Date: Wed, 21 Oct 2026 23:50:20 +0530
X-Gm-Features: AclHuK8f4WthLILvuv2KwWsQUgmBX5_E1tgSVUxvKCsMvOZRVUwpd6p5xmBZTQQ
Message-ID: <CAG0Mgm9ShHdApcKAUj_PgGdm_A+w--FKpSpJq=nTJ=DkRcuACA@mail.gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 2/3] mptcp: pm: kernel: retry subflows
 closed after an error
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

 Sorry I missed this one. Response was in draft and I missed sending it.

On Wed, Oct 21, 2026 at 11:18=E2=80=AFPM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Anil,
>
> I noticed new versions, but I don't know if you saw my reply here. Do
> you mind replying to my previous questions / comments here below, please?
>
> On 16/10/2026 10:43, Matthieu Baerts wrote:
> > Hi Anil,
> >
> > Thank you for your reply.
> >
> > On 16/10/2026 07:49, Anil Kaushik wrote:
> >>> Add a sensible default value (what do you recommend?)
> >>
> >> 15 SYN retries: about 20 minutes with the 120s max RTO.
> >
> > I guess it could even be longer, no? With an exponential backoff, it's
> > not spamming the network too much.
> >
> > I wonder if we shouldn't get something similar to tcp_retries2. But
> > here, with the syn, we also need to tcp_syn_linear_timeouts into
> > account. Either we keep it to 15 by default and, (if not 0), we add
> > tcp_syn_linear_timeouts, or we initialise it to 19.
> >

tcp_write_timeout() already adds tcp_syn_linear_timeouts on top of
icsk_syn_retries for SYN_SENT sockets. With the defaults, 15 gives 4
linear + 15 exponential retries, about 20 minutes, close to
tcp_retries2. I can make it longer if you prefer. Let me know please?

> >>> modify icsk_syn_retries instead [...] WDYT?
> >>
> >> Good idea, I will do that: one new subflow per failure, with its SYN
> >> retries set from the new netlink limit, 0 =3D disabled. It also remove=
s
> >> the socket reuse, the retries counter and the 60s check.
> >>
> >> One point to think though, If ICMP unreachable stops the SYN at once.
> >> I would not retry
> >> again then. Is that OK?
> >
> > Good point. In your specific case, what do you observe?

In my tests, the fiber outage is a silent drop: the SYNs just time
out, and the subflow comes back once the path is up again.

> >
> > To me, the best is to have the network manager (something from
> > userspace) removing the MPTCP endpoints when they are not "usable", but
> > here it can be specific to the destination. I would then say to look at
> > this case later. In this case, we could eventually disconnect the
> > subflow, and add a timer to retry later. But that's also more prone to
> > bugs, so if we can avoid that, probably better to!
> >

Sure, lets take up this case later

> >>> Do we have other similar ones? [...] ss -Mte, would that work?
> >>
> >> I will drop the MIB counter. The test can use the MPJ counters and the
> >> netlink events.
> >
> > Thanks! You can expose the new limit in "struct mptcp_info", instead of
> > "reserved".
> >

Done since v5.

> >>> Is it specific for your case?
> >>
> >> No, it came from a Sashiko review: a dead subflow waiting to be closed
> >> could be re-created after its endpoint or the peer's address was
> >> removed. I will try to move it to pm_kernel.c.
> >
> > What did you end-up doing for this?
> >

When an address is removed, mptcp_pm_rm_addr_or_subflow() now marks the
subflows using it, so they are not re-created.

> >>> can we not check why it failed instead?
> >>
> >> With your idea it is not needed: only one retry, nothing to count.
> >
> > Good
> >
> >>> what error do you get when the issue is detected via TCP Keepalive?
> >>
> >> ETIMEDOUT, so it is retried.
> >
> > Thanks!
> >
> >>> Why can we not always re-used?
> >>
> >> A subflow that carried data needs the full close cleanup. With your
> >> idea we always create a new subflow, so there is only one path.
> >>
> >> For the rest: OK. I will go through pm.c, avoid struct holes and
> >> duplicated connect code, drop the RFC tag, add a changelog per patch,
> >> and test closing the connection while retrying plus the netlink events=
.
> >> I will wait for the netdev Sashiko review before sending.
> >
> > Thanks! BTW, it is easier if you reply inline here below, to keep the
> > context:
> >

Sorry, will do.


> > https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replyin=
g
> >
> >> On Wed, Oct 14, 2026 at 11:43=E2=80=AFPM Matthieu Baerts <matttbe@kern=
el.org> wrote:
> > (...)
> >
> > Cheers,
> > Matt
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
Regards
Anil
