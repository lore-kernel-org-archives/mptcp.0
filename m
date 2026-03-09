Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FD361664
	for <mptcp@lists.linux.dev>; Mon,  9 Mar 2026 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048173; cv=pass; b=GtnWkIMKxt2PLYTYWA+NfAMsdXYHsgbBNQu+KkAiaOCpG3W/c3gnp0tDW2DiBFPa2he7PWDaOh5p2pfKyY9JLc45BrZaCz8Z6NF+/vXAZ+S+sSOaxigJSL7i9pyiXVx7lxe51bIwDx1s+DuzReNDFmBUyN5NFumPhTVzLQMKiRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048173; c=relaxed/simple;
	bh=upio09NojrFHMRimK65FKWysiVde+qA9+o9ztExC8qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUmqyA/4y0Xm3D7Ayk/BBZr5cilwEKy6ja7dAfVlK8YQKc24bXEVHHNLqaICxm1boCs6j0CGZl3uYc5Dt0h4uUXVcUYewIsWfh80PSOYnvSaTS9lVxrVt736Xe9mBp6wnYr/onkQK1l71pMc7vkHhcYdjzHJCzcqsQqEaGeGZJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3x+pB7rM; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3x+pB7rM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a747448dso102119631cf.0
        for <mptcp@lists.linux.dev>; Mon, 09 Mar 2026 02:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773048171; cv=none;
        d=google.com; s=arc-20240605;
        b=Ph/sLv6dF/yYoonI0lrIp3dxReDxy/BF1PSn/+7728mnTwd26BroRGt1CaPzW5nWAO
         KQDRsD1FYnuW2fUK2TWFuFi8v/sFMrYEqIQ8l1jgwd/h6tGqBw6255eZ3LOa6uJsnx7E
         lOld9KPIxQupUdA3XzT1tQUi7WjT+k+ArgWI9fIqx9HSFVphSiSoZkH+vrl+kR8T+rGw
         +56YSixlhHevswTHgSkORk9MkyGb7loJaUsBrB6S1Z502PFG9tC6mX3MqkSK9xtY0LRQ
         OFmGSaJtXqyIEe7JjNNIG2niK8cN8L8+r3WGU9ONim0neuDYgSM6Cej2/2MIM47jvg5u
         0vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7fC3bjKwQcF/Me1NQG71BV/tCAMZf7S0tDB0ddNnBM=;
        fh=w2q0T1FvOb9PkDwxJ+scN6HYV4SLRyJrn0/cQ5Icoj8=;
        b=P0CIsY+uHWoa7xroAXov3gO1jNaLP1aLcBPAOlxAC9IyPvv64Dlr/bZnAfSmRwdD0F
         XC+4FGZxFDxQIzIBZUwGa6TJvo4gnaVC4Sxj3pOlV8tqpLe5YM/ElHLM9679RkYyrBKm
         sccaUyTta7D7xC/kN3ICr1I0rqmTkkRmGTJOCtnIY8aIS6GKsu/Fvc+OXMcyU8YHzECx
         uD6XHXGyNApFADKJdNAICJ/fbryA1r4G6QmCwYID9Ru5cs6GU2I4a9hkD8+c8GHqWG2c
         sJ4T30c4DInrddNZnXj1rJJt+LLR0EzMZAfbTL8ri5OQroJaBQYurowJ12SWBVFlWHMv
         98Pg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773048171; x=1773652971; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7fC3bjKwQcF/Me1NQG71BV/tCAMZf7S0tDB0ddNnBM=;
        b=3x+pB7rMHbg8JhOLAX32ASpQnR8RLee7KUh0KRWhykIiXHGRPbfmyRtmo40skivFhZ
         RXdziv7oUfjL+D48+e/tLLwkyIMCpHJnUrDqCv9hJ0hpGj7fInXEzc9ViY1PfTwJJc15
         4a/389TnFDfhEnZMzJfzHk64wr+TNxr2EvaC9+JcFbmBCC6STttOeAaoNv0dtmHOOA3P
         Gbtt5tuzfFC+zPNagRv4a18rsLmUwvhXS1fNYQgKLpYc0h1GtNgoHJR6iaXCstRZcbpw
         yVNdoJ2ucjNGwhfnwl+sQen/S72jaMjzGO+vgwSn1A+fJxDhYgWbmPQms9M/FcNFF9HF
         f7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048171; x=1773652971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7fC3bjKwQcF/Me1NQG71BV/tCAMZf7S0tDB0ddNnBM=;
        b=jT0GtROLvG7BwzMB6+w6iwTkU8ddMF1AQjLGp6vt0pVCMB+WxKOVzyHeUI2nPr1Vtz
         Uf+5oPkv7BjfdZsSFwNlko3fqpfYBudIV7LFXOawB8vSEoPuvpGfwSUNBm6XwYTja04e
         S5uDUIYRPvqrd8HRA0k4gyMJBU/jSS88n9iVtnRfBbm3CAyDnmYIbFCjQNNiQVafIKv8
         O+UASo7GPan5SukwLEGkRUAYlbL1J6OdO5wNqZPw6f72IF+JYUfd+v96mWKC6FuS+aaV
         2qhiCJ1SqIlFe/y/LqFpoaeo6UDxjdShTVfeH6+rwSZffgvmlzm1YYoLkGhvvExK5CH2
         wmMg==
