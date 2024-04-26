Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E3613B798
	for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115586; cv=none; b=GKjLQ6grZLH/89Jy/2ExQdssihJNguT2sp176kn2Sq9lSlEE2oLoFvcZx7Lc0Gb1VhjyqkAejcw3apSmOIV1NdGoVbjlAnyJcpd7NXqAdXAT75UZyq0LM+FYQcYvoLI3vEgWJVbQeefmbDwM4m4oSS01n3nulK6HesVU/L0jbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115586; c=relaxed/simple;
	bh=Z8twm5a6rAU6hoLxYkCo6bCzS4fAeUn80m/9Y8e0lV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLtFd3ytPE2TbnebUWk/M4tZmJj896H1UT/+e3f4gpRfJlLWX3kfA4L4qBrBHfn7cpiLxBpnYaDJVn8l/ApEQQNnKwoBiZX0PPL4Xq/3aQ/4Dd7dP/qAXvVbow/1ttvQhBgazAuOTltnN9nlOW7YpTSgblxE1zUnIOFlVokCPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsXxc8WB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsXxc8WB"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so8368a12.0
        for <mptcp@lists.linux.dev>; Fri, 26 Apr 2024 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115583; x=1714720383; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpBsRzG2GqU00foP14AueqTQMyi12MhjyWao42xVQ/w=;
        b=jsXxc8WBuU792PMv4lOSoF3Ay7LgF6246/CDWK31IGrurHQUCAKG107lM6Fqipp4ul
         ETk6CNvUeKVtt8xGP35f2QLNIYMDo49giVctDxyj7WTDl+tiMqj+AWRmzhhKfK+fjauJ
         zThcb69xkCtgOSNu8iUPqBGxFLvOIB25I1Dbg//KI02V4wKGeuN+WBxH6xaqQHepikjk
         7sb7bvekgBoibriMbJHNEPX6wL4DQKRONIdIArW/fw9YAffXgUrwzbhPSMM0gtdh6p2l
         O+AZWUzAh6teXXVNOt9N5o5YZSVT9o9eWvD4ndYToe9U/7nesm6KZK5XX5K1yrTvgVux
         CXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115583; x=1714720383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpBsRzG2GqU00foP14AueqTQMyi12MhjyWao42xVQ/w=;
        b=aHIDEpaRhOlw087JUL0CuLz4xaqmlemC6MAHV/nMCNhedOcCThsTvxhAMcfCR7o8dK
         cf8h6zrE0U6HvXaYr5ujUNw1EFYILHHnvlTzymYTAWuQ55SsnjWV15fM47foZdz825aK
         E8oa/TTQdAKgx+Ys/8N5LouGeefUWyTUNJjLs3QmcAxmDxSyyVPAq17ukZzxdeVrhlFY
         bGszxoQmMNkB1ajMJ4MWu4irjlh1z3o4m4Gb8WsmaKHE0sQPKs/Fv+uGPQP4IhgJAYJV
         yRSAI+EfLMSe/mviYzNhQDMADQMmwMUXGJIMFkbDBylExmGDS8H6XmG08TYFo/gDnU/Y
         jHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU93uUiR8MztDatMaJ6oWswDbBLnJsFSs92aG9qmdyPedqZ+YMnfi5zc/18m1Bn8nRJNpUIWUEBukP9jVhVVnZFXU14seE=
X-Gm-Message-State: AOJu0YzAa2S2Lvmx3LBGyD942qAK5ToZrIUzeumia7xXcJps5uF3eaAo
	I6yo1PnFP2CFIXyuE8eCg80cJ3IyVGX6jhSretRqwmW7B5UIpWXeLY5Rc18BrZGppDylS2Yy2XG
	iCnnlj62gyZrFhJJQ/zDyS9hAqc1S7HoqZucl
X-Google-Smtp-Source: AGHT+IHasITeURyfkVcPH1fs8JhvuBeC0DqAQnZkxIkO2RqgOhfI3UQSj8vllz7Y/diwljBek8rJh4/IAjV3zO6mCdo=
X-Received: by 2002:a05:6402:3139:b0:572:554b:ec66 with SMTP id
 dd25-20020a056402313900b00572554bec66mr60527edb.3.1714115582637; Fri, 26 Apr
 2024 00:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:12:51 +0200
Message-ID: <CANn89iL=eyCvykHUvViQEM8iM_y66-acuhZD4M33o+JySV+HhA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/7] Implement reset reason mechanism to detect
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:13=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In production, there are so many cases about why the RST skb is sent but
> we don't have a very convenient/fast method to detect the exact underlyin=
g
> reasons.
>
> RST is implemented in two kinds: passive kind (like tcp_v4_send_reset())
> and active kind (like tcp_send_active_reset()). The former can be traced
> carefully 1) in TCP, with the help of drop reasons, which is based on
> Eric's idea[1], 2) in MPTCP, with the help of reset options defined in
> RFC 8684. The latter is relatively independent, which should be
> implemented on our own, such as active reset reasons which can not be
> replace by skb drop reason or something like this.
>
> In this series, I focus on the fundamental implement mostly about how
> the rstreason mechanism works and give the detailed passive part as an
> example, not including the active reset part. In future, we can go
> further and refine those NOT_SPECIFIED reasons.
>
> Here are some examples when tracing:
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNOT_SPECIFIED
> <idle>-0       [002] ..s1.  1830.262425: tcp_send_reset: skbaddr=3Dx
>         skaddr=3Dx src=3Dx dest=3Dx state=3Dx reason=3DNO_SOCKET
>
> [1]
> Link: https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10Q=
N2WBdr+X4k=3Dw@mail.gmail.com/

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
