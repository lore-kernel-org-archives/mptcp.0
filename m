Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD253F54D8
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161240; cv=none; b=n0IVrsd4ax9Qk1aZXn4RPrciTEOMCLsVv5d+pROBS/L1tC/8HUcV1qFHaFA1/06aV3jySUu9NDGyrVshtwx0W/NQ8lGiNFuh0PabOcuPIGKizcaeXSJmtNIP2dDJPIJZk0infX9XijwOa6i0CB4O3bvc1xBLUTGFXdz99YPQLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161240; c=relaxed/simple;
	bh=7KRMbNqEGC5oymGBIrtELhP6CuQFaxxuTy1uzqYlPVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=S8DwMzMXuroFwSgjhNY+7m+s7XkErQoo5aGyoEPsUvtuDB7NsdYcw8DaEQZRplLxQMyFi5RZRIIRmIaJZ7LdQNOJmYwJP/GzXa/RYMze+R9SXNXvPyRysTKHGmb7k98n+WjKwS9MbaAmrf0ff6doW/K1cOmRE6L5K8b6h3XWBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNd7lbKX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNd7lbKX"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d6b9bca48so10349991cf.2
        for <mptcp@lists.linux.dev>; Thu, 07 May 2026 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161238; x=1778766038; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SJ63qvOZs1egGec9TVRxRv7ALGMg/maIJrgPV3xKWg=;
        b=jNd7lbKXCzJRJdOflK5eYMzN91pO7UKKxodz7+Nht1Y4FngNYdOncL6zh3wuBWMd09
         UcmNG2Wj3QXQ3kUvOgShwoFKAdXgqC7rnyDhQWEN4SUm5sCsYvvmuBvjfyqgDBfyANuC
         AAtSslmE1vem/A2GkeiKmXulrhvNteUBKrDlW7CYVZcrerEXDcnsGq0fpI01Lh6E3ehC
         9La27qUIbvXtBy1I7TsCaAgplMEb1rMJtSmNa0TB7YUcCSmkI94Xabd+IoM2po54RA/4
         TgEfmBNbHsr9LAQSF4CbBlisB+NBBJPWKRQ9vdQtf5yEAFtyKJtqk8dP1VVbI3eleIoo
         z/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161238; x=1778766038;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SJ63qvOZs1egGec9TVRxRv7ALGMg/maIJrgPV3xKWg=;
        b=iz48F5gxwqHmCxBALIl7XPTzsjwARXsHi8Immh4CBzmoOgd65F1Aa2CMjZOtqFUoCq
         pCsWtyeWskhxSfkf6GlZbA9D95b8iX04bVRzmGgpR+FIXes2VYbTwsvKqICQNO0AGO4i
         fRY7BzCbTDJ3Pbd06AJrwyA69MA7WHpYcujLaPH3g5DX1XdGd2nYbjj6QlLJpm43GmM0
         rSlQV9ftZYYyScQuye2uv/itA3NtIs3jWQBmISLaAxWUh4SwfSUh5ajZEtMInhz5DAXD
         yqStw0Vlkfff9mjoyt6SUBe9gUQ+Ss77opcNmKMI5va8Lu0JJ7+CxC85Jeb7FvR15hd7
         T1MQ==
X-Gm-Message-State: AOJu0YwHOTl3eARxN1jGR06ApGYltIvuk4Qs5fWiESNJI42+CDq/5zlI
	8AUJ03l0MJyyKTpB8MWR/QUXaBFhnGv+UohKVLpF2ls5o4nJW6E6wkE=
X-Gm-Gg: AeBDietdnrmkOHA3jdMuq6F4GHuxJbimso7WMPuY3g13Vy2NjcnlvRzbN0clUnOC6Og
	TJsNMz5krHmD8whUbkrgxvp79/tmmRnhCK33iMB2h2SE4XC324SUSEXQv6GtPV8pxY6vZjTYdcO
	t8WCXMpuKvz5hG+w/W/GfE1yiSbKPPe33vUIK9ImgDMkY2o6rvzFaHQo/Qydw4Y62lTamymDuA5
	kCGU7/QL8tbFgfZiLSsjo8qohPieta5qbDpIupGDql28qcdZkoh05Yk0di8cMbTqgnlM12J/9MO
	gh+iEOQhMRrX607F5Rm5wsPqZ4zfyv/Y/PHjiyQUlWMDyxo/d0h8rpcZpJ9reW8cvk7d8GoUE0m
	H20m6fGa3FgFxcrs8McO4QJ7uxldxKJHGY9zacTpdEfTD48oiQgZ1D5fNJgb2BPLaC2R8FyoA+R
	kKheg9rdDMkVnL2Wr1JaVfc375ZpwKQUcp5wQI/wEgOGm38Q==
X-Received: by 2002:a05:622a:5989:b0:510:2506:1ba9 with SMTP id d75a77b69052e-51461fd438fmr120525691cf.49.1778161238411;
        Thu, 07 May 2026 06:40:38 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.37.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5104090bb03sm176058181cf.10.2026.05.07.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 06:40:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260507125224.3536507-1-lixiasong1@huawei.com>
References: <20260507125224.3536507-1-lixiasong1@huawei.com>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: pm: fix ADD_ADDR timer
 infinite retry on option space shortage
Message-ID: <4a212ce3-57e1-7273-ce0d-40196d22409d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 13:40:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/254967=
68062

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/274d555dc3cf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1091028


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
