Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043D1E515
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480069; cv=none; b=M5xDhhTDZjq5e95ThR32bBx0H1KfHwjDV0Ad6KpHDwzu123r2xZy3l8Q9wZeKmstT7+gkgAZ9uJNzhgFHlfwKIRVQFGeTPH7AMWaN2a1FYfg4ATdXBkaDNIhQYhsHLryKDztZM3q6cUfVHshnrKI2IiCewJCR2OQODPHnzqPMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480069; c=relaxed/simple;
	bh=65s86Znh/TMncZbIbTs41iRh4/aQFdfmUg1K2q3PPuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WM4lZHlCLZdPkQ+QUVMproA3HFFmw4vCNajEu9/MtA48S1bK7/7D3K1y3FxWccdfzN/lFFiDLuBSze6aOCTIkQgYsnuXTbNsCQIwfTt0wrPAzGKNdwOPd5EL5GsQ/BOjjY0QuHIseYssnaDKEUY66rZlW3iYJiG/nQM4TnAIOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC6jFimd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC6jFimd"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso141349266b.2
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713480066; x=1714084866; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=howsgI2I5TgSbulsoJY74muz5rwYbpEbVq7yZZ8cUrQ=;
        b=lC6jFimd4hZZOq3edzW9lu/H8Nj3KULsYtDkDOMVtSfKb+HCtQZTcJNjpeZ7SpYQXD
         +1RZpf7LikUnb4UmSFlniVCkbvw99DNT8Yqq1dy2dO5gZOSQcZlIRMtueWQLk3s/409C
         8FhRirlywb31yuBXMfx3ayYFPRUc7c/Jp4U68bL/yKe1w6L/DHOPJQE+Xb+XXYFcfl0C
         JroDjHUZ2/IECigI0DhgQnF1aY3HazqGO/7FdRzPQeGChw3vfOAURaKgh0jh2UvtunEU
         wlEZqRjj5l11lRRDi7p1UEmu94s8503zhH02xmo8s4cVoZSU4/PiLTm5e9NT9AoyZOE2
         o7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713480066; x=1714084866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=howsgI2I5TgSbulsoJY74muz5rwYbpEbVq7yZZ8cUrQ=;
        b=TbO1IPRihz6SEiWN0+ke6Xu1j5Z1BgQ7kNca7GBB7xnmWufJujICsyU9xvuCG6Dmxa
         74Qdz+bTYwvHU7VxzIZwVN7YbdDagajXrtPN7Dsd5ImPQbB5JgydvFf1bCGXcqOXY0Sc
         YkFpuAzGTViBMQNLZvM656cCXzIB1AhG/zvgvGqpVWNRzYXEic58RXcNpiOssC6b+YK6
         UwL4mOr6r0FSw21hFTSyXPs5Hsu/R4Nbw5VXZ7Oz2tMPx8ZCd69kcg5Xf3b4+azetroR
         laoaq1ZhwEqn32Oa1hzAOO9ti0yR2TCvPgXcojNcKvrNdOyuJzQm7yWpp95Z5CB+Gb6R
         FSIA==
X-Forwarded-Encrypted: i=1; AJvYcCUQau0JLWuRGpjyowGsCgFEDpr82V4grxjLWbxbvLOxKweeFPWjT0m9T3ORXxaxGrvfj1B0ckCrRlzYxeBhiBLTgKdXU3Q=
X-Gm-Message-State: AOJu0Yyv9OLNmxZ6/QZ6yiMa0An8FqcpYR6i1xjjR/T03EWWHYa7duo4
	JRwAURLIF50DIFrxCfHtj4rNMO+41zaVmej+T+8XSboYnlRTfNKHJfKbrsrCUFIUMZ/QY1FOzwZ
	O2L9UuQ/Ak+gnq3Xhkd4cH2mK2+LusKspDYw=
X-Google-Smtp-Source: AGHT+IEorWWwe9wcnoC67rKnLRUtqIhI+AMU8yxRVsVBFpVA+Ddweue41FpISTjMrE1QdfifAT5IrJdi8h4xVrgGOrk=
X-Received: by 2002:a17:906:1f52:b0:a51:95f1:4308 with SMTP id
 d18-20020a1709061f5200b00a5195f14308mr283870ejk.51.1713480065488; Thu, 18 Apr
 2024 15:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com> <CAL+tcoBVYWaMAYRdBC6UKiNuhdR7cK+570=0Kw1MKEhPhBL_AA@mail.gmail.com>
In-Reply-To: <CAL+tcoBVYWaMAYRdBC6UKiNuhdR7cK+570=0Kw1MKEhPhBL_AA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 06:40:28 +0800
Message-ID: <CAL+tcoCyuOsNyuuHZG_BBZ5YPNcXHu4v-3Zv4a7JMpLFWwCX5g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 2:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Apr 18, 2024 at 6:24=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > >
> > > > On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > > > > I'm not sure why the patch series has been changed to 'Changes
> > > > > Requested', until now I don't think I need to change something.
> > > > >
> > > > > Should I repost this series (keeping the v6 tag) and then wait fo=
r
> > > > > more comments?
> > > >
> > > > If Eric doesn't like it - it's not getting merged.
> > >
> > > I'm not a English native speaker. If I understand correctly, it seems
> > > that Eric doesn't object to the patch series. Here is the quotation
> > > [1]:
> > > "If you feel the need to put them in a special group, this is fine by=
 me."
> > >
> > > This rst reason mechanism can cover all the possible reasons for both
> > > TCP and MPTCP. We don't need to reinvent some definitions of reset
> > > reasons which are totally the same as drop reasons. Also, we don't
> > > need to reinvent something to cover MPTCP. If people are willing to
> > > contribute more rst reasons, they can find a good place.
> > >
> > > Reset is one big complicated 'issue' in production. I spent a lot of
> > > time handling all kinds of reset reasons daily. I'm apparently not th=
e
> > > only one. I just want to make admins' lives easier, including me. Thi=
s
> > > special/separate reason group is important because we can extend it i=
n
> > > the future, which will not get confused.
> > >
> > > I hope it can have a chance to get merged :) Thank you.
> > >
> > > [1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogy=
svgR8FrfRvaa-Vg@mail.gmail.com/
> > >
> > > Thanks,
> > > Jason
> >
> > My objection was these casts between enums. Especially if hiding with (=
u32)
>
> So I should explicitly cast it like this:
>     tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> ?
>
> >
> > I see no reason for adding these casts in TCP stack.
>
> Sorry, I don't know why the casts really make you so annoyed. But I
> still think it's not a bad way to handle all the cases for RST.
>
> Supposing not to add a enum sk_rst_reason{}, passing drop reasons only
> works well in TCP for passive rests. For active reset cases (in the
> tcp_send_active_reset()), it's meaningless/confusing to insist on
> reusing the drop reason because I have to add some reset reasons (that
> are only used in RST cases) in the enum skb_drop_reason{}, which is
> really weird, in my view. The same problem exists in how to handle
> MPTCP. So I prefer putting them in a separate group like now. What do
> you think about it, right now?

The description in the previous email may be too long. The key point
is that we're not supporting only for passive resets, right?

Thanks,
Jason
