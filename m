Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4C110D
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+UID1Tw"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-65b0e623189so9040766d6.1
        for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 21:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697172162; x=1697776962; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eXZNYajYxhXTb3UBWzzLxXc/EdYltPYPSY96CeeHUM=;
        b=M+UID1Tw/Jaj7mK5JM8dLBm9Kps5bJCkPN97rxAMDAPoUrhJO5XWEE3no4N2nZhpBB
         k5fGnPUwefD+HrOCcstinvdQK2DNoE44Vl5ZJvK+lso3dVR1rdIiUpf9VRV6so0XIYud
         Q93K0hu5+GeHxx9N68WmvoSL62pKUf8DSFaB5Zgl6fe09yfM+OeNC/U2duaaG1tA9Hec
         jCMfqAt65l6ap0aulM9CAlQDBtrU9uWayzPgFuKHZlhyENm/wqx/M0QDdMuMVEjG+Kd6
         uR9+TXaPSSshLvjJx4fH2g71CKJYkn83qUkRSo1XhyDY+yYXp6edStwCr/9mMt3qxGgB
         zDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697172162; x=1697776962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eXZNYajYxhXTb3UBWzzLxXc/EdYltPYPSY96CeeHUM=;
        b=w4XQFu78w5HLBndqAOlONrPNyKqW7NIw9iYdLdZpzVgjlNLMrAEkHJta1AD1TB+af8
         OArvnEzjX4NuhsoqN4PYG3aOlNEjViGjqCiI4jlBEaiUIXH9OF4IRUxwH4XL+EZ9Oa75
         h2C8orQmqC0uz6pUTzeIo6cVAN6TLvXRXFFLox7EU3peDKdFqA3x86tvfBtiqtFjMnmz
         lnXFDxn4NViE9qeuh/rp2fZyfZl3/Yq06TcIg5HC1TfM47aiv/50LC6EbQ+KfLxW+fjp
         UcDM506YbPBpjBno3aiE1E+IIjFM/S7p4oqSDWFvgUNUPCiyCF7yEVnMFvTgPQleyUBp
         Cx2g==
X-Gm-Message-State: AOJu0YwFHy0JKqCq1lMx7J0s6gof1fmhYT2oWAuy1vrUVEPDz0vnrl56
	285fHrAlPbb02yPlpPkeFmfQmkwR/WY8J4TNTw==
X-Google-Smtp-Source: AGHT+IE9PsZH1NhRmltNTrG8z6uPRtXN08y0szaTE+r0rr2NW5xbFQ7EibXW6brQBi4eyO0tZwCDZ15ktr1M3kNDWSw=
X-Received: by 2002:a0c:aa0c:0:b0:66c:faa7:c5f0 with SMTP id
 d12-20020a0caa0c000000b0066cfaa7c5f0mr7984319qvb.63.1697172162578; Thu, 12
 Oct 2023 21:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
 <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
In-Reply-To: <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Fri, 13 Oct 2023 12:42:31 +0800
Message-ID: <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are waiting
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, mptcp@lists.linux.dev, 
	Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
In my view, this patch is NOT so good, and it seems that trying to fix
a problem temporarily without knowing its root cause,
because sk_wait_event function should know nothing about the other
functions were called or not,
but now this patch added a logic to let sk_wait_event know the
specific tcp_dissconnect function was called by other threads or NOT,
honestly speaking, it is NOT a good designation,
so what is root cause about the problem which [0] commit want to fix?
can we have a way to fix it directly instead of denying
tcp_disconnect() when threads are waiting?
if No better way to fix it, please add some description about the
difficulty and our compromise in the commit message, otherwise the
patch will be confused.


[0]: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting")

On Wed, Oct 11, 2023 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Oct 11, 2023 at 9:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > As reported by Tom, .NET and applications build on top of it rely
> > on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> > socket.
> >
> > The blamed commit below caused a regression, as such cancellation
> > can now fail.
> >
> > As suggested by Eric, this change addresses the problem explicitly
> > causing blocking I/O operation to terminate immediately (with an error)
> > when a concurrent disconnect() is executed.
> >
> > Instead of tracking the number of threads blocked on a given socket,
> > track the number of disconnect() issued on such socket. If such counter
> > changes after a blocking operation releasing and re-acquiring the socke=
t
> > lock, error out the current operation.
> >
> > Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiti=
ng")
> > Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1886305
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks !
>
