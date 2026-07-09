Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BE1FC0EA
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602771; cv=pass; b=ORCLKad06vVWlT5WgedWrOVyU9XiJOnGjHkM2PWvAX96tJbtyZGPTQUm9dsLqjd6l+TpzOcNG6nSNq9RbsKLbjKCTXn6wQNX9/y8jP5TE730QDYIItVj9Xu5lopKsLPMKJft0sZwTcQZ0r/vtXsSakSPSxXciKz3XaI6lGg8y7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602771; c=relaxed/simple;
	bh=LuPyH45JluGUsFbICdv0dPPjeFb1YqiZhn15J0rMzCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQrJIIy1Ndvy7MehLpc0NUzZ+A5U3NLdAC5ytFJDuflSDZRTqTiejDiqV09RWQO92upYmVy8F/yFOsDqCWXPCa6NddicNgDmwOaciWjcapPVjfzHdkjXuAh8lCmq/iXcpJMRQa9Kxu48U+bTRweOykkdcyMTNgc/SspWWuhUaaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWRx9lNA; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWRx9lNA"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e763fb7bbso2931257b3.0
        for <mptcp@lists.linux.dev>; Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602768; cv=none;
        d=google.com; s=arc-20260327;
        b=G90INXp0QLXs/zExS4XVLVIErwTJVPNcy3BClvlpvLr+J3BtaPI9X24UjNE2q7d47g
         ZvYMIjSONG//VWoPAkPZM8XLvAKhBwUi/C0uBCU+3maAxkYKirgpPk0CY36n2w19v3DA
         K/BEMtegcTcWhwEA/v985jjQHfZvi9NPZ7No3Pqyx6Kn//tTTd8a/IxuBpEzs5k1vUot
         vydFXe2jMvfJz+2+iaOKR/9adnQDJBXrA5QpQUea9kjKxmx5pvuuJWqOQAOjq3uKguYH
         tt3OJorfpcixAoojhKZ1pGu5HtRpPEJsbfdRps/18iMGWevOOA67w0/hu7svJ0FTkNsW
         dsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jjrc/YslrI9jNEKvWNKtjZOydztcYkfUnEU0y2FxQDk=;
        fh=gaWcupY6dHTQ4NjPfkmtDn418zSI2ME8nc3bj7BbZ5Y=;
        b=qiJiE+iwPS5gmfD/4DEUDRqr38Z0WWHXsp4Chl24SWlt3XyESwXsqs6RKahxCUkEpT
         mFjj8m1hAeGzis7qY9pbeK6C82cLEawkLyDs8cN4IC9x3Z0/CZAgEi6RCobK/oqnp/jC
         kT4nXu02nxb8onFhme3GwLcZ4Gt6U+IkiuDqPLZSZSmrgOA+tX/LinbtFhJO5a3se/wk
         Ojrd0PwdgajomdaUm5Zm8gnZqjpCHNpLH6daTG4uHFkyMz/H1MlktanMKBS+kD1/5z+N
         yqos1s6v3R2l3sE1CtSajIaW98Xgq8A+27+WGfxQ9w2IbnSgN+jj9DFnLvN9EOb2t3x8
         lHJg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602768; x=1784207568; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jjrc/YslrI9jNEKvWNKtjZOydztcYkfUnEU0y2FxQDk=;
        b=OWRx9lNAioq08iUdX3rVvQqZMbzyQObS+i4DeCwhlHC/97JrpT2BsgCh2Y1IFaRvW3
         45THrUm10aUtDxr443g+VvnLJy+mQOXm/q7KuVQWzDBulfQgv+TBbTYcrYpkjobpjUuB
         K6lzLDmZEAn7589+oyq39lgPAHNbtrsZ1Mf/4eGs732hMNG+dtcm2lpbdbreMQRacQmf
         AbdwZ8QaCAF/lzIVZOzbJZUWQZ8/OrqvwXEwPoEmjIKKDeW9AzXUPPasDRHbz8rSm4xK
         OKw+uMlMIE6IUd00Mr8vITI7AzkBbRKHxK7p0ysho2nEQucFEwv+YRlOcpkk1Ab7KcWN
         VObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602768; x=1784207568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jjrc/YslrI9jNEKvWNKtjZOydztcYkfUnEU0y2FxQDk=;
        b=YXiViThM3xx5gbZGA9q7OFLdPXEpThAkmbYRRcZroqdH0FGsdEl3j380gIg2eGleux
         hktKcUTc6igPHmz3kMFucJgReuPmlKzpgHtDOuH7Drcd8UqQ7ENuJutF3vlXC5UQPLqX
         0YpsaaAWvJ74RWiP1DTse7Oi+1BPHbdehYQixUl8b/g+ZWz9nIl4wR+f8OyT2gkYZwk3
         6s6IM2m3sH3hg2aOEQh7Sm+uF438e3UaIMarud9WWoqgDQbN3wxuolpccNeiqNo3rAKi
         SBNLkfR8NOgv81LoAueruFsSU0W619rxaI1dNFze7bJQ9rBTKz9KRVA7sSH4/ZhP9XG3
         FyGg==
