Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A92EA491
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196543; cv=none; b=m7xBUuVGHr+0m6X3glxHsGpgVRvfk/tYxhSiO685rAKiXopDaIVze3c/OKHsjIFS7VH1Wl0BA2HIItcLh009XhVSXhdU4bGHjVDSAhAIwscw427s5DfcZS5YHBY+NI1HaKZBYO8hdvg7eizlarDhhtnPvkUmPOeaBZsJXDORGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196543; c=relaxed/simple;
	bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTGJ+8b4OPoOLXkWTZcPTPd/cy+REsBE3cx9l7/v7LFDat+0VFDktjdXxkmKdfC1pP7siz657dM/h4fVOVFlvv6bB1X+urp6NSZ3Xz9+4AFCV06Kv0JRs2MbiEtlVMXJFjXcwqjcyBsS9FzYJFRdLUFNyJiFqzvl5tq2frsEjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjTrmajR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjTrmajR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab380b8851so48284951cf.2
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196541; x=1753801341; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
        b=wjTrmajRf36LNLcfhhPabjf74MBVkXUzp2/3DjI5pLm1pUJ7gs7wbwFcMt3jgjTW1J
         buPdtVyGx3RA9IeW9ypVW7dbPwKW4tUHece+LQleb/5oYOLMOM6BJawRfx77RayBCxnC
         D8oLX01PW4tiudk6qmk2KDHE3HOoc6m9jZFPlfSUVjTawh+kRK25rdSu1mX9S2MJX82e
         9nabg19vTAqwdem+40C00JGlhNElOjO6IQ46YYvnVbY4GY2YrhJRdda0Ff6xUykhQq2/
         RhBqndps/ZunZqrllwi1KsT7c/C9UMJd3kh5y2L9DpEhc9Y3k9l+v5HJAb9LWOiQM0SR
         uBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196541; x=1753801341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
        b=Lb/kLPbPShvk+wk3v16ZWnR63v0djRwdpNDkjYC1HrLCdaeBdNHgldisqyBqVbZw+n
         1n55+upSN/QIJ3gJsb7M8K2ewmOkPVss/6TnkqGK2j7+6R5AHH5CXhLFsWdrfCnpYeP6
         crMscCrmhYHw9IgSrY7+ZdUnw/cGH0+sD88aI0w2DMqRF38OZuTFY2OPuGuEW1ICeAYH
         falnE35CuNqFzhV4mh3amgr1IBIuVsxWtRBZ+NDfoi4qhMk8k/8na6ABT7WS4y3cBP0F
         bUcdlMAqICPLuqMyHoVc/usmIQmO58zM15d+wCLKut+YGmQNs6zyDYmsr6Kbd8yg1ztK
         CQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKB8rS/iSwmM0+Nl8WusTMhrxfnTPHwgj1QSvClLqdiiYiDIx2+0Q2s8L9XXIuwM9Fu9dguA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9QbqhCcwu7izx0+hSokPd1ukxGmStthAMAtG4CGn/Jw9DEXlJ
	7XUM0qq6AeuA/0V0WzaBOlvlZoJPgYs13ABQPVADYaRelRFpiPXPFgt9UdxAHw9BbT/ZPWhB3PQ
	thMEmvN3LRvqN+a8/LzQa4tKKNYp39IKDYvpT/PjA
X-Gm-Gg: ASbGncuuecRiRLy7sq5fvQEgPnvno16FqaWjkP1ZfNRmhT3VUvDR1Oyfc4GuVfFkOCl
	Lg9BkrPEUY6cmmfd50KpmMSUXNcHMbtWYQHi+1gZsJlThrhww6NjcQxn9J1HlNI7/LN3wYWiJUs
	SUIPbJcOET77c9ZhuUIs9/EvkDFq1k5IQfJxoCWysLWTn38PJDekMon7i/uFFZPnM+XVKHzpsDN
	lv6kw==
X-Google-Smtp-Source: AGHT+IHatyO88FKjpHrkC5ZRrOvMvJcUcR//80j43PsSX5i96Xgq4GOLULMpeJdluQDo1lBmfvGH9r94q7sH87FUvUI=
X-Received: by 2002:ac8:7f13:0:b0:4ab:b02e:8c24 with SMTP id
 d75a77b69052e-4abb02e8cffmr222175891cf.9.1753196540172; Tue, 22 Jul 2025
 08:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-13-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-13-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:02:08 -0700
X-Gm-Features: Ac12FXwnxSRbbL9Frp0VNEdNEKZjMoYAXFHNjGRRYDkATQpDHC00xX2ThpLs5IY
Message-ID: <CANn89iJk3B57ytDOEL8YpQj5K-LacKS0v1ANgLi5+cZr5gqTyQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 12/13] net-memcg: Store memcg->socket_isolated
 in sk->sk_memcg.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> memcg->socket_isolated can change at any time, so we must
> snapshot the value for each socket to ensure consistency.
>
> Given sk->sk_memcg can be accessed in the fast path, it would
> be preferable to place the flag field in the same cache line
> as sk->sk_memcg.
>
> However, struct sock does not have such a 1-byte hole.
>
> Let's store the flag in the lowest bit of sk->sk_memcg and
> add a helper to check the bit.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
