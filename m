Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10ED39022A
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262982; cv=none; b=IJ521rl+wb2/NquN7t7j49shycATxp22HFdPuTIjLP711DN7zjQf5fFQDWQFpm6iJxi7nMK2jjGOiYuU/s6viUMfkMpRs8qFekUB/b/5Pzq5UZwc0O7UlBNDjEc67A7Qr+VfHQwZCJdPsd0ylu5JIuYjFW4iG5sQGR4E008EGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262982; c=relaxed/simple;
	bh=jnev7xplyj6Iqba56zWkKy3NGL79MVHNVSMtCc6t4nE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=MgM2PaD3peVg1h0PXHnZzvrFDSfDEHr8i73e5/8qcxbhVjUSV0P20z6wmbU6YAttocbxBommn0cE2LszlRYt5ncpQt4q7tJSnjx+0FLwUj2FITUbJqJoMMWtK7DfxmWAD1itaTtf/mDTe2IG6EyhqW7ctOfeyc6sKBecunuouaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQbnToKg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQbnToKg"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so908781a91.0
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262980; x=1788867780; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DA58N/hUoNPWwjcU+fyMNb43PZIrHsGSlARj6v/+E6s=;
        b=UQbnToKgEcMq7URru2K3ZWIxArFEKZra/vCI2EPYfu9Xu5rLYdWri9UTkHt0f/71RZ
         NfH3VwfRnR30EfTXeNbVkUClHwWCPCBwZIPaqWRwgWT8VblSiT5C1MgaAX0Imy4UvlKe
         WgooiBHZtgjnIr42HuF6aCf1646neiTBp21EcLGwQ0MrElH4+7G377rx2Fkb5UO0S0+f
         fRyJXDwyaC/DXA7O2Ph3yQw9HAxff/fwE2XSwMRsc/vIu1d3WeU1kALzmh9id1ApoL8+
         ebthfnVF9oVHNzEdowR97Gmhcv6y6BIqRO8jL0s1adB1LYebyNQa7UNa7nfvss8LkRY7
         iEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262980; x=1788867780;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DA58N/hUoNPWwjcU+fyMNb43PZIrHsGSlARj6v/+E6s=;
        b=aOWebXwQsJy9U0RWmC5UvkDu0RFTx9veetnl2D+CzLPn1B/I8xCRxC2EHagwUBIxF4
         bzNhrqRmjaTVCffHe1MuNnsg16pecA4sQCRs2EX2rht1m7fmhBqF8RQT7cr4+4DgEOKz
         lTvGEDYTJs2Q3eKYFnAnuLH2sGiEWSHVHHkYoyYPJxAG/t4XZHR+U57hqKV+NiKSRHRw
         2gdPkROFuxtTFU1VEfEKKCCM12u4cgeGYgfzL59acCN6lC8oy/Nw2CKQwG7MNGBqcvR1
         8xkWN++QTL3r/CvtiQoXnU6wQdf5YkR2elkdvYD6UHh8Nw06EzhjxTR9PSyMGz0UEWP5
         QOZA==
X-Gm-Message-State: AFuF++lxsgp3l9BAkxzJool+x26a7blWPnmoG038il3/IpvEUpFoY1AE
	8OZGYVIZz1I/pdZP2XN36B6jZQ8uDoEt+8OkZpXIYJTZdaWESGxOm68=
X-Gm-Gg: AYBFou0aAJt6Eod0diEemIlxNJPld3g5tuL3W3n9m3SoYaNK1qkRsK8l2ivKggFbrtD
	H3E/cNX7KV+L81n2ephRtyNy5cs2ba/DSdMR7B5XIyoqJYrIG/pcFZWHSxwi7cf4U0DnCz1jKKo
	HHUv5DTuzRI8HWXCWzlYTKuyTCE+zJSZTK2X5tfcOaXF2ZhekeXzOLVOo3AooUkleDu14lTIRVm
	n/cxF19XRJRnRKn/ovTaqP24Idor7nZR1YdtukUpCYtolbPXLqJXyeTaS9BzcNnVOAfV1ML4AD2
	7T+0U0nmGh4uHhYchTlvXaF5uzlciffADaQQsUUNFB4rBE1oRvL9ZEsNEk0Nnr4YWGNW6+Xmt3b
	BwZ1BzAoNXwMw2l8SnEZIgoUo6C1NSUu2SNTA/1BVRSIvuCLajt+hHTASL3AqOupQ9a8oIg/lGP
	LIK6OrmL2xszfszA3VTBKkw7Jhgr9jca3rkDUaItNsFn0lwBFtDY2319/DpqYqDLgIj/NpNQ8=
X-Received: by 2002:a17:90b:4405:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-3990f8db9cbmr4116296a91.23.1788262980094;
        Tue, 01 Sep 2026 04:43:00 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm23853953eec.12.2026.09.01.04.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:42:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ruide Cao <caoruide123@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1788202924.git.caoruide123@gmail.com>
References: <cover.1788202924.git.caoruide123@gmail.com>
Subject: Re: [PATCH net v5 0/2] mptcp: fix request migration ownership
Message-ID: <fb5fa79a-b618-4be6-0791-86a6dbc88798@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:42:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Ruide,

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
runs/33499753617

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/53401bc1f490
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155240


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
