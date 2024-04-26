Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944226AE3
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115533; cv=none; b=nigBVrQaU1cxU2U5TIqAyYWTL2OrRlcZVLIMMJ2Of042kcAZQwTpDXM/T1pWSrs8BoHyDsSx4psvtRAdHJlO57wzpvNyPJNqRIgzOYeCiRbf4tcoeHTrMk+Vz0MO3wdY8cUjC1J1piTclTPZHabuJ0kzaf1MH+ovU090VYcTKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115533; c=relaxed/simple;
	bh=o4CijGE6DQCwbT0vcZY7rzU07Zixh1ND3g5gwlWNbNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAWWVc7yCJM8rdYVV841Of9f1Aah/h2N88bCP9PP35sLKuktjadY58JeJ4lFm74BK6ksK91SR5MhSxwPCn84WxFOi9NKVmdbfF2SZazK2QyWM8r0nLvlMlMHgiq2o653A6cAz9tk0kX9LVV8JTKKew2m3j1Wi5AHcipD03sUfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeTKIMat; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeTKIMat"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so5911a12.1
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115529; x=1714720329; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4CijGE6DQCwbT0vcZY7rzU07Zixh1ND3g5gwlWNbNI=;
        b=LeTKIMat7jWIYwC/InJ9AWKfWflIhB+ZK2kD+Wv0uIISvAQb+34X+9YxN/EltAF6z9
         2G875VVQ7P1Oong7G5/nNyfwd+6fzHeedRWwYQ99V4OXRMPbgGyITW/j+bdSqI5Fdm53
         vaRnmaZvuBr3g3BUdZM7JaMESJQRQ0ydSfID9xYwQn05nLh6eEAFo4YOoQfqfzHsUCB1
         xquXa/WnCui1MymuJpFRz09WGLw19hVviY6ZKTq3Z71X4BCj3a1r1OeTs9LBhQUjem6D
         CluA0rRxi2lxMJlHHAvWzjajivBu3PiS+EFYpYV0d7H6o3WKl2/doMa7bxQFu2PEXryJ
         fRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115529; x=1714720329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4CijGE6DQCwbT0vcZY7rzU07Zixh1ND3g5gwlWNbNI=;
        b=EdtrBr+2NOMUYTfYDsq576VDU90aSO4yHdbw2feXPRJknE51ABRMTwEU/tVvWkPzRH
         EOoJ8NxZt87ugVrYkCSelTFEpAtbSgqWuKNwmgATTAdatVJc/esYcj7SDuDNfI0PEcgP
         TUJsOqBuxpAwQvEZPw/rYlEIuUS6LFW+qj46MTUL2roqhTKWmDPb9/6Tm7W+tFam2u9w
         K3qCwD3xUKLYGEqBW/plVhL5X6tXakV4CSNHK3oVKK1bgJkPOaCgCOLnUyDCbj1AHLcj
         plcVphPM+5EpnwzONEG6BTfkn9qwbRwNgCatft3sih18QQ3QPcw3eC2ht6mv5eh6GOxY
         Uchw==
X-Forwarded-Encrypted: i=1; AJvYcCVwZQATAbHLtua+bbVprICXVPGe0WBDJD6umsMCUwzkk36znwXKFqlDbvqswFyhipgBbXeLELPn2y132QxbG7qs/jnP49w=
X-Gm-Message-State: AOJu0YwK4464AfmX2feQV5C8I+6jjXPn7MEX+vgCfsBXUFVvro91N4Jl
	hDBzDwyMXpuGBqjOIbY4NZE/WBx8vEuyxM1WpFBZNW191ntk+NicHp2g9STkzfX93syaq/UDUim
	0dlQ68zxyDRPVXwMY+06H35Hku7G5hYrbJNbM
X-Google-Smtp-Source: AGHT+IFGK6axy8x4vSxxxy3Oh+3ntHHua1mtJilCxbRJCerWML/wCChAU9qlPo9HVLrAqSWMm+hZgH/UuWi5SnGwh08=
X-Received: by 2002:aa7:d497:0:b0:572:25e4:26eb with SMTP id
 b23-20020aa7d497000000b0057225e426ebmr71684edr.7.1714115529122; Fri, 26 Apr
 2024 00:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-7-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-7-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:11:58 +0200
Message-ID: <CANn89iK9Nqug+X8fPzRQ49fu+AydSqb2Js2FggkOHNFdNEcfAw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/7] mptcp: introducing a helper into active
 reset logic
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since we have mapped every mptcp reset reason definition in enum
> sk_rst_reason, introducing a new helper can cover some missing places
> where we have already set the subflow->reset_reason.
>
> Note: using SK_RST_REASON_NOT_SPECIFIED is the same as
> SK_RST_REASON_MPTCP_RST_EUNSPEC. They are both unknown. So we can convert
> it directly.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
