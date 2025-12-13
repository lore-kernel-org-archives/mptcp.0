Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE03FCC
	for <mptcp@lists.linux.dev>; Sat, 13 Dec 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765612643; cv=none; b=etHZ5P3dS82XBybpjO9AdMlFLP9VDczuMb8cjqH/SJ2FawUZjRTfqIvgQZSxvPznnbV+/Rf49Avpe7/DF+UzfZ3yBILQJHMPNGY5Pbw04jWDJWZ4KKXLyg7muLSB1C7jwJzetXXTrYgcJHC/zKoRknIIuTiF+AstWu1118JqQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765612643; c=relaxed/simple;
	bh=BAaoRqxUkA+bqn88hmHMrVwt5g/iM0nJsolOr08RfVE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PicRe3IEPemHCFDYjbHc1/LO5i2+ba0tAkR72F+Cjx6dzrrug5CFIMKwXGLoTOghk37AXJkV/AsFtxHEsx6Be3l3/ysg7/X0v5/H4VVdlw9xXg4Do1HzoMFGm2uWnI17Q2LvYlyz2Oh4REht4inHwXeroXD3FFhHNiZxds74poM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyG6hzh5; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyG6hzh5"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8b9d2e33e2dso288950785a.3
        for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 23:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765612641; x=1766217441; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53QutDkEL8aH9IjRwtxyF5h/Eo0VehNjFz70h5O7NX0=;
        b=AyG6hzh5G75Ua4Ql3HUCvQglpPvZsrPbkTMvtODKcnMYDsEs2HoGhAp56E2jenzgzd
         7B+nbIuUGUVmqN8O03la9NhLlvlLm+XAEQrIAOYH9+I28N+BqqEt8bd+rIoNccHtlDDY
         hpCYOyFoHUI4LH9nJDz0NhdQUgQey/ebUjYgnGTSn08wXqnLsDLryp/TtYvtRoik4RIs
         sLErWMC3Jc9hddLK38lIHwDqoR90bsBn/+tsDpDQF9wKhNLNOPOhGJlbPoYDmLxtjBbf
         dL0l536ovvysaScO3c+Vsz9RNapXwtDKY/qUxr53ICNai20hOqUiaMKMw7Jqjd033iRi
         K6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765612641; x=1766217441;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53QutDkEL8aH9IjRwtxyF5h/Eo0VehNjFz70h5O7NX0=;
        b=BBvSIzbdKx7rIA5LJs6h/MEMg7PC3eOTL9F11Xza/MSM2DUqkN23FHRVoTg4YUGkUS
         WolLejDZAv0R0Y+P5WdkmDdEv7C5L0AHqTezXu3qIkeEGjyPqf51FOU2GnFwNIa5zcJG
         nCMD4pjd8B0OSuAOHYa8xhRbEhze3PKhegqgS3Ej4B90A/3WBr008J+pk/lBDFiCSBhX
         PymfAHpdZ/AckAAzgvnuvmNfcLlnntlI/n80EZgWJzHVFY25mVB65ITPstJa7P0KHCOE
         4ZNTTkE42R2BIspJc5PQZsvlVdmYIPiamsJTAtlXZKpgqrToqGVk+5BwVeGxivVj7N3I
         VuvQ==
X-Gm-Message-State: AOJu0Yxne+cVln2tnoE5nq45nr8XAkQGEfFNH4VlMvdZ7qRdDwEeoKlC
	EUSLs1A05fuxkDncmTQY+aEUNCx4jbf8d6jaSQGV/zCHZmTcYFZ5V2kCTLM705M=
X-Gm-Gg: AY/fxX4Z3tn+elxdByDcyb+LWFeSdrF+xlN5Qq34INIpCstT+9fFqEGfdaOm0b9TfOp
	sGWNv3+xNay0bvsuoM/AzUqzNhqEztMh+G94p+JmqYSN6DtRBt4f5vcjlC3Gmt6rRff0z75sPBO
	qLX5wJMG8rWiPqoeJOzW7oN8KdrGefceqYszi4ambPbZB1khT0JF7Wycl+1biUx6TAlrqfZ5nDf
	zRE6fUXyAM1a7ypGEiW50nYL977SmTi3Xoc3tuRgs/JXniX1WIgtNjfJZtRydo6eIs1LZ4ST3px
	GQ09Qll2ow5/r51MjuYiwIgZR5sqhdQWXFMG8DWzI779wveMNjn5aQXy171wagM0MzmiiqtHJ0T
	+yyji01t2rq4GjoIxInkLXxWG4o6jPpHWqoUoipnyzzaSsdTK3szpIJ9u76UG29Pg+ZH89+6CJh
	xBF5AsnFHPhM0TmayfVQ9zyMYXLg==
X-Google-Smtp-Source: AGHT+IH0Iuk1lsvcVltAOsTsoB1ICinlJcNUxuPyor/bYnL5dnyQVH6mmsVV0hhAgrqRqcRlMW74yg==
X-Received: by 2002:a05:620a:470d:b0:8b2:7726:c7bd with SMTP id af79cd13be357-8bb3a3871c4mr650308185a.62.1765612640694;
        Fri, 12 Dec 2025 23:57:20 -0800 (PST)
Received: from [127.0.0.1] ([135.232.176.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d3da25sm630947285a.44.2025.12.12.23.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 23:57:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1765607485.git.tanggeliang@kylinos.cn>
References: <cover.1765607485.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] add tcp_recv_should_stop helper
Message-ID: <06e8c4af-8a0b-d32d-78d8-1a240f7c997c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Dec 2025 07:57:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/201885=
43480

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1b24ef0e3abf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1032825


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
