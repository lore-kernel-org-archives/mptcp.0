Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C28BE0
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 15:35:06 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-316d901b2ecso382565ab.0
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680795305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUL9Ul78Bpb3XRyOISIrcWSMNz2ErChRMmovjR4Alg0=;
        b=OYF148h4Nm9P6PgvskOIuWTx30F1Bwm7sbtDJbrJbROEL6DvXKusP6nniCeRlURmqR
         Bj2InPvg2FA4L1hHmkdJMUGoq+ezpYia8hiEp0SJQBf39ETQ75/GR2XsYCc8SFs1gUGj
         Jf4DLn0zPZ0GlGNIpf+McheP0yGY5MwfsfoMtXPV96d4guPMxk/R7YSuetOPL3y+1scw
         En0Dk0K+jo9iVfkcLHvTAX/VoDqS7L/4lxFgnddiTGSXicaTmbnwBfISMqbET7wnlqlr
         8lZFgnbtACkUXk5Z9UmfE1fEuCigYlm6OgLjM5ppw/fUxFUJ9+u7Rmfu02TIZR1YcTUO
         49CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680795305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUL9Ul78Bpb3XRyOISIrcWSMNz2ErChRMmovjR4Alg0=;
        b=H7Lr8OTKNVqUUGPwvecBb6YGlS19VRRHYIi1JkTRjr8/nLUUZ1I+Ieb0SUXCXQgEwU
         l7KVy5jVD8v5XR0UMQvbIZjImle9Vkplsjgw+WQSIH9MXyB6por3jaDERGIKY+lhSLHV
         mbQLxCymHrsjzkte9gRNOV1lc6iXgyFNvM9a35bF0y3e7y3jSLyZ9nobAPIABW2xwujq
         QV9hri0uPqn3rKKQVBiiLhBy3CXtjEo0lw4in9IwUfg6qbgv9hGDyDhpb7LtHfYWyiVV
         LY5SMP6mnpRtCe1B8j/dMt9fI7H8Jp+7+A702CZJDOR2qZih03dZaO7MqhXk1uEPTEw5
         bn0w==
X-Gm-Message-State: AAQBX9c/482GXejwFAbPo2ziVWyMxhzvB7qLR+u4IzqQ/LBap4dt83U+
	zrz0qxXYvD4rLy4bUm1OfaNXyZ820aeRJ5J7amYtBQ==
X-Google-Smtp-Source: AKy350bLXM1iysCDol/VAUBxZbdWNsWUekgKrBjhx1FHLZIm5wLO/EyiDgMXj5s262GeacHOp+oPA919pqPuO2gqhqY=
X-Received: by 2002:a05:6e02:216b:b0:325:a6fe:11fc with SMTP id
 s11-20020a056e02216b00b00325a6fe11fcmr223040ilv.17.1680795305527; Thu, 06 Apr
 2023 08:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230406144330.1932798-1-leitao@debian.org>
In-Reply-To: <20230406144330.1932798-1-leitao@debian.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Apr 2023 11:34:28 -0400
Message-ID: <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com, edumazet@google.com, 
	pabeni@redhat.com, davem@davemloft.net, dccp@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, matthieu.baerts@tessares.net, 
	marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 6, 2023 at 10:45=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> From: Breno Leitao <leit@fb.com>
>
> This patchset creates the initial plumbing for a io_uring command for
> sockets.
>
> For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCOUTQ
> and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
> SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself is
> heavily based on the ioctl operations.

This duplicates all the existing ioctl logic of each protocol.

Can this just call the existing proto_ops.ioctl internally and translate fr=
om/to
io_uring format as needed?
