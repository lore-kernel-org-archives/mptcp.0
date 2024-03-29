Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7E131E59
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741654; cv=none; b=pPqUUBnXBFQuNIiE2sN4Vv/SCWwE4VUwmEnID1k070C4i+yGD4iA1TpuFDnyhgbeWeWAuBP0+rk5kREIACHRHMS0ix2OPqAyBD/oF0xkYShmGrMkEvNky5ryojcNYkdLwDJW3OyxWytyA828wmbQ8S0QAXkoQ1cgQd0IReAE0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741654; c=relaxed/simple;
	bh=3qO10/MrQPqK0qxHV0V0VqgAfr8fwfGC7zXCRtDrmy8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=u8Dyh+DHMWQRaUoP0PCIiWgyQuBAVVcI0kyVpC82s7eDzctpoK+uIZdzmO5C5KlIB/qsMpqGcGfeq3aXDZvaYJEPqXSj/ggVIHikLFusLKt3dbuEPktLXboefpSBpqbJIYR22HDcT24ephlBk3dWwV0h4BcXVxIBb29bTjGYLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzrO9I5/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzrO9I5/"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6143c158b95so10301857b3.1
        for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741652; x=1712346452; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2olPNiUPjxpZy2/vnqk2yssVlsQWXe9Havs/W+lPdM=;
        b=WzrO9I5/tePacXxCL8/QW6Mn1UVZq6m0z0Ms4U3JiN6AWmMGAiSHhM28awRvQtGr2T
         f95l0Bk9zTqgvgMBDaEX0Bhsde1G2tuGYGrxSEVahK0feIYJXxmGHCg7yRkEH7emCKcv
         DgZmjYAErWqvNg/Z6iegKaPSQ/ns7rUc4fnut48MQRVa2DAZbRnyrs6BAWchDMaErzpw
         QAFmiIsNVg9djEKuNu7k7kU3Ya7vkEEMx9ZRjMFRtXDJjohvR/m00L/QKccJQQtE7FgU
         PHJ4foWjF57cQ6KSYVwc7mcyKVO5Lc0FY7sj8JknIb2wpJpLSpdUZiZwIg9PrTazNlOV
         Gg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741652; x=1712346452;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V2olPNiUPjxpZy2/vnqk2yssVlsQWXe9Havs/W+lPdM=;
        b=EkL34Qsi/xXybhDvVbSxI+WvS2vIXAfI3AoallunAI8P7eGDhdwGp8aPurFnyUm7Sy
         ZIIxTCSKe2H4swU66W7TKvlDJ1aRQ7IyMdLPC0csfkGJUVD14LeSyORQc4jdr/GIAg3N
         bEudSC/HvdJdIM2Y/JwTqRtTyPujs35qx+2/4Udzh6hjUKuocBJ+AmMqH3QwsMqtBsao
         bD9rzOMc2Wz4rCaJysf32YIM6VQRIFLBff2SpUfBmGOee88z8yQqgEj+80vNJAJqedWg
         tS5PcwDm3FwurXm7ytbaI95noxCgDbg5hLRmOWNrgEhNUWN17xHl6hAu0DDJuNQLVnwO
         JIrg==
X-Gm-Message-State: AOJu0Ywqm+OXTWKjMwh6Hed+w0owR6wQJrA5vo+q5ViAo5IkEpkPrOyJ
	zSeQ+CrbLM9EJv+EH3iOfKrsyPpfzh12r+lYTnQ2zlpDUgg/9Qo=
X-Google-Smtp-Source: AGHT+IEIhKKLi4Fxkm52Nuk4w+xlxPfLcXfXuTm5M+hIGuYygbNQmvwhhMfE19jKFj54RNcM6whfMA==
X-Received: by 2002:a0d:e8c6:0:b0:609:a55b:805c with SMTP id r189-20020a0de8c6000000b00609a55b805cmr3330040ywe.46.1711741651840;
        Fri, 29 Mar 2024 12:47:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.106.60])
        by smtp.gmail.com with ESMTPSA id c28-20020a05620a165c00b0078bc4cad726sm1072570qko.72.2024.03.29.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 12:47:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
References:
 <d8cb7d8476d66cb0812a6e29cd1e626869d9d53e.1711738080.git.pabeni@redhat.com>
Subject: Re: [PATCH net] mptcp: prevent BPF accessing lowat from a subflow
 socket.
Message-ID: <531b027a-72f8-1f8c-fe6d-8ce638f4190a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Mar 2024 19:47:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8484623071

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e7afe954a2d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839872


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
