Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE23246EF
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848228; cv=pass; b=NTAhsP78hd7IjieOw9fVnOOUvQlxWsrJnsf2wIHosiAiSVgiUo6zitz6HWbUApPtNnP99KxzXc7q92AlC/8lIkJB1Tyc0gjZp1pOi4nneulKw+96eqsr+7mMfzSxjJZlXSN8dwQ4liJDt+/AjH4lEpcGYeFrIWE2kdU6dgUaT1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848228; c=relaxed/simple;
	bh=D7Lvs2/btS7nnxhxusTBw7SVTbbCFZdeZA1q8cuzv9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1bsHFxE+6dTWPkkNPyBG9re6L23pBqW7tif38ehwT9XOAUwgzUC6nceBITAYx1aFSxf40YeRytUfon0m5TKnl1ntzu1eOZZYCdAgblUNcCGLNyh2GxCbuKyMjGTwsEpc30u3lSPcUVPl5golWnq9fNi6gc8qpccmC9mNse7Jp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oie2ZpNX; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oie2ZpNX"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbec19732eso4549730a34.3
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 01:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776848226; cv=none;
        d=google.com; s=arc-20240605;
        b=jyN1pKzKO02uV5cOH2OqXGqUhjOg+SjQAcoAa38ijw0BnuP+iQleD95fm2i91zlx68
         BFlTBA8lRS40lqTALQaAuHuzizdfE+ctvizKuy9xmxIDllPBhTy4X41QX0I3NSccrJXa
         RTW6Lwbujy57PmkXKId1gHPQH+LFN+12xDS3Vvf6iozMp1wpuJnvqqd13xKq5meWzOyM
         CcSGDKvKhnbQNw5dBopEyc/wlLA69EcSKkr/xXm4GJAYjPySfONey9iNbsBGLYQX+tyO
         XMry1Qd+cSwmLSCgrzKf6Ja7WRbD98B9+I9VdKoubdhEDecYbg5rIgnfvaW8qjGIzd3H
         Vz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D7Lvs2/btS7nnxhxusTBw7SVTbbCFZdeZA1q8cuzv9g=;
        fh=1318w8i+2sR4Mp6uPK4c30WeQwgiw1KbigEWoDlafew=;
        b=BgWUx2aWX/eZ+HCZEjOljCq5YQE2OWL1NK8DQx69315swPwWGkJvPgHNMQO/ANAVYn
         yqANuIrs80P2pM9hr1cDXYG0Y2XTHkKXW/KT5qO005t0bqmU382Ox1huljFpFeeZ9Cyo
         ghKRlbyakxa2Ga6caGFdzrbHB1NYmzMfEdG7QeBULEIscgUUZpZHBFInARrGgNY8fNXe
         wJ6Jv1yRPWPBY8RH5A+9bjPm7haSacp5zLNgwMsKroVwH0jJ38LgrOlWKi7RSOogrudg
         Q3R6p6VLeJk53I4tNn7pf0VfXjGShjMqCDxqTcXTrwdxRdYsdhBxX3yhA2F2qYEMnDrb
         ZePQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776848226; x=1777453026; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D7Lvs2/btS7nnxhxusTBw7SVTbbCFZdeZA1q8cuzv9g=;
        b=Oie2ZpNXdXAuFqT7LGc/LZdTQoVxfbq9FZfIh3NfGeko6gUy9OlDURggl/m9w/OwCT
         hpviJK/nOzNAUkmUTyj1o5y+pnRrDLHdzNhndav9rmz5XT31+2PEFt26aZanFoOTv4BF
         EJ3FpqE+Ge2QdB82KgDJiaSKw9BNd8bBZM47N9QUaacnOlfBjVmbos94UTSAoLZYd3rV
         oN5l2tttfvCmSeeNj09qagT/xhBiq76AUUEf6pB6Ga9NPzCH46aUuHYS29S7XZP/kfVV
         cEN+PLu60PKD9bVTqUHJ+XvsDoqDLlR1tno5GbCEbd1ffrt+mNvsK2n0FbH2dAcLrU/G
         jgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848226; x=1777453026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7Lvs2/btS7nnxhxusTBw7SVTbbCFZdeZA1q8cuzv9g=;
        b=secVcpYEIk29mRbMkivagbw380YIGGxc6HMOErGApl3AyJEJGBrvlARky5uBkNmeHR
         v4HPk0Lq2EEHrhMmWz8N/6FPOX9fVbhR9O+sqFzMfppiKwvOiVBGSb6HGi1ISB7rMCzF
         5d6mwJDbCIEG7w6rmc7pAhiQe6Q1+8tSeriAA/JNkDa/CgHHBkBcWQc3gzrjenEkn6KZ
         BgO95mh0Nbxe9uxDVPYpK6Sd8dG7U7xuYfzG10f0YUOQMoFu36CpCBru8pgR3BIgASqW
         0glBjcrxS3nI+HESR8MMxJgjsSENvAmazV7O9ycW9Mt9esC0w4mgn4Qm4j6Ez72dAyrk
         9peg==