X-Forwarded-Encrypted: i=1; AHgh+RoXAonfIuckq17tkHuPDG9GxDIauBcVNqZeKvLGR5aImatK42Ti9cn17rmmFydSCBpDh0f8sA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRPWF8+CafF7JFm8ElLtzSJvAzcIshf6U8P7snZjzIgHEBTq9J
	Lem2tB53HIPyitSvGbd4Y9HDzYyt6PeEOciyNvy1b/En9TjSzyUdOMCTaX4gHv9uj5o8D+sODQt
	2aJiYJqUylOJNleoCDecabruXLZ5QVRk=
X-Gm-Gg: AfdE7cn2H9YVqWG9yP0YZUmDf0J0J5E65S52rdt/Ic9TcpDpyTH4BW2pkSSFNJNhakS
	nIttJv+b+FEB0+E7zXeu4aR19db+C0mAhA1qA3+6pNWJeLzv2oQwEb8u3hGpDca46pFV4Xh29mU
	nHWYsWhyQLKF9ST259HfaNuaQ3mxdqK2NQwN2c0mzISVjcs2uzwf6wr4M8EB/6nCeweE1mchVtF
	C2Buck99XIU18Rb2sSy1Ix+jk4eL2cCTwdiBY0UrWsC4dUyMdQaelHDhAC/Cwp3XI+G27bVtEfk
	OFxsaiKZScWf+Be2dMzhyVR5BtVDI4wlDTqU
X-Received: by 2002:a05:690c:c0f:b0:80c:1df8:7c14 with SMTP id
 00721157ae682-81dbeb5c467mr57573557b3.48.1783602768316; Thu, 09 Jul 2026
 06:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
 <20260707171730.2679013-1-michael.bommarito@gmail.com> <8155514655323d8c4a07da86d2b2ccdd7244c125@linux.dev>
 <8d735844-dccb-4a65-b7fc-468d144ebc02@kernel.org>
In-Reply-To: <8d735844-dccb-4a65-b7fc-468d144ebc02@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 9 Jul 2026 09:12:37 -0400
X-Gm-Features: AVVi8CdRFgA4cFXf-n4mZkaXWRsJYRCw57JUJkCLnvRfnyRQQEi4EQVk8jwdwKs
Message-ID: <CAJJ9bXy29+cwu+Me8WNrf=f4qc=uoXSMCrUG3NJbR-xANJxseA@mail.gmail.com>
Subject: Re: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
To: Matthieu Baerts <matttbe@kernel.org>
Cc: gang.yan@linux.dev, Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 8:27=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:

> By chance, do you have a reproducer? Maybe using Packetdrill with MPTCP
> support? [1]
> If not, how did you discover this issue?

Yup, I'll send to you offlist.  It's a custom Python/TUN/qemu setup,
not Packetdrill, but I'm guessing it could be ported or extended for
testing/fuzzing.

I discovered it with my homegrown agentic stack, which is a Rube
Goldberg machine full of various tools (like cocci, semgrep) and
knowledge graphs (built with libclang).  The agent logs suggest that
it came from a family of rules that surfaces suspicious struct init
candidates, which I can share too.

> If I may add, please also send new version in a separate thread, not as
> a reply, not to confuse various tools, as mentioned in the same doc.

Sure, thanks to both you and Gang for the feedback.  I'll send a v3
based on your suggestions later today.

Thanks,
Mike
