Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1F84FDE
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256087; cv=none; b=girFEnXTqKtiJgm/ZKJ/sCgKbV/oG81BX8M8NqLUlF+PcRhRqMsvpIVdc3ASl5LnYY/GrYTF575sswJR/CT/cNY/L6xWlpFevQXleZkHgYB5lrcAcs+/C66gFrgajcCs+rOpGie+NtIqBwuyKsx5GB59GIGG/hy4LzUqx6GowmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256087; c=relaxed/simple;
	bh=LSQgaKo3zSo2OKX2H5NSXCKesru2UxcFGx0yEKxgHNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRdxNim6grn4yATlckQ3Uh6oY43ufcdva9jXdNJQNiwnJE5I/marI1lHkGPmtG9zALo90m9tu94aPFc4s+FX6g72ZlHVWOonRXwFRSMU1TCt0xy7CZGfnx4Ep+UdUwHTdrQvIDbYZSNqEucJYNzZKigiWEeeak3/7/DOOPzF4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVmoilkQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVmoilkQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a80b190bso268618866b.3
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713256084; x=1713860884; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+ru9+o5to7lMi3IghDKB2ArnFLsjZ/4sMwOmVBAEs8=;
        b=BVmoilkQnN8szNdMvcfqE+oN1xlH/2obX292sD8DFiNgRj3CCXPFcEMu1WE/05NO9r
         XSa7czkahHrL1/h7bgJQFM0ol0B7hamcrwJbyo7AXV1k1oS6t8pXdOSIAzmAiWbzdsxN
         4q5k6CF3az7DdAy4cMOPhdzmd4HUB19l9PPSwbwHFOQa5rdv5ddv4cwiyQcWMTPIQKsn
         Ay5q2ayeZ9xkXh7FdsWbPvjB75ycecfKMXdwnyzEAYcBMZGpqthxe4URxEI7fD7hkPnZ
         2Px+RT0Kvn8fcDxG44DKOHN4Qo7Vi/mxPLwACCCxVEviT46PN3sjPWSjFYSwlAfh0/wk
         27ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713256084; x=1713860884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+ru9+o5to7lMi3IghDKB2ArnFLsjZ/4sMwOmVBAEs8=;
        b=bBAHB5LQRMB79dNnOL86E4wH2Z4ckJZSAOu7vyEQg16DedQBrrkhAAv3l8M8Boqwk0
         qVAEI7YzeIWTWniK81oPHRUuCNuBMkQMnZfvl/DzBUuCm+4x5YCFGSSaaXz16DIodTZl
         LKbkX96Z33r9UG+ozwmownq87DJ83rf2Qz/inzwkeuH3MBkhYP68bdwMqd7UR6o6PWIJ
         id7Y55f9D0lCqA8MPSZbksuQt/byQO8YD9wHJKQhNooXYUONkCnMKdQB6x/0Y/FoXz0N
         7Giy37J2fWigWRVq+9W3i6qc/z+2vt4McpkI/CMjMYjtxQ/9IwGKS6jez1pLkVEzqb5f
         Q9vg==
X-Forwarded-Encrypted: i=1; AJvYcCXqj/Kx6thd94U4bnT+zs792qH9rk/f/uMcIRmoXESvAk3g1NfgYmJ6nvAIlTSOId3mR2YjBuBRXE9qhCjqxUGSITkMrNQ=
X-Gm-Message-State: AOJu0Ywxq4fIT6V2JQCdMFFD2wHrD7timBchAAOAJoBK570erJPKgni9
	VqmoPpetQGdXRueg3DwFXGRY6Xc7kdhLKNu5wMge6iIaKu+hHybmtgzJXIyzBvPzslduw1kpnxl
	QlutQJrM+j2ii+yiCxs+vbSPf6iiPbOVy
X-Google-Smtp-Source: AGHT+IE9qKbZfvuCwUNj6/uaLhFRNzBVWXxKt2l3pIoyrkMsYkFfVgRm2zv+DBpOtEuXgxnwzObBuL1oEK2x1uWEw6w=
X-Received: by 2002:a05:651c:102d:b0:2d8:2d0a:7b9b with SMTP id
 w13-20020a05651c102d00b002d82d0a7b9bmr9844589ljm.14.1713256063849; Tue, 16
 Apr 2024 01:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-4-kerneljasonxing@gmail.com> <2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com>
In-Reply-To: <2d3ea199eef53cf6a0c48e21abdee0eefbdee927.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 16:27:06 +0800
Message-ID: <CAL+tcoA+vtTKLQGMrbS5Y0-Wmq4M0BAzojWKrT7KA6Ju_Eh0bw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/6] rstreason: prepare for active reset
To: Paolo Abeni <pabeni@redhat.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:01=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Thu, 2024-04-11 at 19:56 +0800, Jason Xing wrote:
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 744c87b6d5a4..ba0a252c113f 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -412,7 +412,7 @@ void mptcp_subflow_reset(struct sock *ssk)
> >       /* must hold: tcp_done() could drop last reference on parent */
> >       sock_hold(sk);
> >
> > -     tcp_send_active_reset(ssk, GFP_ATOMIC);
> > +     tcp_send_active_reset(ssk, GFP_ATOMIC, SK_RST_REASON_NOT_SPECIFIE=
D);
>
> I'm sorry for the late feedback.

Thanks for the review, Paolo :)

>
> Some of the caller can set subflow->reset_reason, so probably something
> alike the following:
>
>         tcp_send_active_reset(ssk, GFP_ATOMIC,
>                               subflow->reset_reason?: SK_RST_REASON_NOT_S=
PECIFIED);
>
>
> would work - with an helper even better.
>
> Could be a follow-up patch.

I see. I can add this as a separate patch when I submit soon with your
suggested-by tag because I also want to make every patch clean and
simple.

Thanks,
Jason

>
> Thanks,
>
> Paolo
>
