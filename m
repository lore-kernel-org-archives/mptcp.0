Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F86F066
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255624; cv=none; b=N3v2/4nILVDNvK2Wx9a2TzQiAoddYboNnHmKWLfLCeHjVDr2q7QPoNo9cShPcorjnKHHiP5InqUaZWGzYVIwaFQZcwdudjeeiU41I8RjUakLOxgl//eByIJIwYjjq6jpK0iw21bTZW61gFLDb6OtqrPjMHAb25zR5zBR9DkfmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255624; c=relaxed/simple;
	bh=mn0axZeWa3rV3fphwoeUmwyANcoprQ4GAQmafSk8R/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTfuVsDlSVqtJtBWDVAb1y4IcSO0qCsKeYgNMBj/n8Rno68cmUqfuy/+Qn2ablP5xMuwTZAdcGSWzwCQLWHR5yS/R4b7VagQyQRPSbgyNXsswO+ODN+4DWuMsKXyZksSKT4ZIkUAd/AIw1+YGxmqHAkY78dPRolL6Xv57ADNuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBQ9yxDX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBQ9yxDX"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-570423c4f80so537603a12.0
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713255622; x=1713860422; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufa+XzCLAc4Sqi13iK5xvLeI5rKMZ8RSSCPvL04id4U=;
        b=FBQ9yxDXrdXNim3Ws9tkc9owla/+KL/jV1P94D4EvOkF0R+mMI0ilQWW65nWk79673
         WWhs8n0wXp1iEhR7kayQwm3T9tkftnF1asu8PvoQKS9Udm1LohtBey3WTFUiiYoKjo60
         vipcKwg43pfc8CFIT+hcc3w9P+xWimoqHaSC8PrTG1fvu/fEnGyauvakZ8dJmvEqCjOW
         PMjuhaBHzXwSazsZjT1Mm8gkhmXY0pf/+hlumKisYaPx56E+OINSLJDp5zsagjmO245R
         e2xnUPb8/gwaFE4L05QdTmIH3uR0QSRJKBwFMoTbh8T8zyd9UtEEYt9Fqg7lOCjVQPic
         xs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255622; x=1713860422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufa+XzCLAc4Sqi13iK5xvLeI5rKMZ8RSSCPvL04id4U=;
        b=pTHf96Vn91GBJXZ6H9bgp1bpGU9/ugU235oP67mhRZFjgW+hX17qT/aAOS9XA7i2HC
         M0jZtqILbf+H83vC43GBXjIrzMw3dEnZKeb/HgUL77dhf8uf/Z7Figy7yT/t/mp7diVz
         Q9lBgpN2og64jvx+y/EgwusOP9B8TK0gzrzIyzPPNYHVI+Q2bHD/cQiWG4gfx4BdK/ST
         OF/vAa+ehGUmoRd5LJc+oB0HLxp/7E9VS4iDqHd+yZ9r4E2OX8ZXJJzDda66WUULU0h6
         RCCKqm6wbprT0KtYEiSXKrM4ETfyG1N3w3+dkZFKPw3fLIt1Ek+2P+yEXTKTcMs+gv0D
         xeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTFdd1XOe8T9oJBpNaexlX9YqIR8CaJn8m8jN7dza+w7ZdOT806HnLvbVov0V97AIANkrvosw9QY0OoGy2NOugdaREN18=
X-Gm-Message-State: AOJu0Yxmvjbn+9Z0Wj/hZwoI/2N0yBqHgEVWUnsfTT9QDPg3W9OBkuPj
	8zTreVttBjCObhGEN6H07RVuhfdXw0cJ1jZVH3Jhd7EpVB1szdT4Qczmn5HVP3dGciXxUTsmglQ
	yMxOjOgiGDbfZ4P+zshvHEw0PMFs=
X-Google-Smtp-Source: AGHT+IERiaeKxO4AatIchFxfQmny1mV0EcdvPqGEQnbjwfzwANJjLFlnnhrRekJl3uQ8iUU4Y171SfPElk3BxeJGURU=
X-Received: by 2002:a17:906:7f8a:b0:a55:3488:f730 with SMTP id
 f10-20020a1709067f8a00b00a553488f730mr2066240ejr.31.1713255621579; Tue, 16
 Apr 2024 01:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-6-kerneljasonxing@gmail.com> <3b53762fbdfb7df1b3e79ea5138fabb714449d28.camel@redhat.com>
In-Reply-To: <3b53762fbdfb7df1b3e79ea5138fabb714449d28.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 16:19:44 +0800
Message-ID: <CAL+tcoDgYh3JVHOv9FGKA_dTjoDBD0CK+E4284RQNy6dUFbm2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-04-11 at 19:56 +0800, Jason Xing wrote:
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index ba0a252c113f..25eaad94cb79 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >               return dst;
> >
> >       dst_release(dst);
> > -     if (!req->syncookie)
> > -             tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NO=
T_SPECIFIED);
> > +     if (!req->syncookie) {
> > +             struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +             enum sk_rst_reason reason =3D convert_mptcp_reason(mpext-=
>reset_reason);
>
> Since you already have to repost, very minor nit: even the above
> strictly speaking does not respect the reverse xmass tree.
>
>                 enum sk_rst_reason reason;
>
>                 reason =3D convert_mptcp_reason(mpext->reset_reason);
> > +             tcp_request_sock_ops.send_reset(sk, skb, reason);

Thanks, I will update this too.

>
> Cheers,
>
> Paolo
>
