Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018300;
	b=oOVTCnuGB1YxzUKamatgxQe53UJFeJls7BK42mI3IS66OuGDjXmJpRc2Re/AC/4gxaUS
	 jRsOhHs6jRDA/FFhAhrViabTIJrKBVGp0z6jkJ7qD8/vaXe2rq5aAL+m5mQQ40LLoXzoD
	 cqyGf8JeYEfJiIPJaiOoh9lK2A6btiSXG/zydY/TGMUwLCIr9/hZISgrv1eAn8HBWs6vI
	 eCt46Pvm0fBHND0wm0wG8i0oBdtZIy0OasLTw6CDPL6aKU2ZoBhqy3GbNhpK1bDjc+Waj
	 Y1edWugbHbfpeuwZOCWHpDnTKGeknVR+nw7jRdkhdJ8VOemfDCB1BOML82ZnyP3dICA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018300;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XG8Szrq9HyP4p8mCyECorg47iCZAl2TOpPnmqA0Xpkw=;
	b=ocAGt9N7/Mm/hyLP5GhyWI6/oOisoaXSZGeeshxYNIZNiZXQkGCeyO2ip5gGSfr0og1f
	 tv4BeejvEyAFsWERgiWH4C3dezESPF8FD0OyWICa+QrAkvgZHQIV0Qv6HQM8PTVmK8Ar8
	 i+oNY/0sBsHrOHCvOXSyraiipOse4PPqtU71doVulmENto4rU0JQEuFEW+Ak8n4MnbNwS
	 amjPrhMIVhEB3B9+tL3vQVX660qOrBAsKPVtbhwlsaNoWg+LIyGnTuRbZIJN3vSJdW8uy
	 buNwA15EJ8vXB4AXLiqWkZmT13x4td5xMNmwZ3T+6xZUpDTgPpun26+jPR8mj9qHveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjLm8FtS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D215606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjLm8FtS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA1A1F01828
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018298;
	bh=XG8Szrq9HyP4p8mCyECorg47iCZAl2TOpPnmqA0Xpkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZjLm8FtShg0tZhNiT+oKp913XnkSkLx/78VjPoVNrWiTHkCSmS4c3LBPxoIHUU08n
	 1dGRvAOAkhPCG+83WlAsP3/L0Yr3DKYkbVGpfRX5zBVbBP7bnTGTuzev+v5S8t/JHw
	 +g3L3okX2yOeF04zu0Eg+13Ak/6OScCvZY7VTjBFImLpeYZC06W3sV6iMG10wuoLWW
	 AQhV1H4bSQH64Jbz3j0Ewl+TyfqaQuNBfwv80Ldo85+QgS/RtLgyS2vAY/NlC6jJHq
	 7uo3ZwPh3c/RQJZkwV6k1V7XXI1HuemK9zLTl0ITxbz1UQ5+W4/JhssuE8v+uWE7vH
	 Ok5+sneFl/1Ow==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so1660719fac.3
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz4d5xKH+tNphmfLSoRx2wcbUKLoe15TkSYeILydwAmwmR2F4aM63k4vpV/T6B6Kfh6I3gEXQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYITNl6YdzJMZJyJLibQ659HHgdjNuQd+pAS9/S9yKNw7YggI56b
	JqyzkFU9s2oTRKRNy6wg0Kz6XZw2E6YfyAAD3swoczGBlJyOGYSxFzHhpc4NB1yAAPe+Wlq5VaE
	nBgho2ikL8YLXutNhoPG4TB0bxhjzGXo=
X-Received: by 2002:a05:6871:a69f:b0:491:b7fa:76f8 with SMTP id
 586e51a60fabf-4a83ec452e7mr3868754fac.0.1793018298084; Mon, 26 Oct 2026
 05:38:18 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
