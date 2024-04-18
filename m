Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B374179956
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466291; cv=none; b=aYA7D1E5Y4KOxFKubYEr5SEP2Y6yOEZZP8yr7JhjzHeqRZzBwwPnP3ocZwy1pFMfpkmgnigYY/EqkWmonOH96erkEih1IeUgxEU89cQrCXQzcGABkumzWglY91WBmInkIOraZH5hC31/n0S2RI7xVs9DypdDUyJs1Vmazx/ro/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466291; c=relaxed/simple;
	bh=jvW7hMCjwo7CN/K5mcq8Qwa/N6UV2QWPgKjq0AlxuMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj7E7SjZKv+BRZ3gfhhMMqPl2X6DhnS1o5zzJMmyEMSchy6SXGikz3qYHXR5rL2siKYUv2GBD6kmbB2fy94AxVCJrVcnKBfLQAeWmquZXmVX+NdovdRCRT03ariGNHe/30FZTG07AOyUfuJMbl+b+f+mrmA1xDCdmQZynbbxNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn+oeS9Q; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn+oeS9Q"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so2421a12.0
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713466288; x=1714071088; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvW7hMCjwo7CN/K5mcq8Qwa/N6UV2QWPgKjq0AlxuMk=;
        b=Wn+oeS9Ql1OwbuTBWTrwkR7RUFLA7Da7esYBInKiZD8wLl/MMWUvGIr+V3vc/mk0yH
         H0ZodsYp5dJS3VuS+Efxe2Pb5Bxi0qO9wlbPNOppE3EcdhfEdgmmTxvBISLznqH/LqEL
         7K9sR7qsUzBbps3imykR4XqRKRndFZoVi5zJYS/X/Khr10QlhkLIdbEyJrf49iwf36sE
         89m+l1yaujF+KBVt7/OCHbGpwcjy2YtT1pR9mvuqExNI4/C4Rbci6RSX1A1746lOObFc
         dNjrVmwATdHrYubM0DtP1CUJOAbBfjCgMgKCaPdhsLOnL9DlfK/0E/Dt+9OkYBSBN621
         axXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466288; x=1714071088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvW7hMCjwo7CN/K5mcq8Qwa/N6UV2QWPgKjq0AlxuMk=;
        b=BLm35bX+4pWaaxUCk3cA8nnJTT53aZPVmceeZlOOMFtrWL/KZUm2qQkV1KjIcFA2oL
         I+vFUEU6qL8ed1lwQP3f/cFk5QC6ctCx91Zkl7TsCV640H4/ycre5kPvt2p506vahE5z
         472qAdRpHEXegT3ML+h6X7Uu4NiDGS+/KxsZVIuMYjJ9RPsZElUZS8KqdQ/LGR+I+LLs
         V4uMswWloBsw+MblOJWepAxKm0qnjxXCQ6vZ35hCb2pWuLkR9fpkZfvYX1tgSBUF6XSp
         hpIg3y5Qd2JeUn+w3SxLNcSGBUrKuR+NqiRPRAACsoXIanrnq7aImIj4r7O2MjUAWe3D
         VLyA==
X-Forwarded-Encrypted: i=1; AJvYcCWAsFIIPHIJVc+JKa9slRq6VO5Wcw+NK7cikHmhwLV9Qz8M4p21brkB134khbd5E2IHUUSRP/kSQDOEKyyGMX/JlX12iS8=
X-Gm-Message-State: AOJu0YzOwPB8d5xKQvfSJkRmdVVDaFmk6MDVoMcAGrqN03Drmz44A8wc
	Fd1YRnR6/mLHeCNELqNdLouJRbek/7lII0Pxgj3le9SfFWwURatMl+fEyl/QLpyN23R1+wIJ6KD
	Igm1UNfUFwX0fZqXCUftlXHwa7rCe7Fad4dxj
X-Google-Smtp-Source: AGHT+IG0nwF2sPAth0hGe1xE3k7qAAwtmvw2rthCZWtTHFJ8+eKzu9jlzZvyi0B1H3T1RgbsUYyxF016Rx65y43XYBM=
X-Received: by 2002:aa7:d04f:0:b0:571:b8c4:bcc with SMTP id
 n15-20020aa7d04f000000b00571b8c40bccmr16051edo.6.1713466288126; Thu, 18 Apr
 2024 11:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
In-Reply-To: <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 20:51:14 +0200
Message-ID: <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:24=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Apr 18, 2024 at 11:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Thu, 18 Apr 2024 11:30:02 +0800 Jason Xing wrote:
> > > I'm not sure why the patch series has been changed to 'Changes
> > > Requested', until now I don't think I need to change something.
> > >
> > > Should I repost this series (keeping the v6 tag) and then wait for
> > > more comments?
> >
> > If Eric doesn't like it - it's not getting merged.
>
> I'm not a English native speaker. If I understand correctly, it seems
> that Eric doesn't object to the patch series. Here is the quotation
> [1]:
> "If you feel the need to put them in a special group, this is fine by me.=
"
>
> This rst reason mechanism can cover all the possible reasons for both
> TCP and MPTCP. We don't need to reinvent some definitions of reset
> reasons which are totally the same as drop reasons. Also, we don't
> need to reinvent something to cover MPTCP. If people are willing to
> contribute more rst reasons, they can find a good place.
>
> Reset is one big complicated 'issue' in production. I spent a lot of
> time handling all kinds of reset reasons daily. I'm apparently not the
> only one. I just want to make admins' lives easier, including me. This
> special/separate reason group is important because we can extend it in
> the future, which will not get confused.
>
> I hope it can have a chance to get merged :) Thank you.
>
> [1]: https://lore.kernel.org/all/CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR=
8FrfRvaa-Vg@mail.gmail.com/
>
> Thanks,
> Jason

My objection was these casts between enums. Especially if hiding with (u32)

I see no reason for adding these casts in TCP stack.

When I said "If you feel the need to put them in a special group, this
is fine by me.",
this was really about partitioning the existing enum into groups, if
you prefer having a group of 'RES reasons'
