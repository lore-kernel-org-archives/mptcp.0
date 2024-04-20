Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A939AF1
	for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713615471; cv=none; b=jael84fnYIKX71N+HZWdjOhD1Ar0S30t4HNJGe4iVfbVIs4EhCxw2Yev5Ru2bjDXVF4g2m9Oa6AgxNH3jRsIPRkEL0squ0kvu2ylcRk5yKEqyoM+dUiUBno3jDFZq4Y/1Wmqkz8EsqyVhBuXRop7k1OCLgzBfcRYxRvHX/1EyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713615471; c=relaxed/simple;
	bh=yGQ8ZBiTGnrnLu56Jw3zDZ1A7FtNkgXySejJawf8ajo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=buZ2KClPzgjJXaXlUSJ0kQNPiKd3X+Amo6188fbTr0i4IDrfKHblxd5HBazMCU5VMFMkEDIAThCLg9390hRccx7otuvswp77u2+vX3ac8AKJI+NlRBNS8VHA11OmH8hlpo4xK2Hej17DdzrTwu8iLtg7j5VTQfeWyy9zwvEAe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbxmWefE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbxmWefE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ee12766586so2303809b3a.0
        for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713615468; x=1714220268; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARUduEtZiF3DpHLwbDJm4g/qW1zaAn+f7Rkp6+brMZc=;
        b=DbxmWefEyr2tt86YoUgylDIk0TRjXXS0vmY5bE9YfzXWo3UIXFSpEbSRIdcY95OEcY
         Ypuo8AYbsoXET4NSyH7MjY6g1JEUzO3zqXvgd2KevwYxmcTf2Ok7pUgFolD/889smuVR
         nzyvTIRHe8sUXSm+En+Ofr8yKdOmD7qSvlg9py2Y49xo+A3An6PpTbSps1KEW0MVJVLg
         +jnAen3FF04TJXyOM4wGQvO1yt+8180opQx0Bd6Vgdmq/TjJgD3uxk5i9O+Zq4mUBpkb
         huk94dsc7Gfizp3tFOUwqOG2xkg69bWS0ZVbjj7S2vplW8ddWTv4LLe3x1xemarT/H7S
         v34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713615468; x=1714220268;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARUduEtZiF3DpHLwbDJm4g/qW1zaAn+f7Rkp6+brMZc=;
        b=Hibl/KHbrkjoFKQynQCVgCNIB9iha6gAoSGtSBZEmwCu85lMkJrcqTLgD0mwQhmz+7
         4liIZ0GlASi72rvovP+Jw8NOhfz/F4en92SlvlTuVe6SL0Tigneg0Sl/Kg+yH8EKyCwz
         OeKIsZA4tlVFgMGlhNhMzQvWcLtc30B6j+MZbS/9PWMe75OxQbz1eNGPpO2C9TvfeYXO
         MuZ9wJl8ZnPBAeJsu0Q7uiy8LOq/u/e957JgFTPkvHrhFC4U9mb1uF1qNLX1djem1kBE
         QCTt0EhM8+g1e55xNIyGn/khfksLpVG3TehOWBC5FS0jY5neJ1WQcYPKG2Rz188BhMpm
         Dv9A==
X-Gm-Message-State: AOJu0YzB1U5DKZYAVCm9rbq1HxihjbuVQaOSQRrnkUjugnF8Vw7s/CNH
	zvNmkWmO7c4Gfqac8DYPLHZemI/MaxWRTaOh6ERXwh1lRc7ZJds7Zzqt
X-Google-Smtp-Source: AGHT+IFBXnZUR73MYNuRllMofurGBKtV76+7Nr6sXDeHazJ5MOAmley4nd1n0yNykGwokQTtgrxR7g==
X-Received: by 2002:a05:6a00:138a:b0:6ed:5f9e:39d7 with SMTP id t10-20020a056a00138a00b006ed5f9e39d7mr12705014pfg.5.1713615467835;
        Sat, 20 Apr 2024 05:17:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.24.222])
        by smtp.gmail.com with ESMTPSA id fv4-20020a056a00618400b006e64ddfa71asm4920606pfb.170.2024.04.20.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 05:17:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1713612119.git.tanggeliang@kylinos.cn>
References: <cover.1713612119.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/4] setsockopt per subflow: BPF
Message-ID: <80d55992-3412-4b3f-eb47-b649ffa67aee@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Apr 2024 12:17:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/876475=
5068

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e84d5c297f46
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D846316


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
