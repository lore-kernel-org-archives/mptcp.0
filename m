Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26B2EA73B
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194833; cv=none; b=IdFMspAlBTVFNbXXr76jQXTXCtVO5ddctlUP6nyxBvAE5sIEXJN2ZEWsEIyFnYQfi6qp9j7Y2B5p6gmLn7KTtmX71Ft7Fr9jeZ1Q2BkIDORGXOT++4JLz84ymnYjOK0B5KyI4gKjrd1gN6QEwZVixlTbEAdjgnLGxwMfeKYjvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194833; c=relaxed/simple;
	bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd7wA2z8AOkoPp0Vvi9ijtws9Q/L0EXIE5dGJvnQ0RT+pl4Mynn4nfKEVlmcXBpiP4djFuSysoI+LlHvSXQHir+1dYQ9VhxZqTgSLyy+krABTTyBrnhgNDdreRAkbxePa8qL831INxd35fVO84iCKUTRhMJZBB+LDbHbZepR8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hcg9cZ1d; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hcg9cZ1d"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab9ba884c6so69631031cf.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194829; x=1753799629; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
        b=Hcg9cZ1dwSy2gGlNS0/Fv9GodPd6ZvlKnFtPwEa53K2hvRtGFRFdXZ+URIcQ71N/M5
         WcLNPWdATvqT6EGq0fpp2HO4/FZ82Y7LLB32QxQyGu/h25BTEPoHyyodjhi2rByNnxrO
         GAqkYpo0Vrc2vzqQ/NwplxL14rWZFzxVFjL9ioWxHdu/68l29hbL45QGTLHV/fZnz3NF
         moN3h6nxnd/4b57luR1FJ7QpcgKMTXDlUa4i5Ys2n9xv2QtG3Vhudkb7eagdRdNXtsCn
         FXK6egI+/PtxJ/X97D7hjLHFIKPcTKZTYe81dF8QFqMyn6Z3AiVWN0UUP44uTkWM0cBF
         cHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194829; x=1753799629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XuOmXMmaaWqnvpqCFWTGZCIySJ+eeucJi/seDLbNI8=;
        b=I5ta0VEElDEs2nvarsPQ3F9KJH7q2LUy5QYEyQKygfpFQSEsIXfxklwccxtAeRsQh8
         PzeVoS2EvC+07PJGh/9owsJzfMgQ5HtdDHyNRE/J8nsyAGT/jLCsXpY5oCwGQ5derOfJ
         0xmGqJQ17C2H87W6lzTF1ljx5RTDOj+eAkNXP7T0svRaLbvR6M/LlUj45bZ/imxB6wq0
         kXAIb0YiEk3U5H9RTTidVxO6zbyFZiE0E1VcDnim2toNWPG3bO9nQnpWimOr+lz6To+f
         D3ZmVWuG71/G3sSB6Aete8uOrh70P19yVYTv+3xSm9B7b782XmKcWb9/9sy3CWmSlFLz
         gG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7BulZM5esgqr6CVRd8lY8lm1zLUwZeBKX7IPpamfNPC7NFBTxYPAYyGbS44Nkwxma7237Ig==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCKn4dS9iANfsuxE8fhNvJRbs1vrz0wt/AjH4LMklM1jfpcrQw
	ehgQUnTaJV1kYo7uGClzb2ck+1rc6xEE0r5nHsM8jBcf9vdx21lkLUy/0DzmfBZ11LoCsW+7HX9
	0MEz/gImxBJY7VPKi/fJzCtqpR2TcdEfZoYUagvOz
X-Gm-Gg: ASbGncufj3ZcGO1ULQntls4aQHn/Vv6syo/ZucTU4lQEpaLfF6w4/kkK6s2NQ8pyCCR
	xbsm+tnMr7VlzHIdUHmd7N+XhvJzuHUWBqrV68wJL+2Ydz8n8h0Z2BRiiFPZV2h80yQ1bglG9Uy
	g6j0EF9H0Oi5BrrILcwqbKDFdf66VYgmL3Du0pYSkFWYjRt8aEu0ifP9Pg+e+Jj5amjUrTcfqEV
	EzJLw==
X-Google-Smtp-Source: AGHT+IE5/xC629Z41/ewG1rGRd/vRIyn4/fPdY4AoJKCJUc80AhvNP/9QCPniM9G42/4UNQXgbiL4QSwJejVESK33OU=
X-Received: by 2002:a05:622a:248e:b0:4aa:105c:a0d5 with SMTP id
 d75a77b69052e-4ae5b8c53e8mr53665791cf.16.1753194828653; Tue, 22 Jul 2025
 07:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-3-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:33:36 -0700
X-Gm-Features: Ac12FXxIYBSQCB7BH6twTSCxBz7O9cZS9s2CNGBOnfVcy_wDobXLwLt6phukhSA
Message-ID: <CANn89i+ju=N_JNoCqSMaa7eG-70aXk6ZuNGdjc39cpUFQVvhEQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/13] mptcp: Use tcp_under_memory_pressure()
 in mptcp_epollin_ready().
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
> Some conditions used in mptcp_epollin_ready() are the same as
> tcp_under_memory_pressure().
>
> We will modify tcp_under_memory_pressure() in the later patch.
>
> Let's use tcp_under_memory_pressure() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
