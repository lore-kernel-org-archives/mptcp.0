Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466F130AC8
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741616; cv=none; b=hc4ofXtZf5G581GKcQ6wvRFsJjKI3gfAc6bVxNv26cjbDtzCnz/66viQluI+SLtksT8JVn9M8y79lMdkCdNAPy5AVPpEx2VMW7q47o2MGFM+CB2BXeEDkbEU8YSNkmB6tOGTSfjomQxuM7V75H/jt5qC9LWepNfwM2C5D63ujYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741616; c=relaxed/simple;
	bh=bHHYAydWdM/M/UnzrxvmoD0HEAVSxRyNxvA9QGNXcaI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=T2hzCAGUaWWHnWAdLKbKu4t+pnFhbcYmHfGBt79ZeKi664mX6YRhGVh38g25+dzGoRkUHuKE3GXWNifd+fKpeoqvaa+RmAYAcS0xqCcd8EQvY4G2hXseixCOH5jXrWLfJt8KSvkfgo6HgWO+h4xzABJKMpOJaUYTDdU1/LkY/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE0pSVfd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE0pSVfd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166651f752so1924305ad.3
        for <mptcp@lists.linux.dev>; Mon, 09 Dec 2024 02:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733741614; x=1734346414; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0+V7gouupcjEBhlKS7vOX7/aPmR9PE9kYjsTrDaPdY=;
        b=dE0pSVfdhLSuPokC4ODMnv1UVkCrMniRn22xgQ1Eu41LD/BuMdE30oHHI9EfrjsiTp
         22RVynGcQ84huly7mNuWqguR/inSHm9KAGZy7EVtqxKs4Tn1SvgIHn8tm4vmoVu7kWs7
         XIS2hK8Q9QTJBcqIOwEuRAtHQFg3BIXjqVe0/VupNmPZPTor126HRG5joUd1ThVUU4mb
         lSxnwlIBw71IMhYQ9akk2EwpZctK8v4nPQHmhKJ94W7dK9/o4KnceIfaAKt4laDV8mz/
         OBGYXWyuPGkJoBCiT5v0Mhd5t1PuJDjcMHCdwVR3kI6+USUfmWKNKm2ZGd4pv+eEvvAW
         1q8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741614; x=1734346414;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0+V7gouupcjEBhlKS7vOX7/aPmR9PE9kYjsTrDaPdY=;
        b=DcEsdPAClLn+tSisg9ow4Lk8APPjClmemFmF7jw5vjmzWMGZQoc/deiT3V561WqQ0o
         Tn5xpcWMJSJkKvRbuu3qoBbaOd9eRTfebkuIXqfvdQxAHdLIvZ91q4fUiixu3Af83UcL
         0Vl4MkT+cOn3Sfxj6rCUcl5NvuqFrZGz917xY7U2hJxZ5cUpTKqdCbLBYDDCUAPr7CAT
         Wq7cf+HASa3kxLPr1pepJVNa/EQQf7xj1utna61TIv3Y8Y/4sO6QYhGdnJpSISBnGwSL
         5Zm6vq/2+HqsPM+cxHp5/8++bBLvR+ui60bDb2+PL3BMSax483y22uwKdCRh+SBLpSlc
         XzWw==
X-Gm-Message-State: AOJu0YxAKd5DdUGVe8qw1dW5eK405zycsEdf8BWeX6njBCYkdbADzBKk
	C1go2J9BnoefDt5K3P+getuLLbBd3PfaMfE5wh1Vo/yfYWOwSnuKtCaQ
X-Gm-Gg: ASbGnctPdIvZSA37TzEy6usgTDkA89suV8GG5zzGaZzBeeecmf2P/R2H7Qwx78raElL
	g2Hb7O6I1ALD9QeZ4lh4nd3VGee26+p+sCV3QAesfuY7BgRNByZLfLbYHTSUgSs/PLi7l3E2WvG
	v2CvioXgf40x5c2ESCpXanz+U9EQVP+wGsebCuAg/9Yb5yCJljNznjGa7o6X0SFyiCiqk8Xt5UN
	W/KQ5cld/X6FdMvhWgHjryu3Z805Koy/9/S7RG8WJNdw7HXVZIO3J1YJ+PPyY4=
X-Google-Smtp-Source: AGHT+IF06pfTn492A2Sc0leY0ZIwOeU/a5j3IMqiKwhsGINkZEE1dxoN5WmDd1HaRsKEZefqPuxIAg==
X-Received: by 2002:a17:902:d4cf:b0:215:9649:635a with SMTP id d9443c01a7336-21614d6998fmr139998815ad.17.1733741614053;
        Mon, 09 Dec 2024 02:53:34 -0800 (PST)
Received: from [127.0.0.1] ([4.227.115.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f29c17sm70203535ad.244.2024.12.09.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:53:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 0/9] use bpf_iter in bpf schedulers
Message-ID: <907a5024-30f2-17e9-a36e-6e40cc996435@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Dec 2024 10:53:32 +0000
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
- KVM Validation: btf-normal (only bpftest_all): =
Unstable: 1 failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/122332=
29582

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1ea2234c1f8a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D915852


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
