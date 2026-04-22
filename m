Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3935898
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894717; cv=pass; b=KmtXyf8dwVOQ1pSJ5kJvqwr/o5F1mdNudJbXsm3+q/lnolLBFUIri84na+X2tgceZK8rbCMphMEOk22jUwMqfO0yy5KBHouzqfgzVDegYtSWJSberFu+HkNTqHUzA3ZdF2Xc5C4ZPUgmgHUBYSRB48sv3Sgo0PekGZPNP6SCaCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894717; c=relaxed/simple;
	bh=xCmzg9Y9zqnYb9TwhiKyns+SDKqNBtMsMvqx5WMv3cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAzQ2NunJEEF7mlS79BU3dyDC7bmy9q6SUbUYoA5mJViqxx4T2h3VglRoznLE3BlEEtmDtYJA0R4yapM2o+9nmfoXAQBzLk5j6Icjae/zvBTuwYuky6dPm525bQbZggSssWvCuSqxFPpcUVG9ALpex6NnUcPHa9wIRnT7tccVB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO5SOu9t; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO5SOu9t"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so3087086a34.0
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 14:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776894716; cv=none;
        d=google.com; s=arc-20240605;
        b=GCTE10KnwD6p/+vYbntPWuOTCE1FZQHp6JfkRdd6ULWv1iv+2K3KwnZ+eCTaXh4BfB
         17w/lNpckcZCzW1/oju4Nm7wPJfLSVdLvyhuccAquKWO1bIJSVgAa44Oh6ufKZVG6p90
         BJ0igroMEA+R5+cJVuDj50GkalQAGHpv6ix+7rpowyfs7B+M2hjhKcazkguAWf2aF51M
         k4zt4y1DbbOMi/9Cm+I0cFjj/vcnch7sOt5MKnXnX3ZbTT8GvAQp/zAhoXl7WBNIVKwv
         J+0510LIRsrEAS7jzpus6tMXUmnutXnI9n6p3BmSVi4Dt5Tetwzi6veN4OM48u0SuVkv
         Mojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wqjvDKLcx1FN5IavTsdUZj+Q4LWAdm/7NwfMKyHRjh0=;
        fh=t5+JejTJfYR2N5XavZav/15Z9iEcC/cS8sfhXtVvnzg=;
        b=hNL7i7+HZRQkOMg2GbdrmE2HVGucFVFRK+CdRVS0NpHNqKCBa/UhDb8JhI3ERrY/Yv
         78/EXJ1WoKQrMMWfl6TOna+wJbXSA/TRTrxMLSlTXevajAI1IFqpNdvtvyH5mPuTZz7t
         86tpLNGRPuWq5RCt+z1QxsXNexdhibGlJrusE/HQZDGUF+qvQqMoB2Cz9PyGL7mEf2m7
         6mTHB7The+P5GxYO8uNwHsHGBmO9ul9fmNAxFtRQtCfPH2tquax1Z5JyfFBLzYmtPptI
         O6C3jtgBzA2Josu1GYRoNudPj9mF9uQ3dTMl9wMRmq5euWCMOzlxvYAp6Oyh9XnCPoGV
         3y3A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894716; x=1777499516; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqjvDKLcx1FN5IavTsdUZj+Q4LWAdm/7NwfMKyHRjh0=;
        b=VO5SOu9tVImX2NPNG/aAurN2M1WLQKJNJ8iobVTpUKTxEsyzMgQg4kPRhY/jyXuQKv
         WcrIpv+6AofdsbwTEWh1A+QzLojFvgHXUsP9+4lGdofaTPWgtUa90QeigI2qdfqhjJjf
         p6/GYt68qyGVtzPr0QwcenhU2D4u2hlf4sw+d+lgAdbQ57R2NEISrJ17xWIdPQmSdXw6
         Xs7Bw5aOea0vPenvSswppPGWAlsqcbYdW8z+Auv+BWWTClSEBCqpFR3XpgXBCw5Tbika
         F30Bmw+XRq/2pjJrHp4GvXmVY4mTstzTJaWHCVTmBtWlcMibOhxbDBH1s9ak3GjSysD4
         yG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894716; x=1777499516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqjvDKLcx1FN5IavTsdUZj+Q4LWAdm/7NwfMKyHRjh0=;
        b=DJXa1dye1SR5g6hLDUGHS1V44TgctUbhmDVEHwTlFK4sGPLXCQ/x6GyD7+Cy7FW+71
         LSq+TMJqsj6smERc/tGD94/KO44W2SnrUzwussdmfdypNVXQjYRy3I9ML9Fw1o9N1jfg
         S1R3deqIurse6Om8Tft0Tv7dktW4lgjm290uJUr6sO7m2I5HT729Hl8GpLoESde4Jb1G
         X8sfiwaCueYCf/5Kc7aJ4WmmFLTSEb7U2VTR0M/kDOCb7BaTXriuUdYFgE00mP88bQWh
         5Cu5xAlfoaSqQxHFk5IGhr4LevhfvA+uWiKVYxoOAJqXh6C3hJcujBjO52z5u52zn4mT
         /xJA==
