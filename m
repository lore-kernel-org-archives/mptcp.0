Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA413C8E8
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534765; cv=none; b=lnfpkXocn69pKN8vkuSXGOW0W3B/e6r5UFU+q2ygbPsBV2kaSB1NsIXFkLyA1cnJ73lzUL7wnfFIwIrYMmQ8NgTb/dVaskPfAsB6fIOU0ls2Ahkd1gVNNNDUU9V/s5zdyKMK5oJcUKCTPgpU2G903iDIIJuXXSbLagXDSITtiuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534765; c=relaxed/simple;
	bh=M6InQaB0T4wGw9r+y0hXi5/zJ5LG2nNysefOOnv+iAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDyZXW9nabFFiOM15htDeHFDuXgpD+ASumlKO8qqVAc5TyoQ0qqoluO2JiLuEq/phtFcconPaVcw+lnGb6HlKEdxvPbndMzI2OeKWp2pCDuudvxpFe7EZnmkqZabtbZaRa3r0lrqflDxYzPpYTKzhgm62tmBEsh5y5PlAN83Jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBhASqOt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBhASqOt"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so38952a12.1
        for <mptcp@lists.linux.dev>; Thu, 01 Aug 2024 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722534760; x=1723139560; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qly8JbOiDlnwa/iIbG3/fk35NDbFwt36/SaFwD82+4=;
        b=yBhASqOt5ynLPRK0NLKUxT7dWz/hYNLq9dnjyZ4jb7XGgz4Dwlf5zAq3HlmEli93RJ
         DNEHle+Q3DRN7prBPlIu72xvtVc8HaKCw5HDjLTsO/yPQvoeonb0AMZLisOaWRxFGtNi
         jGK7b7qLNEbWVcYbN4Px1FoyofCE/GSw6SrFeZxXtCf1P2Ycl+xATL/1NeKTODFMf8tr
         tfGijE4SHlRggejZVlNpfFqKxk5GGX9kNUuyDa7jlrc9r5tVueXLj7HJWGLsX5vd88tz
         qTUQXuA8fgTzGS/QFbgIPw56Zd+E/B4Fy4eWJ5z9+VrgCrI2VGM200cFK0IMWDG9CLNw
         hifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534760; x=1723139560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qly8JbOiDlnwa/iIbG3/fk35NDbFwt36/SaFwD82+4=;
        b=k40rxu3Mdb6cZRWZnpOvFmrnBeaA+azmqUwsvIZZez3cUHie95a7V0DTKXvIRy+taN
         Mq6LocWtAYWToLZ553nFwmoKaACbkE8La66Qbo5eK3XPm22bGN7fMlv1VVI+uwo1KdRV
         id2S42NDCNW6xfgPuuC+jYJb1CzMTnYik47KJKKVC6ROxBLHvXmmiI6y7qoAyq+229T3
         0Sb335SJdS7yT0wRFr1FQEkB6q2UAvkhzJ4AiPSh1etwirSPZXHO7iI72WGdFnFVY0Ko
         hxQvDIvCmnnbEBbua2AHHWx9PlmsgVbIdy2hLpkHCoGFKk1jAM4q326jb565sgD21krj
         1Qjw==
X-Gm-Message-State: AOJu0Yx9LrMxs4Rdf5P5k8rNpkwQLvMwsfCPlVElorv1TJ4RFHvPRWRj
	0coYWW3idHyy3/xeppkd7yWSiNZ/+/6UqAGq1MjExGXaTKJoYgiv14wbPgHUEkj7XXrvZ2/9Tn1
	v0SQPo9/gTrkaLKV2fVuxvSG7c0WrWS42EoT2
X-Google-Smtp-Source: AGHT+IHB5CJxc6Tc3CjWDacX26l9/cA+t+kvTF1TdZijWQEEpgYdyhxFzFFAkvLyaqV8sqPcAn0lgEDa7UlZziEV+W4=
X-Received: by 2002:a05:6402:2689:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5b844f86d28mr690a12.5.1722534760180; Thu, 01 Aug 2024 10:52:40
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
In-Reply-To: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 19:52:26 +0200
Message-ID: <CANn89iK6PxVuPu_nwTBiHy8JLuX+RTvnNGC3m64nBN7j1eENxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: limit wake-up for crossed SYN cases with SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:39=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> In TCP_SYN_RECV states, sk->sk_socket will be assigned in case of
> marginal crossed SYN, but also in other cases, e.g.
>
>  - With TCP Fast Open, if the connection got accept()'ed before
>    receiving the 3rd ACK ;
>
>  - With MPTCP, when accepting additional subflows to an existing MPTCP
>    connection.
>
> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
> 3rd ACK, without the SYN flag then.
>
> To properly restrict the wake-up to crossed SYN cases as expected there,
> it is then required to also limit the check to packets containing the
> SYN-ACK flags.
>
> Without this modification, it looks like the wake-up was not causing any
> visible issue with TFO and MPTCP, apart from not being needed. That's
> why this patch doesn't contain a Cc to stable, and a Fixes tag.
>
> While at it, the attached comment has also been updated: sk->sk_sleep
> has been removed in 2010, and replaced by sk->sk_wq in commit
> 43815482370c ("net: sock_def_readable() and friends RCU conversion").
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - This is the same patch as the one suggested earlier in -net as part
>     of another series, but targeting net-next (Eric), and with an
>     updated commit message. The previous version was visible there:
>     https://lore.kernel.org/20240718-upstream-net-next-20240716-tcp-3rd-a=
ck-consume-sk_socket-v2-2-d653f85639f6@kernel.org/
> ---

Note: I am not aware of any tests using FASYNC

sock_wake_async() / kill_fasync() are sending signals, not traditional wake=
ups.

Do we really want to potentially break some applications still using
pre-multi-thread era async io ?

Not that I really care, but I wonder why you care :)
