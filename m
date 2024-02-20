Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2677650
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452236; cv=none; b=D5vY4wBZUt+42w0gBLRzbB9oIQjWt7cVzLmnaIfNjq5PDtiShV7UbJi+CcgAXzBVGHfitt7r+vFLVQU7vYxfL7Ce7D/7ZXknmOjMWjqViGNiJYuHAbowSbTURy7/QhuFkp2hcN0InSjxDED9E6gPP9mB6BAsEkmeufMlLb73LQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452236; c=relaxed/simple;
	bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbATFxVz+dszDmZNO5GuXx16cvdyjE6rqEscCV0qdTPqKHoIK84rn3rtpyeDqQ9dBwihM4sbkzdKJNhPOrX9dgzeah5/uXr92MlNeqRbeTrv+PgrK3jB8vU3/T8/fGc+C2FqBhYR8y2+g9rO9gd+e9Z9myqZYSpE3TYvyVNlgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVB97s49; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVB97s49"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564d311513bso968a12.0
        for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708452233; x=1709057033; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
        b=uVB97s49LOmhu60SBXAXu/6wutbwFH+YZ4/FaX7YuMkQJoMgNJXT0UD4nUqjB4yaAQ
         dbZwt0uW2NwsAELLefaRVYpak4XCGDDAkffoqkZC2apQGsvVfsOPe4gA+g2jGUqEG0+0
         D79VJ1sKUHQqWnCpjF4RuJfi2f7jD9dbtMKSR4L/7cHBnqiG5wOsckRcSUT8GpWehjQI
         sAMtgoYlI+XqF82L1G/7TUr02hTHKDotvsAN2VK3YfOh46NXOM4OoHhz0Q0ik2jJv7eL
         a3GZXzb3C+vuCVngr905CAJa6nPO0VT9TfpDwWU26CYolLzU9IqaAl2A1U1bJrxukMwH
         iDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452233; x=1709057033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fnZGcPGFETnd66ZUdGDszP02JN9rYSHEhGIDwY6l4w=;
        b=AqFpKbUqRGis+j0U78c9uKgrgzPcSln0RfS+Ca+Zff4I/sCZQitA5YDdCcpayQl8YU
         48uoFuH1JZvYDnWT/x32kpG5NOaK0xjfeBihKKjy+gEKlFms+m8eMvNvaeXJAq2CFWk/
         c1EodLCUYjg3mRq2C15PnreOfEPeQh8PUBsX3lqsAnwgPsLUwspnAtmfowhkEP6DVW9a
         0QyJeUeZH8xz9FHwjx6jJPrxci0i2f2AusVQ3fnIMHB0OxxcrLv4Ap0ptUmVSzwki6Fg
         pPeQBmaXyfsz9SQdd+qfwwLuZpFOAOuWCc3AJwm1Dc/mqcN3Fr3zBuFLy5iwIhceCppK
         fBwA==
X-Forwarded-Encrypted: i=1; AJvYcCW8MjyXMqAdSz4BfqB/HNRqhpNs+4KL9lrmDCooOina516uU/yUE5rCVcrF2506FraWtkkX8aEZI2X0Cw3QsCDJGF2IB/c=
X-Gm-Message-State: AOJu0Yx3sZKQBbn5pcIaSuqxIa09ohZxTXw/tNGGmB4onuy5QoQPHfTF
	diHV9HAvYkNlWwPSIcauwK6Cxtmz9mEfOGJ/l6WOo8xsx5Og1oP9t0RBpPXp2Nn0vKTOND/uIU2
	lonAw6f/krSBhFP9CGpWDMIulPnTFQ2fK5NTqA7qEvu7VZtNa7g==
X-Google-Smtp-Source: AGHT+IHw5T91YrU9Maq/ZbuDhD+cF96pVCL0Q7L/zZJ2yh3VVoEnWRHnH3fhRfCS0slaDzwuX66xPIpbpON2ixt2PFU=
X-Received: by 2002:a50:8d12:0:b0:563:f48f:a5bc with SMTP id
 s18-20020a508d12000000b00563f48fa5bcmr441060eds.5.1708452233017; Tue, 20 Feb
 2024 10:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
 <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
 <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
 <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
 <CANn89iK72hE16sQcGPUFG6Am_V-77PNJOYHgeAA6M+SD5UO13A@mail.gmail.com> <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
In-Reply-To: <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 19:03:41 +0100
Message-ID: <CANn89iKn1U14L1u2w3VwenRt0S4QnXJhiA5PvMF0s41d8nS6Tw@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-02-19 at 19:33 +0100, Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 7:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > Thanks for the head-up. This later option looks preferable, to avoid
> > > quit a bit of noise with _ONCE annotation. Is there a syzkaller splat=
 I
> > > could look at? if it landed on the ML, I missed it.
> > >
> >
> > Not landed yet, here is the splat :
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.2/24141 is trying to acquire lock:
> > ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> > tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
> > ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> > tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
> >
> > but task is already holding lock:
> > ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
> > include/linux/spinlock.h:351 [inline]
> > ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
> > inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038
>
> [Sorry for the latency]. Yes it looks like that checking the listener
> status will work. I can test and send the formal patch - with the due
> credits! - or do you prefer otherwise?

Sure, please send the formal patch, thank you.
