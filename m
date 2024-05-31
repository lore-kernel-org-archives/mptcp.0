Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE82869B
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136776; cv=none; b=QbgekDDWH41O5xQyPHGqu7ds1NiUuBMWd5Y3eOITdIrMiT3Imc53y8gAETojQ9pn6oqUgaLz3ej/TowR2RadCYqbvTMfWigNKXu6I08/ZPVPq7yr2ofsgX6ZnGHy0jdtvvqPg8nTeCIMa6vaSOWM3DojmkuFnqp76Bdp7vwLuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136776; c=relaxed/simple;
	bh=t1INJeM1b5EhdcoKhwPK74FNBNyMwEAza5KlFdey1uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyZYOq/1OpvFpFJI0nFF05mJu63889ACC3Up6UKAjkkotxw/HBr9la5EqgSCNM5LE/BH5WaQ04mFmyRrkDhm3W6S5Of+tE+nmnTA04qHoLX93VXvkReFbdMejfC8M9RGQLDreGpMkVf6qBSVE9dR7iw7wgttQdUADtIuEV3DiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRvlJ02m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRvlJ02m"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso11074a12.0
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717136774; x=1717741574; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDDaap/Zd+yl4UAhzv9tDTF7kK2BXXfxpdxIRsgYILU=;
        b=dRvlJ02mxPpSveGamH6XaNDMe+aQ6N6T3FReTHFskx1BtEEd2YrwmIqSspI4yM2jeZ
         3daHZQsHCdMmDoCvpLQJ7AGCg7REhC3mtgbEbNie4DbQN7FFws7oYKp7X66MoSegRfZB
         eoKd/R2La1licrYVKiwvPNIePYf7DbOw/QbBbumM5kcQ/zvji0mxHdR3FSdqI7jT1+GS
         F1g/mKuXKcTTPK0EYFF9cylPUCzvY8wRb8Ah1f456wWaWIo3jV+JN98MWwIdNGh/dnF1
         POvxG7DkKCTD0sul2xuAO0/kDcwp1RAzsEno3P+DN2gqgBeCLa2Ktv2h4lR2Zkwemz6f
         +c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717136774; x=1717741574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDDaap/Zd+yl4UAhzv9tDTF7kK2BXXfxpdxIRsgYILU=;
        b=RmbbolKEZeI4OSDs+LX+l7KPbt29okfzf26xnQqCRBMu9YmFmZ7YHDsKtRUpnSNf2B
         W/gEJmDHZXN/2LXLJCkR+XM6Mwj59HsqYLTjkGUjpJ16Qi0MRnhnyhomZSu78awusKcR
         hYCBfj3aDaCoEyj2EyoiBl9mILn660j3jiT4Uda5PabahfI2dG6hnW2vPEP6IxMY51cJ
         btDlv1stO3YEH1wQVAm7kKc9sJqPVIXzvQau7JnB1T7pGwiOnbu3Zl+GSkSuAOslwRpm
         RU7OZb+MAQhL3ekNi+U2fAVE8Px/NX0iC1WvkOLfn8e1BUHigvaUjGx0nZZj3pZwdreR
         lx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk5rwkrO+5+JLLHb8E+syvr2vkxHKt6T/OaHJ+h8I8grjxHPf8HEhZolx5kNKhNlY2FZ87EYCzH1Kx+BpDgMetGmkDCnU=
X-Gm-Message-State: AOJu0Ywdt+zRQDDDn77vl7R8J4kxszx0GVOgD5FXq+vR2d7cjrA3B8YK
	2gmEWd41ineFoq1s85dC5kXpe1s5yUGUy7CoY9fLViNd25T0EuSzWAQUVWX6Q5oFV3lAyFMM9us
	Af/AG9oaJgVKMBeSbYtxiuQaly7sPcbn1OrUU
X-Google-Smtp-Source: AGHT+IGgorT+ZMUlhUGGf5mKNimyLX32wJFSSiFwPxNqEI9U3HG/0UnUjNNIjCYOCRfzeynUzXtGomqrq2ZpUaDgYUg=
X-Received: by 2002:a50:fb18:0:b0:578:4e12:8e55 with SMTP id
 4fb4d7f45d1cf-57a3785622fmr60079a12.1.1717136773372; Thu, 30 May 2024
 23:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530131308.59737-1-kerneljasonxing@gmail.com> <20240530131308.59737-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240530131308.59737-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 08:26:02 +0200
Message-ID: <CANn89iJZo2R3eOVvWpo3-5aoMaaEtzxH90H0iv0FQXPUz7aJyg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Like previous patch does in TCP, we need to adhere to RFC 1213:
>
>   "tcpCurrEstab OBJECT-TYPE
>    ...
>    The number of TCP connections for which the current state
>    is either ESTABLISHED or CLOSE- WAIT."
>
> So let's consider CLOSE-WAIT sockets.
>
> The logic of counting
> When we increment the counter?
> a) Only if we change the state to ESTABLISHED.
>
> When we decrement the counter?
> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> from CLOSE-WAIT to LAST-ACK.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

MPTCP was not part of linux at that time.
