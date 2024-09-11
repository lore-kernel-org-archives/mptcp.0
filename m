Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152E77102
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040466; cv=none; b=GckIjLRG33YKwRr2T6/WvrPFIdp4DAwMB5Xmti46xgZ6w76TW9I1lkk3gPZ+HXO8yKwFhrKZU5kzF8DwXIn0FbQT/xN7QCSHrW3m7OveoAvUN8cZuEJJukrQBuF0njwLwKkKzL6ySq/T1j064XfjySBARy83SpuJjqLpVKcDKok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040466; c=relaxed/simple;
	bh=uRFvJ5+hV7kipzY0KzGsnYB/ROapPXaG8FBdZsIx3Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVhMrnIMXI50e82faXWw+xYIOHL/hkCYcNMiYrk3uKMpM6uK6SSd3XTRS8ubA8p2Q8WfBz4RuWqZPwjLXLqfp5UUfTrCFMVVtLSnedExl8dpK497V5wbmbfgXhZE8MoicjLcWzmI10aMGkbB+sSeA1rNMEcgcdaBzCF99xRpw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGWSRzgL; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGWSRzgL"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365a9574b6so7472983e87.1
        for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726040463; x=1726645263; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRFvJ5+hV7kipzY0KzGsnYB/ROapPXaG8FBdZsIx3Hg=;
        b=YGWSRzgLo/dwl1ax11U8Liojvc9dVXxBrps2vGZoxXvOURN6aQTPh0GgNRkXGFeqqX
         tqddxkFUmt4LUExvDfuBofyBsITb+1M2UYCgOjQ9uSsvKnVk9TULXGdg1Du3sLsUkvMS
         FoCnuBLyR31HnyTsWFTydcuJ4ZkB8IWbeXTe24CB30N+AEIUb3Sgi02mouvke4lNM68H
         bzAttNdAPuQXEFFx/FDtaXelSfhZxDnW4oHVsNBoTKRHLi02oFw5vIn5V/6OrZ5QRLAP
         YB6UzGMkHz/bnWlDKpfY2YSC++D6U7dw64BMkKiA1YAfMn2jJ+pJgHxQvqfl4HvWGfAK
         9cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040463; x=1726645263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRFvJ5+hV7kipzY0KzGsnYB/ROapPXaG8FBdZsIx3Hg=;
        b=Z4kLGBqh4r9aM6IWX1pdJF49rcxA/rY4lK2IP4iZxbKp2K1V3woi1mKbt2tb7Gp9SB
         xOFvxB9YVV/gO3PTFzPVCt6D/PeRBG+AdADkeqQ1PcLvZzV/EsI/Wag3C8cimbIA27aF
         U9y1gvkR4I8jQ6xK3mavSs2a2xfGNF1UbGhWBxzPiq+L0hdMndO23O0KmcSbqBv5pkhM
         TFsfa/9uEN5ScAZG3nA2ZjtuRcZHRNnN/Sl/T8sFgXjff34bJN6rXDEZ7f6IKk3hkwRe
         sekkgOgD8UBsyRUBf1nZQJMz7KtfHuqU+XjJdxjMsVKzyXzv5BGrZzt854/+SB0qOn4+
         4LPA==
X-Gm-Message-State: AOJu0YyLzusoqIlJyrr6dq0qfihnNUnK+OhSADoUgQcDlNu/l55puO2l
	LgIXTY+MAFqr5eGLYzsz3dw8xsDFaQ9ql7fDwMhYghncX9QTgp1T4yM2zcT14ibAMhdcGxDHBMt
	rjeh4nd2+5I+gVqvZxX1ULw+McsQjzYkZhMCK
X-Google-Smtp-Source: AGHT+IFRO94eFk8lyGieG6bzBf83rb2Yj1ldYiU+jYKRj3JF723mkSoRslv3qc8t/lvhC6jB+C0t4gg/v8XUz/zgTtI=
X-Received: by 2002:a05:6512:3ba4:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-536587f87damr12970563e87.42.1726040462052; Wed, 11 Sep 2024
 00:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240909-net-next-mptcp-fallback-x-mpc-v1-0-da7ebb4cd2a3@kernel.org>
 <20240909-net-next-mptcp-fallback-x-mpc-v1-2-da7ebb4cd2a3@kernel.org>
In-Reply-To: <20240909-net-next-mptcp-fallback-x-mpc-v1-2-da7ebb4cd2a3@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Sep 2024 09:40:49 +0200
Message-ID: <CANn89i+6yPqdEsf7gEWSys0ibYwq7CLm70ikC5F2Rahync4yOg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] mptcp: fallback to TCP after SYN+MPC drops
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:10=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Some middleboxes might be nasty with MPTCP, and decide to drop packets
> with MPTCP options, instead of just dropping the MPTCP options (or
> letting them pass...).
>
> In this case, it sounds better to fallback to "plain" TCP after 2
> retransmissions, and try again.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/477
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
