Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00990360ED5
	for <mptcp@lists.linux.dev>; Fri, 12 Jun 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254243; cv=none; b=dGKHnPBHfcacthsiDXGaoBVG7YrjiomzPWpGpR1JBIS2jgMS4+Y6FaFkaKpFdMKOQoIwdctSvuxdwFL6sNQfMgd2GBHd/FNUhPZTTke04BVprfUjfPwKe5D5w4fV6d7xat15DCH1BW3cRUZjfP8Z2zOhqWMTnhOilqJnOZa6yfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254243; c=relaxed/simple;
	bh=Cte7wOTilxDE/XLhJ2wL5xydWsT5uu+p5Sry/BMor0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=CSJSazVVwla6jIlDcsBlJa/P3vTmF0Ep5a1J6TNwWW4XmhoqqfcEQK/IhFNY7uoiuWP8uHItP7lXIlg0mVssk3FHdUtpSZbQe5T680iEAEmRZXZqEcaa1u91mlglEjfQQ/kH+kRRrXGrTDnAQocJ2e18xcoRa3dDZlh2mvEON9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEPjjMLQ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEPjjMLQ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91591f19c30so106573185a.1
        for <mptcp@lists.linux.dev>; Fri, 12 Jun 2026 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254241; x=1781859041; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ittYOA2+yyF3Q2b5Xr2T/ufDSCR0h4hZv4/gW5yATH0=;
        b=AEPjjMLQ2pSYOVEDoM7WoN4+jxjGuoJrNszIAEBfND9HF6kZ/lFdqFE1wNp6vgteJH
         Hu92sV9BCw7wI29fUPPcOGX3cvgZTRTr4x72HWuWIJ5BwEgWk+9o7qG/JYiMKqo+N7Lb
         jE4UztmrLsC3QWSiiBoYWRLbwTdfKNCh3ZKEu8aDeam3jat4oOowUowJ/XGh7cGiY4I1
         QlmYDRe/X4O1FKWaK3dSjjM8lB6rd+RHgVuSnIy4GbfZ+EYadosdLGKnR+DSLLOQmBoD
         DciNKkQexLoQju6A9H9VOzuFZjcr+q7gB6Sy8lYLK8AH4mNKWbLARX+SiUxbbcsfaN+W
         ljoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254241; x=1781859041;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ittYOA2+yyF3Q2b5Xr2T/ufDSCR0h4hZv4/gW5yATH0=;
        b=RjzkfTzGs+82UTcQQcHqnXZw4jrcBYsEAwY6lKVryWs4JHTqjcvadzdC2s7Vp+lJ94
         7ZUoZbqoPBi+jpHXTWQ/qnaAOT2QXnxSDoQrlshsmEppqcYNNDLZZkIz9NIelnu83rpW
         H9gjd+PPjE+yGcn1trvVl45vJOheE3iVlBv1A05B9bfjG7SuNcLF3ppAif8bubQhy7rE
         qRHLKI6y5czzIqGEEHKtQ/3+iiqKUE9+n7+oW7gaPkbLu/2/f2PkZ2aIal5C5vtkWcoM
         EIjq4C4eZAz9zydECBmVL7VccbV1ktXwowLy63ZMRTQ5WooMszZZpvzko5E6+6BqPtv/
         cHMg==
X-Gm-Message-State: AOJu0Ywg+hXzmLHHV7HAp1y4rnfQiaz+JrbUuPOixqECp5EeNadE9KdE
	uF0VASrukyYNAI0Mw6ncvyR7Ca36NfIhk5/++ctle78aJSQoCdsiaa0=
X-Gm-Gg: Acq92OGDoXW7JNWtdqNnD6La8we5XoNVOxPqmOl/WIfx+w/oWcGzF6ccbCMfQUjLCSK
	rJlJ0wDmNKd0atOQON3wIdYh4j1jhVoLl1steUxY8tFsKepiUoAU7haHpnimbpCG0wMfgWmY+a0
	FAg2tM5UkUPDBdMoy18JPb5KJk4lMAgt3Edr8mNGHIj09W3b/rx/TkAZPOHwHIMyTZPr5SR/obM
	VfuFCQQIyoh+5HI/0AP9EXt+gluLypnalY5Hov3EA83NfI57lT5lN7A6yX3YPRjtorx6oEOWJlF
	vpZ3YNJBIAupfpaguF4NMfUxGAPgXldf+ZEP/2QpqjXSyde4Nz5Hu4BPfIPW5OguY+xhhwA92nr
	4sY4Z2pHMV8Hx1+7t6NuYnEvksF16D/KVYdk6Q6pCNVLlcfifTbtXAk4rHG8U7CEmubh2waMOeZ
	zSM70xzLBjOvpK+8JRHqgd6iYTEmunmbRDEQ==
X-Received: by 2002:a05:620a:4720:b0:915:efa6:d718 with SMTP id af79cd13be357-9161bf65518mr243903485a.47.1781254240821;
        Fri, 12 Jun 2026 01:50:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.10.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d304b57a94sm17019436d6.36.2026.06.12.01.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:50:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com>
References: <20260612072643.2313900-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: bpf: fix NULL derefs in
 bpf_mptcp_sock_from_subflow()
Message-ID: <4b574718-2e4f-97c3-2656-3f9847efbc0d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 08:50:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/274020=
19958

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/910803a3a0e4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1110481


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
