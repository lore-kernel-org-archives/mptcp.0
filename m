Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D69111B1
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 14:19:46 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso74945e9.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685024385; x=1687616385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY3OLocOSEgHA4fLQ6+Y82/v18zp3KYq0EzJK7Sx6w4=;
        b=wHkJLBUPHnTjbEYVjNmSFBfrwTo4TZCcKmMspyHDJqkEgtEn/NrM7MabqcVul3Nqno
         Tj3bI4zoJ6l4Hg9bQmHhQQbBhAlRKcDm8amOqdotCQ9oFlP/+FfObQ0hng3dnX7Q/MZN
         zgGYdbCaPMvQmlkltsmx7FD2VjtKEhvmJCJlXmwvBZuW6dSptjbG7SRNG1Fm7qQKN4yC
         liMx8NahKkYKHcLA5WQznaj+nl+rQ5jq8bHdUqe+SiABS/vuvAbc4CowJ81V9pztluPl
         E5+xBeURqDYhzDTgK1vcmxkBvMDxMcF/cgTRWGzjM42BHCjiZvvDd2GvPhq5Nbgt/3q2
         /3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685024385; x=1687616385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY3OLocOSEgHA4fLQ6+Y82/v18zp3KYq0EzJK7Sx6w4=;
        b=Vf7Zkzu/WJOU0T5XSI1ioh+Q4Coai5awu83LMKQ3HZiPyX/t3RwTzH/jWpQtN9hNOq
         f3v5gw2y+zr5lg08N1+ahnF+9Dslh/YId4xO3sVnspw10j2AHYMwJCnpu1RMLk18JBbq
         YMMNeHXRtIP1RLw0Kfo9WkNM52dDCy9lVYe7RHWthFxg4TeBDOnwYgzChQP3FMoGIhGs
         keZiaE1VUgaWYHRUD8V27t4sVrMlG6pU1crk3H2W8vCrDONzCdrNTEh+eHlQhWSDg8XD
         dEKBbIZDCnrEMlxB/mnrs1hurMQGGBD0rAy0o/7HJ9Yh7pwDlHPs6posRlIj4rvOVl19
         +0SQ==
X-Gm-Message-State: AC+VfDxnG5/+M81y83NRotU6X8EcD7aeSIAO+OrO0VjUccaZAz36u3rV
	mxsCgrnKKmKjFoR677K961JF6/Xp67yhtaQDNgdBAg==
X-Google-Smtp-Source: ACHHUZ4KFnQzrzknp0KdGkKJEouEDAIY/mR2vIflKYoy2kK41wOoC3lIDyruRoVpOijJkXCW0hl4A17q3HS19WMLAxw=
X-Received: by 2002:a05:600c:a0e:b0:3f1:9a3d:4f7f with SMTP id
 z14-20020a05600c0a0e00b003f19a3d4f7fmr147224wmp.1.1685024384734; Thu, 25 May
 2023 07:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230525125503.400797-1-leitao@debian.org>
In-Reply-To: <20230525125503.400797-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 May 2023 16:19:32 +0200
Message-ID: <CANn89i+neca0ApNxRdZCiTMkwy-5=0mnOMM=9Z3u78VPNw4_fg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
To: Breno Leitao <leitao@debian.org>
Cc: dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	Remi Denis-Courmont <courmisch@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Mat Martineau <martineau@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, leit@fb.com, axboe@kernel.dk, asml.silence@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dccp@vger.kernel.org, 
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 2:55=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
>
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
>

 diff --git a/include/net/phonet/phonet.h b/include/net/phonet/phonet.h
> index 862f1719b523..93705d99f862 100644
> --- a/include/net/phonet/phonet.h
> +++ b/include/net/phonet/phonet.h
> @@ -109,4 +109,23 @@ void phonet_sysctl_exit(void);
>  int isi_register(void);
>  void isi_unregister(void);
>
> +#ifdef CONFIG_PHONET
> +int phonet_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)=
;
> +
> +static inline bool phonet_is_sk(struct sock *sk)
> +{
> +       return sk->sk_family =3D=3D PF_PHONET && sk->sk_protocol =3D=3D P=
N_PROTO_PHONET;
> +}
> +#else
> +static inline bool phonet_is_sk(struct sock *sk)
> +{
> +       return 0;
> +}
> +
> +static inline int phonet_sk_ioctl(struct sock *sk, unsigned int cmd, voi=
d __user *arg)
> +{
> +       return 1;
> +}
> +#endif
> +
>

PHONET can be built as a module, so I guess the compiler would
complain if "CONFIG_PHONET=3Dm" ???