X-Forwarded-Encrypted: i=1; AJvYcCV3P8w3sDfsP9AySz9nzEInCu05rQf5F+hwIZxRKgqB86FGIAWSfuLoa/9f8kaQkTh/cwccWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxydfn+i+OU3XF8YUOzr7tfa8/AhB/ZqFqCIAUlma72+OmxlGJv
	w+F+FpT/Evk/FhZ44ceTgB3X0u7lsSgKsdJoq2TwG/BLjEX70+VCFmH/JwjYj4HK6cZMtX4Mvbr
	hXGZ9dD5O5NywVRJG6nKoD7GnLSNlX8Th0Q/1amj9
X-Gm-Gg: ATEYQzzIsgksI5Yz9M16AvadJwSpEEScP37zYEa03FRAc8i5uy15otLl48w4L/Ew/40
	sXC9u/o4868ji3gaBBOo9cDAvGCy3Vg3Mpwk9faU9H2U7sug2yvxi/badn8gPs3T11eOHkUgFf/
	OKwnp/nspBiXD04o3b/cESkju4uUIyeQDkcfQjlGz1tux8x0CgNkEqu3zcC8DSHPfRF1+lXzuiP
	Hh8Caq0TQfgFKJ5vhxXY781uovZ6d9UfP12zIlQ2ow+dNZlYaoXXWrE0BNmphzejtot/BiUo9nU
	C4Q1YSs5Vix1gEkmFg==
X-Received: by 2002:a05:622a:7c91:b0:509:882:9e72 with SMTP id
 d75a77b69052e-5090882e153mr50961191cf.1.1773048170529; Mon, 09 Mar 2026
 02:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 10:22:39 +0100
X-Gm-Features: AaiRm515VzWer9rfQTDKEwoECAFtXOyO-47wB6RLAYk2qz4MnRNOLIFCZe96lfc
Message-ID: <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window retraction
 receiver requirements
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> By default, the Linux TCP implementation does not shrink the
> advertised window (RFC 7323 calls this "window retraction") with the
> following exceptions:
>
> - When an incoming segment cannot be added due to the receive buffer
>   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
>   handling of extreme memory squeeze") a zero window will be
>   advertised in this case. It turns out that reaching the required
>   memory pressure is easy when window scaling is in use. In the
>   simplest case, sending a sufficient number of segments smaller than
>   the scale factor to a receiver that does not read data is enough.
>
> - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
>   allowing the tcp window to shrink") addressed the "eating memory"
>   problem by introducing a sysctl knob that allows shrinking the
>   window before running out of memory.
>
> However, RFC 7323 does not only state that shrinking the window is
> necessary in some cases, it also formulates requirements for TCP
> implementations when doing so (Section 2.4).
>
> This commit addresses the receiver-side requirements: After retracting
> the window, the peer may have a snd_nxt that lies within a previously
> advertised window but is now beyond the retracted window. This means
> that all incoming segments (including pure ACKs) will be rejected
> until the application happens to read enough data to let the peer's
> snd_nxt be in window again (which may be never).
>
> To comply with RFC 7323, the receiver MUST honor any segment that
> would have been in window for any ACK sent by the receiver and, when
> window scaling is in effect, SHOULD track the maximum window sequence
> number it has advertised. This patch tracks that maximum window
> sequence number rcv_mwnd_seq throughout the connection and uses it in
> tcp_sequence() when deciding whether a segment is acceptable.
>
> rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
> tcp_select_window(). If we count tcp_sequence() as fast path, it is
> read in the fast path. Therefore, rcv_mwnd_seq is put into rcv_wnd's
> cacheline group.
>
> The logic for handling received data in tcp_data_queue() is already
> sufficient and does not need to be updated.
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

...

> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..c86910d147f2394bf414d7691=
d8f90ed41c1b0e3 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -293,6 +293,7 @@ static u16 tcp_select_window(struct sock *sk)
>                 tp->pred_flags =3D 0;
>                 tp->rcv_wnd =3D 0;
>                 tp->rcv_wup =3D tp->rcv_nxt;
> +               tcp_update_max_rcv_wnd_seq(tp);

Presumably we do not need  tcp_update_max_rcv_wnd_seq() here ?

Otherwise patch looks good, thanks.
