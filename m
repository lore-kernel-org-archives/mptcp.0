Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315054;
	b=mq2HbKW7fjBzjsd3F8j0bMUldedBvWsD6zOMXZnAwdPaeLK+z4xIzq2qQ6TbJA5Pw8Ww
	 8he2WJUDKLskI3HA48oCQkk9yzYdkXo1B7uebuk9XBW2zZ5y/N5VBGFlwPpr97qhLiYqO
	 34BX5fEeIsfPGebCdSWEYY6+Y5QxVsrGdyA+q3h6Md2K+3WWOaNcYhpWjJtLnNWw5tdOB
	 wPvvaD65Nm+a2OL0iUuXfwxqsLhv0E94fTaTHhMjdPb6mDWk/R5W9B8Azb3SNEvLGlZnj
	 lp/bwpxqte2xroNyXM36FMDqrNIy7l64BS7LDgqcepYvWpn4tr2ONcfJIYrYVAt10QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=EAr1+5icJgsBBUXaQ7EMDLPZu9FG+i0x/p19VFlTlMg=;
	b=pBev6vKquw3JEKq/wMWGIbtBzswhYmSarJAVIF1jEmMzfjkuRVB+fD7TIUvbIKwGOYRC
	 SIwY5fSZw4t8gN1VucbN/znomPWQZfAJkYxfiblcEDeT7W3PW1VMqubzpjst4hZ+PCUH5
	 68dMnmqvTyyC2Fouc1gQ68KQaVte2kjcm8apR71sY890pnIPQ7Gg3r/VfIRD1VAEPx0+8
	 /zvEOdajVif4J1znQaI6e1t6fgdA0Yl6mbtMINjCl8q37RVdrE7FFWI1JDUE5LjS16oNM
	 EUCWZVG9NoD7CONCfbewh+8aBUntQsFtyap/sT9YMw+FIMNXiYhNxjoY8moERAqMxBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+gJDNbw;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E98606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+gJDNbw
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-451a49abd8aso95168fac.3
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315053; x=1793919853; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EAr1+5icJgsBBUXaQ7EMDLPZu9FG+i0x/p19VFlTlMg=;
        b=r+gJDNbw6Q73ks9ArCar8Cg4/pZXyjJcyZYXcQKLnL+kk21wnqmKs9DUa7ercEVYKW
         bd0xmTaZN8Bq72fr8Sai+jpbveknHWgMyLk8gCt1JOSSzqs9DJzrdOriKJ3hctJnQAOr
         FR/NthIaAAigEnJzMnoofMrbbnFs8Q1uPXWrWmio6sSw3KU9Mj7UuSOptCHevvwNJ7U7
         egOtsQi1wRSfieUf1M33Z0FLnAMsyN1C8urnVUjYW2UB2LBi+MczzJrU11xX5h+Rtphm
         m6f0WkHQeWyCv9JeVjx7bljoqVJdB4FeF+zhz0oqAkZmXm/77OUccc2YkVdpE0+beGn9
         /3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315053; x=1793919853;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAr1+5icJgsBBUXaQ7EMDLPZu9FG+i0x/p19VFlTlMg=;
        b=KUforWYKaBaJOou3neK6Ew7qZ/CweP5Ai8jZOAPt4XMphpHiSmoIVquu8L6GtHLJd3
         v1RKskLbSnqQ0nlcb6zncOp5HuV40YGbwRPAVXxUY8WpCxCKZw9cx4eWvpb2hMmMGflP
         3xTZP0IGta751OB5F4kKEtL91JjqMy6Im3kKTu7ne9hTlvSyz3sg9vnhixEAWESoik4D
         AZOLIQEdwQVzdHGbDWVyTchLKRDy0/sF/r0dUT4vSPADBukEXpRZVYJ/RgCOCky8rWO+
         8XcR+ZikGURZjRFsOVoL2gquk3MX/1zlpeDH7EziWoHLuAxfAJuPsEQst6Zq5tWrwgTi
         bmXQ==
X-Gm-Message-State: AFq9FYL+mHrTv8b7TNJKqFoktGe93O46BRTqmRWbPGo1DXPnTOJHW/d/
	8a8k/Lt/Gj/EL99H1fklI1Y32+3btXeo9SaC4Wus0IyYsSQigHvlrBg=
X-Gm-Gg: AYBFou3x3y52oI6Fn/rpEAq1Iy8oJAEYj0q5WsuQ5YPpw+mrXgHMz8nzZyA4fwbYPrg
	VwDnvfg2vldW/9FrxWV7DHOQX0QRQkWNwILH+jKD9qbMWvUc9xUIByvU/cGbgryrloNuDP0tkSb
	VBErRbnKvb1e1OvQKrPgH5dl1baChEY21PgFbU5ayw7JCDMWHw56GMVCMK+6JaFo5Mq/ShpGDmy
	QL8qUXp5L0DbNyoAkFa3On/S0aU7w7/uUkY1kUmkCxYSRCTWsOcgE1AeSRDaSUz9KSfNtheb0pG
	XcJOuk04WvWFcxehn19QIxhsNYmvl/QVfD5OqTgZc+RJumEA0DAvRWRs1/QbDuJncHvdiU/LLEk
	CNl2mVzSdbzHqDkINP3Uos+L0g8sGLDNl6x7qM3pENvZ5c2YVP1SwsjC/IaxueAnHLuUm2n5SXR
	36QLl6xAYITOTI/qhFn24hZXX1x3pPx99sxsXSrt24IGd4wnTTuiFBsU3dh2+glYKgG6MapnqLM
	A0lBCXn1PmreOXYV19U5R5x2D8DZee3oTrKH6Xb5sX1ULGd1auOXgnelu+RzlhICoecLe40yVOM
	fOtXi4Jgb15uazZDatYKjlC8pOnzpXOpL6wiofYgwKT0
X-Received: by 2002:a05:6808:c12a:b0:4f2:6f1a:a34a with SMTP id 5614622812f47-5640dd023dfmr566082b6e.12.1793315053122;
        Thu, 29 Oct 2026 16:04:13 -0700 (PDT)
Received: from github.com ([172.214.155.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fa0af12sm282800b6e.0.2026.10.29.16.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:04:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
References: <20261029-mptcp-mib-inval-opt-v3-0-428f42a35674@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/3] mptcp: options: MIB for invalid &
 drop suboptions
Message-ID: <a96d6955-67be-a163-5bdb-8beeb0037036@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 23:04:11 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40958087376

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7d5e686a6c=
fc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196631


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
