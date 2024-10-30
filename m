Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE31E1312
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297912; cv=none; b=THnWpBZKNV3JD37npy8duvJqRyzVRVs1zY906ozF+1o6OGC32SGmWjjcdsgAa4QDkH5KoTiXKyI5jk3ZsWu3zlsVK0a3wvsuS0UIkQH/8t/FxUf7kC2yUSdbg+yQCCBXBgjP+Z5yTDfc8zNQ97H14Qf2OgJgpTdF0eT0Xkt+6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297912; c=relaxed/simple;
	bh=ZCOoHIRMbKIZGLHZWE5qwSr0CwEqLtaGujX1YBNvVxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lffh6a370c1JH0YVIdj4D3ByMqrBhqsl8fQH7ddDJOB1KEPtKEgEAQpY1TfR3X/NRq8jSdFs2BdekKe0CLpCK8ikXxFNdMEzN7Sep3qXpTVzYfX+tbUteyyhTWtxeeATL6WI5q+LRN/Am5AYxJsSjLBLteV+IxuF5weCPGeh8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQse2KJo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQse2KJo"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so61687021fa.3
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730297908; x=1730902708; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI1Q7iFFALyNWdb6YnYTA6RNW062i2zYDoz0ifkHGFk=;
        b=gQse2KJoe9e+wOhm+XFmz5/Csqr+nP3G5HG76uyYZIVnXhQ5ASbVWPpxCoIOUjxvl8
         vf5T738HXDtntZV0u7A27oDebo/R5PV9Y6lnhc/N435MkClhRvyxjMtFZugVNihehAqK
         xovWgNLHSC0MWiPIAFeLLVk3Z2zYWZ6DnZLUKPPEPFCvBqKOxg80HO7XzdfOdd3ZNEH0
         IG20JjVNEEbsh4XznSZ3ptZgIC4hCUeGGJKLtNwoL/DHXiDVSUP/6V1nVCYUNxCz3Jx5
         7OrRSaQhRr3hAx4xppVbgf684sFnO9KWRgHSyosZD/uz1lUU8UJpQhCKzQbciNgM9CcE
         c34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297908; x=1730902708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI1Q7iFFALyNWdb6YnYTA6RNW062i2zYDoz0ifkHGFk=;
        b=M4/WOVvE4PslSPg4mga/BmN0XsmUrgf3lkkexn2FYo+Ql/r1/78vbIdHUxXZQX1JQW
         Xj9TDnpYh0hs06qaRh4CQMrxz1/UxsJC2lk5e11+vnOZpBt7F3s7HCF6o0Xgp1emkCAb
         N3OU3kH8X3BDbK/8O3lHXKUkauoPOp7dhSlJXMQ5XseJ5no7/VQl6khckn08NafsQwUo
         etCWlZn6HvY3m1w7A/yxrtk3ctPw7ZUSSNxcvjG9j1MjnpISpeD/d5n+9jET1iNgsl9U
         INg8RHu1ffwHd8rJrDCyC9O7Dyd3YKqsztHG34EhwHNV+najwaIJIFPeIT7tD10S+iBt
         q+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kqM/qrMJ364X17H7L5XmzQTZZwiSUfhX3j4/xE5XhXkcl3lbB/EwJQah7204AlB2Vx0dIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxE2Fuq7vSL8LDmwmH3/lC4JBDvSDh1LxXhfL6vk+3uaTjDqZL
	TTgEs9AIv1Sp0uoIvvGKEAeIaKxypczTLhNftylNYNCchfsVSbj/oqYA7acjrSEaqSlC/F4PBZf
	s+tzplvJqzts44Xc/gg7tjq733vD06LlQFmlb
X-Google-Smtp-Source: AGHT+IFBilfUkzHEmS6+o84sCK1y4uKaB4NO7YNRFJquAc77QKxj0moVYTFp7ObaLzboY+vQGnMMw+U412cqHiD5QrU=
X-Received: by 2002:a2e:b88e:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fcbdf5fe55mr73102971fa.4.1730297907852; Wed, 30 Oct 2024
 07:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030140224.972565-1-leitao@debian.org>
In-Reply-To: <20241030140224.972565-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Oct 2024 15:18:14 +0100
Message-ID: <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com, aehkn@xenhub.one, 
	stable@vger.kernel.org, 
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:02=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The mptcp_sched_find() function must be called with the RCU read lock
> held, as it accesses RCU-protected data structures. This requirement was
> not properly enforced in the mptcp_init_sock() function, leading to a
> RCU list traversal in a non-reader section error when
> CONFIG_PROVE_RCU_LIST is enabled.
>
>         net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
>
> Fix it by acquiring the RCU read lock before calling the
> mptcp_sched_find() function. This ensures that the function is invoked
> with the necessary RCU protection in place, as it accesses RCU-protected
> data structures.
>
> Additionally, the patch breaks down the mptcp_init_sched() call into
> smaller parts, with the RCU read lock only covering the specific call to
> mptcp_sched_find(). This helps minimize the critical section, reducing
> the time during which RCU grace periods are blocked.
>
> The mptcp_sched_list_lock is not held in this case, and it is not clear
> if it is necessary.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> Cc: stable@vger.kernel.org
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6d0e201c3eb2..8ece630f80d4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2854,6 +2854,7 @@ static void mptcp_ca_reset(struct sock *sk)
>  static int mptcp_init_sock(struct sock *sk)
>  {
>         struct net *net =3D sock_net(sk);
> +       struct mptcp_sched_ops *sched;
>         int ret;
>
>         __mptcp_init_sock(sk);
> @@ -2864,8 +2865,10 @@ static int mptcp_init_sock(struct sock *sk)
>         if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net)=
)
>                 return -ENOMEM;
>
> -       ret =3D mptcp_init_sched(mptcp_sk(sk),
> -                              mptcp_sched_find(mptcp_get_scheduler(net))=
);
> +       rcu_read_lock();
> +       sched =3D mptcp_sched_find(mptcp_get_scheduler(net));
> +       rcu_read_unlock();

You are silencing the warning, but a potential UAF remains.

sched could have been freed already, it is illegal to deref it.

> +       ret =3D mptcp_init_sched(mptcp_sk(sk), sched);

The rcu_read_unlock() should be moved after this point.

This means that mptcp_sched_ops ->init() functions are not allowed to sleep=
.

>         if (ret)
>                 return ret;
>
> --
> 2.43.5
>
