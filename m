Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4B14C583
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722977; cv=none; b=mTZBhCyFMHIpM9b2ksX0uI3Rx/nz7BonKUbui6UgmWJY3gCizD3dCKr4sIJvJJ5evHaxv1C7zwZWW45T4G/EbZGTUpGbDGW7sAuKxlbSufUFUYZ2EqRuTS0ZRqT0qC2dna+k5vS8ndCw4i6vecUoTw7V5jP9fxRSf4RfexodwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722977; c=relaxed/simple;
	bh=bULiKcYtzRzlX0GiORBKSEHwonRwDFkZZ43sE1qZNew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aULlYZTxNjbkC+z72tWidav7CzMnaHxOo6sgNU18B0gPi8UI63PDn60M/z1MsoAHp3Dv4/FsfrE4LfLxaMJvXN+BcAwIo905PnlpXC3fDVCNXjMrnEtWuEDQGD7duYjrVGj5+l1lKHxFcFYRmnAoZx6QZVDnEUYBRhnnP4vFhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/4JqBqH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/4JqBqH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so9164a12.1
        for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722974; x=1722327774; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHzffdK1t29wgBUTlrheqQc/1FBrMdd1f0Xh1Fa/cyc=;
        b=k/4JqBqHvtm4JixrbMCKw2iQfruM0ryNzKh2CGX/6KFNQPAuWqtbeYd9e74eoyCjCr
         u/C9U/p9GpP8PnUP0ehoIvXwvvymIRqOkiR1kgOSObjWFCVt0zAYCNfrg/Wty6qs4Jex
         zwFaR2TqROFd7R7rWoryBMI2CjG0VciDsuRjGDD4etT4O5KpMcCtK951q3213WrCS54l
         LZ/6lS1DfFG8p3cUQFSEeKwOnNB6ZStlvhemSOe1OahWgcF4E9sKpMLrzYL4qQHJAggy
         488CqUqbM1ZQsULA3MRgm1AEwheD3POM2HqheeYvzEritEXRLQW50Mpc6fyL2u8GBssU
         q2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722974; x=1722327774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHzffdK1t29wgBUTlrheqQc/1FBrMdd1f0Xh1Fa/cyc=;
        b=OxRjEVuP4kgsVM/FbNtHHcJbqWM2z9/p/434tZNFK2zN34sLW8JVeg6yq2i+RllgzJ
         HDPtLz+pU5NhvjuXLttughRFv/J2SLiPNRrVYNGffR3Y3lWhTsZJj7p9FQB79gqhsQPJ
         TtAJ41fnBvKEdmPIP/KVh4Fe1D7rr7eUypwiRibcD4yKCoBhDd30oTPjYzwSzqVKtHid
         QEbFea81uh3YQ367nl0o+XibEgFI67OOINcPtvZbBLwq2E3K5u+Tw+0cpluSm9NrWMZf
         cMiigl+w0d8xSMAr4O024BP/OeLUd+YbMJwrbhTZUM/X+tI8h1wlyA9Y17GPjuqHUdEH
         NThw==
X-Forwarded-Encrypted: i=1; AJvYcCWM62hUX6vk5nMLuD64w6wa+TxJeftBgFhixY6DqC8RQiJF9UJgI/8KNl3rnAXWUrIafCmnoYRMx/NWIfiqCdxiNtpxL2I=
X-Gm-Message-State: AOJu0Ywh2UHzS5fx5zGQavVLsd7evnWFPG8wBo7icWLEOlxfvfDPfNbQ
	wSqPnuvVO2SVxNAceKa7Qzz2Yl6wLIrlzRgMNcYdEAPw6WAi4Ebif7v1iySLlXpFex7m9P4zOC1
	O3kYsUfvdL99LbxWZi1/quGGD0w48yk466eIu
X-Google-Smtp-Source: AGHT+IFloeNOLjx98DobvZlaIXggAhKgmTEsQyFXl+zDVn0YHqOhg/R7X7Lh2OPbveWF/8Lg8FOnw+q/voxghpl33uk=
X-Received: by 2002:a05:6402:34d6:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5a4a9300bddmr484291a12.7.1721722974127; Tue, 23 Jul 2024
 01:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
In-Reply-To: <a2f181c3-92d7-4874-b402-50a54b6d289c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 01:22:40 -0700
Message-ID: <CANn89iJ+sBaa3hbPceGytu+pj6u9z7+YQ_G6eL1S4sYMfPVQmw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: restrict crossed SYN specific actions to SYN-ACK
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jerry Chu <hkchu@google.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 1:10=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/18/24 12:33, Matthieu Baerts (NGI0) wrote:
> > A recent commit in TCP affects TFO and MPTCP in some cases. The first
> > patch fixes that.
> >
> > The second one applies the same fix to another crossed SYN specific
> > action just before.
> >
> > These two fixes simply restrict what should be done only for crossed SY=
N
> > cases to packets with SYN-ACK flags.
> >
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Changes in v2:
> > - Patch 1/2 has a simpler and generic check (Kuniyuki), and an updated
> >    comment.
> > - New patch 2/2: a related fix
> > - Link to v1: https://lore.kernel.org/r/20240716-upstream-net-next-2024=
0716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org
>
> Re-adding Neal for awareness. It would be great if this could go through
> some packetdrill testing,
>

I am back in France, let me see what I can do.
