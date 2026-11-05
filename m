Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867765;
	b=W81W9aZTizPV1CLVNfCEO7lzjzZmDc2nriLgwjiGQVnTFy12Pr+EveqxzgWRe/YkV5Uj
	 LNBLDmNUf+JXg5FvKfSmWLi1h2sgz0eheJrtQ5884PDiSCEdlvIk/gz3CbJRWO05aUMO/
	 vR63USTdoHZ/K6pDKARCurezEw6pRS9kw5UyXC2m5KVS8x8PZPxANJDUY1n79z7dAbhvN
	 7+6rcPyQQwPO0O2eloFLAKfonNbyM5cYyaRi0UPvRC1G3olXY4moXDqvrnhjSmsAdTPJN
	 pC/AYJmrKvAZESxMmhW1BqiqITrGy8u/NbmsjdV/gOTwsqkQneRXJscVP7j/oZHX9mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=W1u9FFDhyaoaYsNEZxq/h1fzFfLKcgpeDrwLjzNUzV0=;
	b=EGtwdbbfSOnKYI8nnKfL7Tel/gHfFwgLryFWd0DJT5Xld7ZSLha0RrJ98LC5QrD2Tz5X
	 8lJYSWP11VyBpeQV+censZjVLjNOb1yNg8T3DqsMPhNfYbN8IaR3xIJhQ6x/rUMdXpJZu
	 wPjkzqhhsqo07aaRHsMuyAYQvV3ZK9hoO8m96bCI1L/AcQ0MEK9QoTZJpDsmIKnccHrEm
	 qTE+NZE44KS44bVXT9r6v3dg0e5AhRoBRd6GutN95vWqV96uHDtEzxp5lh2KYl/o4/DsP
	 90Za08Hcy8ll1HTHtCtRtNpAZ15mDQjDHKovASDrhrtpEoTKQCHRGxi1Gu8qRlYfa9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cd7whV+h;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54312606A32C
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 08:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54312606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cd7whV+h
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a1947498bso4520911eec.1
        for <mptcp@lists.linux.dev>; Thu, 05 Nov 2026 00:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793867764; x=1794472564; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W1u9FFDhyaoaYsNEZxq/h1fzFfLKcgpeDrwLjzNUzV0=;
        b=cd7whV+hnjkxvzXz79TqXlSxYsG4amw88tNe1ifF5/bhXm6Ty9CZ/hB1VQPw7kkwmb
         stdq5v7gDLdoZDlmbiIU5q5302btQ1Q1eeYbDV5Coaed0RaRcw9xV9leGY6OzLXxhFtS
         BuLybS8EKFdsIY5GgEEFkECrWz25Esyo8gm6Kt2wA76G5qCb5JJBuOYvDZ7yZHWoUOZx
         gHxoxNYr4X+MfQbIdw8JffYn43menGnCA9VvsAtTdBMzvuDcj8fGUqDpmuO051jWjVcP
         EdXp8nhpdqL6keqY+m1nxt7WJOQS/E6ZQOIhmn66MBlD6ga8rNxZOkBjyHHfURgVWH7y
         eXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867764; x=1794472564;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1u9FFDhyaoaYsNEZxq/h1fzFfLKcgpeDrwLjzNUzV0=;
        b=DXA2mr0hQ/gYBFWhCGSh5xJEKSodUXll/1NlQrw2IOLLnC3RMKeFVQKvhsaT684zuw
         bwOIy5ZWfm/6PhQfnRZl6Hl8KvHVpazLMQjZ1zBGIhuDWP0LiXmavA6nLNDGa1cW960J
         8uXt7OuSXXwVaR6jtkJeuoHhyXsrtWtgZJP1gg9NdPXDaOLzyc6vLakBNG7BthzbldG7
         QR6fDGSJfSTx6R+Po9jR4QRZILWnrXIeciwHYQiAnyTkeN5Ux2rYx/dtmo5jsirfaIQr
         pepXajbxXywmMhmvais0C9K354Sqk7WruIC5Ns+Z048lNSRvFz0c3Osj5JFlfLduk/RJ
         YFPg==
X-Gm-Message-State: APuU4Z9hWts0PN+tpj6JmxheudlXyUiS0hoUEQyjHHNonPjgtxMIo9fV
	KZID4tWJ+qIB4IHH1NaOWZC4IHUAko4gsIShmdIZ5zEXN+fDhz6ClnhBvr3i
X-Gm-Gg: AYBFou2IoUrXeRnxbcpyM0nZEOzIjwnZhXuLg/RTq4YVm8KBq531xBa8Nur2NZtS4e7
	1X4bqs5K6TcKYY/4MnZnmQ79Qdx4oSwuD62DszmV35yg1JtFg+o6TYrpIF9dWSs5QTEeDZg1dy6
	ypmswhym+b3Lr1njhMKC/Z7zawN1jhV2N+Hu8msPf59Zt9/xv/XxPw4ErpjbW7sOUCIpTQgDOLO
	l6NAKCNeU8gvlPqITcmHXJAHDZ/BUijeEL1syizYo5+AEQnSBHtiFNrPf7wI45Y9pvFraBDDMP3
	7q9aW/b8AzQd9InlIupNOT2UxA9XFia2KZ97QNZhRjB34Xhbc616PYR0+7M3e2/zch4Ajo0upXg
	ieAIo/RLsd4FtAr00zFN20Q7ZisNGVG3qDhHKuBgFjcf16TzBoNrUWBqrfNAEU90OReXHJs7Uk9
	s8Dduj+N5OGMfHFBZ9R1rWuJmDqc+ci0w+OQHOqCjA1l0MnVpYT4wap1GrQBYTU0kZ8gzHAftJQ
	bO6I1sZegMoGcQDBccKTC3QsSgLdkXdpoAGwGlMefw77X6Nq3GCLRH8kJ17R+wXG98/rmuD7MdW
	2iaA0pFQCo0+0eGOQAWpXaqVQ1OEfqW5CRoPR0c=
X-Received: by 2002:a05:701b:280c:b0:19a:bbe8:41a8 with SMTP id a92af1059eb24-1ac5c64cf83mr23389468c88.20.1793867763952;
        Thu, 05 Nov 2026 00:36:03 -0800 (PST)
Received: from github.com ([134.33.78.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm21459019c88.17.2026.11.05.00.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:36:03 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/7] prepare interfaces for kTLS and
 sockmap support
Message-ID: <1a38c4f9-f4e7-e017-00c6-8f81796f2494@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:36:02 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/41983965630

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/96ace799c7=
e3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1202770


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
