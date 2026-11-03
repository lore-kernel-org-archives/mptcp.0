Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702615;
	b=WCfdY8jlu5pmP1hfHOmsphoDaD2dpVrymeQfOkfLhknhV4L088LLUU1IxhwBBH1skE0P
	 mCQFgYaOU+lBPELlnapnNTK1KLNeM9kFkBFFlMf8XgDkhx5ig8qCGPCCSVxlxABy6O6N3
	 YpUQKbrMpBiMNc61m1wQtYkQi7hrmRZNykM+EXpMZbWc5ovoNXPN1kvLy2SnZWrz6D81Q
	 y3A5DKyKHDBNuI1gZ7zztgTHnfovgi8KC6xMNUFcovkQh9MAKtj7jOboe3aDudX1HO3XW
	 nXiUTgURT1TbuyLS61MBsouVWbvZtOzPfyi0GFzvI2i3EscUZLFsEiLpRfJQpyA3akQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
	b=getNNTKKEMELnBWNmJ2Wrqu60g+7NqNeWclO9oe6pKenaIvq1mNJKQ+GzzfeTsU/2VmF
	 CMuWlU8m1ttXmtC20/DDVhkwpJ5y4FELonkDmiz3Il8+6XxShtfDQNnW1rtrYE8/eaJ1h
	 UH2Q2kWt1j3F5i/2WCsSr2TYAlH+TMDCJDMJkfHsnGR70b6Lr0UCIngSvfO2iTgIzzEDO
	 8RZ+k8kd2qvB3sHP0aiAxHdL8bmOGSZB0hB0DrxiFpxvzq6XkgWud7j72w8jytVCWeQ/O
	 c6GaVAOvYyzohRZjNNaOWscvH01bggnjXi7UhdUPOprrnlr9XNnfri9sBtXJznPAzlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIW7fNCW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BED606EE9A
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 10:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BED606EE9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIW7fNCW
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-83bbcfba0ffso2973404a34.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 02:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793702613; cv=none;
        d=google.com; s=arc-20260327;
        b=nTcSUfLjuEEq1Tea0l9+wq2nVDziYyibQD5cC8fBjIIAlu+kFovTuNEIMyfvk1CfJg
         z8O+Y7SL12A4z+5ArNRSm8yoOg8Qhyt3HTz9KXaxyis/4NTz6Qs1NUzjZW2Qee4Dll0n
         Papt4Zf7D3GkMlDVFUk5ySct/sruGXF/SqFm+yct5z+LuxtSDFfj7bWDQY/Z9gGsUlKo
         cDV/MnFcZC+WU+5fysygi6hC0qZLjFV4o5RCjqGps3OK7tEVSsFuWGuumjcwEktKdztj
         Tv3/z2YF/EEbIKPPEHh8rOH8Yu8YxFdlFKJAkekRSwhkTHfst17v7JnBCHYoBTqUTRdD
         M1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
        fh=KljHuPi9yo8e55C0skqrlKcRvHnF0XQicmkXBrtYq6s=;
        b=manKuquVecY7+yRaHm9XQLyzFkK4VooCHukKQAn/HRyjx5MguYtg8fLCgkEnyNv1Rv
         ODtrhp7h3e/TRBaH3lkwVzBVcnBQSeGJ01Qdf9Xr7ApZgY7d7LDP+fW8v4xPDlNlq6YF
         ZQPm+0xghRVRgyxeD0RQzlobt67tXpgS10ZRnqA/yYGfN4L3Pk2cB/+U3FqlaDAhAfzT
         ehqukc/iTXg0AH6PfhNUcDcoUofDg+0PzcnabHuhVr2hlzyvW1AK5/91ST3vE3fo9bsk
         0Qbrws3X0OTJa5pQzET+LHnm+FkPkCoLEn69pCo1arC/Q6qgVrYi304VxUOgBrh9cSoZ
         RYmw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702613; x=1794307413; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
        b=EIW7fNCWuYuSDrG0Y210bnH6p6zE/OXHVkNvccBA1fviPSM+tKPR646MNfTOq3BCfx
         49f/t5KX049T11BzY0+goleo8mxpUGJ1QYdxF1pUjoQ2FnKjA3apXZtD52vQLD0Ly/S/
         vamNMrn6PHhPoqTzfmhU+FBDUbAfX0Jyjd+DjHSKwugxBv1nC+vsNBztb3lH0ebAzS3/
         4EAEDMOLPA9y8L+OHsXQhZu8GD/dMS7GrdfbQmn0UKppbgCXM8HIQyYUwoZxzImhNXRx
         uwUqp+Iba43goajWFh+4YUfs4BJKvA8ZdbvceJJVtFgO4V+zdJeuqQnqwDYfshiUhbH4
         uzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702613; x=1794307413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2clxmetH1f6hKvvIm6D4A4xikxCFsBoxO8NB0gBXdk=;
        b=OOflfvzu1xWB2fJiyTJqx1ztEySNUlF3HRdj95sgp5zPgkKqGLwuWwdX+LCbZ0aOM3
         i9rQG1Q/0+HeMcgBLh6K6i/DcvCeiISyv86NEhNYASq+lrWM++7tf8SS6AXhvpb6nR90
         6wLdmq2o3amj87e+d8hUPwXkTRSiuIAZrwFr9FDP0OX//LIB1DNOaIbfVqnaLfsmqXBe
         UY5hbNtCmV8KEtipBH6NZEUkeyQWE4mY2PKCVI6quVChomZl7dYG6Scp08Ew0TPEj4Y7
         Vk5ih+Brqn4n5bxN73PRyC3eMZb5RdYs3W19jGjJeD2eVkgNHPNhD1gb5KIQ7VwqqCgy
         6QaQ==
