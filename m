Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5A3032A
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345765; cv=none; b=qOX0+foKtwb3153e2GUq7irB2KkC4lnmsCE03Fdhw/kjt4e8K9SwqmXenpwpgFqeyVRFqpKxyGmK+OBRdJ9lSGNkp7c6JNZSeeoYdqvV0FGPN1jfeSc7M0FrB3cQyxENPXgokmf54CM0PRRoZlopTUn4Ark1uoylx3hdMxA6o2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345765; c=relaxed/simple;
	bh=c4au2icJSPKncXqRvVreWlcffcYZI2pV7PV/A3myfjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoOL3A8CfW8epNZ260t8CW+XTXH5rNNzkPGxHXm7wNQNrhUawkqvmTAr0pPARtQ+K16wd8qVBtln5U3B+ipfr6DU5pJKWHNLodq/fh0sclqf1N0y4DAQhePb7TCRMwfDVbnf1ODKeOaw/lB1kLpCyClbyOStgZak+4YiCKyWtc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdAye1qJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdAye1qJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso4653250a12.1
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713345762; x=1713950562; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW9PmjLbwn7pJabXhHqlARTl4IzAtlALQknNYaa1aEo=;
        b=SdAye1qJqi7w39CPBmUeUCaRBIw4d3kY74aJIBqBSs+WsSw8FvB8QlXR8FGX8q16iJ
         7sIdoz8epC0eqmwijacU2q79xdqdtZkfQm3cuPjklAK98uGXzD2+pb3DjNRJlJFo2Vop
         fgAxandOJypCb7RNpXH+pj7YkUnPyIYi+MapCUZvaisUkPCjNAWzsEU3XayoD6Tymqet
         KPBz6RBDZ38noSU69H+xl7eJKfK45pD9LtdckMkbT0sWcjrtFMXNaiv32IUT1j+HQr2M
         0KLNCdZFO2OKw3lxsUCwvXclgU9UONNkNO/zjKDb1cH+PntIgNHkBs/PqZhthUwUxtyI
         jJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713345762; x=1713950562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW9PmjLbwn7pJabXhHqlARTl4IzAtlALQknNYaa1aEo=;
        b=DTcVrXfb5+oHzi7UKOEzT5vHPLtyOxjRsajne9u8JLZGCJRcVpfJ24sQ0LRqvtUA+9
         0PQBbLVQYKTZLhbUXu0cOtUsWv+J3vQbEazRIaqx2oa8asR7gyyyyJCEfdIrSjyilLyQ
         ymRGV8LRDWhJ/P9iao2E1LMeC13a5dbVwliuij/zd9uEJo+0Db4nctI5bzIaM/S/kLJZ
         hEwuT5JuOX6lpq8GAlOEP5zCWapdoHYi/8DgZ4fkR7emQJV11dHZpNFm4eRKvEhY/iv0
         VshYq34Qw7eGsDGmFFh+DliGzBIk5Z8ofd35vyHFDIugoQjF6lqONXdYi53DuyH8+zLr
         U0uA==
X-Forwarded-Encrypted: i=1; AJvYcCWLtkzCKmxH5MPnH1izpgAXoQwCe+gWvL0VwDmIyeLYG5xQlFpfIiLWsLNQcfOnQjetjYdiNI+9BTwCGxSIwo77LtqE1lk=
X-Gm-Message-State: AOJu0Yw3HLx+4gIosA8mrHBSxwpSHYF51Sc/tJj8UiKT8HxzQcqJjA8j
	DzcXIMkn9N3YMzcMe7lD0fjzu7v/cLqnR31SFRWEx4TBdVNkdadYtCKOWXO+6KLnRavIfAne9kW
	MT/1kRcGWnRn5ByE41wUVeE56TAs=
X-Google-Smtp-Source: AGHT+IHL2T/dUxZvTLwRpF9eorxg0NEt2cytKUT4skY49BBflJcjLDdYgmw3ytzpCLdQ5PdeePx2tsTKBimLdU+a+kQ=
X-Received: by 2002:a17:906:3fd6:b0:a55:54eb:c3dc with SMTP id
 k22-20020a1709063fd600b00a5554ebc3dcmr801485ejj.77.1713345761680; Wed, 17 Apr
 2024 02:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <20240417085143.69578-2-kerneljasonxing@gmail.com> <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
In-Reply-To: <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 17:22:04 +0800
Message-ID: <CAL+tcoC8VPOhvPbdbJUrRrAiLaOF2jwsoBkFBEkivPgMzijG5g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Wed, Apr 17, 2024 at 5:02=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Apr 17, 2024 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add a new standalone file for the easy future extension to support
> > both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
> >
> > This patch only does the preparations for reset reason mechanism,
> > nothing else changes.
> >
> > The reset reasons are divided into three parts:
> > 1) reuse drop reasons for passive reset in TCP
> > 2) reuse MP_TCPRST option for MPTCP
> > 3) our own reasons
> >
> > I will implement the basic codes of active/passive reset reason in
> > those three protocols, which is not complete for this moment. But
> > it provides a new chance to let other people add more reasons into
> > it:)
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> My original suggestion was to use normal values in  'enum
> skb_drop_reason', even if there was not necessarily a 'drop'
> in the common sense.
>
> https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr=
+X4k=3Dw@mail.gmail.com/
>
> This would avoid these ugly casts later, even casting an enum to other
> ones is not very logical.

Thanks for your comment.

It's a little bit tricky. That's the reason I documented and commented
on this in the rstreason.h file. I hope it's not that hard to
understand.

> Going through an u32 pivot is quite a hack.
>
> If you feel the need to put them in a special group, this is fine by me.

Yes, rst reasons only partially rely on the drop reason mechanism to
support passive rst for TCP well, but not supporting other cases. My
final goal is to cover all the cases for the future, so I wish I can
put it into a separate group, then people like me who find it useful
can introduce more reasons into it.

Thanks,
Jason
