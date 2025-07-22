Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA62EAB7E
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195048; cv=none; b=oE/A2gyn38txVUhdgZDKdkGCpDipQA4KiqUEQh8cJTyMI6b8x+WwBPqwYPrgDBINstu3YeGBrqNeQifGHoF4YZ24OiQSfUY1Ore+IV50WCa4ZVf7vKitJXaPilyao/sfSGwBdApEUpsQ0f5HkISXmn5Ef7rNXbzNWN/uXj+D+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195048; c=relaxed/simple;
	bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUPOt89noI01P84hmHyhUcVwM4Vjv4JMTxbwlQtk+xvY453wa/SnpJy32Lz5PADxhG0JqQuOg6yV3iREOf7IKnvrvVSL2Z5olDGRM+WL8WJOlFfK2ZTy+fEG4TJ2CSNG1ZW7FAgdljVIGVmEW5hkPEYkqQs7NalcZ3MwJqHgKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8xEcfSp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8xEcfSp"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4abc0a296f5so48719111cf.0
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195046; x=1753799846; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
        b=o8xEcfSpgJkAV3hg9+1JwZpIcfST5G7USIRnh6f4RaszdVLBMqQqvzMB4yTKT9BXg5
         7DlO4L/C1AeWPEBvnJlKaZqxrJS+Gkit3+rNtZTeTW/Tzlz1SIuCeJA8hvikgdGsAHoB
         NgwD5N7QpKzfjXG4evCTnOmvES7DjtbAIyYOUpTRcqpxaOQLsAiWd5qGkg/fk6YgbE7g
         tbJOiAV6+oqW3Zj7Nc7N20rGoXfBcZv/9rBEKH4KUZ+LeOlKPZElZHGckyMb0HQSfmly
         eAtC5YJ94bL5Gc0D7m4G7cJc1B1HKhtwPvoowy+pt1UDelWBa7h7aRst1gIeQeb8FXun
         wDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195046; x=1753799846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
        b=v0bbH2LANQHMYvm734qUETH+A3b9iamT1a+BIPN1MqF4tWcleoOoGR8EfJq2yD/Vus
         r72phOi4dbyMKmjip4koOfB/7XqiGS7AvVgflqWOxxJWZ1zVIlnYJ/uIQFe9DPYf5qZK
         ndJB+j/D0GmYXGFhbvgtIPNlPuDAN/+3F/xj/jkfzi41C7ho++BzQPv6evjdxXT/fLsY
         91Her59pApTiIp1Imh6RFxyb3xIM4LuaUYvME3m5amjuwUopSaWgevXDO2SV77yD9+Df
         SKTZ/VBpLpnNOKp13fSrZsO2ALsjDQl+UTvxzOI59yLNitYVCo7uJI2teVkSKPp5q+7A
         pPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmC8rjPBZyvgynawJwGzBa2Mb6n5uRFMY6Lu47JptAAFhQtZrdRJuwyRgzqcozdGw1+CH5kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbT6nXlpsy8DBxMsgih0G4FoK+DOx2ERanuQEz0lICPBf1kRQP
	8GMTas0d2J20CBwB3vCtfZ4h4Qr8FuZUnm/TNY9JyHZDX9RwxyO1JAzkubak6+KRUSCsu6EbWkj
	nK3u0OW60aziyC3BuOZDiTehSNUmO8/8HyxDrGATQ
X-Gm-Gg: ASbGncuOsbQ3+B305u7o4vLjdxwhxLuYrbgUhXajW5/xXcrl2TMpMPo7DUQ3swRDxK0
	NyseW9qXQU6Bw3H9OY5rNbt7FJw++JCP3y+MZgjTUWuoDqPCuEgm/qkHffIowTDUgvsZ9079YBd
	RYzF3pIhxey6YWlFbY76t5YGXdN6cPcRVaKwdwlh9D71zagJr2yxhFFVHwgHWc3J//YlaDda3I1
	eotIg==
X-Google-Smtp-Source: AGHT+IHh/lY3G2VVyGGsILbI95GYxwwe31jY4DMEtEPuVbiqIy2WoiqiCRLo4vbR/BymSRXtvDDARRkbJMlep7SRIZY=
X-Received: by 2002:a05:622a:5815:b0:4a7:6ddf:f7d6 with SMTP id
 d75a77b69052e-4ab93c7d56amr387332941cf.10.1753195045666; Tue, 22 Jul 2025
 07:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-5-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:37:14 -0700
X-Gm-Features: Ac12FXw_PVmGWG71LBM_RvH4ODSBv72aWxnT33PfI7UhVcDC69sZUBCPONqRMjA
Message-ID: <CANn89i+p45mE7MTEmf+_fYA_fKXnzMRXiDXNDdkrHVimcYMFRA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/13] net: Call trace_sock_exceed_buf_limit()
 for memcg failure with SK_MEM_RECV.
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
> Initially, trace_sock_exceed_buf_limit() was invoked when
> __sk_mem_raise_allocated() failed due to the memcg limit or the
> global limit.
>
> However, commit d6f19938eb031 ("net: expose sk wmem in
> sock_exceed_buf_limit tracepoint") somehow suppressed the event
> only when memcg failed to charge for SK_MEM_RECV, although the
> memcg failure for SK_MEM_SEND still triggers the event.
>
> Let's restore the event for SK_MEM_RECV.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
