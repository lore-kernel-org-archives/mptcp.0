Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879475;
	b=VLTEdHEbT+jlkcQq9QIRRYqr9co0A69M4st7BRj3jYWi8solUQ4bzuwdvHxESxLMl13W
	 2qSYLNoXpPGFwy2Dj2CoIXkZn92tptOrrdzKSKsYXleBi9HvCxeor4y9AlwvtCvW1JnY2
	 5O3hPRnryn99efJQfONLTtQycjEbtyG2Ki7QlMbsSccOtKK4tbBLl7fRvn6/Vd3HbqEKQ
	 9E+W5zkZiC3+mPeq1J5Blfretg4CUt2PQGSS1NUE7WerK5wu+MFUCOhwsocWpBPNdeWNK
	 WAhKGG66HVR9eV/EJ6vKRBKt4bZD+Ira651I5WeiqkY5XnZys+V3EgXr4Vbrk2fsLvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=aRJEo7tPWkr19BGiu2Fnd/PX8UkgI8hfSuInHie5Oqo=;
	b=kroKctQ9CROobn6n5WVNSOJyvVzuoDLnFfZMu2313bI4K8jhjjVTJMVrs/xkvgh4HBKx
	 W/nm/m/GRRbZ/YD3z+cwGJNpz6JhRrXYC/IWkcFOhS5O9tCP2ONrMTm6JJfs0PKfHpG/W
	 wkfbNItn5ULN5dzKghLllhbrkSFrEBmzuH0cX1Cg9R07Lwi2nDLmWBWCsLQTQop8HIJWr
	 vMkrXu+rQDExVkitECEzgjRsCxuF2uQclyXMEq2l4T1UAEwW8CGED4WRLduakHWdI8lUf
	 d4flb4rhNkdjhQfdsvdpH+qFyenCWMyxTk0Hftstle5vuguXSOU5f1U9uAVFkMYadmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S9Vy/DoX";
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5274606A329
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 01:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5274606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9Vy/DoX
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-716b58a4365so2675064eaf.3
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794879473; x=1795484273; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRJEo7tPWkr19BGiu2Fnd/PX8UkgI8hfSuInHie5Oqo=;
        b=S9Vy/DoXKg4A9t8L15/BItdeHe784+E/ah5icXsByLsihoiUq074YVtk38wsFv66XP
         oPWm8Z3vmrrWlnmLdzjHCIjvVSJ/IC6PSK4HRbhO0gHePK+/n/EU54Dw6R9XtSevhxzJ
         J657NVvh7tlTCoJWYbvzLRPV1tzKrg9zy+RHhEDk+WV6sTW4JoZQUTD2khogtNMweQhl
         w6BAuZOtxizmWknzqDlQp6ALru2T/HIe1CaEx8Ax5I5M7ADfwlYPdFOLkgqSF2jVNJgO
         bmIDzUNSSNfV/j8NNdk6p9k82YaUGH9TvPy8NyEoA4S4StBY3EUEvqDTLbA/yH2SJ6ju
         uqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794879473; x=1795484273;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRJEo7tPWkr19BGiu2Fnd/PX8UkgI8hfSuInHie5Oqo=;
        b=Fz4WfTESv52XLuRoYwuWxY8Pqeha7j1ectLmeMZo6OUBa/EKVOYPHvcsMV1IxR0tWJ
         LGKRyXelOVjafj6yAE8NCbv4Mm7bi9A7JD9X74TnuJoDlWpfHJKZAMH59hKdwWNFtD5q
         Wvub54vUBe9IOa0SRW9EH6GvuqGObJCZx5kNi7lQErB/ocJnfSo2lYybTi0wp2/gon9U
         0eEgp50KgcFtXtb40B2W4EgwOAl/MUP0kW9M4zUzTGoR29WizEp0i4xJ5ahK9paKzc9C
         iEx8z9xqeq6h4W0T2SxxN2aMXmeI3C5JqRyIl57RJxSZrPsTKO/YikrwQDl8BF+r6OdD
         4FEw==
X-Gm-Message-State: APuU4Z9wCfiJ4AT6EOoRWkTCYcvJ0Zl+BRWNh2b5SW9s4FO3HFUTO9dt
	1+pn99bFVkDN0JVQXeSv6tJNGZIgTh3aCzmcotVQXe4O4Tq1bH9s2EY=
X-Gm-Gg: AYBFou2ZedQ9KK0cp17bolAWZRrD2uqhO++rYON5wwJt9QI4VTLguxudO9QMn6VlQQo
	7jTlxacO5+/Yu7Jw0xUz+EmJJnnnxkuS95HAsb7a3NYVPr9RPDT/jmu5+iKageu8u8M50hY1jRX
	3ptbaMS3KAJUTZeUMT7kElz3Fx0oC8SBfAZbDYe8yx/4whRHj61/W2Wt8vtviaMDY9DgNn049/e
	Awj4SGBEllh+ZyNNIVSpv0JmdirCJNv0clH14IzsZn9JlQA4jyNFafIHHcZsYLwDzoTHEWFF8Mm
	iS1MDsnUdkL7CMXlSQRJX6fIQoYwE2dk/YLOQ8L9zJSxA2UGtqv5zwfsB5spOsIADUuV60xN7DR
	pxpM98gr3/+pzNoHcdVM/0KjfWZouu4rNPFz6QfzcjJXUbW74WFGr5g9lPJv4eLOuy1v87vSXmK
	DEdgNH05+qpwda9cHpBsoanrwX4opySHQbAKYwOZ1FxfpCkoewEiMjHdOoTeQ4p0+k/nPly7ScE
	L0JhW+iFBAZOroAvqquGwr+1Xm9jP6SMbif3XuzElbtGob5j7Uo51iGjhkPzlLAw5x+TBIQDSiy
	i8SKhilFRbnj0/BlndfR4lfYW06hHG2SlgdahLxMfA==
X-Received: by 2002:a05:6820:83da:10b0:71a:f082:3c7b with SMTP id 006d021491bc7-71af0823eb8mr2624494eaf.52.1794879473465;
        Mon, 16 Nov 2026 17:37:53 -0800 (PST)
Received: from github.com ([20.118.39.253])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ae860ebd7sm5432989eaf.8.2026.11.16.17.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 17:37:52 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261116230555.2305867-1-kuniyu@google.com>
References: <20261116230555.2305867-1-kuniyu@google.com>
Subject: Re: [PATCH v2 net-next 0/7] tcp: Prevent tcp_collapse() from
 bloating queue.
Message-ID: <8d71699b-58db-c174-2c07-b4b2a1a62037@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:37:51 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): =
validation:sched-weak-secondary =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/439843=
29957

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2bc9687ac49a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1213235


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
