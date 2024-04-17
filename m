Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614D27701
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344533; cv=none; b=QKD+5hDULzb7qKe2pKiOavnrJH5R7+/0rNzbcx85SOiZEKbRsh3S62DgV7JZxiCpkshhBu3KociUgSX3x5lbWSo4LY6pmWdVTpuN46qV1XzhWSeiex0ewxK8P/8Wg/61p4x4883RUVmUTI/5xzlDGH6fmelxOVu1599w/DLU1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344533; c=relaxed/simple;
	bh=co0vGStyxzs2wYudwfZgCahyCD+9GAQnQzEr1hx3Sl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r246xP2qyBENPXcZ0R8Fz08yiNGXcxrfTn2wuDv21WRD0PSmoN1vp0Vs2STybNtJPSWXdKE6y/x1gcdMC+q7a9d9UTegt8sriVksXfGZfh+xstRPfQL7wh+bOkmwd1mSrUf0BgTkhrWXDmt89+r9dXIIt6tsVU+BPmidxWBGJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4DBjELz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4DBjELz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so8382a12.0
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713344530; x=1713949330; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAY8JMpfOE+rjYgFlJjU2Fp0QQAa6jroDez9CFZ6FKk=;
        b=y4DBjELzAD26WwJnvJXKHpvwK0umwj7qtbX7F/Enr535NXvvrHbl8rwsUv2nPFH0/p
         avJg+1dqRUo7iSDb7zPl5rT/FoeRBA2ceMLLNmAjlMUinKn+TJSjCA4zumRnKU0Ef75f
         NeJ9TqQXqvfZGfl6UYLSODv7ZD+ikG/eMGW+9lV/tnK61tU9dvNe8/H5qiLQcawqXI6p
         CgiBak52vgwxup0WyA4h5c5s1XxHJ6alWj4FZqki3yVHizGuuU6HOXzwt7OJMpAEJlaH
         92gD5hZsKQXQKMMm4xPn8/3g5WhzFPkH8Tc7cywdETCN0SppKZPS0ORuv7NZpzaiHglR
         OM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344530; x=1713949330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAY8JMpfOE+rjYgFlJjU2Fp0QQAa6jroDez9CFZ6FKk=;
        b=XT6vpJVdbya1s1jB39pJ5nyJL59445i4AlowPFGHk3HJv5ytJ6NFurjWUodNA9nzLj
         vXTgr5pYRauDjN7Nd/ncLA8tRxeSMIghwjVqTqot7aQ0DrgThGZErX5ADSNSDo3avBpw
         zKwyl/w1T+rUucn2RhbEcHjcbimzyjvalbbRO0mPwgD0ruAzyxevOKdLxD0GyHqpSqhO
         DWrfvbZd8KcYn+9LchZYd25HMHv8JnY+kZE7Wkg2vUsUaxsWNphEmr2cpwEi09H3pgHi
         /37gzuFvZowjwTv4CJqMWgf9Oq88Se7RATBeWXG+z58e/qBeO9rxB+TDLtjRR7VQ4La1
         cR8w==
X-Forwarded-Encrypted: i=1; AJvYcCWIhbvyedNG3jzgN9UZ+vPpYIgTIJasFyYZZmQ9jn2nsy0QOa3U4sdjMaD5+aPgpxoxmkzBST4+/LKzvGFLRsHaNejgsqM=
X-Gm-Message-State: AOJu0YzV8Rx/lPXVIR0JrdKj/G6sKIp4b+lmDAMSDNktvSlG+g9MoJPp
	dHLxWZq0O8Wcnhi6zY+U994BvfGmerCH4MqGLf5TE6O3x1adyVCijWj+THqktwq6Izo5xWyCUok
	taTyP5eSczjEJGxd4BmwFxpRS4fQsA+QcnLHv
X-Google-Smtp-Source: AGHT+IH4cUad/wnQKLE4dWvHNWAVSWHtbhac2FgNRdt0BeRKm1vTHUByA1AGiXIWwXcHIzNQLrGDOtsihbDKjDzHamk=
X-Received: by 2002:aa7:d9cd:0:b0:570:481a:8a1f with SMTP id
 v13-20020aa7d9cd000000b00570481a8a1fmr108872eds.5.1713344530145; Wed, 17 Apr
 2024 02:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com> <20240417085143.69578-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240417085143.69578-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 11:01:58 +0200
Message-ID: <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add a new standalone file for the easy future extension to support
> both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
>
> This patch only does the preparations for reset reason mechanism,
> nothing else changes.
>
> The reset reasons are divided into three parts:
> 1) reuse drop reasons for passive reset in TCP
> 2) reuse MP_TCPRST option for MPTCP
> 3) our own reasons
>
> I will implement the basic codes of active/passive reset reason in
> those three protocols, which is not complete for this moment. But
> it provides a new chance to let other people add more reasons into
> it:)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

My original suggestion was to use normal values in  'enum
skb_drop_reason', even if there was not necessarily a 'drop'
in the common sense.

https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X=
4k=3Dw@mail.gmail.com/

This would avoid these ugly casts later, even casting an enum to other
ones is not very logical.
Going through an u32 pivot is quite a hack.

If you feel the need to put them in a special group, this is fine by me.
