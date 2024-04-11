Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1031EF1E
	for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839776; cv=none; b=UXvU2xZYuHVpsDttxKbHpMAcDfJqw4AiEWV3BgB64Ior2y23bWswbInNUN9G9dLkq+d61aq2JB9klwoRgLDWK8/lioIab63k4Vv5eD0YkOHkup9nVYWfvJbxgYboB9MR00WqiQIT2EloWpM9LqSz21U9DGKvPxmfuJ98YtsKZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839776; c=relaxed/simple;
	bh=oIPDov2VVCIpmz6tjjZQ19XqYxN+iQI2/S5KHWX6l34=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jDgVxzbGQViVZhgiTk51T8EW7rEthEyTvEKVdHf+wZ7a/emG6N+ZJA6v4BLbv4zofg3LTwRcz6Nrn4okcEPtREEBf6ln6nyxnummzRQ+o4w0wwsB00R1rjoSWZYCHpxmlYr97ljGr3MdxY8dMsbH6S7FK1OH/jAqCwADQDDuYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw593ymm; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw593ymm"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-479cbfc62e9so2336931137.0
        for <mptcp@lists.linux.dev>; Thu, 11 Apr 2024 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712839774; x=1713444574; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/V5X0oXZNgeRKEpi+SB2ucrxgtRDfru53UCEY5cgSo=;
        b=Rw593ymmBUgFh5LcFuVSWe8TeMGWUKI0T/rI+8SZadffUenU/t7FQRx/c7qj2Aijv/
         IEJlnKsr1kFKB8Minbr0McQtbEczxcvgYRIf5scKuxpVj3lvCEsZyXyAsJe5RGFt6/iw
         pVUnP0rszAP5TB757MBBqtbWpSwzS/lZ1EZMeWvnWvPrfCCt3eWV66ic/DaXZ1+Je4xk
         2mzhWAeOsQ3cdhj+HYhxB8w3MXFQuDlo5cHDWhh74i2rVj5SVMB6kLO07wHmDhKj/9+1
         dNIA3TCjsf5zPBa26OgS/r0KOmS+suns1eL5c62AFfFJ2bRkLG1RXChj39GVHc2Zbyd0
         bNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712839774; x=1713444574;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/V5X0oXZNgeRKEpi+SB2ucrxgtRDfru53UCEY5cgSo=;
        b=MS0EnYVQGVv7gfWTfAAcdDl7mUbar3dxv8PzutQ8CuRQ9R9nzQXSAVjpOCS5pob8bs
         T7LcP+/Qqf1iQY0XQh+kKCQw60ncqAAq3zNVBlMLnmKW/uSBlCRnpmJvO0wjOCiXj6Lp
         R9J0Woa9Nso026MYMDDpsxujkujX/aRKV87yG6mCQ1s0zeFf1U5QSYX7aTBYyZ3O3uyS
         mXlZOn7d4iNguZze7D4F1WUrltiIwQUQTpPOAl7zAg1rdjLFezF7w+IW0M+3cLEif3cn
         j7b9GyOwkbQPpbGDnjaPECRR0g7oPCSiinxcjq2ECh1FTqsn/GrPwnvS36MzUhLwrI2O
         IYFw==
X-Gm-Message-State: AOJu0Yx4rpdt57EyNR1WDu1TVwPx4kib+mXJqfwbOsah5xhnzoGUFF4y
	ZwmSpbJeDzAEYhQK2XbrB3OwFeuiZLXOJKlJa7zOLm/e8tjnKFA=
X-Google-Smtp-Source: AGHT+IECfgPGedU7e/VM6ZAaJLFOk9BKB1EGheuvrYlkkJwmeeJ1a3Iv6E+66eKNrz5CpGVeiUAFjg==
X-Received: by 2002:a05:6102:c4e:b0:47a:40f0:d343 with SMTP id y14-20020a0561020c4e00b0047a40f0d343mr126734vss.32.1712839773632;
        Thu, 11 Apr 2024 05:49:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.36.173.204])
        by smtp.gmail.com with ESMTPSA id e11-20020ad4442b000000b00690fd3f6e3esm882677qvt.104.2024.04.11.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 05:49:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240411115630.38420-1-kerneljasonxing@gmail.com>
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v4 0/6] Implement reset reason mechanism to
 detect
Message-ID: <5db10185-ba45-f4c6-d798-187451b3018c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Apr 2024 12:49:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8646443837

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ce1857255013
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D843592


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
