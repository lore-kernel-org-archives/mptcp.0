Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39800136E16
	for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873825; cv=none; b=bUYT1t4OpELIovf5Lpt8fvi9HsNx53zYMtgzwFo23Nh3n5140cExNau/zT1LiHqda5LUcP/TxqZSnD0T94O78A1CY+XOeMMIP/N+dPzvjwuHVGu/qcpnbHyQqNzwCRB4EzjoAjAktPrf4xVlLzfwLKkGoKPjRmaUQbdz+aAhDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873825; c=relaxed/simple;
	bh=lVQZ5Rcf8gZ4XnRnWLlUduBtlydqs8gWc4eGtC4r3WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV1trZA3V2mMGxnwxCQOR03r1Y6yvWg8GcdhXtKenEdjeAACOJ7TB6UZwqC5D2QPkuhLVzQOVg7zv5XPtYkNhJmqtJfEz+tnGp1UR1qub2tGf7yySa+mZoIrNrMW1IBCPPbIC54bPj6iLddcAt/dkcL+pg6kiDwjFA+jkHKe9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnAa9YMc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnAa9YMc"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51bafbe7509so672598e87.1
        for <mptcp@lists.linux.dev>; Tue, 23 Apr 2024 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713873822; x=1714478622; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/w20ZiELlVwKA6zWZGpUJTiub65abyXy03YW90UiWI=;
        b=VnAa9YMc5N1uq56Or8chtDkBpVxSMmBEPfRSdfWG04zetDFVgoAeKWfp8+RRH5E9dC
         6UJDz4gUYQs0sE192kFo7M+CgXmPUiaoIES5nbU1WK8YtFM/G2ilvj/qpRieWu7vaYg7
         Kz8yg7zirEPH4Tc5aTbWoAXOfxd7gLMWPFpdJvIlGe1w5Y95yLmz/13WThnqoDgx+4kC
         yjW2m7VBhr0GsKo0pvnMuKGPmdLgkc1XDEqqPQm8k+pJsTU8ufU8n1ymF2kuo4bdzqZm
         J0JjnRxG+0lAEARRfxpIDVfyaTNx81j7RpNBhD7vCr81Dd9ASnv3A5R4uJnKOfIFyu5t
         OJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873822; x=1714478622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/w20ZiELlVwKA6zWZGpUJTiub65abyXy03YW90UiWI=;
        b=EMbaUcyHmfqXTEryH51bvlkEcHV6B0lYaml8eCjJjuDHCJGPqtoRW/+tqmfPfwbrvz
         gSkt/4fuunROS8qxmOMO0Z3T9P1ek/nRODcDNkwJn3cwx/h9CwpsY5o9uOT8L9X2gq7X
         GCjNfgZy6XTvrCVbJVWxPmzktaiKwitRK9kiGSJOhyQ6KUvi+iPty9cJTEkdukJ6DrWq
         rL5TPEYID01f7ZYEEK69wqbN5Kny8lY7JQ8Ymk8U1IXYARmSc9thMbxXYwc+ajy9xSc7
         UNQU4dGkrdlxzLmRgVUB15ynE6ybKk0PE+2HJ3kU5RTZ4AUx0UngyBZikTicahB952o6
         Sifw==
X-Forwarded-Encrypted: i=1; AJvYcCV1iFwNd05ECMm6McjrsnoffNjvztvECQGlKnsR6N3T8H7fKXXoBR2/LRXsylEbdDIVuKtFhE05Gogdkh/KyiJi5T458GE=
X-Gm-Message-State: AOJu0YzDETJPr955OM/5bKDvLpQUEk6go2viY61IsVisv/RgWgIbFIHy
	YMBIPaTe3E/xlfGRXuAds5B7HFUEazILM2C3LTu8miSpBG8JoVVOzRqLnR8XKzEPtYAlh9DKmYm
	6oTJql3fW3QmoNyeYXBV5b0qGEys=
X-Google-Smtp-Source: AGHT+IEZrTkUH+yVEO1ei3tcIdp8WjujcTNUGA8uqf4omiHLerj30JF8ox6xLYlHGf0dYgq7TisU5lV6hfxep/8zQ3s=
X-Received: by 2002:a05:6512:3daa:b0:51a:d74b:f122 with SMTP id
 k42-20020a0565123daa00b0051ad74bf122mr11860840lfv.59.1713873822043; Tue, 23
 Apr 2024 05:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <20240422182755.GD42092@kernel.org>
 <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
 <CAL+tcoDoZ5CYn-fdK5AWaMe36O10ihe2Rd89dDmjBxiBDQ37sA@mail.gmail.com> <20240423115725.GR42092@kernel.org>
In-Reply-To: <20240423115725.GR42092@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 20:03:05 +0800
Message-ID: <CAL+tcoBA28pH0tvCadO6rqMUUnpKtAnGnqmfnYQhdLOB=978Jg@mail.gmail.com>
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

On Tue, Apr 23, 2024 at 7:57=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Apr 23, 2024 at 10:17:31AM +0800, Jason Xing wrote:
> > On Tue, Apr 23, 2024 at 10:14=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Apr 23, 2024 at 2:28=E2=80=AFAM Simon Horman <horms@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
> > > >
> > > > ...
> > > >
> > > > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > > >
> > > > ...
> > > >
> > > > > +/**
> > > > > + * There are three parts in order:
> > > > > + * 1) reset reason in MPTCP: only for MPTCP use
> > > > > + * 2) skb drop reason: relying on drop reasons for such as passi=
ve reset
> > > > > + * 3) independent reset reason: such as active reset reasons
> > > > > + */
> > > >
> > > > Hi Jason,
> > > >
> > > > A minor nit from my side.
> > > >
> > > > '/**' denotes the beginning of a Kernel doc,
> > > > but other than that, this comment is not a Kernel doc.
> > > >
> > > > FWIIW, I would suggest providing a proper Kernel doc for enum sk_rs=
t_reason.
> > > > But another option would be to simply make this a normal comment,
> > > > starting with "/* There are"
> > >
> > > Thanks Simon. I'm trying to use the kdoc way to make it right :)
> > >
> > > How about this one:
> > > /**
> > >  * enum sk_rst_reason - the reasons of socket reset
> > >  *
> > >  * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.
> >
> > s/skb drop/sk reset/
> >
> > Sorry, I cannot withdraw my previous email in time.
> >
> > >  *
> > >  * There are three parts in order:
> > >  * 1) skb drop reasons: relying on drop reasons for such as passive
> > > reset
> > >  * 2) independent reset reasons: such as active reset reasons
> > >  * 3) reset reasons in MPTCP: only for MPTCP use
> > >  */
> > > ?
> > >
> > > I chose to mimic what enum skb_drop_reason does in the
> > > include/net/dropreason-core.h file.
> > >
> > > > +enum sk_rst_reason {
> > > > +       /**
> > > > +        * Copy from include/uapi/linux/mptcp.h.
> > > > +        * These reset fields will not be changed since they adhere=
 to
> > > > +        * RFC 8684. So do not touch them. I'm going to list each d=
efinition
> > > > +        * of them respectively.
> > > > +        */
> > >
> > > Thanks to you, I found another similar point where I smell something
> > > wrong as in the above code. I'm going to replace '/**' with '/*' sinc=
e
> > > it's only a comment, not a kdoc.
>
> Likewise, thanks Jason.
>
> I haven't had time to look at v8 properly,
> but I see that kernel-doc is happy with the changed
> you have made there as discussed above.
>

Thank you, Simon. I learned something new about the coding style.

Besides, some other nit problems have been spotted by Matt. I will fix
them if it's required to send a new version.
