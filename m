Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88459189F20
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471245; cv=none; b=DAj/w3aCOZZcAxzOppeM7Vh+LUTriAxmGn1JdGLRq3bVu5PLDA+gdgEbBt5raRSu5nlp/VzSk6IAKmLhqKSb4MMcjMr/lI8jKd4djhjSdohgzhn+tIS1bX/wl76tWXM0BzuR+WUas2ztfXlFwZ/ZiYf2jRZ/TbQxHiItfM4iW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471245; c=relaxed/simple;
	bh=0K36knES0NsFKvPrW8XZZx2SKons0dap4uOK7k+iCvs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hoLmbrZsVWwGv5+0h6R6cVNC80YD350LagxWZEwonYyc/EjlmQQEjM9X4IUdBtrYcK66TCXBvuHgvhIZgtgWjV4IIvuqMlS6ars/jDnMFya7dDvzwTDaZwv1pD8pxjfL6exEmI2HBaCqr1yzt/LtDU5+AYBPgc6zXtMBH6dPUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGh6Wzxt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGh6Wzxt"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e27f9d2354so1485170a91.0
        for <mptcp@lists.linux.dev>; Wed, 09 Oct 2024 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728471244; x=1729076044; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpcyPCg5jQTJsclwBXXo5RZTXkQuLx4kUY5rUn+1IIQ=;
        b=aGh6WzxtTeQUkTqbRvaYkLGdhJod80vJT+ax9cjcqsCL4D3lvdgL996yiyNeYGpOz2
         f63xRvnEPl/pU4qqI998KI+SZwpruwSYdqqJloOby8+v5i3yYdv5mfiJBbZpFaQ8/pNp
         7FTIR/P//nYdLi26vi+rjWCCIu+6YgrJl22AnRzQNdOazHMf48DL8PdnLZ7o+lIqVhiD
         ptJDs1DzrhmyB+g6pHjb8WZL4470j4BoI7bBvPQlW2CXLii1xoxOLNbd/tkz3FseeC4O
         D+ARYxMCR9/5/pAbeSOeY7wU/DyO8yJx/BXsaZ9JLjlup8WilalfwjGDhOo+IXXwd8/T
         55pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471244; x=1729076044;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpcyPCg5jQTJsclwBXXo5RZTXkQuLx4kUY5rUn+1IIQ=;
        b=GM05t5fT1uY2p7ZvqmMQNW2ZJmp9Zlk0wUuiVKuEQ0uUodBy7PvNnpWzBINtc2h2/g
         V6t30g7oF5J4jib+qWJfdDz1CBPBjcRFCnEMT4lE8iU1CqC+YA5jL8WomS6qtYXsoJ82
         /oC8Vb1MMeO6HqPYlX4P+pusCEt3Kj7KzxULODV77kv5ZXsiqwTOw2F+xGlGv0icqTeO
         cy8SAfIPYf+m6zyf59ewyYNoYraHH+UtjUzN9jpJRdV2kGfQpILXZWS2YYuj1VbU6cfg
         rZHQR+yyLog5kuB+EkMVlVAkj0zzACoaYFB/SRLbE4dq2fg++k4h6o5wQ4nBAL5dDWYX
         TQNQ==
X-Gm-Message-State: AOJu0YxD4hsKFYIMZWeh0MOre9jttcXC1+BvdmKgfDX0whC+zftFVeiT
	A/YSsSMp9ccifKHYOygTiAGVZxIJ76F3dKIOoqALk49sD3mCW2BU9r99
X-Google-Smtp-Source: AGHT+IHjSVOLl6SY4vkbeXCXwqqqBDuSc85w21XbrmIxBb1/iccmQUiakFh9l4eY9RktqlSIbYj94A==
X-Received: by 2002:a17:90b:3548:b0:2d8:e524:797b with SMTP id 98e67ed59e1d1-2e2a2371816mr2178642a91.18.1728471243624;
        Wed, 09 Oct 2024 03:54:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.142.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55fc87fsm1321257a91.7.2024.10.09.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 03:54:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728466623.git.tanggeliang@kylinos.cn>
References: <cover.1728466623.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 0/7] add mptcp_subflow bpf_iter
Message-ID: <705f1b90-7c53-d1b3-a862-0e955b598463@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Oct 2024 10:54:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11252652873

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b00f1ec86da9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D897104


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
