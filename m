Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817161;
	b=rnCeETTUql15jJXUzA7XAKqlTc1Ek8FgEnOk2m0YfZxhokpRZFW8Q+Fj5hVkmjvTjc5Q
	 fh2mq1MapUFGF/yyxNiUDk+9hJR1s2aeA3OOwbw5dxEkkreiX2W2EAxxwB53LcKPldE4L
	 p3dmvQR3xHSTOK5TbHvZ2L/qyB3XPq2wvNjlkGNbXJgLLW3mfnq3fB9aPd6hmZLeSFMvw
	 slI1iu3X7mznJOO7U2Ekf7mlD8AX5DilkR92qcMPmatGxgr3glfKm/t5cCbj1u+1bD4qa
	 UdWZysRqVR16zofvplfZVu4nS7Fee8lekpVt3h7JKKPehPjOdjEAPLVDn1+NDmUuUlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
	b=wEb7F9V1jhqTBi9JsBffS1b73qpB6VoISN331u4SIUb6Ka7mY+juqJYXicqjwtg0cE+/
	 UPwd5/mWAtpGxXz3MGqkowJgakcaaoleOC7c2p9buho2NzJIMHU6E+aRwxqGVDqbKt5kh
	 YtwmLrTfEm5gv7cIF1/6MOHMUGqTxo7N+TVFN5keZudGx/tqJwHdat2izgsMmu2Z5K+I9
	 GdKbg5sbuTxgWeC2qCiMq1d8YYryd6+Q/plcUHri/TQWDnzpVkWW6dzL2N66ny1V4/7Go
	 vLpEsltgqUhfYy1nyW+5EsFATTZycPT2y47/caTW8QyPFz+KHYpu4xsoExN5irYmoUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbkA4IxC;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCF606A31B
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 18:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCCF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbkA4IxC
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc147d86bebso616147a12.0
        for <mptcp@lists.linux.dev>; Wed, 04 Nov 2026 10:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817161; x=1794421961; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
        b=GbkA4IxCBwncg/CmlR206Gby+Xp2yPZvD989hAtPhitFjuiJgSvHyMOLoVzKgGMuRa
         40ExbqgkGiCFrg/3urdemgsqv6sXX65bLhAryB20AXo6RYOq28KO9ytczQyK4rzzQUnW
         gaf1rAMkfxw/ImFOzOUKhyNx6QBeVTXNkieYvacR+pIdSkg6kvitII73ukrlcoQ7f0XI
         2c8pHFmGdogoY4fr9NJUcnOJbcW6mo66lXlLtGjZmUTLtHUjsgc/wvBi2mCaDoGYhIXT
         yTcA083IQmIJTXKCm3L8JHZJ0/ufgKpEv7KIhiThs9uws9HSDsSAL0rg8iSSy+Q0iMTX
         v0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817161; x=1794421961;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgGvwwQ0hp1A5Cajh6ZjxfCDvcyK9tWxZx+AIP+8L3A=;
        b=DcSSYiZpzxD+QedrrZM/lJEutWG/3o/Jn3DQIHrRL198W+IjRHdFFGecm1rKxjGcDH
         eAbqJWEfcVlwKSVBTvVBPcFlpW59yriirkzTjNR4GNjUK+br9L59dVKTOmBGm9J9tlQu
         V1IlLGAlpqUeaMGbRYs8bvL0z50FGDDiKq9kvLz9jGUm36xZfV3B2RKVhwZougnjWS9E
         S8CUOWhaXgCRzGNxdXDzoYr9T8XPY6KIJkCsEzmfOOKU4rIN74fdKXPk9TXegUrPhUx/
         e52UA45mP6sg43U7jNW8mxsPMbpODGzzLUExqo+p+AfrZQriN3nQEBDR6FaAQl8+NtkT
         zmoA==
X-Forwarded-Encrypted: i=1; AKwUvBwRXE2j/vT65AlU0yxm/vLzLtFulYII/MVwBVCZR44l9hvgfRYIDP8v8W7ptmKFz+2/kWZWeg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+UGEiIEUnEn81EdLoMDU3nGWxcQJu9ADJ7LvToWfHcG1gL4zit
	Ws6xgWbUeQ+w3reJmaX7F2bcjLMfwf5x9cdafdNYk/vU/bY6iDQ+I0QP