X-Gm-Message-State: AOJu0YwrzlHkIzg13dvdky0cg7BAS0xlrxeosUsZ4/G3ky1QgO3aqU28
	z8OP+9u8ZdvL4GAmxctHFBphh0uu9VhE8/mg8DHybJ4XT0PM8AB7DB9Gdh0uOjD7VLTEFna+nx4
	GfRBPnOoWX2Hd15WJnkUnzh0ky2wqkiU=
X-Gm-Gg: AeBDietvEid/PC5YO9ybHMIwJRNgLw7QScf8nGirQ+39fhEeeYrSLKtIyqYK33GOJR7
	5vQnFf9OuiT8aCvFMASohfxIEzC3qSQQ3DGoggwToFFtCEFIYNgQsa8hOxnpt9vmhJ55nF6Chil
	i3zqEbCl/0TeKfq4EZ+34yXBsxPgkrxeHcDUQM83CZ7gNIvcadVyIQo76KbBajq5RIP+YVAJUSp
	aJ+JEJeDKDH0OItjmvhRmGcU1SnxH4Q1IxG37Dbi0U7kwiOxgG7YE+VDZ5bdAzdwMV5Ax9x+3x3
	Os+7BZmJjE+8/8m3ovbCWkboVjHFZHKJW0lB02mDsv8HyFEi
X-Received: by 2002:a05:6820:4c06:b0:694:8f3a:3f41 with SMTP id
 006d021491bc7-6948f3a4683mr6389196eaf.41.1776894715652; Wed, 22 Apr 2026
 14:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421223338.52743-1-devnexen@gmail.com> <20260421223338.52743-2-devnexen@gmail.com>
 <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
In-Reply-To: <e5dbdb08-f666-47d6-83b6-c157c7e9036c@redhat.com>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 22 Apr 2026 22:51:44 +0100
X-Gm-Features: AQROBzDcVw8ueQGz01nkOK2UM56nAYOjEBWldf9n986-wrplHHiOPjPls-KcVC0
Message-ID: <CA+XhMqw5z0NbsXH0MRL=T7ZmRv_OT9Reke6Uo6Yq6kFQJL=2yA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 1/3] mptcp: propagate RECVERR sockopts to subflows
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 4/22/26 10:05 AM, Paolo Abeni wrote:
  > You should drop this line, only a single SoB tag is needed.

  Ack.

  >> +#if IS_ENABLED(CONFIG_IPV6)
  >
  > Is this compiler guard strictly needed?

  For this one yes =E2=80=94 it wraps mptcp_setsockopt_v6_recverr(), which
  calls ipv6_setsockopt() (no !CONFIG_IPV6 stub, link error
  otherwise). But the helper goes away once I move to
  mptcp_setsockopt_all_sf() + MPTCP_INET_FLAGS_MASK as you suggest
  below, so the guard drops with it.

  >> +          ret =3D mptcp_subflow_set_recverr(sk, ssk, rfc4884);
  >
  > The above looks a bit overcomplicated?!? It looks like you could
  > leverage mptcp_setsockopt_all_sf() [...]

  Will do, rebased on Matt's sockopt_seq_inc() fix.

  > Instead of the above you could add a pre req patch converting the
  > existing inet_assign_bit() to something alike [...]

  Ack, will add as prereq (and mirror for inet6_sk()->flags).

  Cheers,
