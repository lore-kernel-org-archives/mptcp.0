Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C077291C01
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494172; cv=none; b=F3i9DGd8zz5Au/+1EhSaRtk8frP8F6mnc/qO0CX+imPT6LC/GBkuIVzEBj48YfugyQoS44GR1fUjSnkufJBOSJaf52me1tVKon7FSLHY8uzQuv5EHHoWAJSCQhIO/DzmpgoAO08ikd0ITi/LdnRlPFoGhJi7SF18JcBNWrncUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494172; c=relaxed/simple;
	bh=WjuMKnVMomJQpnTRdf70eaWbWdoBCyB4E6wXOxWgkq8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OUluFVUeYP6ZM205uHjW1gU/4nK0OL8kLFeeTxkNNnRT2Sb5xBo6oYqwi2Uz3CnrdMCkxEo+M0fUkvm3rOYpyVOo64ENNGKD3M9pej/fyP4iydxIBvcppRXhKs7VpsQsxqGC8SDRCyKrBl5PNEYQqaj0tREgppykQxzYAtwtUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYvIPcuv; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYvIPcuv"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4aeb2f73fc0so215511cf.2
        for <mptcp@lists.linux.dev>; Wed, 06 Aug 2025 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754494169; x=1755098969; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdyNBGIeLcEul1wmiE24FnxaawOtBnJwLwQHiA7GHOs=;
        b=UYvIPcuvc5hlPvw4sek7f85AVCbWHEMSkd5H/G0YaOzJDkg5E1CyqSKigPwEEu45Ip
         UYyRmz6570vGITEgREkp5NbU3Voi0S+gaCKvqkvVOJm2ht+nPSUJvqURduGKFNMzWZ3/
         YiXBz0gczfU9YMudZcPXLfH9s7AbLKkatU+OpV62QXtYADWpsJT84a7viD0P51DBZ9hK
         Sk5Q6oPszKtmcLng83qrlVyYsqWpxBAt5u4KqT7yg21F5WZAgCJnb4ZEKqxVFhr8A8Hj
         UkAwWQHArDh5L+QX6y2Oqx6o66xuipwV5EaPiBkzLCFiDsnmKDeg84X3bblHTK0BIu4R
         yRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494169; x=1755098969;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kdyNBGIeLcEul1wmiE24FnxaawOtBnJwLwQHiA7GHOs=;
        b=dxgdoVTdwVQ+Mknv4LBu2NxG5PXDQaAQoEpmmOll+s/A1cA6o4zxMPSa9G7twJj1f1
         LyzBaSOGtXjPIvbT7sWmumrBu0HgGiAUWXYtg8xISoHvi2AxeEu7Do1uxC6U0IOB5H/l
         uCTdiwUtuas8FUlvpXgGzTzbpSaWfqXOBFRH1upb+BpGTTYM/DGPGr5/DFANS8JZ4dt7
         CBCu7DjU8wstQHTRPrWNauini79b6D37f2DR7s4nNeurHbOsLi69DMJtvcC1tMURoBbw
         cVGFro/nsW/NGS9jSwqwMhGoReFoLYR6iWJxWw2kDOO+h/Wv473Z7Quuy8JNJgjqNK0O
         V37Q==
X-Gm-Message-State: AOJu0YyNxauBWoasbbxsP6EwPBP00E7VTeU7aQa/+v8wMN98AFgqhL/F
	udVp6aS6K/5ri7CgmqQo96GVrktuaavkaj2+xhuQo71znx2KfI2LFXFB1KCX
X-Gm-Gg: ASbGncuNYI1YjkuPdcBJZP0oU9fNCWucqNxEmzZSQy5UG5Iuocgi0L/8nBrPH4r58c5
	k7R7bCePIeu7zQGG7d7YLr0tlumMmwoe5w1V7oL92bf/4StU3qOAxd5oqLXkxVwwbwlhjsBM+fD
	gcyqtxr9vVtgANUCFYHaWQdBNhz117CX3hT1aYnpPds8D1wN64IWYBVQwmI/vk0ttsxCqpVJE9M
	7tNP1t1xbNmOqB1hzuROsKyinmGwL8JGJZCo/OAkxpYEbHd+wwWTJUSSzb9S9NozDlYCKD/CaeN
	5V1zkzK9/8wAT+0xj8iVuSnlaccZKS2pNS5HkZJ8csTaXtFLvStz+WOSKGnmnUTrK2Ud3NDAUQJ
	WsVvAhckMRgyWGEueUjB/1GN1AwiH2IPQ0NphJmDPmgom6A==
X-Google-Smtp-Source: AGHT+IFzRA0fmEB72LJWfya3EHNz/JYghkIkr1vfs1CtsDI9FnToeHL9BojMUlJJn8WuDXEsQ0IKPQ==
X-Received: by 2002:a05:620a:6cca:b0:7d3:fb3a:675b with SMTP id af79cd13be357-7e814dae35emr442244085a.35.1754494169264;
        Wed, 06 Aug 2025 08:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.38.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5bee91sm835481185a.32.2025.08.06.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:29:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754449947.git.tanggeliang@kylinos.cn>
References: <cover.1754449947.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] mptcp: improve ADD_ADDR timeout
 handling
Message-ID: <c59fed78-9dee-af6e-c844-e450c7d0cd27@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Aug 2025 15:29:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 2 failed test(s): packetdrill_add_addr =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/167786=
76332

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/287779d926ff
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D988606


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