X-Gm-Message-State: AOJu0YzKJ4V/o/Xtok7fKyRm7Uz0ZSQDtgNS1Xy9hVp0W/3cRR04yUcZ
	btgllq+yPHzyrLFpYX2y78W+YL0n2LeTup23kGhlVHhYmoADZvY7BIradHvkTgs9LQZ+eQg4acC
	16sW/kJnwt5JezSNiUgtYi+GXDr3oisg=
X-Gm-Gg: AeBDies1z8Td3ztwxunsi82Z5WZR+1Qjm+pULYwpaNWTBr+WIC8Ef9y/2rGHEB27NMl
	wZM3zU2UnIsUalKYNwPPyQpENe0nt2f+KX8pd8zgp/BZNYY9G50H7oOS41FT/MIZpiixWdH7bvd
	8W4nbZchXq4xlKymjT5kVm5Vi5gwGRv+Ze3miEBOMSDhZDHVj91anqj71/Ryz5Yi3N2UACwVJ5h
	yeWpIAxEBjVgLm7FCqkC+TtZnvtgyn5K1XaCMngomDU4SKhozu94yrF8yFM9ELpR43nW9dwtF39
	2SOjXP0B08mYYyy51+rFX66wGd0JKbHKkSvBbq6wDVKL9O89KvUq3G3QkUA=
X-Received: by 2002:a05:6820:3094:b0:692:a19b:af70 with SMTP id
 006d021491bc7-69462dffd01mr11518328eaf.4.1776848226376; Wed, 22 Apr 2026
 01:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421223338.52743-1-devnexen@gmail.com> <19214e19-0396-4c2c-9c85-cb1b13210a11@kernel.org>
In-Reply-To: <19214e19-0396-4c2c-9c85-cb1b13210a11@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 22 Apr 2026 09:56:55 +0100
X-Gm-Features: AQROBzB4N30V6CXq9efdjxjW5L-BLflmASWTLzAXl-OGqI072i7nn32IDPo_xlY
Message-ID: <CA+XhMqw4xRGdJbtX02++9eS8u_bWOzbPimM1Mk_dDNed5SX94w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 0/3] mptcp: MSG_ERRQUEUE support on the
 parent socket
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 22 Apr 2026 at 09:22, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 22/04/2026 00:33, David Carlier wrote:
> > MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
> > parent socket does not currently provide usable MSG_ERRQUEUE handling.
> >
> > This series wires the MPTCP socket up to the IPv4/IPv6 error queue
> > paths. It propagates RECVERR-related sockopts to existing and future
> > subflows, makes poll() report pending errqueue activity through the
> > parent socket, and allows recvmsg(MSG_ERRQUEUE) on the MPTCP socket to
> > consume queued errors with the parent socket ABI.
> >
> > The series also handles mixed-family subflows by applying the matching
> > sockopt according to each subflow family, and avoids silently losing an
> > error skb if requeueing to the parent socket fails under rmem pressure.
> >
> > v2 -> v3:
>
> Thank you for the v3.
>
> Do you mind sending max 1 series per day, please? Each version generates
> a lot of emails that are sent and need to be triaged, it is then harder
> for us to follow, plus a lot of shared resources are used.
>

Dully noted.


> If you need CI support, either execute the tests locally with the docker
> image (preferred), or send your patches on a public fork on GitHub,
> after having enabled "Actions" support there ;)


Yes I realised that only when I did the v3 :) ok I ll go through all
the remarks later. Cheers.
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
