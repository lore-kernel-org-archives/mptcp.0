Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3715098A
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144761; cv=none; b=FXHgYRcHcgWjUk3NA1xXZDBxbahSLp8teS+jMwxKEnNm4qSchBNeT405cCLX2DuIS0DY39pzYIo6lp3nmT6m15upXXtZn2TSNXZXumICn55UdkMvuC/LndR3RrXtkoz3viMH1XJ9xda45ajIFbY4PiSh8v9eIwBWxvDLejSwSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144761; c=relaxed/simple;
	bh=llsTeOa6Zi5pY6gaSeR1zkK4Y5MZtBCC9QXLk6auZoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSjVbzG/Gnjgrk+9kl8IiABCXieR5U0pkK6BWLjw0BtAxMiMi9F47EfOMjsah9UXiz2NB7cyF/QQFD8yqONl6VXAMfHGXmO7Eec22dJulSajOY8KI6NdZPh0WAs9qC/bRB11t/RXr9r8gNzkbXvyknJ/6SX5Ub7i/rV5dRoyXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Af+RPClb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Af+RPClb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso12521a12.0
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717144757; x=1717749557; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llsTeOa6Zi5pY6gaSeR1zkK4Y5MZtBCC9QXLk6auZoY=;
        b=Af+RPClb0EgjoqM/6CryzSvg8VqESUp433fwnGpE57FLR1dg1uw8cPIxIlQ0HxjwNX
         w60n8n2hHPtbpc4l1Q1xIkd1u8bxn0/OIYh+G9/VceKwQUTBf9W9yFlsz1k/ymUC9LRr
         /RBmTAOQ8THgDdwRm/H6jq32RgBeMb+nyV8ZkX8zkf9NLq5mEyvFel4QbVZjxwkaWIRs
         jr1iL9X4DRXL3WpvUxM+lsvPeHKBPyWNZ67I1kh2hCeXuzWV+Q8cQBHj0YX9iYLJmeEe
         XdZwmhbXsSyL1MXup//r7LR5HrwIC7eWKMMBNi0xGB7edO8LXY7wy6NduPykPtK/II5X
         II7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144757; x=1717749557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llsTeOa6Zi5pY6gaSeR1zkK4Y5MZtBCC9QXLk6auZoY=;
        b=Ob3WPOdf9H2HzAcHF5n93ee4AmYuT5HRz8zt8ZQK/8rB4PyuYvoIE+OmnNiMaIon1+
         9su+CEkaVy1OChF6C8G+1nQsw+JaTH9Iu9GCmFCqQEDJSM/tMlXDHto4ir84pNOZO54w
         l5BRijxNSSTR8YgBpI31ebFeoUhS4agw9UoyeyDmF8PQqpYsfPp2NnAWapJZJl/SzNF9
         y1hdiJAn8VfxdZgTExarQFiCsFHJut3YjZI5H23L6utyHh/uEN/pHHPVr194Wse0Bcsb
         VFqfLWUsu9JwyRyVrY3ES+u44edsd+srd5OTyv81KJFdh8yw44r+9XoGgRUnzx0+qlT+
         LMxg==
X-Forwarded-Encrypted: i=1; AJvYcCWx4Zyp06LwllZyp247zm5Ej6P13CwQ+4iSxn0Pz6GfjPDWfC1/0WlnuPxwbiXiS/ZSB7+NvhZ5AJzbUWCv3tNvJUs4044=
X-Gm-Message-State: AOJu0YxCYEYbEQpzECd0pd4BaJQ1XD3Tp2VRZL+6xYXEsWQIRcg+c0d4
	dTBH7BLMwWEUa5mpaSbYVJAfevqTDT80dKodBHlpKQCvaZsImhaugLlaOXrA497X0Is/n8Jl5N5
	sJF8sODIDoCX+io49r5QhVIlmvY0kydOcUDO6ZdzINO3SRYbjHA==
X-Google-Smtp-Source: AGHT+IE9sqKACR/zHG48C2o3CJUqL0ykYteHHRPY3wtzNnCz1ewFWTGBr72XKL6NSwYPoB7UZ1O/siU7K0HM6PEPfZs=
X-Received: by 2002:a05:6402:3112:b0:57a:2276:2a86 with SMTP id
 4fb4d7f45d1cf-57a33c7b7f2mr98341a12.4.1717144757163; Fri, 31 May 2024
 01:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530233616.85897-1-kuba@kernel.org> <20240530233616.85897-2-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:39:06 +0200
Message-ID: <CANn89iJtm8h8wCYVO6ht_TkxeJQu5dvSSJ=LUq+J0sbVKd9fQw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	borisp@nvidia.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> tcp_skb_can_collapse() checks for conditions which don't make
> sense on input. Because of this we ended up sprinkling a few
> pairs of mptcp_skb_can_collapse() and skb_cmp_decrypted() calls
> on the input path. Group them in a new helper. This should make
> it less likely that someone will check mptcp and not decrypted
> or vice versa when adding new code.
>
> This implicitly adds a decrypted check early in tcp_collapse().
> AFAIU this will very slightly increase our ability to collapse
> packets under memory pressure, not a real bug.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
