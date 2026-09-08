Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC86554528B
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872489; cv=none; b=K0t/EIsxZr5LEoxmfYUflBCnmUS3E4hhtIhQrC2kVkKB2O1WJu1zx/7h5rTZPcVovq6bcGVJIDlDGcLUs6U4nzfivp5xaCq/ZIPvnKPb+SIj7k/JzYdolgxj2g773fGv1qP/T9fKalQBc4RonDvklTeqvtaS9vQHQYAfm3T8aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872489; c=relaxed/simple;
	bh=ebYf8UtzwPX2P9e8OwNvggzb/sMp41yR19uEyeVcBFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sKteU31XWOekNMVTZbTQWBnrM3jhkBUUNTMVAE/biValBdSoMoXObJoWJoHrqUntv9HLcjXi7U4SYgb9zE3Bc03xmZ7OGfdaBL2oMOcbYeiq7NRCcW0h3Rm9t9MaLNkMMq3plfwEhbFu8IpOsqCHkxI2ArmUtHn8PKw3aZrf2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GneHZG1g; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GneHZG1g"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f4b94d72acso3809416a34.1
        for <mptcp@lists.linux.dev>; Tue, 08 Sep 2026 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788872481; x=1789477281; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gTPkxzaEPK6qRt2fjRWp+uhE884kbq4YL2ol/AB+s70=;
        b=GneHZG1gRlN76OvIIVyiZyEV2pzr99ZZPPIEB0mA8j3dkvXdiHOdjqzePt7d4Oz4IL
         NUzUxa9JTr2pEVerxclrLg8KiWdWAa+f59nInlTrYDTXrqMudbwLIcSLjeIbStBwY8ha
         df7YnsznLgvx/pVnLxRO1Aiid/Zr8IX0q/McktPOAj/tK8dpM2grWP1s00vqnrclrF2i
         HVNmt+jSjW/VNkeCf6/yYFfN3bz89Siz9ISlWQn4b9PNiu/Sfz/EajfeRFXNNeBE/xbF
         Y0nDipdmO2OExrymFzO8hffPEDYIpUmkk+7B0Cpzln4MX1VBPcW+MhxvTEIOICSIYiwx
         qSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788872481; x=1789477281;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTPkxzaEPK6qRt2fjRWp+uhE884kbq4YL2ol/AB+s70=;
        b=WBs5hwsCmwhClvq7aH7cBUm1QSyrxQt7hNvl0UIjCpbO4My/42QYkXid1ij15xYDK9
         Il5PC09TXFa8cqbh4ESnn9bg4vem2jcUyjWZuJJ7ulHUj1HRFP11mnX4kRG07G6ZANr5
         0weAGd9Trv1RK1Cvz4VQ4wLvvQiVy91cfa4SdGGqeC0H2JzchzJbwakSOqrK8QZZfE9l
         ZRQXAkOqE6C8jVsNkO0kfgnvjHXtHHkDu3tsgfSXUU9/ouxnkGefbXBRgZzmAO01W9Uu
         mEuLjxhnqfMslHpYYV6aQ6V/5YY2JCcQjsR1etyFyDyre5QLsV15T+COul0D4+WxOMO4
         pMvA==
X-Gm-Message-State: AFuF++lD6N27gCHE5z0NtjBFWEBaOFoZvFc05Xo85PqRfFhr51WjOjEw
	LkAKAY434sn2imUVXCVI4FoeBgYtZNOBNZsFxxcHw1ALqgoBfkuk42zCpSmh
X-Gm-Gg: AYBFou2KKTztyz8V+spFWPj/o9/icIZCweqyQkSYWe6Ne/hkKe6OZZ1aQnIETmsn98l
	5C/e1Tf1jgvpaUnWdEuuhKXL+RrBVMZUNRwjmw1R7vNRyw9D2ZkFV+SwYljWsAJcTpEWfFA2jXI
	v0N93pNcQ0pbjTHAu+MBttcmIgIcR1TxUbBssTzxEGE65/mTgGJnsGlNT8ivcoo+9Es7Eey4J0n
	KrJaSARj0tFxVg5qh4+NDkTLALPLIBJru1GmqPPY84iWTR/KAyMH3p9irq6csqNSU4PGYGe/LZj
	KKVVi9z+0iczHD1evaZXl9vQxTcmVNbHqyQdqBOTYlSr+snGFagn9kaDWJP2U3oZhtnWiDelWc1
	f1kHXJ3JwF73bKBTnTL3OByWx6av2HZ2Ocr/RWjFd44XnZxAQRPKbWy/KCfVc8yNuRwen5YVtLV
	dgDW+xArZr08g/1tkQQcUvmn9YjY8Wau9eKOx4SpGjwQ4O1GwpMQKOpirUUz5c4z9vFxewSCnXm
	rN+
X-Received: by 2002:a05:6830:81ca:b0:7fa:5c49:5254 with SMTP id 46e09a7af769-7fa5c495574mr18898447a34.27.1788872481078;
        Tue, 08 Sep 2026 06:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.169.253.136])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7bf0086sm15030740a34.27.2026.09.08.06.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:01:20 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260908-mptcp_nft-v4-0-af0a6120240b@kylinos.cn>
References: <20260908-mptcp_nft-v4-0-af0a6120240b@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/2] selftests: mptcp: convert iptables
 to nftables
Message-ID: <65d10c55-cd81-40e3-e505-3d0c60a147cc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:01:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/34223550098

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/84d6fbfc051a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1160437


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
