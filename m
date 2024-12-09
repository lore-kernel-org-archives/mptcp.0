Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEF233135
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751263; cv=none; b=PWjsDe7d+uekJElun7HjBDTi56rTXAhd6TksvfRvwTL9eEZM/8aAuq5SyTY5Ro7GgN+8hu81H02B+Ver9bfpLg5SX+4FsdRPZtsofBPOpRuYIO5Nna3buHHSgVPtgYy+zbfnKVyk5HQ7rfW40BLCKQSvEvAfyw+DPSiGKKd+gZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751263; c=relaxed/simple;
	bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL6sGB4K6Mtnc9mRGOZeAQNWjtXGP3n8QNHb51lLPr9BRnW/J0Ea6e2J/3wrPB42GaqGqvqxR4x/AC3JZIvufNyfFkD4uS5IELyOVUQWVX8y59jwNzUcDE9vxCK3nF7fpzHppR6TycYwU94l2F9vIXhgpKW/KmxTyAkfF1NrtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+gAb2HB; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+gAb2HB"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a8160382d4so11257215ab.0
        for <mptcp@lists.linux.dev>; Mon, 09 Dec 2024 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733751260; x=1734356060; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
        b=H+gAb2HBr5p2rEh3EKXfEH9EurSPVJNETeyKSYb+lLjVjHH8BbeU4rI99Iinfp1aQK
         RMDVzWtAdN/BN5wsdhac+raTdIuhHVphM/Jv1IG8lf5Stj1ThdqWDaT9WsG6Si2bvh/k
         J2mCIXQxvLjhwQmZHCRrNrzsVqh0E4eouelW2tKCC5rOKcqsi/AaNpw0AsmdpaKPiLeb
         wK1nyOq1CHXJRFuXllfnF8+RKbf7w7BWtAnUnv6hDXvRuJ34QWPx3ENyrEt3MVAsJr0+
         ZpzNGXTDi+2DU2ycziZWSt80t0lmG6f/YjOG9QDokOxGwZWQvqJ9/cKCua4bU1YZ1d6A
         3CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751260; x=1734356060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
        b=r8jg6+logTYMbCjcOSke7/eCgpmljTvApfvbEy1XR2RhLHXQtbxxZ6B88j1LA+PMop
         teBM6WEZrjeZo7M8NFlQuVl2GMkLkE/zHr5nWQuWRdn4mfWtbig+8El5QZZteDP6+GEh
         sdGzudNed6wLIbBiSgloG0f0aN/L0NN0R3WaDEKwOyIWNvmlTASVFVALx3dR9w2p1EeV
         THwEUPT9SGPCSl11YdyzQnyVSYLFy3tVC/5d7t5y8xVoPYU+TBIvWK1ClRU7BNbs4S/A
         jK6brZBvzoyZ2exWdqhwNGc73o0+zANvLqJF07io7Psxy7DkdD17VdQCdg86K43tS1uy
         OXpg==
X-Gm-Message-State: AOJu0YzjY5TeBGTevcuxht8Cw85Xxfb4JB9V4Srek9aXCv7tL8SeaJQU
	WlFgXtnQCugP6KSwLhX7qE4omiBHDX/llo3lm7Ou1oMYS6THtFHYgs/zdhXDJN/QKAJwgqJr3th
	QKeJ0dDKRNy3PEeayd7anBtJR32l4qR4X3DqL
X-Gm-Gg: ASbGnctV8BUB/lTkXBZFUAQcHJ7bfBGiok0u8sVgSB4J9VCKp0n5EPrH57TCLI+5YPu
	B3wO07CBjpuvZmzvC/0LkrCvA0O1WmA==
X-Google-Smtp-Source: AGHT+IHRSd8liIwypeFGnJ2w4GP4iNsA1tFPI9rJi5aQdzanGH/U1dY5+7Sdd0pd0DZsUi7LvwuAbNc3wqFv/AS0+bQ=
X-Received: by 2002:a05:6e02:1e06:b0:3a7:d082:651 with SMTP id
 e9e14a558f8ab-3a811db1f7amr136023395ab.12.1733751260168; Mon, 09 Dec 2024
 05:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
In-Reply-To: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Dec 2024 14:34:06 +0100
Message-ID: <CANn89iLipfRa2jj7bXNQzx4ocgbD2C+z8+cYChQfPRwQ2SoiEw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: check space before adding MPTCP SYN options
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, MoYuanhao <moyuanhao3676@163.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:28=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: MoYuanhao <moyuanhao3676@163.com>
>
> Ensure there is enough space before adding MPTCP options in
> tcp_syn_options().
>
> Without this check, 'remaining' could underflow, and causes issues. If
> there is not enough space, MPTCP should not be used.
>
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing conne=
ctions")
> Cc: stable@vger.kernel.org
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> [ Matt: Add Fixes, cc Stable, update Description ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
