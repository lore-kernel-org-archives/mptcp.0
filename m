Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9431F03C7
	for <mptcp@lists.linux.dev>; Mon, 26 May 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253997; cv=none; b=SFLjyUj/FUPWXgq3J8DANYBvlrf0Mn0TLCs/xLNClamhd7NKJDWJlnlxYd+IxBoAlNCpVAj/pSd2D21zCCvNLCGLjjBzmm/S2hYVVNzHbv1YCMBl3vRDVSQchkL4HI8PiK1PKL5rsmdgr1dcnVVO1DSQkOnFetc4537om4IvM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253997; c=relaxed/simple;
	bh=wHuTCDqGbQazXhYURFiMHlcs6ZTg1HV4SgDfCGERDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbpY7paNuEal77OuQ477KuzUPabzyduhpwj3IiYEch8Vdx8GuaHZcpv9GEaZdY1AeaRdrsQd7k3d4rux4I0nQ2aWuDBSuEGk824+0vJ7AEg6TH67B+VxvLhIoSNRlKDVgID9s8fPLg5pzRPqq3glDH4FSn9JaZatHYGhrnGmefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU69/bmM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU69/bmM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a36e090102so1131283f8f.2
        for <mptcp@lists.linux.dev>; Mon, 26 May 2025 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253994; x=1748858794; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=;
        b=PU69/bmMkFyk07h536IdRL3pzmTU1ku8J/rIJXAaRH97rcEoU7qhf/4iAtfxwIeqAX
         RNYXkkYVF98u4okka8w/2ZYHlmgfJPP3IZ4sFCtLvT95mfzBNX+9OALImYqO7Nivchry
         GJq/rs43d/QgtGXZCBjweqTRR8ULBWswJC+Rnqwdj/+ZITPkewyCDxACSl5r9FoMpkVP
         Dri0XWHpP7QEKs6a/e/1S2dPJL6V8Sol9KMpS2yz6Jul/szOrJzEvRFmo+LW6bcsghoc
         pO4SH/0T2cX43tmOZfI9WuwrpHMLCt0TqgEr4/OIdbxYCQicaYPBcO7sVeFbtyuDCVoG
         7zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253994; x=1748858794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPh1Ct6QshCKWmDEdMk7hCZKp6Jz8m7ODsFZr4dzpn0=;
        b=mXG/9O09nG5G7X7y5105Yaud55Dped0KHRF4LpQxDA/DJ0ovGGYuccPBpUpABoTyex
         0ccgJA7AW7GHWfgkXNnIp6IyO0YJ+1VEPp4IeKjGLLQYe3fK2FyIp1NG3+KQEXWNeBgq
         RGGz6rmkY3lBSwYI8DiQY6kgGTy1XOko1i4MELTgDybINNsDtxs7icb28aVofrzomeZB
         J84g7fKyzVJwVvHp7riGIuwE9EUyRCWETPLTd11LjlJqz4hKXkCqWhBSPj7KNpXO3BpS
         HvG5jNxnR1kJ4WoSdL2GAbQ1slVsHY8w8YyVAvEdA1BmGH7d72TGfNb0gbzCEYro+G4C
         6tNw==
X-Forwarded-Encrypted: i=1; AJvYcCXyLwviL3TIuiagSyUdydZcosY5yUBEVMYyMKf7UaPRIavsPe3owpGtsevHySWbwtOdYaJJ3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+k1wQs2j6ubaLeKH2K2ZfWtUXddCnXv9cPPACo3r5zhs8ngcE
	eloi93Irm2SpCrbCn0eH9BgMz/R6GHZe5ywtOBCXgIQSUXWFRvwzc08Y
X-Gm-Gg: ASbGncvLVpzcZTmsb28bl9UBkgvRNr1W66JJ2LQnHNlkjWm0oAHaKHjB2Gjatwl3Qbe
	nIOAte9543IMwXJIgqC1Tvh5gg/3SXHekji7dBGXlGwt7B1MVSv2VI6+EJ+HfUQ1jYSjjIct9gP
	zez8zDlnDKKu1FqizZoYZp0lXQze6fbssMnFCKyVkcYaGOqvYg+EWbren9HLRuOOcApx7Z52TM9
	YDCKQDHQ0E3ZOaS4tRpsQZW+cPlugetQQfeqqBqm6+Qi119GZmObiiBeVv9Ihl9WrePP4czNPh7
	r0IsIqZyORS4PHgYEfrJ2gcU4CEiohO1nxbMWnwBRcZb347fyfRDYKaF1qJG9u8O2/dlcQ+QfEp
	Cfb1Acx9R6SNnKg==
X-Google-Smtp-Source: AGHT+IFNZkvn3tGi7ARy4dpQ3TrKaZGPDzyR33srZYXPNzWELPLp52hjHD63j/jTAmYk0WDJMq4RNg==
X-Received: by 2002:a05:6000:238a:b0:3a4:d367:c5aa with SMTP id ffacd0b85a97d-3a4d367c798mr4219403f8f.20.1748253993614;
        Mon, 26 May 2025 03:06:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d67795eesm3561697f8f.86.2025.05.26.03.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:06:33 -0700 (PDT)
Date: Mon, 26 May 2025 11:06:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, Steve French
 <sfrench@samba.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Message-ID: <20250526110632.7ab3323e@pumpkin>
In-Reply-To: <20250526052907.GB11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com>
	<20250523182128.59346-2-kuniyu@amazon.com>
	<20250526052907.GB11639@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 07:29:07 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> > Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> > sock_create_kern"), we no longer need to export __sock_create()
> > and can replace all non-core users with sock_create_kern().
> >=20
> > Let's convert them and un-export __sock_create(). =20
>=20
> The changes looks good, but the commit log including subject line
> is rather confusing.  What you do is to replace all uses of
> __sock_create with sock_create_kern, which works because
> sock_create_kern just calls __sock_create with the last argument set
> to 1 as those callers do it.  This then allows marking __sock_create
> static because all outside users are gone.
>=20
> Please state that, i.e.
>=20
> Subect: use sock_create_kern insteadf of opencoding it
>=20
> Replace all callers of __sock_create that set the kernel argument to 1
> with sock_create_kern, which is the improve interface for that.
> Mark __sock_create static now that all users outside of socket.c
> are gone.

I'd also like to see an explicit statement on all these patches
about whether the created sockets hold a reference to the namespace.

I know it is documented in the function definitions, but the issue
has always been that the callers get it wrong.

=46rom what I remember, as this point in the patch series sock_create_kern()
doesn't holds a reference, but by the end of the series it does.
That just has to be a recipe for disaster and pretty much requires the
changes all go through the same tree in one merge window.
But the code touches multiple areas and the changes would normally go throu=
gh
multiple trees.
So it's going to be hard to get all the acks and the patch accepted.
(Unless you persuade Linus to 'just apply the changes'.

I think you need to look at three merge windows.
1) Add new function(s) for creating user/kernel sockets with/without holding
   a namespace reference.
2) Update all the callers to use the new functions.
3) Delete the old functions.

There is no point modifying the callers twice, and the commits need to
explicitly state whether they want the namespace held or not.

	David

