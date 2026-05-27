Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9CE3B4E8C
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867408; cv=none; b=dXPWUa3/1T3NkNttYegkBRP3JpXI/+3gQ/CPh6gCUDoJVunmy1c+HIEKTEDmyOdlnOwGJxT/h+e+/SkkxrsOsNDvGIivVJeDbAJmdy4LlBHVMxcr5SMPKtqJsnl6SN86BXK+osqC7+PnCdCNkNB0dVpDhGmKKYH2kFQQ5MBb9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867408; c=relaxed/simple;
	bh=T25VAXl3tb0yOCV85gQwtEEMSotWxjkNbIWdcRJrUtU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uucKzds6bn+lRYzwwSTNB80uQUKweHSLhpLrA1WbSx4i+feP4eEt204+Jx2HQVvOyXE3xsPRZYa99vnMD2OcNC9HK5zTtwT3Z/t+FABrLOaO2+/HON3lzPmLoU0CnwWeoI2kntWWSEZvYZAzvAPfKjazLxUIsmAsxXXimdZEB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r24OUhKl; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r24OUhKl"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso4394387eec.0
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867406; x=1780472206; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8U3VmXcppqiChpQdG/fIyw3jDl7SeO4h3Dw17lU3Nc=;
        b=r24OUhKlsYiT40MJEUTs2AamImaetz5l19nfCh0sGqDnWd1etOh5wYMS4PsShbrySQ
         UsmibeVME0LOCtiK/V5hiz2EaOd9EtL3Lk63MGzMijUW62d47vDynF73F9jxpb1IEfk9
         rEMne7gAXmhz2Ib1zvLokJ46gyykwxGUw8iufTX6ehFv/y3YaiE3efidwv7HgMZS9ZNb
         gUaEcbNURifLU0vZSF/yDmizpLkyoitfREB8f93Bb8ElmdW69vfaI7N1CZb5a7/3EyEI
         ZldJ0SfL90MxjZLd9PGASVwsUyeRQ+3q9v1oqJfw/PSpbLNVoRxHjuJiFVWAEZMSBHZb
         XrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867406; x=1780472206;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8U3VmXcppqiChpQdG/fIyw3jDl7SeO4h3Dw17lU3Nc=;
        b=TjVYms6tg9CBh4S3S/MbnsGAeT+kup4ZXcvth1JaIc3O0ZUIigKMaC0zIKufEMbW9g
         4SF5HTS8Jf2QnoqWTJgGLTshgAjwSQUl1PW7xb7vJoId03PEvnblb1Mp7yxorYg6txSf
         BnpbZP/f/ikoVPABXYHYbY9tcuXENp8oGMxa2m8ijMNqxw/aBfKHy8goK1LUwRQQ9rBa
         j1Qs6qqmM0djzskuSHCMNNwAc9CKOHOPrL93im5E+OijcvZIZfbevBpfqnb0wPyLOmFL
         HjL6wV23tb4rB/jaOzjLYJkwEvywX41pwZ00x3YtVt9w3jBFD9ie5q3kRoxKMLWK+xPC
         8xJA==
X-Gm-Message-State: AOJu0YxJVTaIzvhY/RvixHSIdMaac8n7VglRHnc/btiuJlvso6Q8AwBJ
	DlUG/pnotWH64ZoJeLgrTb95pZ3X2nlkpLzqeNUExOfG0h9lTPzmzOszf8dO
X-Gm-Gg: Acq92OHKeQOYtzgixcTA+1Jv2e8iFxxaICItsgNwMuo2PUhOopsga6zTG8SQZ3gjELp
	kWmXaIwMSSSKwEPgs3LVdgO2TNjuz+jykRrCCuUVFKhGGZXCR7WV9ScLtIhkuzwOHAEnwUZ8c+h
	Ma3xczk6qThx40WZavDreTO4QKoNKVBRx5MVoyaL2SQmhiuu2UQHDMBrN1WvYEg2g6PqhhNrF8T
	qqh+yL2gqLXb0uN5mIgRoXGgm6CNcbZ8eY4SItVlyxQs733BVrU2hbnYclDn5M6ehC1b0p2tIxn
	sLI5w8J4rISKR/NcNEYpR0wVOAYs5hLYlrzKbuRKom/ba7Zy4keT0Kuk3AEUhV50I9yX6jwLVLX
	qAU9qeIiHj7wvmfTfw35Wl91Y5EZS1XD+ErjYuSb9WdZvUp9sh/X2q+aumrMDdJtXxDOnAf8kC7
	6liFP/0ZFUoqpwohUlohc+yP2NSjwJyvbJKfs=
X-Received: by 2002:a05:7301:1922:b0:2ef:8b91:212 with SMTP id 5a478bee46e88-30449063389mr11129642eec.14.1779867405713;
        Wed, 27 May 2026 00:36:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.55.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304522314a4sm12020578eec.18.2026.05.27.00.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:36:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779788090.git.tanggeliang@kylinos.cn>
References: <cover.1779788090.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v20 00/15] MPTCP KTLS support
Message-ID: <5732dd86-3887-5679-e916-f0cbd68a224c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 07:36:44 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_mmap =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/264947=
77306

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/22b32594b480
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1100835


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
