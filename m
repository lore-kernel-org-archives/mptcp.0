Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112F357A4B
	for <mptcp@lists.linux.dev>; Wed, 29 Oct 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745362; cv=none; b=tggM6+oamYeNPFBr5dRDeNX/WiNLgP/LwoWNxzctx/VrINuJsxbewGUesdv4NuNpkCIjqtMExKp8XwSzcIZ24Atx036E7TcrW6BGoGiuqAYyRQevyGnuPTmKi5wIWwQVwdAsFUsvYLTIgFQE54gkIhBrwcMjX+BxGnJYjWI2LtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745362; c=relaxed/simple;
	bh=eqmbZ6C+/pzZCLCfiQmSe/VNbkn9pwD4O5gf0205jdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snnFNBczzFXH3YQGb6PP4/28dIlLTRLNhYeDK8ZwEN2Rsiu4vfaanPGJ9AcODUsI2gnKdAY0i5ariN3a7KzrV24YweZnarfKqHZttILRL9BiZ+AWa4IOzR7nMd+d/K+IH6LB4OkCc6kq5HRvkSIvls/3qW/PEUKEBsH6m8yC4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2ssr3R6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2ssr3R6"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ecfafb92bcso314881cf.1
        for <mptcp@lists.linux.dev>; Wed, 29 Oct 2025 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761745359; x=1762350159; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwK1ndFtoZIlgGj7bI2/GfCsVHplI6VuQ2X/63o4ayg=;
        b=X2ssr3R61gXcvaVUUO1/PO6uW37/SRRRdqPq7K+Pmw/wyu+X7A+ebQJF0kYu0ztETF
         aznLa97ZFJ73RCO/pSvISj6FV65Em8u75qH0K/UQpCSq91YYRJz59RMOTMIHAwfFKdUJ
         0QrCRcK5HDfXnBi40mT0kxKKCnQ/94EV8XuTw8hL2iGC0/51ADM8af9JOonwQgh/9gwt
         n3KgaUbJRkYIUgP0BKxf6PLfGFtMNXpbZJ01jEboYnjlg1IzAbE6x9vbFrH8jlePUX1E
         8WVippTsp1OmZq7ZlpaJ8LyDQR1MEz+eKrd8qO0i55F592B2HxutdnjDYkryyvBVY7Ja
         VhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745359; x=1762350159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwK1ndFtoZIlgGj7bI2/GfCsVHplI6VuQ2X/63o4ayg=;
        b=nC8gN2pe/OIVD6aE0ruiEKiARa4t6p5VN2vmMzLY0AOpyRFoe7m5C5QNcxRzACwYJZ
         5Q1hf5UbwFifTFdTk5yj032pa+TSWf3724fcXvZuxocGSoLhCsESpmr6R0vqrcVEz3W7
         JMBAVopXUOgfwNZpOSyKa5Hmhqo9b0rMuaXFIoLPEcvAv5VLqqIPM+c+4r3aF5Smz6t8
         +b7vcEnGlP+2yrPjDKxx518q7rDNJWKgRq4FZWBGbciiq6p3iVZx1VeEBD5zWNWFuu+/
         Nm1/fZwi5Kk+VzDzE/FGFPRmHKZ0DIeprTExMcmKgvAQoSGcfZc1R2Nuxb2loWyy8MZk
         hcbw==
X-Forwarded-Encrypted: i=1; AJvYcCUpxscsUkzB/UfxYxAArBrDfyLa86/buJMPED3gXGW5qV6aYvr1dSyKLvlN3259NfNzu12PUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9xzKVzPceJ1zKF45K97t1qPshbirupfPln5VgWYcIFXQZu3QT
	xzBP6S6C4LCfc3NMVqhuQJDsbNJiVgrDORTkVsBe5LVccI3Of/ckp17+gUx6sP6lrtzYDYJRDvg
	p+I0/gsbPd1oJTusohpkN0d68173AKrlivt+k+cpo
X-Gm-Gg: ASbGncvKbujO/+4+X+j6Ijomht/8yk0G07RG2oMiOR5gtwC1A6FUAgPYsNOWdSPrtmd
	HsoRQLAmYI1zVR88i3YIRNOwN5/IaWOMKJvRKFLitWre6TV9jSI+5VKn7vHdsIQg3xhWEd9lgZy
	NFXVPfctTDWe2JmM6jce2vrpdLtZ9BYDB3v+Ep39H3XOu3Qn8k4P1txRxXX6AdNTMgJZFqMi3or
	XYzi1izvC0vUNLhXCTrfZyKZQG+sH21UkRukIuidE4UTij8mpipJvBZ/s1YmYpJMkQ2m9ggd0F6
	9gB+XQ+RYnvgdupTlf8RUza6x+gUH1eG7/04otg0aTL5l8aLJqncpnn9bE2S
X-Google-Smtp-Source: AGHT+IGtHWfovXqfvSbcFy+Pt5rl32fTWV0d/1Y/CsEeBRhTrAlUP7rTGJeLhXDltf8/Z2wATZXHrUKI/n/m8N95X/E=
X-Received: by 2002:a05:622a:1b20:b0:4eb:7681:d90 with SMTP id
 d75a77b69052e-4ed158ac668mr7989031cf.16.1761745359037; Wed, 29 Oct 2025
 06:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org> <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-3-74b43ba4c84c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 29 Oct 2025 09:42:21 -0400
X-Gm-Features: AWmQ_bmkO50WQoFAT_CZV9_dPllZDeiEg5XeCFHugo6EvwnaCcAy-NspHcjqfqc
Message-ID: <CADVnQyna1BX8y8Gw4=+4dJ_VYn=O8JMzSqh2y1i+ZH5NpfPsfA@mail.gmail.com>
Subject: Re: [PATCH net v3 3/4] tcp: add newval parameter to tcp_rcvbuf_grow()
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:58=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> This patch has no functional change, and prepares the following one.
>
> tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
> old and new values.
>
> Change mptcp_rcvbuf_grow() in a similar way.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> [ Moved 'oldval' declaration to the next patch to avoid warnings at
>  build time. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric and Matthieu!

neal
