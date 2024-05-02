Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876D13C66C
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658010; cv=none; b=rwEeksLMjirK0t2aAkVNUFGJrzSYKFAVPDUU4RGKpPHK/Gf5cVHJPsh3QZMx6vyve7P70VOJpK63Ou5u1tKza0G7LEtJI9mo3e3uF+5s7etMaDuFwQYJrQOvfa1CGoEBBldK650JYQszVUPRg34i6e1Mo5zIR87WZSJ85muHiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658010; c=relaxed/simple;
	bh=398KaDuX8Lteuu3Gxyh7T+DlJws1LZveE+O2WHrsyhY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iDzQK1SCFdHV78bjQAZuOC95qeSqA0kzC5DpCqYNTdyfkw6FaeVyXP8tqd6V6GpvshsWAvy/vVoNOO+Jjy+Q5hVnp2c5KEt7n7TqfsuIWJToozOGxv5BrgZBiFRXOgRkI02iPWxa1ztDJiP3v+T/v/cMxDrAmKwYucvIWJzCpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkRsnI+n; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkRsnI+n"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b6d36b71cso39167846d6.3
        for <mptcp@lists.linux.dev>; Thu, 02 May 2024 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714658008; x=1715262808; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1E7+/LF0Sh3AbnbLJkLAHBCuUvNy/SiP6mRrT3hRpI=;
        b=AkRsnI+nWNHHBA+KqkSkopuKHgjZjz78hi+fW8PavVh5CSqMIS15v3M9kd36J2NjnU
         mmyCbDflYyOYd/8TPDR3W5jLq83Akt2qf7Mhg86sN7KNVIjcp8zHcQY2pYnfdZXY8EWn
         LfPBmMOtoeVNAm04yHuMXvk4d+kWSQyayAPrXxscp6i8XmO4nFij50f9OGA4kn8lxY8S
         i+2REyEk67NnC0aExZsRlF8iYXRwuXzUjJDpt16uDUjA4Axr7mhnm3MzHIBWlPbTr92F
         TndMZMxkTVgZ7wMfLJHZhKhTIErkFMnWR34R9c1+zyQ94IljfYNY9YziJg3/bDA9CYIh
         xa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714658008; x=1715262808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1E7+/LF0Sh3AbnbLJkLAHBCuUvNy/SiP6mRrT3hRpI=;
        b=OoGUWUjA6d6QCnzs1yVdEXR1mmlxV9zP0J+C4jc96K2RMTIRfPsFAjBMCGTHmP6amp
         fxHzZQ1Gz59iHJCS1tAUcYcibZUHc2Kh9BUiBDfT6LvStiJc2z6swuW2bMHb7VvdRxjs
         AZxFDq8HeLjzRZZgz6/Gd3jnt6aDWiBYENhCYLYS6zvGqk7YNKbZyQNjRseXFdtYexGs
         Vd077QSqncmnCpKkEiJhP0+cNxf5Gn6H7/t1ds8gU9izGd/TKP3QtAs0I5TvQ0X7Z6K1
         0TB2LGnlrCdg9vit+01rbRtmLyqO//YLjdaJYmGRPyAq0mxarwLtZMM43zskdLVGdR8c
         +/mg==
X-Gm-Message-State: AOJu0YzsumZRg+I1kGJMQ6xLk9vY/qdtSk9yrPQwSnFEQYaZvkf3E7NZ
	Qpgqe9D6/R9o7pI/lF+azvNHbTVMmgNbOeoPoVuT1VpPhBM1Asb3y7R2
X-Google-Smtp-Source: AGHT+IH1voK6niFNFK57hW7uur7LZpUMMLAc76nRqGdjewnG9r/GEuJhu9B/Gk++lev+VmFQaDMCow==
X-Received: by 2002:a0c:f94c:0:b0:69b:8053:2c88 with SMTP id i12-20020a0cf94c000000b0069b80532c88mr1915632qvo.49.1714658008164;
        Thu, 02 May 2024 06:53:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.154.103])
        by smtp.gmail.com with ESMTPSA id l10-20020ad4444a000000b006a0f0a7f7c2sm367765qvt.89.2024.05.02.06.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:53:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4538e7bca21fdb7f997c026d74f886aedb547d39.1714654631.git.tanggeliang@kylinos.cn>
References:
 <4538e7bca21fdb7f997c026d74f886aedb547d39.1714654631.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: fix EAGAIN errors in MPTCP BPF tests
Message-ID: <c2996ce2-a24d-2208-549f-26728a561190@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 May 2024 13:53:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8924476878

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/66c948e86929
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D849887


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
