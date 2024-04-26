Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1562F13A89F
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115501; cv=none; b=L7vLNW7cMEpkoZvODLNVoeyrN39FKZOaR8UeIY8HXi6rc4ZLlU+vUgGgBmrrl3PlJhZO01ana2Bu1y4jPK7J6v/jaQQFOmn08T/gIhaxn3vHycCuI0PDKN2NRSevgJX/8f8nH8YCnABdTFj/pqGdwXCFrer5ce1ejvIEIWG5sCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115501; c=relaxed/simple;
	bh=Nd4jaR/42dIYUGyfQPfs58FKm+xvVcQuYdvOUDI7cZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqEJ1WAwep2uP3SptuSvO7LPhbigBaCsisil+13jmWJ3K6V4nk1mQ18ewndBx9OAbooL0gh7i+N0iEzmhw59KwQba5nuYi9lIBh1ue0UvN67BDDhsyeVeeZPyBoocKWC4vGpQhU9zfRNEpyyXcGHMv1bnXeT54FH94TnyO62GzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJXfq9/x; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJXfq9/x"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9057a12.0
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115498; x=1714720298; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd4jaR/42dIYUGyfQPfs58FKm+xvVcQuYdvOUDI7cZQ=;
        b=EJXfq9/x3VFZzjwwOOZOQNcV4UA+v3G/HZ9DZ6EJePCwB+w2ry0KjGlxvt3Rl2QB6X
         Om+8099VSfSFASSqROQVJnvx+Q/rOgDJ3Coxb+gIzl/BGBhj0bjmkgSNtNHsNqt4vuAf
         +t3/OqqCq4JArSXAy5JZzEkCx3iTwbjgjHqJgmSqScQC/L0vpdwGwdRABgiQnbYGSZVA
         6Z1GuuWSbXuvkgfsXxorLJLZu8jlKm+/dtwGhYuNmjHycFpSkvBpXLEBrzZSC8Rs55TK
         hfSKnKBTh4hxzN1b84t8Qql0VCBSFsVLqGvdgXr9CI5ake38aNWTgqX34HJaR4rf+Qpy
         g1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115498; x=1714720298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd4jaR/42dIYUGyfQPfs58FKm+xvVcQuYdvOUDI7cZQ=;
        b=Oy4HIRAhWI7znuzn3HWs5MZ+Ym57t+5ZZ4R/DafJ9oPpbSqNYvGDbSESkgQH8dPsl+
         cN2cKr+lwncyCdCRxkPr4aiwMEU3B1wRoziPTzmyQxFf6611PXrN+enFfX2Zlp39+hgn
         LR0Yixx4pNAwxWaduOO82hNMBKDnkOSlE4nXolS6bF8aLI0bXcbJHuu44v1UKlSw6WHk
         cA8oYZoYaZOQd+LW/4U7mTDXMAbZ4qe+BfaWy/BxV+AR6khcHy8v/IJfmFboleG5yEAJ
         Ry4Zy0mcgnUDc2TBcD+cIwuUJ4oC3HV+DIdYytMMmaxvTmseczchrRdDMr6+3FNBRLq4
         b77Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmJSnTf4o5fX5HXRDr9jZ6kT7xshbEol1mV6RDKLf5/eaziU6Uz8Lla4k6AAFmQHGauhE0HQGBRejyk/nnrvJ+BMlcRCA=
X-Gm-Message-State: AOJu0YzqAQzv7Z5CgaBLLNqEBWMfICxxzVX5fwbXx99xqMiB3C/yCrbU
	XoO6INv0ff2J2KvztU74mnjxjE5LXwdIwNRwbd3+eM4inzcobouMEcDKshRcqBprL6wH7XMIdoH
	CuXpOy7wLxQ3dNbar9S6KY8QP164BXSe53kPR
X-Google-Smtp-Source: AGHT+IFGFOVqN9rWuwqHOOO+oH76cLWmGLatqVO6OwSVaACVskc25LUiElBUrODWl++2MM5fkppQkcjTxQG26Gykqd4=
X-Received: by 2002:a05:6402:c6:b0:571:fee3:594c with SMTP id
 i6-20020a05640200c600b00571fee3594cmr83544edu.4.1714115498355; Fri, 26 Apr
 2024 00:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:11:27 +0200
Message-ID: <CANn89iLEAyZVBYd+Sy=y4sxvqBEdev-VhJvW9k4eRRSBKff1Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/7] mptcp: support rstreason for passive reset
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
> It relies on what reset options in the skb are as rfc8684 says. Reusing
> this logic can save us much energy. This patch replaces most of the prior
> NOT_SPECIFIED reasons.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