In-Reply-To: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 13:38:07 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
X-Gm-Features: AclHuK-yOS0_zQhnBgPZbv2A9ize24MPt8Vf2Uf9oc7WYOKvbednnhX2kOUiocA
Message-ID: <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
To: Cen Zhang <zzzccc427@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 13:04, Cen Zhang <zzzccc427@gmail.com> a =C3=A9=
crit :
>
> mptcp_diag_get_info() reports the accept queue of a listening MPTCP
> socket by reading msk->first. The token based dump and the exact token
> query only hold a reference on the MPTCP socket, which pins neither the
> first subflow nor the listener hash bucket, and __mptcp_close_ssk()
> drops the last reference on the first subflow before clearing
> msk->first.
>
> An application can disconnect a connected MPTCP socket with AF_UNSPEC,
> which removes the token but retains the first subflow, listen on it
> again and close it. A dump that obtained the MPTCP socket before the
> disconnect then reads the backlog of a freed TCP listener:
>
>   Token diagnostic                 Application
>   mptcp_token_iter_next()
>     retain MPTCP socket
>                                    connect(AF_UNSPEC)
>                                      remove token, retain first
>                                    listen()
>                                      reuse first
>   mptcp_diag_get_info()
>     observe TCP_LISTEN
>     lsk =3D msk->first
>                                    close()
>                                      mptcp_destroy()
>                                        __mptcp_close_ssk()
>                                          release first
>     read lsk->sk_ack_backlog
>
> Take the MPTCP data lock around the listener state check and the
> backlog reads, and only follow msk->first while no process owns the
> socket. Every path that disposes of the first subflow runs with the
> socket owned, and lock_sock() has to take the same spinlock to become
> the owner, so the reads cannot overlap with the release. Waiting for
> the owner is not an option: mptcp_diag_dump_listeners() calls this
> function with the listener hash bucket lock held, which the owner needs
> to unhash that very listener. While a process owns the socket, the dump
> reports the MPTCP socket's own queue values instead.
>
> BUG: KASAN: slab-use-after-free in mptcp_diag_get_info+0x415/0x490
> Read of size 4 at addr ffff888111763818 by task python3/499
>
> Call Trace:

Adding these stack traces without symbols is not really nice.

Time to use scripts/decode_stacktrace.sh

>
> Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> Assisted-by: LLM
> ---
>  net/mptcp/mptcp_diag.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0ee..a71bcaee15c8 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -199,7 +199,12 @@ static void mptcp_diag_get_info(struct sock *sk, str=
uct inet_diag_msg *r,
>                           READ_ONCE(mptcp_sk(sk)->backlog_len);
>         r->idiag_wqueue =3D sk_wmem_alloc_get(sk);
>
> -       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
> +       /* The listener walk holds the listen hash lock: do not wait for =
a
> +        * socket owner that could be unhashing the first subflow.
> +        */
> +       mptcp_data_lock(sk);
> +       if (!sock_owned_by_user(sk) &&
> +           inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
>                 struct sock *lsk =3D READ_ONCE(msk->first);
>
>                 if (lsk) {
> @@ -210,6 +215,7 @@ static void mptcp_diag_get_info(struct sock *sk, stru=
ct inet_diag_msg *r,
>                         r->idiag_wqueue =3D READ_ONCE(lsk->sk_max_ack_bac=
klog);
>                 }
>         }
> +       mptcp_data_unlock(sk);
>
>         if (!info)
>                 return;

This seems overkill, and adds a new msk slock -> ilb->lock nesting from
mptcp_diag_dump_listeners(). It also makes ss randomly report msk
rmem/wmem instead of the accept queue while the listener is owned.

msk->first is a TCP socket: TCP listeners have SOCK_RCU_FREE, and
tcp_prot / tcpv6_prot use SLAB_TYPESAFE_BY_RCU. Reading two integers
under rcu_read_lock() is safe, and stale values are fine for diag.

mptcp_diag_dump_listeners() already holds rcu_read_lock(), only the
token dump and mptcp_diag_dump_one() paths are missing it.

Something like:

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0eeb8f7050344a63396396d8718206c..28a42eee665129fe56c47dc2dd5=
b265ba18b2e95
100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -200,8 +200,10 @@ static void mptcp_diag_get_info(struct sock *sk,
struct inet_diag_msg *r,
        r->idiag_wqueue =3D sk_wmem_alloc_get(sk);

        if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN) {
-               struct sock *lsk =3D READ_ONCE(msk->first);
+               struct sock *lsk;

+               rcu_read_lock();
+               lsk =3D READ_ONCE(msk->first);
                if (lsk) {
                        /* override with settings from tcp listener,
                         * so Send-Q will show accept queue.
@@ -209,6 +211,7 @@ static void mptcp_diag_get_info(struct sock *sk,
struct inet_diag_msg *r,
                        r->idiag_rqueue =3D READ_ONCE(lsk->sk_ack_backlog);
                        r->idiag_wqueue =3D READ_ONCE(lsk->sk_max_ack_backl=
og);
                }
+               rcu_read_unlock();
        }

        if (!info)


pw-bot: cr
