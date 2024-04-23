Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAFC17BA0
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838691; cv=none; b=dLtftHBBME+6tw9/HXXRIYFkgtpIEQu9PnMnmIFI9zf0HwlOyyyvYWaZnkYm/8u2i6Dbl5r7ghhhDS4xPAaMKqsB+acqxqtLTvWkt3tpO5TkiPBk9THqjFEND28hDxCD/1DfZg87CvNCJNoFtPxtXXEnehtHQE9UF+nWDf2F0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838691; c=relaxed/simple;
	bh=IopP1bFkYoWAQOq+qAQGXZ+TGVLKYGRlyaC/38OvAac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PE2bDT4zPmRv3l27dq9AKxmU0JymhG+JLjGezRl61kjVIxLteM7xSAZTjgPqZDQajINb6+7QLYXlSWm4Q+OnWO7vTu+/VclOi+g4CbRQ8dIs4XB/dBn3KcvVYlSwCTNE5XUN1Lb2Sy9B1y0hAdZ5zPQ5elL9RPdw2gPXJ+PVaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au0E1WFC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au0E1WFC"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso5464218e87.3
        for <mptcp@lists.linux.dev>; Mon, 22 Apr 2024 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838688; x=1714443488; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNx3rKWvVj9v4h/EIoU/yDC78hRfQ0z6qddPdkKKM5o=;
        b=au0E1WFC9EFJ6BAbq1pkmws1GvhWlry4A5F+aeRO9X9DWG7qTtz2Xdj1d/AhAIj7io
         DdTL+0sQwqOi8mQf3KoYqH/JrK00MkJBe8n2i7xFYmWivq8I99QjAAocOum8FObxkITL
         yGI4h4tdyMwlCvjpoVu/c5nXYZbtW0zFFScDB2BPxELHuY2zOhYscn3tIC1YEEI6rlye
         JsfIex0sa2bZIR7DRQUD4O+T9sd6BDg7xyWb0ZKUnFxMrZX3yTLXqVsFO1IoJt1vpsA4
         kUGdUYKBy7k97p3XICddsC8KGhsAv6HMHQSbTD/rnkfVuO7pBfyxFbC/Qm7iXeSIkLuH
         d9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838688; x=1714443488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNx3rKWvVj9v4h/EIoU/yDC78hRfQ0z6qddPdkKKM5o=;
        b=lcK7US2viZ9bQaUHc9DOdicn/z6JeTsgyQ2xS5NSjlLgczQccrMp5I9i2ru8BBTm8a
         lx3O2L6VGVUH5iFpkdYS2/rsMEQoOw9+V+IpZHHzhKHhB/1uVwWasA9h5BlLbu6mopJe
         +60WYl5dzUarQNnR4xkzurtbIk2BX3S2EmM1dfMUaJUZ/Q1NsEfv3hmC5rI5ObAPpBoR
         tZX/CIwN280iynz2+9v/UaIF3UOh5PC9CB9y2ARPdhV6zNgnNwgmUrNjFhaBZJ1PoCRa
         saJCNbdWmEgnNScgfBSGOlE1pf8aB6xJmwq4lo7CL+1VarhNAGUvWnpJMAnUr4lkjoHy
         A7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsaKMY+q+av0+5QhQYwqoMroGmj+74sS1W8+dznYImIrK48Yib5QqpYrqtMPm/7PZj4SlSCbNJkve2hTR5yOUGepVJ8Uo=
X-Gm-Message-State: AOJu0Yx6ldeFW7EsHNOiYgSeCeOgS+FKJmrF10T6Uof7FtYc3SvBSiaV
	gUtfiB6l10VAyTt+noLuUveGV+XGku2WAPgeQ2ccRHGuSoJI15bymQbOHXaqrkC7MIZjX4XGcgj
	Yk22Oz9oPlahbfRaQ2xlodXVmZ7g=
X-Google-Smtp-Source: AGHT+IEjFVfDZ1b7bRrb9RNiaXGSUz1z4d0R1LaPaGHytvUP/U/AtHU07YcBD9GKqtXQAIQBGHYMbRVr20cCPAIoj30=
X-Received: by 2002:a19:a413:0:b0:513:d3cb:249f with SMTP id
 q19-20020a19a413000000b00513d3cb249fmr6700874lfc.52.1713838687950; Mon, 22
 Apr 2024 19:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <20240422182755.GD42092@kernel.org>
 <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
In-Reply-To: <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 10:17:31 +0800
Message-ID: <CAL+tcoDoZ5CYn-fdK5AWaMe36O10ihe2Rd89dDmjBxiBDQ37sA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hi Simon,
>
> On Tue, Apr 23, 2024 at 2:28=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
> >
> > ...
> >
> > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> >
> > ...
> >
> > > +/**
> > > + * There are three parts in order:
> > > + * 1) reset reason in MPTCP: only for MPTCP use
> > > + * 2) skb drop reason: relying on drop reasons for such as passive r=
eset
> > > + * 3) independent reset reason: such as active reset reasons
> > > + */
> >
> > Hi Jason,
> >
> > A minor nit from my side.
> >
> > '/**' denotes the beginning of a Kernel doc,
> > but other than that, this comment is not a Kernel doc.
> >
> > FWIIW, I would suggest providing a proper Kernel doc for enum sk_rst_re=
ason.
> > But another option would be to simply make this a normal comment,
> > starting with "/* There are"
>
> Thanks Simon. I'm trying to use the kdoc way to make it right :)
>
> How about this one:
> /**
>  * enum sk_rst_reason - the reasons of socket reset
>  *
>  * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.

s/skb drop/sk reset/

Sorry, I cannot withdraw my previous email in time.

>  *
>  * There are three parts in order:
>  * 1) skb drop reasons: relying on drop reasons for such as passive
> reset
>  * 2) independent reset reasons: such as active reset reasons
>  * 3) reset reasons in MPTCP: only for MPTCP use
>  */
> ?
>
> I chose to mimic what enum skb_drop_reason does in the
> include/net/dropreason-core.h file.
>
> > +enum sk_rst_reason {
> > +       /**
> > +        * Copy from include/uapi/linux/mptcp.h.
> > +        * These reset fields will not be changed since they adhere to
> > +        * RFC 8684. So do not touch them. I'm going to list each defin=
ition
> > +        * of them respectively.
> > +        */
>
> Thanks to you, I found another similar point where I smell something
> wrong as in the above code. I'm going to replace '/**' with '/*' since
> it's only a comment, not a kdoc.
>
> Thanks,
> Jason
