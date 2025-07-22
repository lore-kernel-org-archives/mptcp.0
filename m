Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CB2E1724
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196294; cv=none; b=GEUNs71FSS+NRCJmuj1XuNnm1+3Ub576qzYi44mAmvr/aRMTJwXoi0h5viLxxaLPzEX+CGHR2oDNIfv3H/deP/Q3NWPOEie+DL6cku+RP7McM+nXQh1mAGiZQPUgBeapTW1Z896vKsx13qFqjxiYh9VaORjoKeDyP+S9roXgJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196294; c=relaxed/simple;
	bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvdrdTd1ainjcAQ96WEWaamn5ScKstpybGfKTH7w+/mO/SXSt/9byo1/k0pFWnEq0dHq2HF9T5hy4MBC+S8efqqlAnGLNbfkyeVoBiLofaiTSpx4uKbbQhapJBt5uw0CqMpTCK2GkUpXhXaP/bHXMEIXcYaId+MfXMoDd4TILfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ih75siks; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ih75siks"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab81d016c8so77546031cf.1
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196292; x=1753801092; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
        b=Ih75siks6VSzrtBn1kmgZsEiZumXKMLPy1jrCPSk7OpRPjmlIoygsNmcJEprXLcoPA
         suuGj5XbdI2BWytIPxhZHjiqphfoqum285hX104P3goyYJZfF+6f9wLo5BGErQElwjXI
         T+E0zofemH0Bg8K3DlZ9U/rJuTSBTtkvzdCQRHSEaC3GMXuGYHZbDhKzLC1j5E4HvmWC
         DRd//YYMuRIsMdNESWego5sGX/61h5j4zakMGa2QGQIpgXLp+4X77SO9DMJApj0JeK48
         WbuH1MghWUfdnKq7LdXIQToDEfGq8O1E9bPhWjiCVJOD3HosBz4/9u/L2T1s4nR3Bv0s
         8plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196292; x=1753801092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
        b=cA8FFVa1HGrsQ80IcsTYHhcgqemZUl6xla2s6j4mtp26aRD3KYsLKy0gXD0JEsT0DT
         3q0mbcWRKzW88/KbMLAknVdN3B/j7w+VFou8fu4JyKqm2/DJTcQl64PowP329ImOy1Ub
         hFR02Dm12cKuy6hGIEdBSnU4u+umqxbM1AY9baczlk0UWvRXfYQFlse+MRqc1j+5NOwy
         RaXHPHAJ15wbkLmH7QomAMpWap8a27NCdEGoZ8RhilqWDSvARpN/IF6TbNsgQiweydYC
         WLANeKFYREoRmEO/wPmAmprWZr/aLEsTiF+xrSm3rk86B/bEUc0MItrumS1zTqpuC/XL
         K1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4QjIQSppbdRtH2KLMz4pW2jiFXUqgPExfG38z9u29YWyPBjH+og4/UO5bRzRD/QX11MjB+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjgG46ntHJzy8e3V9hpDdeK+WInH+1kKtM5g4K7SyK1lG2Ts5u
	KYEOQspwlCd+EuoTH12xkKIzqYu+9NJdPMf2YIbWcWJrDJaHbGnvOaRqtnqb93JZcJaB5jwe7La
	JZYQHvVP5v1SXlSxTn9rOKbad+f0O5BWXQb9y02y5
X-Gm-Gg: ASbGncswJklMqBdo52L2BDn+iv+ADXHgR+Yp/sYA7QRv2QeJXAoNj8bqxAk1V8MlOXC
	jLAkcXXbdCvyLXNRwe0b1mI0t1fGStdlNav3DgoxMAYTG//EgZPGbPvK34lO8NHf6dSVkkfUbQn
	HAQMgipB7YXlKabcv0SET8qYohWz1gX79KU53cEk7tApAvWTNA24YP5UNvrkgW9o5PV8fJWqGzC
	b68+w==
X-Google-Smtp-Source: AGHT+IHbvsTmXoMJ90OlEJkh3KhkwboNSzW3FyySqD4AsNrmtWHLtCL62ueTgeIousB3XPBSsSCTtP6ho6CBB51apSk=
X-Received: by 2002:a05:622a:1999:b0:4ab:4d30:564f with SMTP id
 d75a77b69052e-4ab93df21dcmr375890231cf.47.1753196291532; Tue, 22 Jul 2025
 07:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-10-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-10-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:58:00 -0700
X-Gm-Features: Ac12FXyjA2hCizSwjNeIJfXQ3m0aOkPNJ6whPVh_v503OAB4UKe5n9M4BBBTIQU
Message-ID: <CANn89iJckRO1b6_pdgq1dY+wE_6M1SBgzenR4wtggiykv9B3FQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/13] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
> We will store a flag in the lowest bit of sk->sk_memcg.
>
> Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure(=
).
>
> Let's pass struct sock to it and rename the function to match other
> functions starting with mem_cgroup_sk_.
>
> Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
