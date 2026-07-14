Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9830C63B
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998844; cv=none; b=nAAtqYfglRGzfdHLHyXqmJyP6lMX2rQGyvdT7jefsf8ilCbP7okm4ZK7830lTHJonCbOGGFQZw1j1VqXEKFyt9IPhDnqhYrqbLL4hVrGAhf7Ip9L09swXXdLzynAdoICJuAEdge/TALaSudXjWUquPLKItungBw6zckR4ScgCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998844; c=relaxed/simple;
	bh=xmx0Oc03bPpb07LYFT5MUQspGIxrpM/de1M6MkJ9cTQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GMlMARGAMQsQCM2gJnEArIHz7cCy+YcFxcrvNLwO307s38+pXI37h2jI8dQwn5n/NrPdSZcrLrrfgGCFa/j9WxpFCjRxZULX2IQykB9l4XATrDbfFrHbp8CD+85Om50zwRKCiRstpNxv/PSfu4PVFuuY3nkUiuG5PXD5Ti46Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQgeH6ds; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQgeH6ds"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ee88fce572so6782006d6.1
        for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 20:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783998842; x=1784603642; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tPCATge1p/YE5tV8GAS3mf2OHmeXcl+FCb2R1fD8s/k=;
        b=sQgeH6dsSwOz2XQAgeUldR+785j2n/395P85OFoITsB5a6ZYx27zpn2OejG7W4RAge
         w9/jQful3UONHpGttkcuSN/n/rIv576ieFZsNwjVpuuqvftHgjxIIvnaEJxWDBgrh9+X
         49bYCcRAc8Vhlot2tHBZ/SsLJykUwiMpi5MI5SQudQqEFHDqcJXl/TheLEZQmTaRfOcP
         5ECEi5Q0vV4jDSgi8pj8umAJhdPO6FvnnthkLVVB/aVZZG4aZUC5NtsAcRybD23+6Kg+
         VkE44WAub0R9LW/oMdfz54cMr+zvJIGP6U+HFiWWFnSdD5CDTiQVmxPLhtVbDjRCBG75
         hC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783998842; x=1784603642;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPCATge1p/YE5tV8GAS3mf2OHmeXcl+FCb2R1fD8s/k=;
        b=a8JKLes6NzaJw9SOpHFjtFaVOEzjWwNSXPf6B2xfal5ZPKTQ5YLFz3pC8j5t3IRuot
         LhM2jFhISz6G/3a5lrKGUGta7heVmJpG/j112u5nbWvml7Lm2owRiOJPLrj/MPEsbi1b
         SmHa2ANQDzQU71KGyEq+lSPEZ/MdMa6IGY8xI/L/oFB8qaQ2MDbknPahC7Z5gpdRxihg
         123M1DgxVu+vc9UDBKzSxB6Sk6AufEz6+IXEwCh4kc+n890zArLGHGOpfZR8K6BQQWjN
         RYPpUPB354afEYGecnXJFTnz8Cmro0exuoX1mjgUHHA0OXS13kNCpMEckn5TxbLhqbAw
         1xNQ==
X-Gm-Message-State: AOJu0YzDs25nzfe6xZdNBRK2NkX2rWtfprU1gGOF2k1U9YF2cJoH6Svl
	Bx7tM1nAXHwktZ+K3jdzE21XVk+vHgdqyVhtue2Q2nna+LIQY+h4b6CWSj2g
X-Gm-Gg: AfdE7clacu0KqWmDy/uOv/c12XUsk0YZsoVK0sVh9YIVQVTCuyTq0hKWeg6r4978KjX
	G6Givj7IzqYN+bGZj7tujsG1N8egdAJR52jqLsTmp2KOuxD+cuT5NIZm86rWcg9vhpFBdrh/Q9H
	AxF0DKwzI4Y1BjtFjLWOQmzF1laNHk94MAkOPv795LWnttSd56LdZjkG0M4SaLZuTSDnivEK+Q+
	RXdqCXHhzIN0QF6pkVCv6x6CQ4jQd+Qf/0lXsE0OscpIfN0etPPgL8NM9GYc5SdsbOzgrzFseX5
	z8ajeXVvGQ0j/3ZHl4nEzkCV6HWYS/wjHW3xWmuWiCHdGaq/xci+rrfweT2h3EnZ7TyYDmsgTxu
	ZamwAAjm/i8WnSGSbTg858m8yFfLFxYaategBU30SYyM2HnSu4TgfGVySzhvLWYWFhBmntWh9x1
	5tME0EIt5DhATllpHwu/la3XFCZJk=
X-Received: by 2002:ac8:5f91:0:b0:51c:6d7:215e with SMTP id d75a77b69052e-51cbf163551mr116463211cf.32.1783998842035;
        Mon, 13 Jul 2026 20:14:02 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.153.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm152800276d6.39.2026.07.13.20.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:14:01 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783994494.git.tanggeliang@kylinos.cn>
References: <cover.1783994494.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 00/13] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <c5d46a9a-7bb0-83e6-b7a0-5df2494cf717@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:14:00 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/293011=
04649

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d33bb48f28ee
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1127008


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
