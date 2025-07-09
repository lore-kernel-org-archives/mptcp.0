Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13C23E33A
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083604; cv=none; b=KdxOfYsMdg79W4PLHhYbHO7r60EYn9xFqk95afgCZFrq4dANrMMGavVIlGTFm/eRYplUC+YTV/5PKHKzGKL4K2VwnOtTo4AugM3qjBL02Gv2TRQBVZ2jpmKKEwn2n++iBg6xf5Ryshta89a1qFVtdHiguJL3hrWrhx+Q3Fgd5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083604; c=relaxed/simple;
	bh=ivSLh8naYOmtiei4FFBoMfKF+MhHSO1VKfLs+hmS45k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=O8NAt/4fyHEjhn19dpSJC8gohmBIjMlaj+CANJt5XY1iMa/nYnfCaVpa8EAaFW3nz2kQ23QqXYN7dwvH6SokmKLGDI30xii8C5De5Itw38iaR6yLwejnUk3s3Kymn2gp93pDsSVTlm9Gats/xX6icC9U9fsPRbTPg9IedPBiV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0hon1fr; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0hon1fr"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d3f1bd7121so14432485a.3
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752083602; x=1752688402; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buoiu74HEvZBMrxgBShEZ+pCRE2WWokhn4pKLWH4YLg=;
        b=E0hon1fr4r1Eckrp45lF21ENnrzMiL7WkupR5zEH8T1t+AbEe8tvKYoEYgJkUGdWE+
         etPinCHQBQdcvQjXYZdRlhMDcgMJ+xSZSBV+fAecq2QYJITnlG+9/qbX8JOpdlHB3AvX
         Vb90tf4z+ecxPppTGzdWVB7pPzA5jB8L9j8Z0CQYhWQR+w8uDYL+OC+fAUpBV7mPD5tC
         8dQTUlBegPBFR5Cmf1ee04LCj/+UWBpskuy1o2pTOnoYUy65RyjjMdbmBP6ZU+sz5HhN
         FMFgQCpJuP1G8mBubMX1avn2YiFBTr3QtY9FFLpxocO9O0Iv9u6xm80YPxjIFBy0Cuhc
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083602; x=1752688402;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buoiu74HEvZBMrxgBShEZ+pCRE2WWokhn4pKLWH4YLg=;
        b=P3gGeQewYbVu0zAWYW89f7QhlwFY836ph8xIF8/ZDm3Qe/tSzs/7AdwBxTRx0+QOWA
         XxTNlpaMTGOkjgWrhXDvWMqfHoPQL4tv7GvhtHe/3ZhOqkHeuOVyzi0Tzh1zO8AsLE5S
         bboPN8oLZOnBHtPZkf9mPcHpc9E8eP+7VpUJa5vQmw+B+zNUOTOTt3LWwTzh/7DVw35L
         WCVc+q+3YAArA+ixsKq/taCe8ThSz/BbtWKDw8D7JdphPknDoqsyx0DSm5ESqRH25wNT
         TgAPC9wsBjscwOrv7m1ZMzctgm+E2UJCq1durOnsFBoAJMQWFWTAdFfz0/2JkcojVsp5
         ZPUQ==
X-Gm-Message-State: AOJu0Ywi8tmZq7sHxOO6phDdTiD4tKRfh4GlhWan8SLhHilwbN6srQF9
	Tgt/4RZZ+1M5I0CsuIF/Y9MKGbminTGPcGA60YQQe/U1t2EzwkZ/GxbCWjuB
X-Gm-Gg: ASbGncsaM3JP2o8XWQVVdMXFfX6f1MpWBtCi7EraSy47C2rp1P0gX3EFTvCGpryiK3x
	2K10XEunsZJcB9zZqrYoFPEiQU7fCJCBIJWl8aZsC2i051NhAA/QG+HOytK1xVgMI159XY6EMoZ
	sfWRR+MnXa6APabsu0llV+S7q4jFnTo73DbzNajEUSndOXbbT+YIoSgkY2VfKwqz24p601t+Jf+
	23TndtXGApnW6DgGOFhfptsODKXPu2kK/WkU153mhg53+QqR2z2x6VbnfY/HKqsL/puPHgfUW5w
	YzUg+yWu02uERyamQ8E2YW68iNZR5n3G/+7UI9ej6J+oLxlcqYVOIVPtFsXyBNI9HlizW7NL7Ia
	Z
X-Google-Smtp-Source: AGHT+IHKeHXulPVxwObKlBaySDE/Oy0Thr29bu7cLkJIlVDdZ8U9ZPemDHco4DdMSAwdMjS+tYCQ9w==
X-Received: by 2002:a05:620a:4509:b0:7cd:565b:dbc9 with SMTP id af79cd13be357-7db7e53aa89mr532056285a.26.1752083601997;
        Wed, 09 Jul 2025 10:53:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.95.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe92da3sm966023385a.90.2025.07.09.10.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:53:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/7] implement mptcp read_sock
Message-ID: <bdeab071-5216-127c-e14c-8a58c00b68c5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Jul 2025 17:53:20 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16172161051

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aa295276bd34
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D980362


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
