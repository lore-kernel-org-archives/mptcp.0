Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7514C59A
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745167; cv=none; b=iDOIsjvvvyTGY26/ka/gA+gJgQOcyOzSAayj4nwUAVo52Mreu+u66FyRHArwuuDBnUC3J1Ci6AR6CVwG0u1JklUX8kryEpj4u62Jupyx7Nt+FT4YcD6pGxbfqzfv8wPZpl/HBQRUJyOXcei8/peGxxOZyHjXOKPT4khuOaGIzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745167; c=relaxed/simple;
	bh=M8QPdNoErhvseqN1OJfQLnvZ1KG36wzCI2ty/tnPpuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6YY8uk1Kr6BsCc6bjU6OAFM7F+j28/6r2ITtCgOeEQWcnuB/4GlyavACtugHftfhFlPFN5WrNrp2r5fBtglhGq5EYdgE9rWxQIXBsHmgE2kEHkz9pqGQNXZP23cn3IAOFvhIFegHT2UDI6DZx1VmoGz1MHFOYxIA+Cj4F+nrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mszt63BN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mszt63BN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso17557a12.0
        for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721745164; x=1722349964; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/3luC+b74oek9g0LUsZq7rzlOWeW8aiRXZj5lINnDU=;
        b=mszt63BN2Uv9fUuXZIFfaxPb/+ah5qxezP5Wn6Zwk4+6llLxldZl/R2iLZL4R16S4a
         230kSy35tNcMF+wlUIJTBAHgqdKN3+Jl3FHh2lEw0Kma6WF1p53QVOZZF0J5IXD8XQtB
         Hx9R1FtyooowBwAu/rekvFl3syYg9IS3xVAlXh2gJc9ISsCXpQCS+k/AdGoHb8mZ4lla
         OjWruQq8mW42IOzJR8nC6bNc1+RFc7ZOZaWKR4U5UrqFIbst3R7xb4VgwqQ/Gm9+M8PI
         fGDnJRHSjSYymFoeahCVgJFrHve5UrdPwdnQqFmIUs9nwzOf92koyrWm79b5o9hLeEF/
         ybkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745164; x=1722349964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/3luC+b74oek9g0LUsZq7rzlOWeW8aiRXZj5lINnDU=;
        b=kEGLmvSy5etxjfn/2LFWkGPQYlhqY8Ax2GoUNvsWMoYUkDi3c2Z4D8ZipFXTX+RULL
         ko6HNsIp4yQcd+PAEPZsm0IIhKWvgPiuXaYFic0bKaxz/iX1OXez9c2LTCxqfWZ2DgMF
         kAKl/fELOE1py7lBjVponC6+s+IHnq9IX3ZuWoG6tZqQmyrbWPqWgt7q3C4m6S6Nqynm
         nHrxSBoG8nS7WhjmFKF3Cvt+WmdQ5e9nCTAEuJ/sS6RjY0ssRsG/caHgQZOayjLY8hJX
         YKX1I4EE9fJS35AZ9r9DI4q6pF5ovrMq+NCa9QAY260O0SV1Nv4tZWUQwLpJjyAiAXiy
         tqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQ9miok6YsyO2HeJFOC3D6RWVuog1ZW2CrwtzEEwTZBaTMzZ9KA2jpP+u3iNq6hQ3N5oUQ2AnKr/MFpa80k1Ijt7bNfo=
X-Gm-Message-State: AOJu0Yy+4QNM1aW18FOPeMr/XTkKVV6N/qFHytx2dXRExVcIuK20Z3ZA
	B5SPxFXkXAzP94nc/7SZaZZiyzzlyzdv+fwKAcsZUhqkE3PFRyu+s4Tg/p1eGcaniXRm3RvAFGr
	bWzrn5basxyKsTsG/PeuVmvIW3XNBOJe+uTZu
X-Google-Smtp-Source: AGHT+IHryeGRcNZLCDA8qms03eeDbKTz45Mz5TYFlQKLM2GscLleFt9jBQNlP1av7H7byqMt6vKBSbp+d8N3aZr3M4I=
X-Received: by 2002:a05:6402:5254:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5a456a63b69mr546528a12.4.1721745164063; Tue, 23 Jul 2024
 07:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
In-Reply-To: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 16:32:29 +0200
Message-ID: <CANn89iKOa8YKYjz4jVN0R+3qCpcALTAJ_8W+pd+022jAMT+Zjw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] tcp: limit wake-up for crossed SYN cases to SYN-ACK
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jerry Chu <hkchu@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 12:34=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> sk->sk_socket will be assigned in case of marginal crossed SYN, but also
> in other cases, e.g.
>
>  - With TCP Fast Open, if the connection got accept()'ed before
>    receiving the 3rd ACK ;
>
>  - With MPTCP, when accepting additional subflows to an existing MPTCP
>    connection.
>
> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
> 3rd ACK, without the SYN flag then.
>
> To properly restrict the wake-up to crossed SYN cases, it is then
> required to also limit the check to packets containing the SYN-ACK
> flags.
>
> While at it, also update the attached comment: sk->sk_sleep has been
> removed in 2010, and replaced by sk->sk_wq in commit 43815482370c ("net:
> sock_def_readable() and friends RCU conversion").
>
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - The above 'Fixes' tag should correspond to the commit introducing the
>    possibility to have sk->sk_socket being set there in other cases than
>    the crossed SYN one. But I might have missed other cases. Maybe
>    1da177e4c3f4 ("Linux-2.6.12-rc2") might be safer? On the other hand,
>    I don't think this wake-up was causing any visible issue, apart from
>    not being needed.

This seems a net-next candidate to me ?
