Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8D7E101
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717136649; cv=none; b=rmESSBlv1nCrQzUB1aJJyBUOonl5GwBziWkPPdLp5vjaQ7oP83b1kJG8tO5iS2a8BVfTVZKBVRjvhNDoXB0MBEa/flAjvjgEb/JoSWA20ulPserHQRP3HxqKPgZVVULy3ZO/fTtxN9RmYB8WBrvv5UW7APgADd2uLe/V09pPzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717136649; c=relaxed/simple;
	bh=AU8OP+j3zx8s5L6slB7WGLzdCE3cIdWS/zNOw7ix9hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3zLWAeAVBsYM6i+kgugAMbI9rL8sGs6R0QMCq2PASIOUWhmAK1+ZsURiFviujRk9phQyKkmtdRFqCBcdt10GXTsRk+QbugwV6siJX0NOrtnU1BoJCBwGa1kk86z7KCK5EblqrOvV2G/UFvMaHhdg8PhS2ODqsaYEwzQZH7gjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYpKJpux; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYpKJpux"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso6070a12.1
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717136647; x=1717741447; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEEkzxzw2l9dsGceL+M9m7VWZ6HOQUiTt3ium264cY4=;
        b=BYpKJpuxIQNkDi77BMlrdECB4wz/UWc2su9/iuoaw2IUbvOmXOKHapt2XnesmHYfqt
         BXnnh2IDHQoCFbpy0fI34BQU5fV0swpbbDnlrWPe0P9ZXiPCHFxnNpXAqUKTx4nLzo3t
         pfwefG3kF3MdBTNssxmHrnefjQjroIgtesxWxWMWXmxDNISqv8kGFP1eAFlFaMqFxFPH
         J6SYU3AB9HlujIpeEi4WAkZrJXu3EsVWZ0wx2bAIhe0jSK/JlWwoayzesY5yKHgxKHZA
         CVxUii4g+HLJqaVtIs5xXhH6Gt4aqA4bhlQg2grynIv0wNDXd/kYAJUl/OGibP85Pqx6
         MUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717136647; x=1717741447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEEkzxzw2l9dsGceL+M9m7VWZ6HOQUiTt3ium264cY4=;
        b=koSN2JcwMAVJqIV5VoXaH9LixJKwhY2HEKR5PRGdXZxWGd6mPsngBtOTbMHtYXTVqy
         7WGsAYvukD+N6sovVGuZP3bBKecW8/pt8FCloRV7sNZxgNp4YCQcrwf22Xxu8L9347KG
         nqhgP/co0WKC01TusZXUKsm4fZd5Z+3IBHVkgvDrJ6jsYni6sEJ1Yd6Ja79bAZ4kPU1j
         Pnyg0nPmEgqDbAq2gMkyeIsx4T0G6g7Gg8ges2PuRcwrU1u3+uMhndbpK0jxQoBpIY9Q
         VFeVYpOKTCn6eBkEZ+XkxNcrkfyt3v+DHPS79DmFsiQ3zjlt0QmC53KhRnRgfleGE7Hh
         3N9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZEJIcVruc6fj4vXn1H7SC1166iQ6eqf461c0XJNKaJn4qzfcdxXanmjr/SgevAJ0pRQwSlpDGH5AKxJ8GyaocYgms340=
X-Gm-Message-State: AOJu0YxcwmE913uiMCjt1JPramFAmrCeBKJ8k2VDGnpBqlwfBzVuMe+w
	zRxLjqd5FDUuPB7NS6SawtYl80b5CmPQNttOIiYNLcdhCgTORBB4wPrj4R7He5ekxUoajePZ//Z
	ZPML5AysWLdtxPH4hf0eCXmItU/vX4aqqkEg+
X-Google-Smtp-Source: AGHT+IFuhZwScZ5INqv8GHb32wDNKMq8rDNGgetkBMalXnj9RK+/6EjJKHZP2HhZdxzjRMg+3RcoQrSxTOe9LsQD/q4=
X-Received: by 2002:aa7:d6cf:0:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a33693e06mr117681a12.0.1717136646388; Thu, 30 May 2024
 23:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530131308.59737-1-kerneljasonxing@gmail.com> <20240530131308.59737-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240530131308.59737-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 08:23:52 +0200
Message-ID: <CANn89iJh5S=Rmq23SZGCsECUdvmuD22O18rNA=-Z1782BoyMNQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:13=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> According to RFC 1213, we should also take CLOSE-WAIT sockets into
> consideration:
>
>   "tcpCurrEstab OBJECT-TYPE
>    ...
>    The number of TCP connections for which the current state
>    is either ESTABLISHED or CLOSE- WAIT."
>
> After this, CurrEstab counter will display the total number of
> ESTABLISHED and CLOSE-WAIT sockets.
>
> The logic of counting
> When we increment the counter?
> a) if we change the state to ESTABLISHED.
> b) if we change the state from SYN-RECEIVED to CLOSE-WAIT.
>
> When we decrement the counter?
> a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
> say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
> b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
> from CLOSE-WAIT to LAST-ACK.
>
> Please note: there are two chances that old state of socket can be change=
d
> to CLOSE-WAIT in tcp_fin(). One is SYN-RECV, the other is ESTABLISHED.
> So we have to take care of the former case.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
