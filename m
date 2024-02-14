Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4D126F3E
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934707; cv=none; b=Ofatt6XRRS7OikzNIkdRdV/wKFI3ywNG0lNRPy7miclg91qPainEg82KEvhHxHv0iPeKI4pbYp4PsB7Nby/2NNaanwEekQPhTLfbSsnV2gQHq400yzqXFQ3jZAUBDJqzL5ctWSDRVFOHaoL1+Kzbe5JNTASRBVwmJI3YNE+VGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934707; c=relaxed/simple;
	bh=K7wa5eLM30kpIgZ4hHnMWW+LPPK9kCniDQ66HlqAhXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/qDCL+hk+pkL+8Z/HQqB8y0SSgEYfhaOSdU0UK/GUxtmB4YqUn5RUAG1KUbHU16pO4lgyW7xrHuF2ppYHKjoQ2RkdJeGwb9jGP3mEm775LBNv/C477LD4eSwZ+tXQ2rWAvwwc08KTc8wDIhgzWFgXckFZEanWQ1bILpsbqi8Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0a9uL0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0a9uL0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4353C43390
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934703;
	bh=K7wa5eLM30kpIgZ4hHnMWW+LPPK9kCniDQ66HlqAhXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0a9uL0RgBtMWx9Du6IoLkPTawIRqjBo1KOva7QP/fnP95DixF3Au23sa/KHr5Mb9
	 9ftG0pyyQtOvJMMTkdN1ks3r4ilz3EQ4pzorHJFLLTzbUvjqgf6CjAsMGw0jH+A39y
	 qrjEYpB+IzppzMdHXvW2YhMwWqe4WIWwxu+p9cLNW3GTLCzPykgtnl3ap9a1lVxO2Z
	 1bua9l5l67AOHD7SGFJ6jMjBx7/l4wrpQY38yrKTyG6zOG2H7RXBvcf7M3IJ9IXjBB
	 aFvPGmZ3fDEPrJszTPSVROKgwQPFyzAQvrYmzaIgFd8qnEkfTOR+doQyrW6sZa4wuW
	 bjazAPl81CbiQ==
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc71031680so2140092276.2
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 10:18:23 -0800 (PST)
X-Gm-Message-State: AOJu0YyzHQPtEXCSY5Wn3/5xFR4r63snfFzuF7DoNlvo2izazPRRBsTy
	4+ChUZb4dTRDnyngKK+WgvLU5cO5TGjhramhF5Ah9EI2unURwRJ0Skq7FVJjFiKlqqrobmjhbNp
	AQPlLc11pOTYNWqs0oYOvoOrUA/d4l5Uexwcf
X-Google-Smtp-Source: AGHT+IGWPSmzgwhdmNYCqOERrmwPsHZWGB0vmQO9Yl7eSyrQb2b3S6Ss0mcrY+256wAW8OjkI6EddjmdLJRvSRHWFZM=
X-Received: by 2002:a25:ab06:0:b0:dcd:3f82:e803 with SMTP id
 u6-20020a25ab06000000b00dcd3f82e803mr3084603ybi.39.1707934703005; Wed, 14 Feb
 2024 10:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
 <a0979ee1-8af9-fe30-f166-33de3543d030@kernel.org>
In-Reply-To: <a0979ee1-8af9-fe30-f166-33de3543d030@kernel.org>
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 14 Feb 2024 10:18:12 -0800
X-Gmail-Original-Message-ID: <CABbSpchzSj9jn1-t_nmamRf+oH61jecwDw08mr9U1YP9dnw8Pg@mail.gmail.com>
Message-ID: <CABbSpchzSj9jn1-t_nmamRf+oH61jecwDw08mr9U1YP9dnw8Pg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] mptcp: add a sk_is_tcp check for sk_is_mptcp
To: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 5:52=E2=80=AFPM Mat Martineau <martineau@kernel.org=
> wrote:
>
> On Mon, 5 Feb 2024, Geliang Tang wrote:
>
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > sk_is_mptcp() looks like it can be called using any struct sock *, but
> > it only gives valid results with struct tcp_sock *. This patch adds a
> > sk_is_tcp() check for it.
> >
>
> Hi Geliang -
>
> This is exactly what I asked for in #453, however in our meeting last wee=
k
> Paolo was concerned about the overhead of the extra checks when most of
> the call sites are known to be tcp_socks (especially in the TCP code).
>
> Paolo, what do you think about only adding the sk_is_tcp() check when
> CONFIG_DEBUG_NET is enabled? (kind of like Matthieu's "check the protocol
> with DEBUG_NET" series)
>

Ok, we talked about it in the meeting today and Matthieu's "mptcp:
check the protocol in tcp_sk() with DEBUG_NET" patch will cover the
possible misuse of this function in the mptcp code (where the main
concern is confusion between MPTCP and subflow sockets). Will drop
this patch and update the github issue.

- Mat
