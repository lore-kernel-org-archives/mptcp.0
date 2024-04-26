Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C7C13B295
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115438; cv=none; b=CtyvkW1G27iOiOkydOPhOzLFcfSSD2fYOID0/pEDdAFI/IZMp7Wo2t2VnWcedFe1qm2gOZ9Ib/0YXbNcSbB1f6kBlluHLgIT8s3cIIjYF3qGrQ1UCM22w+9w22UrqlVOcwZVWXzuaq/ehtNnffHve3rxs4miZuipdGTIa+wgcec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115438; c=relaxed/simple;
	bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULxN2U7DGvqJuAIMoqIpE0c5Im2RAGVnL+5H7641iuf8iIyQRmq/tiHFwpk2WfTGnayGHic6GPcwtUcfPHIJ5b29kEM5KXisr351zB60s6OhsSguXT4gdZWpnqmGUarl25BRLaWNgvp2dYcQgjpOwKer4RZAHPRpyRbAqBZH2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAND7q+k; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAND7q+k"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518948e1ec8so2409e87.0
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115435; x=1714720235; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
        b=vAND7q+kNnVGIKSGkVjwRRnyVLXTcjffYeFlRYREwyZH0MTWpSpHbqbmR7BXjDPolN
         FkbF0AteRGP0s8kvwQ1jQdDDb9qo60knajLANX9oTsW9YFgWamCUFE4VG7TfPZ6VAd96
         7LHAgY1h87JErr1pFRWjLRJbu75RDYdGxgf1FtOZh6KU+Al5ByW2ZmS1WJFOTWmqNRj7
         tpojqv3wjkeABDNl54kTgkmia3rvG9bJNIXKEErD5OE7nFw0Azp9twMUKW/qPSx2xDfA
         uH1OMAzJyujCb7tavMIGzZuH77ki03bjqNExEVvqy4q9skM0CqhehVfLkwtMV5cbJwnI
         0how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115435; x=1714720235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
        b=eL/7PH3507h1LKZ88Pl7Mc5ttfSmTyabAh9saSEEnJG8QHxx8xtHEfrmlUKXFbiZDW
         HZ2C/mdaUdw2sCCGfuj7yjY/e30mtydupLokoC8fuOJsHFupjoFzHySlklSboXkF9rDn
         43uPmxdhbS0uGr3+vnTfuSQUiWqsVpuc+5Gtw51RJYXch5wRtdbGK+t61wxa7W5gKlFG
         uJdVgOC1FBP7Sn0MEwx91RwExsH1AwqO3otyFNvhiT1XmztD5nP6qHvNv0Oa72V70qPb
         em8VTO5toFGB+0VjOEJczCRpJpoaM52bFCYMxgb9/mf99jOXz7/rZOvBXY09qKTJSebr
         gMew==
X-Forwarded-Encrypted: i=1; AJvYcCVVnEAXCgPmoMcl/ywMQ47DHQDEKfEBg/ffsPTt7EGIH8UNiOXkFAoYJx0LgPZPLOmqHXeH+gn66gkfbaVp3cTtUX9SldQ=
X-Gm-Message-State: AOJu0YxiHuFnISfIp2GpBSenZrhSaewoUVNrqXXgtep77Qse11m+d9B3
	4VpL+y/HWrOuym6uJwdngHMG1xy41wk8hpXUbfxk80MlTCN9LdgoSVzNZBzYVcbNFatyL2uMz3a
	0P1ogaLChPFTDtx66Er13gnUkbLAoQQBM9MdP
X-Google-Smtp-Source: AGHT+IFLgpcyXrDmw4mPYNfyBndZ+UooKXi1ffmkUY+z0h851PXJpHkoqiepekOpKxRIe7dBf7Vsq7Vu2v8cQmWJEz8=
X-Received: by 2002:a19:384e:0:b0:51b:badf:a650 with SMTP id
 d14-20020a19384e000000b0051bbadfa650mr87566lfj.4.1714115434548; Fri, 26 Apr
 2024 00:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:10:23 +0200
Message-ID: <CANn89iKbzuPGN=M4YcE5gFGBXDR+DrDigf3E7FfGSr5ac8u=WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/7] rstreason: prepare for passive reset
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
> Adjust the parameter and support passing reason of reset which
> is for now NOT_SPECIFIED. No functional changes.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
