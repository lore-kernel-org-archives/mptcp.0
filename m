Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC42EA47E
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195242; cv=none; b=HVqSWXZAoj7NWAL/ilED89ka+BIttSd4etni0dpxpsJKRgefTfyMJFQAC1NYvtyIgNI8IDXes+dL2I0MZ/klu3qy2SgzUXTdJT525dE4RqvvvM4rvdF87IWhI8YE1Eqt+2IIFGyjU42S8uV04iInYLzYyi/E75h2/QNM0JJ0KAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195242; c=relaxed/simple;
	bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcL1g8MLgckBB3JREnYKb997JLI+W7e4X2EPrhcepSRwZQMLoC+pSJ3TKn4N5AdmQ5cl7MdgPB7zXvEXNijzmb9kVXgrOluZlQfuWwaHsXbgYcQ5wSt8qUl0WA/aYaR22a0Ky+vlMr1TetQEF2URfPvbkfP5bjcBd14/XAfUAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxPoEm4e; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxPoEm4e"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab5e2ae630so66305461cf.3
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195239; x=1753800039; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
        b=yxPoEm4eczN1hvJX/0qqqjKf+Ea3VRN4BTZPBuDSeiAjHbb1IgdjzVBXrqxdpF9QXb
         fT2VNDWVw9atkcopsDSaVxfGfPEYsyJVI+MIewN89HJWizcDshuoUhniVhLSPVRSc7d5
         C5ESXqp7jlwKnGvg36j3J86g2NKcN9xJlov+/RMju3AnbghZ7Be0g3LU4YjuWegpdy5b
         fjRqjPnwRoorxHGjiyhfzcknBtpL5R/Ycq/zmQG/V5VxuLBfLI224uWEEf8yMwUQozdZ
         nnyeXalvsSYXjpasKNm8+emuHc/Ck0H1cEaSYi45i0KPFIS7j+ik19qnjZOvnScZ3/6h
         IB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195239; x=1753800039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
        b=ZA77Yn8a0SA8MnSNJscFATTQp6dnoybNlj1ysNDGWNPW+js3IbT0gEV1eAEjW5m1j9
         IClSfRPgZ1khNIYJgKqq/NUFznb6wti9ZnkqSh/oskUVpF3Cy3vGwzYf4to+XDqnRtWc
         34r4APaMPdTgce7V+yCNHnG+fIaZdI2bl+Xn1NhlnY1gczAllufeuaV3yAOOtpH8P/Id
         XSEPebT3bQ//0ggjVHXAbd9LHymnQOPO3IqiFG6OSrQ7D6ht4Bg8dJ2xcQXkx5GN6uc6
         CjYiB4S53XWQZ37SMD9H17ADmABvDLGE5jyQ0/rQrYisyBPnbqBF0kMPsGzvXlQjkdTN
         EemQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5PWSoeh0l81vu/29UGxMunNB/WGUVPro6Set511eHJBfqG9O0m6bJlIPibM1SP7veq9amSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYHSbZaZ+i8tulvwR93tRCIeDcrBOtBr5+lGYikUrMtBlVucRB
	8+aAmZUmVpSJAKcx8zAPHGzqeLSXLRjurh1gnI2N6e16HaZqkPgdQp+M4+Sx9OBm/FG3HLcdop2
	CKZTt0aJJE0lcZicbmRhIPZoqIrzH3BbUKe60j3Tk
X-Gm-Gg: ASbGncvwG7DsQ6cX4NV8j9zm84Q86XrAf5h7IoQrQHnu7Qp88NuMXsWn9/gWOKpH7gf
	AkXdAHTUQqLCPEQ9MhiQOuVqHPzrT1Hj5ZXXr8qst/U03hFjVAs+xSnTGcAQIuxY3FRBMN0CNZ5
	T5o/Zi7XrTMhq6Ycf+O/E9ziSjy/HDpu3/+COuvNsO5vvSXRjjcPQVXu1wOoX9pilo5Q7DznyNt
	2jf7UEySTJgxAIl
X-Google-Smtp-Source: AGHT+IFZ5x4jrTTIZ/sGd3+42jtNM9vA9GRL20sU2/Os0v7FJS5rj0L8KeTwvfFJmKz+wiHNsfD/xtdlAAVmvq93h24=
X-Received: by 2002:a05:622a:250b:b0:4a9:a90a:7233 with SMTP id
 d75a77b69052e-4ab93c9cf1amr314039221cf.12.1753195239084; Tue, 22 Jul 2025
 07:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-8-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-8-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:40:26 -0700
X-Gm-Features: Ac12FXzTeElONnU3WaxKpa2K4YFqUCuJ6KHpalFp0jXckJ9R0eBW0R2J1Duwmhg
Message-ID: <CANn89i+XTkEfrLdJJa88n1YWPapFAc_OY7L0kAPO-z4hsqjHhA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/13] net-memcg: Introduce mem_cgroup_sk_enabled().
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
> The socket memcg feature is enabled by a static key and
> only works for non-root cgroup.
>
> We check both conditions in many places.
>
> Let's factorise it as a helper function.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