X-Gm-Gg: AYBFou0vUQnlJWotZvqap6ZIitcVijJ930Ko5MTCsYQ6IlTe/WHagzDO06JmVgC6R6i
	Qppgc5/Qp2ZrM5aHbBK/US4pcyUiK/tZ5VGlCw8DDuRdVilnpgmTxgPyAQd7klpt8leiiJDzp79
	1MrfIzIP9tjwC3tBgnt/Gymy9rtgMEFiafWIEpu3H9n9CQgPgWoB9i1s0eo0ntgneIz0NtZHDoF
	BdjUgU0MNxVdSnJQoHq98kPO92Zt0DRKesBZ1sMFUDDTYHbOvuhI4sUEN/4kXQaMZO/c40NXFO3
	0W6m8j1lWmC3kQJjChiQBn8nSylX7i/kzeRKQ/sQLJ6QHoa9SvI9N6B7QByAJn4Cs9yj2CRYIJV
	AVLU52CdlBLVfpdGtGHshzeS/HB0K4AsYb4yK4kcWE+4nFTXDBtV7Ci3marnYdHzaYKS8SM3rrw
	DdqWLdT+fQ0TAXd/Rli3hMyZ59aqbzgiz23YUbr1eA6C70wScHY5A7S8n/Os9FdyiAORi0wdbTu
	5W+VLKATEKZgX3Slo+Oau5L7F603hmna8gN47VDveOaJcSIkMWH69YzK05cDipobH930qIObO0L
	LVO3heB87TP6XOAatsBa/xXiOx0+UnXOZgFamrmtnBl4Jl0ECLfiL34OwJrZAroiqtkcGdURF6V
	PGHPIgnu1v0AhsKw7f1ujg+2IZGZEbEI5UQ==
X-Received: by 2002:a17:90b:554c:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b0afc77a41mr178745a91.31.1793817160656;
        Wed, 04 Nov 2026 10:32:40 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c143sm154357a91.2.2026.11.04.10.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 10:32:39 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:32:39 +0000
Message-Id: <DMMN42GPUESV.YUIKSBF4E297@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>,
 <willemb@google.com>, <matttbe@kernel.org>, <mptcp@lists.linux.dev>,
 <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 08/15] net: Leave sk_stream_wait_memory() once
 the socket is dead
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>
In-Reply-To: <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-9-alexei.starovoitov@gmail.com> <CAL4Wiiq+QX8quVBjEZK5qipki6Yt7vx4=tt2L4o+FwO9zD-5=g@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 09:23 PM Eric Dumazet <edumazet@kernel.org> wrote:
> "A signal or SO_SNDTIMEO of the target ends it" does not look enough to
> me. tcp_sendmsg_locked() takes the timeout from sock_sndtimeo() of the
> target, a socket the sender does not own and cannot configure. With the
> default MAX_SCHEDULE_TIMEOUT, a blocking sendmsg() on the sender's own
> socket never returns, and the sender's sock_hold() pins the dead target
> until then.

Right. It's not enough.

> Since this patch makes SOCK_DEAD a reason to leave, one wakeup before
> sock_orphan(), while the socket is still owned by the closer, should be
> enough. The sender can only get the socket lock back after
> sock_orphan(), so it sees SOCK_DEAD. Nothing walks the wait queue after
> sock_orphan(), so skipping remove_wait_queue() stays safe.
>
> Something like this (untested). sk_wq can be NULL here for MPTCP
> subflows, hence skwq_has_sleeper():
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ void __tcp_close(struct sock *sk, long timeout)
>  adjudge_to_death:
>   state = sk->sk_state;
>   sock_hold(sk);
> + /* A sockmap egress redirect can sleep in sk_stream_wait_memory()
> + * without a reference on our file. Let it see SOCK_DEAD.
> + */
> + rcu_read_lock();
> + wq = rcu_dereference(sk->sk_wq);
> + if (skwq_has_sleeper(wq))
> + wake_up_interruptible_all(&wq->wait);
> + rcu_read_unlock();
>   sock_orphan(sk);
>
> This can be a follow-up and does not need to block the series.

Makes sense to me. Thx
It depends on the SOCK_DEAD test, so it goes on top of this series.
Will send it as a follow-up.
