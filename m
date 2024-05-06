Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7F15A5
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004357; cv=none; b=Bugo2C3xysET6m/k+fyLpcm6fz+F6Cw1fP2muxmr0SlVcRJOknW0TeOVQu4OJQnyS3T+ZNJNS2KapeItXq7FWmaD3iEDoo2NzEvM3pBV66eVwYmKmcRWfclYTWPDeDhT+9j/ekGuCLJ0ew8TCLn6y4CDC4Y7FrdtUjAun2lUQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004357; c=relaxed/simple;
	bh=Ngz4PmiRwaxWtenKVhubszwKfA3TgrnF2uI3BompDBc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=neCFyuvw42oKjt3jyY4RoxB4kVQO6n3Xb47chCHJL8CYElq8gLpBFuFWE0GTp7hzv9rKhxGVhO3U7WNTUVvWLBIHIj6LepypHcekrvHaqzOYsgz6FxW4lyjqcDwuqzFm0+CA7QVUil5+cv/F0Nj06i9GvxiRcJa3P8A/EcYI0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiZCdvrR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiZCdvrR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7928b371fbdso107353185a.3
        for <mptcp@lists.linux.dev>; Mon, 06 May 2024 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715004355; x=1715609155; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gfy/ecC0BxuHXXhCxaqPKgp8YfkxBYgASBj22XEDkw=;
        b=WiZCdvrRT77He5NY9J4766l0zQNUGjSsQ61bKQ1nG3xx4GG8uCtxTrEwBdXG1iCrO3
         oyo/1ewLuyZVQX8tNEWmZW3sCnNhmbg+paKSmlWgy9e26cOghhPmR1hi6igqDI2RV9z/
         Wd5p4fZKX+cNkJlRr8Nk9iHNuF3n0cbtrBoqI6asCKxCEFJCP10uPGp6Wa5rXLPEg3wX
         Ot8C2yNkgEHdPzTY6dkg/egs94gwx/W9Gh5lWCb20cnXtvMYjUiFF12i6/sJ6UaT9y6X
         AhmRHCHCGkF5s/Grfi1lI7PbROaIh+cxglCrYcOTBz4knh8QDevLUCa1EyP3VYldy7II
         Wz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004355; x=1715609155;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gfy/ecC0BxuHXXhCxaqPKgp8YfkxBYgASBj22XEDkw=;
        b=RUg6IE60ykPlVrE7YJx0SwAoepoVvkz8sIznGN6MUk07GWcsHdkzB6PN0uhHr4AHrr
         v60xHn6O7fh9fIQBeMHJ2gUOvXc02aQNzbzCEgLF+iGh5Fv87K0cE68S9UzwUm/mB3wM
         lnqMv0VeV1L8pMG7/54HwXjRaH7c9fF1ZMDKwqHcO19fhrnaTMaZsAkgl2vhYGZ8npDL
         sz+qn9TkoE985O/fbfSPLjc7cSx0+WbiJiJzdb8H2AGQCL//AnKh21SJE+TXMMqof4pj
         nXt6Cp3uey92Xw+UlcQltvY+kKi8S/U5oMyJCaaOp4Ts/3cpsQeiK0VgGpFEXr8A9OA5
         Y79Q==
X-Gm-Message-State: AOJu0YwtE6wou+go3Nvei08S8+7kH6x537MTRr5xPLZHmvrgG60dvJJo
	mZ0NGZxfSkg3PC8NcIGRTLQ6NxRUn4qj7nMWnVv7N3HUTgLS+vGSBjuv
X-Google-Smtp-Source: AGHT+IE8G6+ZnFcRfAdGT6FHyi3HbtO/zhuanuPcCH18vBFHX3LK95OeGjQZwna6seepwnFCEp/0GA==
X-Received: by 2002:a05:620a:4309:b0:790:94aa:9628 with SMTP id u9-20020a05620a430900b0079094aa9628mr12923040qko.15.1715004355202;
        Mon, 06 May 2024 07:05:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.16])
        by smtp.gmail.com with ESMTPSA id cx23-20020a05620a51d700b007929bbc4b8dsm777024qkb.62.2024.05.06.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:05:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org>
References: <20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org>
Subject: Re: [PATCH mptcp-next RFC] mptcp: socket option to check for
 fallback
Message-ID: <e881531f-49e8-e003-4092-039779f2d57d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2024 14:05:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8969920875

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7ab69926ab5c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D850796


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
