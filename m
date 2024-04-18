Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5616F29F
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457462; cv=none; b=l8xuoIKKSlqfqJEIolgz19Xt1+JulFxRsCE5WmRVhbx8Bor6IKscTheo2/RElKCqf3ftdserQpvRVbtE5Z1vvtsFDN6iTMdf6iJNBexpIfjcmlQbcfrhAQDyFyvg7i1bo+9HVpVW1y6uzxYscSq5eyhx356J67LZ+xQTvWhMaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457462; c=relaxed/simple;
	bh=T+dCC6mPrrDOxsePc+Ywm2CcOIrhdxqCNx8Dn1/Sgpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUBtbvRsPaBdSbCd7WeQ6w2sct9GEaW0DMrlnBzP+mXoy1RdPHACZDYiDLMmK3nG6hJqgXRnsGYNVBs7uFQ+W2yJh4Nrj7oKxPRicW/P9A7hgUrwuMbPwZlG8i1OG+P0BDZ9v8OaUqQcl3y3rKQ2ML2lVbJ2VNWDgEFgJ465zjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j++682xb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j++682xb"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518bad5f598so1348909e87.2
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 09:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713457459; x=1714062259; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+dCC6mPrrDOxsePc+Ywm2CcOIrhdxqCNx8Dn1/Sgpg=;
        b=j++682xbykKJlVQWmmdfzao52/syl3v9K9zqIBgepmFcUyB11aEeiMkhuAbHFdVNlO
         ez4iJ854nQw9vWfeqtmeHpMX4IO8L04U72/5WaAD4IJut+jmYOM/brpx53/EuxRQ1N/C
         BZ9Dzrv0SHRjQtuck7m0UHO8L6loBb8kbs3TwKbbBsByRhe98dOEXKI9MTKgXF9aq34D
         aFOoSIJy2SqQJY29fij8mUYyY6WM1z14VXZ9EciDLfTcsCygddglGIMILcpy8cNPeQVg
         ApIT+GX5TkTsksIR7G2OJZnXs9gr/a85wTfz2H7XmtRbXBdu4BANkhnTUxSpbLAWDmXB
         nxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457459; x=1714062259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+dCC6mPrrDOxsePc+Ywm2CcOIrhdxqCNx8Dn1/Sgpg=;
        b=hnCUOa4Ea2Lw/so2UEAoY238sL64HWRR3NcwACqaTQPgUJYupLIgptxtIGigvOjc1o
         Y3GXb+vd8JrHnowe5xlrBSyUEFvcsNgH6S/ML7V32CgYSmPJwGjjH8uozjR+Wdw+GvWL
         SexP+7yEJtylA7F443KZ81Mpst39RodCrmhB+7wJOy09kN38I13/bQ6jZ2VE9CVPVqHk
         qY1fFsW7H5PTaa59ceWnRgIAXfTuuDhT9ABXWcjFS7O8xDdUUEdcrpiDBOhmz5dn0S5C
         NRBKhbLnuhWv1/W38rTcknCsHHxSSVLSsIxOpOdw4r2oF7TTgXKUziM8qxG5EQYnphSq
         0asA==
X-Forwarded-Encrypted: i=1; AJvYcCWZdEBjPHE743K4JYg3vLoeoKgQKKMdrWQhi0VQlD2KTEr+KGry0z74vZiRUBWuFIKxf43/fy9F7BHonAkdMM9oTNALYRo=
X-Gm-Message-State: AOJu0YyJK/QJGHtC0V2X/figqqkxLHrV2pjXH3bvjUSTGuH4MrS5g8Ar
	0iL+3BvELZmr0XEeUg87rojYrKQma+Oe+ifhTjqjfvgcQdo3NNZQ2AIDDwFF7LTAtCkjgCnxG/U
	mLVy6Dl5uYew4Lonw+MjjPzYmkpc=
X-Google-Smtp-Source: AGHT+IECeTUNMOsaM6aXlpQzxaYVOTDkwSlJTUZQZfQwVQMaXBs3ulVIy6NOXQ1XJO3G9OMC8ZWm+Jeohz7lAnqY62E=
X-Received: by 2002:ac2:5501:0:b0:516:c8e5:964e with SMTP id
 j1-20020ac25501000000b00516c8e5964emr1954011lfk.21.1713457458599; Thu, 18 Apr
 2024 09:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com> <20240418084646.68713c42@kernel.org>
In-Reply-To: <20240418084646.68713c42@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 00:23:41 +0800
Message-ID: <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > I'm not sure why the patch series has been changed to 'Changes
> > Requested', until now I don't think I need to change something.
> >
> > Should I repost this series (keeping the v6 tag) and then wait for
> > more comments?
>
> If Eric doesn't like it - it's not getting merged.

I'm not a English native speaker. If I understand correctly, it seems
that Eric doesn't object to the patch series. Here is the quotation
[1]:
"If you feel the need to put them in a special group, this is fine by me."

This rst reason mechanism can cover all the possible reasons for both
TCP and MPTCP. We don't need to reinvent some definitions of reset
reasons which are totally the same as drop reasons. Also, we don't
need to reinvent something to cover MPTCP. If people are willing to
contribute more rst reasons, they can find a good place.

Reset is one big complicated 'issue' in production. I spent a lot of
time handling all kinds of reset reasons daily. I'm apparently not the
only one. I just want to make admins' lives easier, including me. This
special/separate reason group is important because we can extend it in
the future, which will not get confused.

I hope it can have a chance to get merged :) Thank you.

[1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8F=
rfRvaa-Vg@mail.gmail.com/

Thanks,
Jason
