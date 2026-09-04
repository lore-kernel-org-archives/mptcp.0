Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88194242910
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503400; cv=none; b=il1pVuwBABV6lDyVYB277C4sB1GiOafpTUgfTk/NjNpsJoScSl4QYy13uQr6ReY+FgLOn9QhLlO+KOMrMKgYTGe9zvFs1mXHaqpDesPw8i3BDOTzGcJ0TDSi+3zgGPmkB5kvuGjsgcWPatj4VXYgau4e7/CRul49MhWAhpG8HeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503400; c=relaxed/simple;
	bh=QirwaVPFdIy/vgSxahmCyTmOEbbVQb5X/2f/m3Aypyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=t6FDUvSGxAlVmcLLmXDYN1ppZpjXw07J83ji3EX8Ad09D4jVSCQ6YkHajmwj5Hh8HgK6nPRj6XHuvhNeqG4E06Y3CBKYPWgV1T+mlW573sGHY7pST/rjc4qKqZBVixMUJtVwLriHMsZUDSBk9cVYQ8RJQYvo9FTWgXO1T0Lvb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krBfTvNH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krBfTvNH"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5301db51586so10119301cf.1
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 23:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788503398; x=1789108198; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VVebxlrCO94IjVYsJhuxMot3gvRudY2aE4rA2nkcJNY=;
        b=krBfTvNHkGnBt6XZ1wI6n8tkpgOCUD30Yxj54jUlB73h5I2XJ+QIO5b242TiZFN6vB
         aNt8YoQifww/lxcGR79PWVuqOZt/UxVCOzvZazQt6EHO6DjX1GkzpUwfFM6WQJGasQ0d
         w1mPrMUbJwzqMUdb+tq6rYb2Di6uZH8qr/d8qtcmP0OqQKW7Fu6R6j0qQ3J3RzVZ6z/I
         wx+S+Da8RT6+Q8cCelzXMSbzMvrajL1JKSXIHZmc4UNXoRYNylNblKwlY3ZwDkqMAEMk
         DJ4nHo9bZPaRQnj1fBIlrbKq06WsZWofmj/f/gzAffdogXX692KGfs4YSKR+OH/Zgict
         U0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788503398; x=1789108198;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVebxlrCO94IjVYsJhuxMot3gvRudY2aE4rA2nkcJNY=;
        b=ShMVZliRH+TxYd2CFD+y/g8Cm8yOAUdGAUx5OyNmrLiKZslj10wBW/DDl4IowPqs6M
         6H6MWjxpMHPNIP5+0ftUCfYqzZevf1VGIGKP+x08Zz6EuKXfac8yPEaUg5FHYIVPdv59
         jM9NN4NDpP7rs4e2/kS8K/PGrAWyjlCoOjItnoYmy6EKRdXeWfkjwKcHEZD8FsByN+M3
         L0e/k+lR1Hl0yNdc0VmUAwfyT29SUA1c8K/ABfuTLXxP4RWYOPxo4P5NIEX00lX3Bt/R
         gIIpgpkhqBiKcAXn7855+9yJZpgQ+0i571HzIczyIAVrYUZ5QKPcNji0yCG23Rb5YXmt
         pRew==
X-Gm-Message-State: AFuF++lwoWezsrS3qg7C5/E5RiUCCiI6GLyS0dyfnCYr1rQER0jUiGp5
	ZWlpteZLmZ1gMj9yDy4grzThRwvF+EoeI5d8F+Cyt2mM/rjLgw2PrxU=
X-Gm-Gg: AYBFou3ySZdk7rc8V7Hqhr7qKpyfCWaj0iaVvVzZPSRD02jsNsN6fKPkqHVTn3A9mRd
	E9EcCyhC7ri9ZSCuWUfY2QY81+IZb65/1fgBvCPUhOeVpdGhTCtLM230N88+dAkF1NQ2QErZAb3
	PD0qiMgxzTHL9oyk12J4ub1V7aVd3kgx9HPDUalqc6LN9Fcaz2+bwcOc7BfxdG1tik+8QnUheHZ
	e/nVFWGmfgQbLKZcjfC8vjBSZSN/vv+evnVdxha6BlKrS00AfiYdo/vmQRI73GhuraZ5wEBZUoi
	219GedfdpeNmGJr3K12xNC/hWT4Ab9SmhDtxdR8y0O6TwGVDaMEFN8/c0GhuULZ+ZkQP1qJbE70
	CYUFN5bulQ9uZNn1ky5f32uvl4qgUDbKnBqCya7jnWKdYG6iHkyjaJVfOfWq14k12tWXkCIHlVD
	rRUyRSDKvPCpJ35GVlH6fCZGSeJV6+7JKKZ44R1+7JMpEWB+hyqRhzBBX14vpdNcLlKbsmLP+/
X-Received: by 2002:a05:620a:f0f:b0:937:19d3:3fda with SMTP id af79cd13be357-9398042d815mr372141885a.28.1788503398217;
        Thu, 03 Sep 2026 23:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.222.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f0734sm149931685a.4.2026.09.03.23.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 23:29:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260904051150.1196427-1-cui.tao@linux.dev>
References: <20260904051150.1196427-1-cui.tao@linux.dev>
Subject: Re: [PATCH mptcp-next v3 0/3] mptcp: pm: fix reachable
 extra_subflows guards
Message-ID: <4877adc8-c838-ac57-bad9-df6dd1c5b416@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:29:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33840713883

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2d0e39ea2ca1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157585


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