X-Forwarded-Encrypted: i=1; AKwUvBw74Pjh1rVvR8qmRGWOLAgJ0taiHEyjD0W8nNH21GBHmuWU6naBDBqAJzsN/cWtvi9JXKDBXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jFgo3RGychcQEw2Zh5bKzfxbeQOK90eHuHuUKDCMukLIm2+GY
	lLKvsnPHK6iYsm8fj8Iex6zroUH8mL6yPusrnmIUs7Cqr0s/4BAI8B7XGj3xXGZ20Vqu7DWaa/j
	L0GXdxC1oo1yYPa2B+lPM41U1WmSTGyU=
X-Gm-Gg: AYBFou2IZVtorNi/CrZYa5V73tUEGJjPx4K2I5OjeOsptFPDoX/aHVXHu8SAqYyBrkN
	EVjeHZ5CfTsfgOjypdjP/cX1HLxCaSt3j2fT/Ox7QpBGDmsId2G9TdNcoMoh1rcQXG4n84Fr9To
	+bdoBIgwKpA7rtbLWxXVkvtXZ/HsKpMI5otYFlq+N4Wi8q9NnQ7xJJcgIRQYeG6Hl4aXZtFHplu
	7SdpOU3Tw5C6ys+iOFH/VxIh9+IINW37xNjyolEQVwAjHVIhuXdpRVp59XTfggCp1jm0NhL1H0U
	3eEE34+F41g1Mb5tQDF+L9FiLXInBJ9zZKBoJAOkBblpvLkeIN1lzvxKBr4OPReTJ8RRDTDWoHR
	akk/zrtmEN7k5FipYZXi5ddHt37l3/2eA6Vq5QUotGxI5/wnfRAWviQUbcZ4=
X-Received: by 2002:a05:6830:3114:b0:824:659a:adbf with SMTP id
 46e09a7af769-85d364be1b5mr12424576a34.5.1793702613420; Tue, 03 Nov 2026
 02:43:33 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com> <179367762613.488856.7087052675164086918@kernel.org>
In-Reply-To: <179367762613.488856.7087052675164086918@kernel.org>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Tue, 3 Nov 2026 18:43:21 +0800
X-Gm-Features: AclHuK-oQ_9e5ylG83bQrdxRkkrucYAPnzsIDVk3iyXuWtU1FMLt9B2kyf0M3b4
Message-ID: <CALf2hKugxdDx0TmsY-ob5Q9gPzjRcDc8Dv7bhAV-oMgB_=r5zA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
To: netdev-bot+sashiko@kernel.org
Cc: edumazet@kernel.org, kuniyu@google.com, ncardwell@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lyutoon@gmail.com, tpluszz77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch does not fully close the bug class it targets: an IPv6
>   skb handed from the socket backlog to tcp_v4_do_rcv(), which then=E2=80=
=A6
>   ...
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261030032314.1978575-1-zhiyuzhang999%40gmail.com

Good catch, thanks. I can reproduce this by widening the window with a
socket filter.

For v3, I'll keep tcp_v6_disconnect() and make tcp_v4_do_rcv() drop
non-IPv4 skbs before interpreting TCP_SKB_CB(skb)->header.h4. The skb is
from the old connection, so dropping it seems safer than passing it to
tcp_v6_do_rcv(). This also covers the ACK path.

I have posted v3 at:
https://lore.kernel.org/netdev/20261103103633.2707416-1-zhiyuzhang999@gmail=
.com/

Could Eric or Kuniyuki please review it again?

Thanks!

pw-bot: cr
