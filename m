Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142234DB6D
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745976; cv=pass; b=jc62afT9MlgNnR7/Wg2RHnwDq9hSLeKbmxdHp/fdNacWjAEx1gHzNAE7GpwtPrdo0JaPO3TRvAO2ZkJyOOfya9iUEczW4LEMGmyvFfOYN3fGPZSiTS0myHcHD2hH6CFrj2o0vmmbOnom3z2/nvC1dZP9IX4sq/SaRK119ulw7wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745976; c=relaxed/simple;
	bh=XcTaNgTDPsv2STdc3SNfWdK5+ZyqZko6rivjx4S02cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mlu0HUspJQ5O4Mw/ZzkD8/YRodM3BBcxrHr3nMakZhcdBjEyRIc8g7LgzfxvkfHH9jjdRqZhXx/Rt8yAiFvkW47MRC5ulTVSgKpWkkIHqBHauwxn1wnprjq/a827SrNfsSVBfXXP3RF7gSOWJtbjG9//+NxO9UFLmvQWY1h/k+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdcfHaIg; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdcfHaIg"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c5b53d710cso3160349b6e.2
        for <mptcp@lists.linux.dev>; Tue, 29 Sep 2026 22:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790745973; cv=none;
        d=google.com; s=arc-20260327;
        b=kZ+5INMbPYUpdTDts0/9E/mZczigoh0p22lIRr3Pz1aBhmAUt0LPOTgRr8RmDjUHRE
         Xe0nGsyRJ11cASqMWipVzSvNkOdj8BPIZOHOuYiTFTEdHXuzXkfoKS9/SuqM+FAgUz3S
         ku36WAKdZYlVj53PGT3YrzQYxQ81BodoRBU1I4G2GWTO+VsxgzedgY1QjkyIAN/x6RbH
         uNoAl7lI1+it6bfgkl5wGz4BV1b5akg7citpMIXk8gJmV82lSSIFFDqGGC6VwODynD3Z
         fGnZzcUK96cV/ph7KuJKglqc5M0VtH6/bkspsgM3eso77Ta+Urb0KVepfbNr/HjKMfXp
         Q4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r0jNjbh9syAAkV3U2px+C+seumaDfM+HGYwjQEG3/Lg=;
        fh=V43DrKGXUjNJyLw64hjvd6JLMAtYld5kcs/oRhs5hGg=;
        b=Q5wh8la74ZJ1eSLbCKX+7SZb9DtwstnFWM1cdUrysBsVYffBMkDSiMisI9WAC2ddBL
         tLI/Kc9qdMU2P+NXHYLNQ9DXPp3JNNFOSKFRMtkSYomFXus3ETWcrZKK0aFh4gyquvLz
         ItgIeELM9VnVbcbQP5GY16jhPNKg3y2Ow7kIB7cOjJCzCQLpVFG12zOHixedsFNa/OyG
         MYMqYpnf9W3//HPMOu64pxSLzOrkDlmx85BSVgWH15ZSggfxRPl6i5C7EL8xJEyDXSTB
         1efgGurqIHiTzXJxRYtTVqrWa9nbtFEsyJL5Wii6F2+9niX67BZbpZoWTiA5xtjXPtjH
         e6wg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790745973; x=1791350773; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0jNjbh9syAAkV3U2px+C+seumaDfM+HGYwjQEG3/Lg=;
        b=SdcfHaIgb0BOWAajDMkZtWdRX6mPSZW5VgQvBMlk9g9C9QIVJdlDWUfq22hjGqbrGB
         qHmefzhff0z96G9V+37Uev71hTohRiOwIWJ/+emBnGqUt9/yVnfvm/J+OebGkdDvX7YX
         sdHSCmiZQJLjhTwr0y+jhmrm69GeGEQbhETVTrMv9F1n07b9fRoMeQ+zgoZ98oQD8u8c
         SpUzUQTk+wns59m+T4gFsHTJ1bHlClBhfhNsRWKclmvdYrMIVZ9+sYQfFmsMqTZlCx1d
         ZZ9Kb67V9ilq2yC/1qtvc5iTd8hDcWYbLFlowMbznYKZoa1sX+iKhje+kURle51cluG1
         dGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790745973; x=1791350773;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r0jNjbh9syAAkV3U2px+C+seumaDfM+HGYwjQEG3/Lg=;
        b=KTEUXJGYi0+8rBnCZWZAbHxVmEPDrwuzLwtUa93/SB8Ib1YnkifHnMbI9h5XiUyEPA
         HD6K8gTjKP4chHMVR6O8lCoPHK1GyiUActfzY1+JAXgmtk3UxjXyfvdH3zmUMjkwbeIZ
         4liZAHx6woVGsu+yIazROznFffrrFIQGS4HRQIfNtbtVujITWgEVOAK8mDVb9c3dEJHW
         9kTNmpNty8gYnXMq7YrkdXjHhCR9j58JPQmJVZQepC9XrVi+G7uQe67Y9lOnzhoOO5Gc
         17WyBDfL+K/T7miUz+dzXP7HYuwrSQQHj65rairDtjXMROmm7/Hv0OCPihraBOMpcq7z
         SIQA==
X-Gm-Message-State: AFuF++lux7oa990CXyx56JOixM35wPAe2uGm6ykSnD1bJwQ/gjsoL8BS
	ZVl+fc3lJ1bMJQczXMJzwYt4mYdFey/94ubLyw2/wVSMsI+Ertio0r2eM0dFj2fLE3vvC6ra60d
	xFa4XJiiIXVONR86kjj5H+KdvKelkWic=
