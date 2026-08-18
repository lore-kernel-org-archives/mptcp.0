Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EAE4749E0
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058789; cv=none; b=bcnmsMn8ScXMWwTAJpMJhV4NyCMeoWkHve1FzeT9diOWDR4uf7Cky0sLNYfRWfb7wHucmnbbay3NQRuK5VC/KFXzuHiDltLJyApbqp/S7BQkf+0Q7FCqaCD3gHn46GcvVf6RAYvMBwLwP5DPYvzuwm7FN1CpIpgiNd5Fb+Vk7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058789; c=relaxed/simple;
	bh=DcpFmB1o3HR8r49VSnyHThu5tOAwc7mbi1kbkZYzZYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DhbDEeKJUT8ERT5TmdJ+JUioTj9EU4iYmBN0oOih9d+oZ1jb8zpUNd59XzfBF7tcJ/eIUJpxsAqdmxLq+SWri8S0jbCkvb2HcT72HfdYxjK2MYUzS3xOmyrAUkhqiv9upuw6dS2epgaolHdyFWuGSi2yWzchFI3Go96p2lYvmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX8VPwq/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX8VPwq/"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so29086211fa.3
        for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787058786; x=1787663586; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zwoELJXXYfGkHpQGaJwKJznDZTDthmeEn+T2q5ZKp98=;
        b=dX8VPwq/OaDg6mz+ZKavqBm9EU5mlU+O7v8IWJJFJ+O37FVEPFTdsjWB+nVmUt+AmK
         Lu/qlMZgF1PbAsA5qCeC4MeLDW4QFm8Lm83tHs9dFWoM9BcCjx/3q4I63zr9/KCg//6I
         vyFpDJdAuTVkQQ9v0Tfm207A9PtSAtytla9479oa3AYBocmG58V7RedYaD9iRhyfovKY
         x9PRBJpWRgoNd6b/oeg27/24tGRzELtEKQ+ZShnUpQROfckm0qtsMxlrZ/LOHJLDjz1I
         I1vdCp6M/HyLe/J3vTmlVV6NhzBm6Hj5IBR7pts4O4fwZLQo6Z7B2RAEw+M+cHzsWGIZ
         HCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058786; x=1787663586;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwoELJXXYfGkHpQGaJwKJznDZTDthmeEn+T2q5ZKp98=;
        b=b63NfruJTiDfvtGTRXyeEdbK8rFO/Px8CRK4TXjrCmLeiCqvmevo5WV4p1xucYDyZM
         szgc/0b1DNNrdFXyslAdWu1C3oDultSuFj1AAwUV9cmi1VMIOIHz8y+BC6Z8Kk4XhwlB
         SGgfaa4NqitvIjmrnrXxMBrDW/G5HME7C1v9OssHnyalSJZYsYvtu2yF42AxQhUXyIx8
         J57ZBEUzRl9Xk852STSYaLrjbsl8Bm3CgekcAHLvbLxoeYxHZCtyHGts9tbSuRvMwC2d
         QiBf54DnqW7kSWkXaLeEOhmVMo6AkMeDGch9qGMcjE67nq7y/OcQx3RKqZlAOVIjPMko
         r16A==
X-Gm-Message-State: AOJu0YxOfNNpRYQ5WcuQZj1qXR4/eROGqWoRYO8qrRfGVvQl8iNWDGbZ
	xT0C4MmOD1PBj2YCnSr7mD5KPCx6WZhRnuXpYINxs5kgw6ZEDgLWEkh4f6dX
X-Gm-Gg: AR+sD10iNDkG3jDKqZ/h9O+m2jSF0lDW3PgL/iYTj6IwdD1Ey5dNBCjaH9oomviVh0A
	hGWBwM9MMuGVifmnd5gxw/5MhWlSrUYHn5qU9Up7v9ynU9yf4Ic6ZP8l1ofPIL3qNN6Vi5mWCnC
	XGtqMGMxdFcRX1Xw3ovK/nrA/Ee/9RLWS3TmIUwib2ALijz6jNZJxaW/9w6byJptgqguL4O0Wwf
	hqnXMNYqej8sXuc5Bbs0GahwEUKgVbw8zu5teFSek/Dkuxy9GMcu3vqT5IvcwTj7Jm/PqJsuAbn
	n1eRCiNAiLC1Tz5j5Iz2dTR9TPy1KDcnOSawq5MhlwqNDuZBTe7TrILT6smg/FkLZA6lGoxDQGT
	e2ZDD2SvnaVyIwbbZMufRYCSn4ChZvIO8afQr0Oo1WXtEiBTLc64UHIBmbAl9m3RPb5uOIktj0f
	FsT5zZPwsHG81bj8BCdsvzI1yeLyC7UIidGbpAZwxfm8TMLguegia3xssqnSzCzA90eErlxJo45
	dQ=
X-Received: by 2002:a05:651c:1503:b0:39b:d04:b778 with SMTP id 38308e7fff4ca-3a1323dbe7emr42993441fa.5.1787058785471;
        Tue, 18 Aug 2026 06:13:05 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cf957e2sm1214110e87.3.2026.08.18.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:13:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260818120437.3949686-1-kalpan.jani@mpiricsoftware.com>
References: <20260818120437.3949686-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v5] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
Message-ID: <4c6e4132-49e1-9867-8582-8bc0320a7880@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:13:03 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/321368=
36643

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7b8302d5a4e9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1147788


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
