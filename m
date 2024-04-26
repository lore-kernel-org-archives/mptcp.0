Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35EEACD
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115403; cv=none; b=OFHVJi3Zv4LJZasJiMOYSNuR/s6Usu1pCMGTrra6rErO4dt6AhiZREZewWnWWraTSSk/d8npAyFzABMdinJSlE0Z4t/Ra3LPZMsH8DK3t3JfAqyJuxsG2xpQDONCd4Ep72Vhr2uUpRGfOafb4gzCRExOz+XGJDIHai3z2KTXFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115403; c=relaxed/simple;
	bh=p61/qeqHYLy5frKEp02v40mvBebGAAq99s5Dtut/6mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0Z3U1dKujBWTAFPk7+xyr9H1o2fmw3i5Shp+/AQnRBLhIl9tSNfCmU2cYGppyYz0D8cKu+gbs74aD9b5FI7/8kWvB/jITE17sXbo5SnY4bon0pr8wpEV4ikUByAMnVGImMElPlr/2GlfiRrbrvVdbgk5SfSqM84FYMB1kw2juM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpFIjz/c; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpFIjz/c"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9027a12.0
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115401; x=1714720201; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p61/qeqHYLy5frKEp02v40mvBebGAAq99s5Dtut/6mA=;
        b=YpFIjz/ctGI89Z2dKNZOM/2bewVBSa1aHmB40XBj7GoNr7qg6Rug79BWv24Ykihap6
         6ywbX5PdAT4ly+iC0XixCLC0uUqY1HlqrHQSJbCGJ0lNdIKl4XwuUMPZ3y16G5dTuPfi
         3hsO5jB8VYMndvI4WCA8LYxsVSbSTsd7kGrkMmJQuMz355ou0N/2klQ13ZAAcNujtju1
         R9JoU0j4ctjHJ+TSlOnEWiUKlrxFIYaCRvt81MBsZK1rnvPZK4mEU22e4rZXs4Kihzpi
         b6Q7B6waT9UCADYm9oedngjeLz3TJwzy0o+sTiR9cXMpYo1DDfjKwmWkzjIZOhuyBKdE
         8N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115401; x=1714720201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p61/qeqHYLy5frKEp02v40mvBebGAAq99s5Dtut/6mA=;
        b=OIKAIU1ouTNWkYgWbza240NQEh3mRs5hXA4tqf2oy471Vy4n6fb3uYoXGEOgFinEqd
         T28gr0SzOQaTMymSksPyL48UpW5t+3BrC86EuVGbBJaSN5iDlSXswJwR8/ZitBvOmral
         iKf/pC1CRLWmI4S+rx9PQRXhMwnVu6KkQDucQoj70Rr+jj3JAjqjdhTNOJOb/4Gl897f
         z5WcJl3LdQZCA0DNB0UozA5EKX1EPgv64/glEh2xc7WvVLcBQLSeZRUVAbqVJauKHCKo
         ZXPvw65aauebC5rtTqsOdfDG7nc6cYSyF46Y2yMDAnr33DcCkXouzBkX4CAE/ANrZNbY
         rhqg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1kuQbxh62dWGNK7z/pfpLsutJvuAMHDAuuqj7OoZZ9q6RYBnLbQFdiU4Kbf+INhS7FxeGYYiFtYvMvpFK96R8MeLFQE=
X-Gm-Message-State: AOJu0YyS9aFwrZIH56utlXa/xsTtZBBViIMkF9n23jqOJ5G2eouKNQXy
	43tLOY8/H128RCAjJML9qGeF9Rvpah+yWRaGv5dQA+vuv0Y9F7l69s80IrlL9oga0+pYWr0Sh+w
	ppriqLgLr7WqnEaKKcqMCo6KbDfbO55l7rQcD
X-Google-Smtp-Source: AGHT+IHuNHcmCc7KkZwueD0UdUaftzjxD3dk9jc98IZkb4WuQLZFgdRK+7VjwnLqz6wusyhUrr1e/xc5Q7Ih/J9/ANA=
X-Received: by 2002:a05:6402:c6:b0:571:fee3:594c with SMTP id
 i6-20020a05640200c600b00571fee3594cmr83432edu.4.1714115400548; Fri, 26 Apr
 2024 00:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:09:46 +0200
Message-ID: <CANn89iJywTXfRdGLi1oMPwz4dVYbA5TewZC8-GiG=b7dNv9FOg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:13=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add a new standalone file for the easy future extension to support
> both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
>
> This patch only does the preparations for reset reason mechanism,
> nothing else changes.
>
> The reset reasons are divided into three parts:
> 1) reuse drop reasons for passive reset in TCP
> 2) our own independent reasons which aren't relying on other reasons at a=
ll
> 3) reuse MP_TCPRST option for MPTCP
>
> The benefits of a standalone reset reason are listed here:
> 1) it can cover more than one case, such as reset reasons in MPTCP,
> active reset reasons.
> 2) people can easily/fastly understand and maintain this mechanism.
> 3) we get unified format of output with prefix stripped.
> 4) more new reset reasons are on the way
> ...
>
> I will implement the basic codes of active/passive reset reason in
> those three protocols, which are not complete for this moment. For
> passive reset part in TCP, I only introduce the NO_SOCKET common case
> which could be set as an example.
>
> After this series applied, it will have the ability to open a new
> gate to let other people contribute more reasons into it :)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