X-Gm-Gg: AYBFou3PBeKBgAkD/mGUZ6fCAlZsYgTEufssh6pp7JW9R+ewTlAbXNDIt28cIPgnBk0
	P0Rm9snY99yUhiT0EfE4opYE8cqOcKRcVvtjCuKSevyc+zrSAFt+00IZeqIWtKsboXtD1teVVrj
	yLul3FRYtBe/xcOM4jsSK2EnfGsqrojZ9M/wc1f5G8j8AjwcJ2QfVF4MwoDEa9/BQ1GqyLF/Gsd
	6Z76PM4Pp0+myNwLmHZfb+YTAj7XLgwjLpE5fEX4ikvHFb1+0oBucyvwyYmuCjoNV+pqa4sqOT0
	Jpumniqq6gcZckSkviqL2MzpkWSVFGdXkvVQFybtuehbwL1f29YAbonbanNhme12HXnDJ4b8g8g
	gr1mbzMhA+w==
X-Received: by 2002:a05:6808:1992:b0:4c1:5e42:51d0 with SMTP id
 5614622812f47-4f1b0c1132amr211233b6e.4.1790745973341; Tue, 29 Sep 2026
 22:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+XhMqwA+x8kd4VjV_N7S9S7mCtAhr7FBc0ByKDQOTyU-PQr=g@mail.gmail.com>
 <90d9bf08ccc7c52cf7791654737509fffb149dfe.camel@kernel.org>
In-Reply-To: <90d9bf08ccc7c52cf7791654737509fffb149dfe.camel@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 30 Sep 2026 06:26:02 +0100
X-Gm-Features: AclHuK-9ueBF0UEZGtZaow6xqyLGNpuhu4xkz3VmsDAwqzvSsxgNj5Dwbu6-fcY
Message-ID: <CA+XhMqxbrk+Z39t+L9J6t+vzdLyHx=ax+0FzR4Bz7muh6QbKXQ@mail.gmail.com>
Subject: Re: [RFC mptcp-next] mptcp: TX timestamping at the msk level
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Geliang,

On Wed, 30 Sept 2026 at 05:09, Geliang Tang <geliang@kernel.org> wrote:
>
> Hi David,
>
> On Wed, 2026-09-23 at 04:27 +0100, David CARLIER wrote:
> > Hi all,
> >
> > After Paolo's comment on the MSG_ERRQUEUE series [1], I started
> > looking
> > at msk-level TX timestamping. As far as I can see nobody is on it, so
> > I'd like to check the direction with you before writing code.
> >
> > Today nothing arms tx_flags on the skbs built by
> > mptcp_sendmsg_frag(),
> > so MPTCP data never gets a TX report. Roughly what I have in mind:
> >
> > - keep the tsflags and the key (data seq of the last byte) on the
> >   dfrag, since the actual push happens after sendmsg returns;
> > - arm the subflow skb covering that byte, keeping its tskey in
> >   subflow seq space (tcp_fragment_tstamp() and tcp_ack_tstamp()
> >   rely on that);
> > - when forwarding SCHED/SND reports to the msk, rewrite ee_data to
> >   the msk key. I'm not sure yet how to do the mapping. The easiest
> >   option I see is a small per-subflow list of (subflow seq, data seq)
> >   pairs for armed bytes;
> > - emit ACK reports from __mptcp_clean_una() on DATA_ACK rather than
> >   forwarding subflow ACKs;
> > - seed the msk sk_tskey for OPT_ID the way TCP does.
> >
> > The one I went back and forth on is reinjection: the same bytes can
> > leave on several subflows. Plain TCP already reports again on
> > retransmit, so reporting each transmission seems acceptable to me,
> > but
> > I'd like your opinion.
> >
> > Geliang, your MSG_ZEROCOPY series [2] touches the same spots (dfrag
> > layout, coalescing in mptcp_sendmsg_frag()). I'm happy to build on t
> > of it. Do you know if it's still moving?
>
> My MSG_ZEROCOPY series is still moving forward, but it will wait for a
> while, since there are other series to handle first.
>
> I found that I have a local patch "preserve the rx timestamp when
> coalescing skbs", which I added while debugging some feature earlier.
> It might be useful, and I'll include it in the next version of the
> MSG_ZEROCOPY series too. Something like:
>
> @@ -178,6 +178,13 @@ static bool __mptcp_try_coalesce(struct sock *sk,
>
>             MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
>             to->len, MPTCP_SKB_CB(from)->end_seq);
>    MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
> +
> +  if (MPTCP_SKB_CB(from)->has_rxtstamp) {
> +          MPTCP_SKB_CB(to)->has_rxtstamp = true;
> +          to->tstamp = from->tstamp;
> +          skb_hwtstamps(to)->hwtstamp = skb_hwtstamps(from)->hwtstamp;
> +  }
> +
>    return true;
>  }
>
> Thanks,
> -Geliang

Ah nice looking forward to it !
>
> >
> > Cheers
> >
> > [1] https://lore.kernel.org/mptcp/d6cdbc83-86a6-4c2a-ad99-29cdb83566
> > [2]
> > https://lore.kernel.org/mptcp/32bac661bcae143f7e63905dfb781c98e95cdde5.1784260668.git.tanggeliang@kylinos.cn/
