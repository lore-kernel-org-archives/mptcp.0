Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFD1586C3;
	Mon,  6 May 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018429; cv=none; b=Sb49XzOz/lGFE+wQVyjb2NxsJ67TXmywU3kYpITs2qhKQtbBrTb7mobCfUcZ2QOlwSILuLAcehO5t09efJSTRTK1EcHJUb6olSQ04b69PxXR7cCP1cS5HSjB2vkWUFhzilJq7Mb/YNJ/NVf/AOrezYn77iuvDVoWKSHBY6w4igY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018429; c=relaxed/simple;
	bh=no6tilYKngaoTOqfGFWOgA/5oNjItKCJRl53C/eguWs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W/uc86Z81hbgidYQ44p8Ud+Va+70P2Qp9wl95/kZLRVYsg33no/vD0QtG8PGnoZjNHR8q3gJW/+ewSYKjoGfPwUMOhAB3GHx3Iu70C97zVPXF+P81F4VMsMxEc/PDeZ5p5s1v6CVhG9Gn6R5QVDpR8uCiW05qV/ujSFE1oWJNTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtvuysZA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtvuysZA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792940cc66dso134053885a.1;
        Mon, 06 May 2024 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715018426; x=1715623226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewxWon8y3EC8f5KNKIlRB63vgk6021CZpyEJEMa3QaQ=;
        b=MtvuysZAjzU8J97qoQtzeOX2yKrx2hsvn/bCTWWCVjGa6/Qk34fJDIoamwnFCY2ecy
         n0WysAmlRtQuXswaKFiMZvtpG7bUDIeWHbgrPQEJLArCR0Z24vnIA+EieEMbChOkTQoW
         nzUiVwxa/Pj69yWpOBdSCayU7IzJOhcJ/BLs4v52YznAAPNa1LI/PgDRyklNU+tzCv7h
         2zGai5WAlwi9gV/X1W2rQUV42ogFLEerSnMkmEAwIVHE5Y8ZbRcz6BMNJ0pgMtKXiKkJ
         3ZmN7v7VbIbvBmjbN4W6BHuTfSAeSjXHp+cqRcHtBvBtG43s1siCuq2TVf23YpCes9vM
         xV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018426; x=1715623226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewxWon8y3EC8f5KNKIlRB63vgk6021CZpyEJEMa3QaQ=;
        b=XYkqNwvXno2C1HQSKF3WiMHqu/lmkrHaYmwBKvSLb+O6X1rk74TmBSnDxi0VATAB+3
         bi08s8e4YxZFE3Vgu02YYO4/TPPFQD4u6RMRugeOMV2guLTRE7voCwRa9xgs4YxcIVHg
         ChN2pcgMpAWYu+TAlYkLmUCCzzwYQOGLC1cQrGMFPW6ODXK6EISs8XhNhRQEJiNl+og9
         9aUai88g5iboyGEDgfwraWzN+HmLMJ87Qc7EELUqTiJlZP5zjA7W4BzCosl90zV3/eLf
         6gxbr9hEWyquy4qkypX7ym9BWMxcde2XdMdGIgDOkDKmag7jl72h81Ho6kRvF2BZvmU/
         K75Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFnEG4EWYnYwxd0koroNfnGzulOrZwhIwYjnXIxG4k1X5rilsZpQ5m8HoIZIq6i6Ynj+OWXpsMUxIYeXQQ74BJVD1eLF16FxWDeae7Gsxn0CQR45BQayZlyS8k
X-Gm-Message-State: AOJu0YwKKIkBWJsHA1ZDrN/XwzXRbHSF2tChIolmfY95rcm6Af9mYKvd
	c1Ds6qKPDNwrSqaC5LMiucYn0FU7YUfIYeqPDNLXoSZsmFDNL0/p
X-Google-Smtp-Source: AGHT+IHwxi+MsesdxS51NMGdi8E37iQPGrsyCgG+iNUpxejrVgz1gYPJSIt1PiQCGOpKWPnlFwfCJg==
X-Received: by 2002:a05:6214:19e8:b0:69b:17b2:df34 with SMTP id q8-20020a05621419e800b0069b17b2df34mr13732146qvc.63.1715018424782;
        Mon, 06 May 2024 11:00:24 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id qb17-20020ad44711000000b006a0e585dc77sm3903456qvb.70.2024.05.06.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:00:24 -0700 (PDT)
Date: Mon, 06 May 2024 14:00:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>, 
 richardbgobert@gmail.com
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 zhujun2 <zhujun2@cmss.chinamobile.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Benjamin Poirier <bpoirier@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-actions@lists.infradead.org, 
 mptcp@lists.linux.dev, 
 dev@openvswitch.org, 
 Valentin Obst <kernel@valentinobst.de>, 
 linux-kselftest@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, 
 llvm@lists.linux.dev, 
 John Hubbard <jhubbard@nvidia.com>
Message-ID: <66391ab83771c_516de294d7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240505222639.70317-2-jhubbard@nvidia.com>
References: <20240505222639.70317-1-jhubbard@nvidia.com>
 <20240505222639.70317-2-jhubbard@nvidia.com>
Subject: Re: [PATCH 2/2] selftests/net: fix uninitialized variables
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about three variables that are not initialized in all
> cases:
> 
> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> not "ip". This seems like an actual bug.
> 
> 2) The addr_len is used uninitialized, but only in the assert case,
>    which bails out, so this is harmless.
> 
> 3) The family variable in add_listener() is only used uninitialized in
>    the error case (neither IPv4 nor IPv6 is specified), so it's also
>    harmless.
> 
> Fix by initializing each variable.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/net/gro.c                 | 3 ++-
>  tools/testing/selftests/net/ip_local_port_range.c | 2 +-
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index 353e1e867fbb..0eb61edaad83 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -110,7 +110,8 @@ static void setup_sock_filter(int fd)
>  	const int dport_off = tcp_offset + offsetof(struct tcphdr, dest);
>  	const int ethproto_off = offsetof(struct ethhdr, h_proto);
>  	int optlen = 0;
> -	int ipproto_off, opt_ipproto_off;
> +	int ipproto_off;
> +	int opt_ipproto_off = 0;

This is only intended to be used in the case where the IP proto is not TCP:

                        BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, ipproto_off),
+                       BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 2, 0),
+                       BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, opt_ipproto_off),
                        BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_TCP, 0, 5),

In that case the test tries again at a different offset that accounts
for optional IPv6 extension headers.

This is indeed buggy, in that it might accidentally accept packets
that should be dropped.

Initializing to 0 compares against against the first byte of the
Ethernet header. Which is an external argument to the test. So
safest is to initialize opt_ipproto_off to ipproto_off and just
repeat the previous check. Perhaps:

@@ -118,6 +118,7 @@ static void setup_sock_filter(int fd)
        else
                next_off = offsetof(struct ipv6hdr, nexthdr);
        ipproto_off = ETH_HLEN + next_off;
+       opt_ipproto_off = ipproto_off;  /* overridden later if may have exthdrs */
