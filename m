Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2F1EF0A2
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300490; cv=none; b=hlcm0ImigQIix4DSH4JR64TSFETYbL9uM27W4oT68SogJlV5w5HjISr/lf3Ml+jj8Fpxf6tYn2JZLyl702xH2DSpJ1j+mceJeVp/+wwV39Oucscq4cSULHKDkC64oc4owToVmz5Ih/hfHmcbBfcjMqvUiTZ6hCsrXAsdXbocw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300490; c=relaxed/simple;
	bh=s6cBiL9Hq0Q20TzyA2dVWFduhAA/rN8bWvy+wmTLmYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgeFY9SWodhy9AacF8Lj4v6f5fJO/0iRT6GAgJq5h1b68BIiBUZ3zfarbe4MBHUb64gxuzhJ8m3o2cvMPC1bk0XBAJu+i/GSf3uppDgwuqfnwhOxt5/0B/mRjooUFkA3cixq6Zels6z1/gNE/nDSXL5kT5aF5TpghdKaP5fqYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9abe139088so996135166b.1
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300485; x=1730905285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcefwH6DwVLO3jkdi4UJLGk29QViGQKLdm89K+/T0Ig=;
        b=EqpvpCDNn101J5T2tGjSmYEQJTXJOCgjE/fxyCQhciNHxxIUAXweJiZag5X0eZP1gV
         eXioqgaO4CmW/updn+DkQcBJIGR9cqmLRddL0eledpN3+Lb2EqOaNVyar7h7esiWqu7B
         wXqYqBFmi2eSOCf1HrRTE60XaPQli//uwZaeFx7AgQc5F1QKug5sPEKsp2gEeIggHbrj
         /yHhOJQoVwlGCIuMUXoIrAlpgz+yiFXZHdvQgiuOvqDKHu1N2aTa2itI4xI7MU5kGsgD
         ODkPoIk1tHIrU46b/ZxFZcRCZ1Cq6wDHN+A1HK3Q6EjrQiOBdZAjFhO/7Njpws1KUkFw
         F/fA==
X-Forwarded-Encrypted: i=1; AJvYcCVT9cmNdQ8B/RiGATSm3Ol9GdXbiAzNrDPonrLHc+U+qDUo18E+kwYJKywPzzuDckkk6LobjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGMX2fbACvYTzf9vDe8J+J7V8YhZ3B/qzCcvgL0ekqzaF7Pkk5
	EedRooomx1gFzQvBcNvVKyLvtrC63lX+RAOppg3ZvwkGhcFKBhZn
X-Google-Smtp-Source: AGHT+IE0mMeXCQD6h1yd6THZC/eiGg3fCLvdBgMNwVez6Ft/Ssxur1UOrug1MDpyzVlJbd/JIZBSlA==
X-Received: by 2002:a17:907:1c22:b0:a99:f1aa:a71f with SMTP id a640c23a62f3a-a9de5c90d49mr1630487766b.11.1730300484919;
        Wed, 30 Oct 2024 08:01:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631af22sm4800577a12.77.2024.10.30.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:01:23 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:01:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vlad.wing@gmail.com, max@kutsevol.com,
	kernel-team@meta.com, aehkn@xenhub.one, stable@vger.kernel.org,
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling
 mptcp_sched_find()
Message-ID: <20241030-hospitable-sweet-chicken-f71faa@leitao>
References: <20241030140224.972565-1-leitao@debian.org>
 <e891f590-7dd5-4207-adef-d90b90172aeb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e891f590-7dd5-4207-adef-d90b90172aeb@kernel.org>

Hello Matthieu,

On Wed, Oct 30, 2024 at 03:45:02PM +0100, Matthieu Baerts wrote:
> Hi Breno
> 
> 30 Oct 2024 15:02:45 Breno Leitao <leitao@debian.org>:
> 
> > The mptcp_sched_find() function must be called with the RCU read lock
> > held, as it accesses RCU-protected data structures. This requirement was
> > not properly enforced in the mptcp_init_sock() function, leading to a
> > RCU list traversal in a non-reader section error when
> > CONFIG_PROVE_RCU_LIST is enabled.
> >
> >     net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> >
> > Fix it by acquiring the RCU read lock before calling the
> > mptcp_sched_find() function. This ensures that the function is invoked
> > with the necessary RCU protection in place, as it accesses RCU-protected
> > data structures.
> 
> Thank you for having looked at that, but there is already a fix:
> 
> https://lore.kernel.org/netdev/20241021-net-mptcp-sched-lock-v1-1-637759cf061c@kernel.org/
> 
> This fix has even been applied in the net tree already:
> 
> https://git.kernel.org/netdev/net/c/3deb12c788c3
> 
> Did you not get conflicts when rebasing your branch on top of the
> latest version?

Oh, I was testing on Linus' tree when I got the problem, and net was not
merged in Linus' tree yet.

> > Additionally, the patch breaks down the mptcp_init_sched() call into
> > smaller parts, with the RCU read lock only covering the specific call to
> > mptcp_sched_find(). This helps minimize the critical section, reducing
> > the time during which RCU grace periods are blocked.
> 
> I agree with Eric (thank you for the review!): this creates other issues.

Let me comment there.

> 
> > The mptcp_sched_list_lock is not held in this case, and it is not clear
> > if it is necessary.
> 
> It is not needed, the list is not modified, only read with RCU.

Thanks
