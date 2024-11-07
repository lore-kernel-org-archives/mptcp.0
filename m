Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850818FDAF
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000967; cv=none; b=nWzQkGpNw5rodeX7pEfKyyXCsU3EeoXC1udW+4mDg3Yc9MpLTpqZ2inii+UiRc5j+wT3TlbLZPsbG3nUxMmkSJcHQXbeKVausQBUCKqxmI9aXPhFdfIA0CVNOe3BiGm9n1r3k1A04FJjthvTKPwtiCzqwAsJx8wOLy+v+Jq4ss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000967; c=relaxed/simple;
	bh=UKuYG8FwCoF6QshUo8ov5ArilZTdcaVcHFVwlxyNXm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru2DrRFXRX1jbTwEXfegFejCVrAaju8hFaB7KICmy2wv5+0KMxXZHry52yaIoo2PPAaGEWjUSqxR96ohcvr6AdfMTYs/Lszu2Ly9ZYo34OWIfm92rsGZQG1hBspXRtSGoz5++EofYp7rCmSlA6U0lzl8nWP/BcE2skMmykCpcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggP7u5FT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggP7u5FT"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so944278a12.1
        for <mptcp@lists.linux.dev>; Thu, 07 Nov 2024 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731000965; x=1731605765; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+BKvueAMurCuyYxOiQu6I3rkTTp3EWgPYTH4la0hQU=;
        b=ggP7u5FTv0teTeldi/G8kk5Hc0N4j7scPqw/uNgOE/Mrg9FWh1I9MD3CB30gni762U
         cv2tTZ6fuUqpgD8VuG/PHVzBhpwM9LnAQyuBLwri8KBrm9sx3eJKhrMOKAcd4n63s2PY
         jWTrdjev46ZLtTvvjDYK5MpCC0Ylq2BJSeiUB7/wEPd84+mU+zuJvF5GZFm1HPjS/5Z4
         L7SEw0bYADFgyHS7t/ORG+YvQrzgtODwk5PTvPvIeIEPSrQg2u4tlSgHKZwK8g1lm2fD
         tO4nAbyLnAzbb6JRcBtHsvzx9knhIyxp6wSCWY04ZeZsqDX9VeAyGVVxWOMpG3n0Y8kn
         IluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731000965; x=1731605765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+BKvueAMurCuyYxOiQu6I3rkTTp3EWgPYTH4la0hQU=;
        b=dyMQZ9j7t1W1UeTMz94E9oyElOzrEmYbXMco9fHS+tPQNugERNr0o/gT7ZptWRvIbR
         mo/rt+vEiM4oPkuwR3SrX3OjW0TujeqOGTbJa0ctgU77LKrk/VZul8o57Cj7ZJatgdq6
         JTUrpcH8hrxwVZCCogUk8RWL5OKSPnPLdLbg/vPu+gTEKxr6KBf7GiaiV6VkrSPWq2xc
         2ErOv7wq2UsIZX60hBBdcNkyJSKCeWoDkhXg+/i/9z10jGOJv8r5xTHjLI3IwAXPSkzX
         kKktu+Sbpd3IDfebtSXRThIeHAZlM71HRNXVZBWjAJ2P6PqpqVAZJ9HUkb5Y5A2grgEG
         JPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuPdmLds6sfFFduYe/957tGeH7dr9vmBNic2pVQYWhOe8N1ZJe+LEt4sC1R48ZaEjbga08yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzriXNOPYYkq1KFZOZDwBko9NjOiaThnH4Feh/PqueNR1ly+Of
	HaqX1jtoBqbih5i0XhoWiYeMiVbkgf2dPpzgHoShILyyBGYmNeLsdYgiC/kIGDv5pH2V4WV21e0
	PGvaC0TPcjnShCMmOING6xoKpt9k=
X-Google-Smtp-Source: AGHT+IFHHsqtP1ozsre70rwHiZZJRlOml9ng0+oaLj617ngkIPN4BI70Dx9d93qcde0Zwp8covoqQhifviG9JAPqKoI=
X-Received: by 2002:a17:90b:3890:b0:2e2:ca4d:9164 with SMTP id
 98e67ed59e1d1-2e9b168241fmr9018a91.12.1731000965342; Thu, 07 Nov 2024
 09:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241106-tcp-md5-diag-prep-v1-4-d62debf3dded@gmail.com> <20241107002133.56595-1-kuniyu@amazon.com>
In-Reply-To: <20241107002133.56595-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 7 Nov 2024 17:35:53 +0000
Message-ID: <CAJwJo6bnYm9cuJ=-xXw4n5dscq+CG4mpbtOc_vLMFmWKD2GD1g@mail.gmail.com>
Subject: Re: [PATCH net 4/6] net/diag: Always pre-allocate tcp_ulp info
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: devnull+0x7f454c46.gmail.com@kernel.org, borisp@nvidia.com, 
	colona@arista.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, geliang@kernel.org, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi Kuniyuki,

thanks for your review,

On Thu, 7 Nov 2024 at 00:21, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
> Date: Wed, 06 Nov 2024 18:10:17 +0000
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > Currently there is a theoretical race between netlink one-socket dump
> > and allocating icsk->icsk_ulp_ops.
> >
> > Simplify the expectations by always allocating maximum tcp_ulp-info.
> > With the previous patch the typical netlink message allocation was
> > decreased for kernel replies on requests without idiag_ext flags,
> > so let's use it.
> >
>
> I think Fixes tag is needed.

Yeah, probably, wasn't sure if it's -stable material as I didn't
attempt to create a reproducer for this.

[..]
> > @@ -97,6 +97,53 @@ void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk)
> >  }
> >  EXPORT_SYMBOL_GPL(inet_diag_msg_common_fill);
> >
> > +static size_t tls_get_info_size(void)
> > +{
> > +     size_t size = 0;
> > +
> > +#ifdef CONFIG_TLS
> > +     size += nla_total_size(0) +             /* INET_ULP_INFO_TLS */
>
> It seems '\t' after '+' was converted to '\s' by copy-and-paste.

Thanks, will correct

[..]
> > +static size_t subflow_get_info_size(void)
> > +{
> > +     size_t size = 0;
> > +
> > +#ifdef CONFIG_MPTCP
> > +     size += nla_total_size(0) +     /* INET_ULP_INFO_MPTCP */
> > +             nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
> > +             nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
> > +             nla_total_size(4) +     /* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
> > +             nla_total_size_64bit(8) +       /* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
>
> While at it, let's adjust tabs to match with MPTCP_SUBFLOW_ATTR_MAP_SEQ.

Sure

[..]
> > +static size_t tcp_ulp_ops_size(void)
> > +{
> > +     size_t size = max(tls_get_info_size(), subflow_get_info_size());
> > +
> > +     return size + nla_total_size(0) + nla_total_size(TCP_ULP_NAME_MAX);
>
> Is nla_total_size(0) for INET_DIAG_ULP_INFO ?
>
> It would be better to break them down in the same format with comment
> like tls_get_info_size() and subflow_get_info_size().

Good idea! Will do in v2.

[..]

Thanks,
             Dmitry
