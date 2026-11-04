Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769826;
	b=1M+a/x7CUAAHKeD7+M85dlkRelgJW4QeYSHnVj6HlrN/6xVfagQPeuG6iu5FPTdDXQv8
	 SaTuQdSowXFPeq//kUcUoPMH5S1QaZrO+Pt+JWnoX8NXshfeL/SsoQSB4spUOqgEo4sjH
	 c+sXCBwZdtqf9bQ2Py7Fzd2lnjqSX6hYWoyznXEnQ8Fe3GaUW5vzZQmTsoE/ymwQLrDsn
	 EDx+Z2felAvCRo8ngwSEdRgUXgswX3zexhIESIW+M5x4AHRk0Tcvb4j5eQmTrCwzsUfIm
	 OIqN4hpD+r4Ob1s0Ce5AzTnW0MT2nJZ6Zsi4uN4fFu7kK/reyr4sfes6tYwdDGFdnJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769826;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Qn8NAtZoDb7HH34IWyK2VCQA4luhbTedxXM4sKwZuRo=;
	b=fmnczAu9RdiwfK+3WeKxk7u/m261VG0fuVL6wRogi59VBwoIPq67Z2Vu7sADKb+cTj0I
	 EjbVNbfif/Nv3dSkNo8V+7stLs54gfFa8xl/TCq6xKzoXIFQh3sx6JeAgXsDqZXYjUjKV
	 k5t/gqGriU/2pTX2xEEB4Yu0/zMZgtrhKLC5d2O8e2//Xre1C8rh48EbppGDbOefbjaBi
	 aiN9KYyEO9Ol6Gr9e5xkqTsgxdlzKcxW/xBLvb5CsHbRv5o//D7GHmWGIgaq54cX7hf74
	 zN5bOOTuMEcIes+DmMh2Kkbml+kxoKqt6jEUDMyNRGzQiu1rbd2l2LTHov3+RIEfJGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oC27qxmL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C126606A31B
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oC27qxmL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9493E1F00919
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 05:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793769825;
	bh=Qn8NAtZoDb7HH34IWyK2VCQA4luhbTedxXM4sKwZuRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oC27qxmLddM+EFhnLVgpy/VmEZXINf+xmHMuE4FdR6WRBLVsnWvH4KjVNHVFraJuO
	 /8MkqE97l3jpwOqC3pKUzDOHT9ZRJ1DXXVzgBzKn9ZKDZfJsxzGxxh2bMHJWSUoO4P
	 Iw9Rl2YyPuajJcU8OJRvCxTdBU9IleHw9W+6i52qbeVTRP/a4YmrOt01ifcx6sjGHh
	 ZJUmeQWpsSTW5zqXezbe306mtiwtYW/T/dYIHro4eFD8m5+H6WJxonqCYrmAb1qqy0
	 h4YEOzoU8ZjAqpOXrGwZ3Owi4CViRUiQdQ7ALC9gsPHBJny2GXKyd3FzwjFZ+u3zSd
	 pjJPF6FRZ9MwA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-49429181ce9so295266fac.0
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 21:23:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw7FukWJ0gKoFrC8bFuMXMI4D8wUlj9meecvC/tkbc9s+lZfL23RAD/dhMKY2f5SMzSmzgAIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9mnav/78ylMd/6+gjCmlsfpbFnagu+H9lQZRD7qdV6Pq5Y+ZsV
	SBoY9NsMs9XLCEJYgI/Ud3y1Bg+sojCKxrj2S8tb/xH85MekBuw+GiuuOBvYNKoL/p/0hIHC48Y
	/3OWTrfVFIZXPqWBC7RFfxiyjQIfmtu4=
X-Received: by 2002:a05:6870:e988:b0:485:d1ab:793c with SMTP id
 586e51a60fabf-4a90769be04mr9501691fac.29.1793769824978; Tue, 03 Nov 2026
 21:23:44 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-9-alexei.starovoitov@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 06:23:34 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
