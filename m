Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72841C2E4
	for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683018; cv=none; b=H+u1EusXjSITP4nXKQVqCR1bo1szsHbXwJhx6rc34DdiX7ckcjV9L7v0deQSqJ5X3epbVFSmteehD6RtL+x0DfQcFICwXY+exy/0B/1KXXUTanJk8fi4FEaHZSB4aPe3U3xoaKUoRxJdUMF6gxSXLkCDEROZ5tP4/1ecVCenk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683018; c=relaxed/simple;
	bh=uh3uJMr2RiWEThcwpHqhZNaJZWZBsTyiL0nzoLlhDL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Y7rVlX2PKRWTplA/2thketA0qkh0lHK+5/N839uJkVFBRdWLqWDDiDWxFSzWfVrp6QaQjbDnfNAJnNn4Y1KgxdpDOZqPhrN+OIG+Ye1EJUE9L4kTpwAXPJ9ZhtRDcYZbl6HttOCXjSwPEhETTRBWbuVEJW7kCE2BzQCf9sh0sNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxejyPr+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxejyPr+"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e622cc874so40458985a.0
        for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683003; x=1784287803; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gIZXTYPukxDsy7JKlNtR2rQdCR9jhIPpZ/e0cYLoLjY=;
        b=GxejyPr+tQh0qvRD7WQhgmuioTIweGXbnC6p/99p40sqewJA/8O9YrSLqjHQGwpbtC
         JwI9rxROWemrYVrH1tFFabsCQxUjoXsk9kIuRv2jk2ir7Yq59Z7yO6jqbjQm/4CXblXu
         VP5mSW9R4oq7K3yiBBrZ21C4hB+R/FTNFoRBmyHnII54UVg0NTC5MOmEV6q+QRWQ9/5q
         QDjY3xhRYQYYCVBdIp8a1KLEkJ/piy6wiWziDTve84pGxQRf+PC/yICnpY6+WT5D9hcE
         qj8AgB8HeJ1a78hATkCwmXMRpbsGThKAwyfquhcpKdwo4BGDAkmD2BN8pnn9On8rtrpZ
         Qz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683003; x=1784287803;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIZXTYPukxDsy7JKlNtR2rQdCR9jhIPpZ/e0cYLoLjY=;
        b=mR1dw0hxeeIFetItyy5yBJqHotzvsgxesblLbfxMuWts5lvtn8uXZcUwxc4iLPNVp8
         rku2ZRgh+bMyhMXCfOFySvx3u4wzqLcrTSBvLQfurMBbVNgAZf0ZJ0rMEW8J4I91t7gY
         thX7iPXn/AKOJIHeWLBzcHSGyioxFpA6zCgacsTmyOHACuKcU8u9/8vo92FTdNE11imB
         fSWnriYY/m5yDWQecKuI8RDn0Vi8OaNEv5GMG7fqWV48HSMzirj/nlMCV4cFCQzyjc7D
         TeaKtJCcCWlOmgoYInEikHI8gmFQR9KJJoBQR/70++8RhQXlgHyKGLg15FzEIUphI9Ff
         tHGg==
X-Gm-Message-State: AOJu0YwvHKOm8Gbexht5Gtd6+wlQ8DycmIwctuKlKWRhhfOd1gXnIavj
	kxHpiGnhV4c8QaD6MGSSDtCUPIq/oUifjYCGybeQqDJl+/eno00Szyf3bQV9
X-Gm-Gg: AfdE7ckYCMzxQHflIBX4SSzqyCi1S/G6wY90u5J/hem6yMQAk5MKHmYzUt+gJ+Rn9rx
	PRTzwn35cx3K1GHxM2xJOeB/ae8BzRx31AjkkcRk5z33uVUIdezTz9ze0VCA1Rf7Le1J6s3zKZW
	WuPOte6mrj6B6MR4zxf5MRU1BIHDE5KhANikxLlHkOMznXjLnzG1F15IQyL5tMAgFrYYxniiy6l
	hqeqhK3Mt4S7NWWcnFRRxHniHoQfsORTrChKiKNgug0Rwbp7bxIiMsAeyEbRPOC+MMfj7pQ81n2
	AqpxT64OZyvzpu6txuObphMGYvusmvEuPki1sZ3IYxMJDdnA0x00+dk5KBGG3v5OxIPYbAvOUkC
	H1x1V29oqLw2MiY29LJhtbQD2xbI1vkR32/lBQ+CDSFfiyAWLxh2Dc3HSnWOhdyJNyzj0aKo1AT
	q0YPx0zLnUbN/ZT80N7Ap72hzfqw==
X-Received: by 2002:ac8:5ac5:0:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-51c8b409e0bmr117867351cf.65.1783683002735;
        Fri, 10 Jul 2026 04:30:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.158.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe009sm38716746d6.38.2026.07.10.04.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:30:02 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783673158.git.tanggeliang@kylinos.cn>
References: <cover.1783673158.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 00/10] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <d57caaf0-bb06-4773-3094-76b25f17f692@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:30:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows - Critical: Global Timeout - Notice: Call =
Traces at boot time, rebooted and continued =E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/290834=
22362

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4cc154851693
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1125257


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
