Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF339A4A7
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342952; cv=none; b=RGfONvaOOQbtFHQMINgTUcNtKr2ydYUlNbhn9x3+PVi9M03LRl9jMLy1ChlkqYWYBhAUSnYMcPOilqptQdC3mP4Vu2+DA065LPSQSJRq4gaPVD/O04BiJY2b4OwMnMm/EcJB8FrSVxnIEFuU4Oedissb2nUjMlSWPv3yrxT/YB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342952; c=relaxed/simple;
	bh=RE9HtCXkd/4KTdPJP9kfdFrZv1bos78xyLqBnL9d2L8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=U1+vl5lGpfcQ0331Z+23oAws10rMYIfxnGvf3MCVjW8HNmX5H3TxhTyh1oErucTeM5I7gMYte7zQxPnRWw3ZZQd9dqDy6xIGMxS2tDURl7F35iTk+4Av6OklchhLVgdOUSOlkJ9DcV3Db34Lwm/vf9nMobHXZxCtdfGKJ6b7DQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBNrGOq/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBNrGOq/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-39647184c73so2008480a91.1
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788342951; x=1788947751; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0SSkuuFuWnBKDhw65Ygv79FBd4ucHOXC/OaOqdSZXx0=;
        b=cBNrGOq/FdvN8nBg7VhWWo4cbXyf/PGyIFgZu4Vib09sYxAX8JP7vkXiVCa6JFZ/3r
         Hwml6yEvKUxZm3/8PYmN0NAWOouBUYDOOBK1lLyiGlg+wDT93qK8duAaA5kam+chkXOt
         oNlNibuk3ZZxbaZREkeQ4k1GI2hcYH8uvjPqm28/0IYeuIaz7v1PkhdDv1WhBg5TCuXp
         hY0gR938ubHKB9JieMWChtZP0IP2vc7TshGq/3eHO856iayP2oQ4KPXQRQD+REUxZp5X
         6PWtXdCMLdtBipcxxxtIfDLwmRHrqxegJwa+T0DZ9+gZP2eW0leCS59VEQsYIfPP8j7H
         QYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342951; x=1788947751;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SSkuuFuWnBKDhw65Ygv79FBd4ucHOXC/OaOqdSZXx0=;
        b=syuvzdwktzLCZ5L8Gmrms510FvkZ8CnXvKjrqRieSlS1Gee3JEUBz3TUw3M7BcuszO
         kVTAnrziZvCzZzEUDIbdMXDq7gqPVkPqtvqqStf2VvR5FNHHuRqv54s82FJFrb8xGAwD
         Z1rgDpimkTQGfFAu5meRMt6Wjbk0lb/A6PZN5t0VApEs7wLFSUBji7XDaajzf7dXQrjg
         xCQ3QoMZa4Uwfoy94D2d4o0JTmuAGXBuQu0kTRdcbAdyu7+2JxwvPiCNksKJj7mhbqd4
         gNXrEdCpp8dr4MjzD5iOKd5sei5aEx660z2w7KBM8822eDmetEDSiavPFkNrJxun7Hkf
         WLvA==
X-Gm-Message-State: AFuF++k8tFiGfnc4j13Ok+ivK+D99e26TKSV9VpwRc/0pYxPGIP9qQGH
	sS1J5M41fj3UFli4CLZsfYnDLEv3smB4Daap36Zfwr4TutHedhXyGdrEcFo9
X-Gm-Gg: AYBFou1CQKFDxdavzkMyzrNQkkmD5NWRKc+nYb0T8H/4PC6Ux5ZGARJgjgDTmVjyWxV
	WvesWjeBt0JnBWjEPJbbZrGLOE15clMITErafYY/ojeki3CtIJs8WQyICf+xk2L7o8lgtwbOWFI
	9CbPgOO1iqg7UpTSFX3BnSKMA4gLk0hxBu8+bpLxUTLl8SZ6v02U0VwoLWsXuJjcdtDNO4UOOzz
	ykORv0FHKkQb5w0UdVU1g2G+IEPXT7NpGNG+6M9RWnExQyzsTpS6f14UAqs5ebqaDLP7NhWsXbB
	g9wmNTJRi/u8denzd9k91PujRYU0K+l0+sURkpTxfXIyrF552aVbG3HaXgS/JXAsMZT3kMtbciV
	dOSVkyEiRI6+8/ei5z6wTF+t05+EgJVpfIKj4uaBe/4ATP4AaDesK7aEfiIuHf3vc6WJrAYvQgq
	95Ctgn9KuE/bDRf5C1rrESBA0Ea6CcyVl1N17kEvl3z6BM7pY6bEYKTJktYff+sU2gaDBfft3f6
	g==
X-Received: by 2002:a17:90b:4c05:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39af63caf84mr1406774a91.7.1788342950849;
        Wed, 02 Sep 2026 02:55:50 -0700 (PDT)
Received: from [127.0.0.1] ([4.149.244.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0f27047sm4848614a91.5.2026.09.02.02.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:55:50 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6e4266b0dc3eb7e68f0064e16fa9921f46b85319.1788338252.git.tanggeliang@kylinos.cn>
References:
 <6e4266b0dc3eb7e68f0064e16fa9921f46b85319.1788338252.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] mptcp: fix skb_ext leak in fallback mode
Message-ID: <93485371-6def-dc36-8da5-987a7b6a28ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:55:46 +0000
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
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33611802226

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3024edbc6c71
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155957


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