X-Gm-Features: AclHuK_M_LLkqH56WlWzBGN8TVZ6lnrAKJmZVwCPt2OMDTAdOmG-v8JtUt35WrY
Message-ID: <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once the
 socket is dead
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@google.com, willemb@google.com, matttbe@kernel.org, 
	mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 08:22, Alexei Starovoitov
<alexei.starovoitov@gmail.com> a =C3=A9crit :
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> When an sk_msg prog redirects data to the egress of another socket, the
> sender calls tcp_sendmsg_locked() on that socket. The sender holds a
> reference to the sock, but not to its file. Thus __tcp_close() can call
> sock_orphan() while the sender sleeps in sk_stream_wait_memory().
> sock_orphan() sets SOCK_DEAD and sets sk_wq to NULL.
>
> After the sleep the loop continues and does not test SOCK_DEAD. The
> subsequent sk_set_bit() can dereference the NULL sk_wq. The tests of sk_e=
rr
> and sk_shutdown do not always stop the sender. sock_error() clears sk_err=
,
> and __tcp_close() can call tcp_disconnect(), which clears sk_shutdown. Th=
e
> sender then adds data to the write queue of the dead socket, and
> inet_sock_destruct() warns.
>
> Leave the loop with -EPIPE when the socket is dead after the sleep. The
> function already tests SOCK_DEAD before remove_wait_queue() for the same
> reason. A caller that has the socket open never sees SOCK_DEAD.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor soc=
ket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  net/core/stream.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/stream.c b/net/core/stream.c
> index cb255e2a3a5d..334124d683a7 100644
> --- a/net/core/stream.c
> +++ b/net/core/stream.c
> @@ -150,7 +150,11 @@ int sk_stream_wait_memory(struct sock *sk, long *tim=
eo_p)
>                                     (sk_stream_memory_free(sk) && !vm_wai=
t),
>                                     &wait);
>                 sk->sk_write_pending--;
> -               if (ret < 0)
> +               /*
> +                * A sender which sockmap has redirected to sk does not k=
eep it
> +                * open. A dead socket has no sk_wq.
> +                */
> +               if (ret < 0 || sock_flag(sk, SOCK_DEAD))
>                         goto do_error;

This is fine, but it only helps a sender that wakes up.

As you said in your reply to the bot on patch 07, nothing wakes it.
__tcp_close() sets sk_shutdown and calls sock_orphan() without a wakeup
on sk_sleep(sk), and once sk_wq is NULL, sk_stream_write_space() cannot
reach the sleeper either.

"A signal or SO_SNDTIMEO of the target ends it" does not look enough to
me. tcp_sendmsg_locked() takes the timeout from sock_sndtimeo() of the
target, a socket the sender does not own and cannot configure. With the
default MAX_SCHEDULE_TIMEOUT, a blocking sendmsg() on the sender's own
socket never returns, and the sender's sock_hold() pins the dead target
until then.

Since this patch makes SOCK_DEAD a reason to leave, one wakeup before
sock_orphan(), while the socket is still owned by the closer, should be
enough. The sender can only get the socket lock back after
sock_orphan(), so it sees SOCK_DEAD. Nothing walks the wait queue after
sock_orphan(), so skipping remove_wait_queue() stays safe.

Something like this (untested). sk_wq can be NULL here for MPTCP
subflows, hence skwq_has_sleeper():

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ void __tcp_close(struct sock *sk, long timeout)
 adjudge_to_death:
  state =3D sk->sk_state;
  sock_hold(sk);
+ /* A sockmap egress redirect can sleep in sk_stream_wait_memory()
+ * without a reference on our file. Let it see SOCK_DEAD.
+ */
+ rcu_read_lock();
+ wq =3D rcu_dereference(sk->sk_wq);
+ if (skwq_has_sleeper(wq))
+ wake_up_interruptible_all(&wq->wait);
+ rcu_read_unlock();
  sock_orphan(sk);

This can be a follow-up and does not need to block the series.
