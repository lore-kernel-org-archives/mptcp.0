Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A8178CE4
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479400; cv=none; b=Q42aO7F2f6/3/iBb5eqUxHr4Fi/aWZPDS8D55LItts+SPbwhSPMjF0roem8d/prF58S4ZIX1c9W8QJY0PjuT+j9DAbJUPj4bhxbeJ8hwuTVP6nCDZ8SrJqTBn/rJlXGTCNDGJg1OT351o9+kqU5GQM2ZRovirC2IDcxomJhsAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479400; c=relaxed/simple;
	bh=jny9PTEeGCQgR6BpCNvvucw65gCkhQ8IJ4lvib0jUHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zxg6hA+Z8jYse3j2WhhbIjU44eLD7JzHhAm/YrLurOK1wSdQ59T8KXfDw/SxiY/ZIfbXll1GIkPnCtoHAqOCm9PBFteIPmoaDFp9uhRfkkkXX/tKyIiJoRUfDpAQdnQepCRGzPkbcLFdUXMziKBWb++g044YhJzZ8drc/RVajz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXpOQrWZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXpOQrWZ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a556d22fa93so163753866b.3
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713479397; x=1714084197; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+4KvND2mQ965yY+mYlrwgLNNZfgfM81bsxNc9865q0=;
        b=mXpOQrWZzoNLnoLp8Tpa+4sGdgkEb2rC+Ot/SomUivfxPasJ66xdZzfd7nkUGkmhDu
         RvjtqCoIEwFPOx4BgB0Gk5KtJlPX67zmzyh2kqo1Iutu72IohP+R1FjFPNKlekG8TgQA
         zkIhlyYVgsexp78cccwVICQ4SF05mSh8fHVbhbeEmmjilLVez/sMujnIA+4Y4okrmzpA
         VgE9l7DbpQQ2EWmdwF1zevwQx96LXQkA+z5JXFLHBfH85B0CWC0FhsxSAMVUebR19u8Y
         z15u8ST5hYpD6HJ6cP50JNG37mlnxHQdJ0uDnGHvfYE6Igb3OdOGabMGtug2xXCAvwxm
         0Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713479397; x=1714084197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+4KvND2mQ965yY+mYlrwgLNNZfgfM81bsxNc9865q0=;
        b=J6xXs2W8H8u3Q8oSzjEyp3wb1ArNhH06vs+2Nc27o9kvPdu/Y2qpJsGEhK1YRLzud4
         7XG0tKEwCi9e8yfT2eJdqR2RnnMDlSFoQoSla86s5o4CRmYPi0SOWLZTO6Vzb0kLN89K
         tbxDf2pc7zEQRQ0SC/mCG9najwmHNujJA4tvD1mzc4aWTP+CN5ly19Z9PWAC7k0N+ZHJ
         Nu9xEw0fwbqvud/c8iFVMxdfr/QiIpNQMSx+oUhv7lyiuRCEBX8irgfemm72XIqq/upD
         WQKSpbitqmEuMARTdybpRpcHrFsHWQPf/A5lLdZnfQ3ZyYf7TpJiC+vsSrEpda0+K48x
         N6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWd+5q/7RTJX3wxqivE0JNNiB/djuIy8F73CX4bAx3hjIxKBdVlrmBWLtbDfr4aAUS+3UJoavtR161iInQKrg3mzJVjCIQ=
X-Gm-Message-State: AOJu0YxF/kgkj2bEPyawkdJmuNuw+gUmUIUVOyKoSkN2k7D4jvIXIhAF
	O812xcs79iQNMjWn2XxR6wEzRRIL1d7Q8shO1bmPviyQDh8XLYZyY7azLchoOkqjvBFe/l4k755
	Ujxh3ivqE4NCumnLp0KT8AEOV3Bk=
X-Google-Smtp-Source: AGHT+IE6V5mFUZPVGUU2SzTgBj9jbHCjqFZL9dLnzLdH+rsYdJvHGFBAYrSPLP1rELbC3l9mAh5Ete7xbMLWCE/4MbA=
X-Received: by 2002:a17:906:855:b0:a52:5a6c:a359 with SMTP id
 f21-20020a170906085500b00a525a6ca359mr221188ejd.63.1713479397058; Thu, 18 Apr
 2024 15:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
In-Reply-To: <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 19 Apr 2024 06:29:20 +0800
Message-ID: <CAL+tcoBVYWaMAYRdBC6UKiNuhdR7cK+570=0Kw1MKEhPhBL_AA@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 2:51=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 18, 2024 at 6:24=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > > > I'm not sure why the patch series has been changed to 'Changes
> > > > Requested', until now I don't think I need to change something.
> > > >
> > > > Should I repost this series (keeping the v6 tag) and then wait for
> > > > more comments?
> > >
> > > If Eric doesn't like it - it's not getting merged.
> >
> > I'm not a English native speaker. If I understand correctly, it seems
> > that Eric doesn't object to the patch series. Here is the quotation
> > [1]:
> > "If you feel the need to put them in a special group, this is fine by m=
e."
> >
> > This rst reason mechanism can cover all the possible reasons for both
> > TCP and MPTCP. We don't need to reinvent some definitions of reset
> > reasons which are totally the same as drop reasons. Also, we don't
> > need to reinvent something to cover MPTCP. If people are willing to
> > contribute more rst reasons, they can find a good place.
> >
> > Reset is one big complicated 'issue' in production. I spent a lot of
> > time handling all kinds of reset reasons daily. I'm apparently not the
> > only one. I just want to make admins' lives easier, including me. This
> > special/separate reason group is important because we can extend it in
> > the future, which will not get confused.
> >
> > I hope it can have a chance to get merged :) Thank you.
> >
> > [1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysv=
gR8FrfRvaa-Vg@mail.gmail.com/
> >
> > Thanks,
> > Jason
>
> My objection was these casts between enums. Especially if hiding with (u3=
2)

So I should explicitly cast it like this:
    tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
?

>
> I see no reason for adding these casts in TCP stack.

Sorry, I don't know why the casts really make you so annoyed. But I
still think it's not a bad way to handle all the cases for RST.

Supposing not to add a enum sk_rst_reason{}, passing drop reasons only
works well in TCP for passive rests. For active reset cases (in the
tcp_send_active_reset()), it's meaningless/confusing to insist on
reusing the drop reason because I have to add some reset reasons (that
are only used in RST cases) in the enum skb_drop_reason{}, which is
really weird, in my view. The same problem exists in how to handle
MPTCP. So I prefer putting them in a separate group like now. What do
you think about it, right now?

Thanks,
Jason
