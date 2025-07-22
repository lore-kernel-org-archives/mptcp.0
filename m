Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0228C017
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195098; cv=none; b=cz8XtlwHBaCUmzq5gOiwvuT0uhB2rRh6ODa/6DZTJaO3M7BlYwybXmUetEVVQ6TvZQ/xIq5iZ3ax53SepgQcRVQZXzo9C6OnwwO+cgSTn96pLY+uft/daoJ1VQz5tGV68N46F7mkDOYVupGkiGh6Z1te3CSc0N8z4DSaIrG6L68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195098; c=relaxed/simple;
	bh=os2DYnIMBSE/kMJQ/4ssNfzgbbajAEFKtkzZf35uM/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaN0uFCvgxWoTYkYouW+w3cghwobsG5b0aMdhXApgRmIHOCRHXDQSZBvXcQsqLCZw+hmTC2cNyUpwnmHJ4Ij8yRyM+VKwHnBZsZoKFfPQV/u8bEjwgBMlbZGsRpwSpljreLZwcV5NAZc/YLYzkvTRzBFZIWr7o8iyZYviHK6etc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Plai8R3P; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Plai8R3P"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7048c49f1f1so46466796d6.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195094; x=1753799894; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn4gJyDMnXhPbLwCQpWenpbaZRFD72gmw0empnN1AaA=;
        b=Plai8R3PmcvDa2D3BfVMm5HoC1HVBU+d6a7m3sZ0f8V4UmT+O3bW8TQA/PHXrkg2qa
         4cAzjfjLdK6g/64bbhdDtQY4+iwR8Xtzy+zMjdw8fwyq8z3Fn/1PrqOw025F+4VJMRaX
         N9d5jP70xIo8l+vJ4fiLmir+y2XiUulxhSg9Sv5vbY18W+1F/TlUJSP59qg3Tw9vTMYm
         VKTTfhNb8h1KIxVMAx4QcBf9p38YF3EkkV80PEZ+V8dhO8hEEmXMcGUejAhKhDfwAH0K
         q54DjLw4iFDLqi3cd+aUFXn803TEkaP/o6WDvXkEapvrO6Vfcatbi8kyFijHE1iZLfOj
         Jmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195094; x=1753799894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn4gJyDMnXhPbLwCQpWenpbaZRFD72gmw0empnN1AaA=;
        b=Vb1rIt2GrUQS4rLxgS/y6fBELJ27VlDlEgX1WZlloeTEU1EhcqExjgV5Fn0WrfNQYD
         r+4mzwoZYoTXuKoV/QLScI8Mo6dEfPpaguwVwhE7J4xJmAl/Olxpyh5EvD/QRC+FtUKa
         3h/Sz/zdUxy3HDQt/BqXN2r+8XA4Nm4ZphAfQJVAxTg0vUd8llUFkd2KdnrDPwPguoL3
         7+AbTGSg6TadzR+ZnxEpWVxbS4N3iPfkur4yKyj7iyfcgW5P7BvajNX6w0Z1wGLxLXSb
         YhySlSFp06tty35DHHx+mIKCEAWTpFFL2Sqa6S/aVZdoYY2N9RuohvmnNspqPrDIVogu
         6HGA==
X-Forwarded-Encrypted: i=1; AJvYcCW2EWMC1BOrryfkbwr+TBzf6GpGy9jgV8UT+aGn5LaTkQ4MwSBdBLvb+o7SZxGkvs0S+bP/Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWdvTXXN+Gq6D2XLV0YJKmjFUevgQ88kK36/MZz8HOrwu+m+1t
	WcC4SP3kO+Hkrg9GLJ00s9i/1+qJxLug1DQGSQ4tZLfnfsBBV4TJkHfhAfc3f4+a4Iwc6QqPRWA
	LsjuJvVqscTM5mmI+03wJP1QLHF63niTwgY1nhEHu
X-Gm-Gg: ASbGncsXj+QVLnU966KC9f2Z92oq3zNTBdNuAJmMgonUsZrPEQSmOMZblDoqCdsNqLm
	p3aMv3xehrhKwLXOITPlkeuCBrTp4ZgDvEUueAoFouJPTvbhP02E1MpTLXGjEESKUQnAMox//U9
	OA5OokdKpxG4W8hGBqgGYORzGQ8wlibV2XM+UNYYSXolL43VNxh89wtzxF+aJS4RR3NsQL5uYok
	oJEGA==
X-Google-Smtp-Source: AGHT+IH7wiXrlu0TBmC9UV2qMcDz1px3wXYN9maWZ0wBhcAItzqiY44+P1BWoDs4fyTq/fL+do1VMmfi2vruAWutpv4=
X-Received: by 2002:a05:6214:6207:b0:704:f736:7353 with SMTP id
 6a1803df08f44-704f736739emr250100436d6.25.1753195093977; Tue, 22 Jul 2025
 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-6-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:38:03 -0700
X-Gm-Features: Ac12FXxlsXsI3zGI0AVZPAQnuIlcT_-ASbHpDgM34ehNdBuFJw1M1IUr8BHKjK0
Message-ID: <CANn89iLBoSc+x2n0w44HQp8CKumWBkqgYQEOi-enLahFTY02wQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 05/13] net: Clean up __sk_mem_raise_allocated().
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
> In __sk_mem_raise_allocated(), charged is initialised as true due
> to the weird condition removed in the previous patch.
>
> It makes the variable unreliable by itself, so we have to check
> another variable, memcg, in advance.
>
> Also, we will factorise the common check below for memcg later.
>
>     if (mem_cgroup_sockets_enabled && sk->sk_memcg)
>
> As a prep, let's initialise charged as false and memcg as NULL.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
