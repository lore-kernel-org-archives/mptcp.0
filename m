Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8182E370C
	for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721397; cv=none; b=Ig8d8zW70GS9mezTia16Yw3TlJM/Pxjv+pQzf904ZryOWMpMYAs1ef5aKXD1DPiVnj6HFCfDCOSJpQ5h0ORPWhuMaMyL2k/NnlBqNE3sEU4WoOZxuQOnTQXMw+qlptC1Q0LDkLUtgJF6TW1THUivn4+HHrSiQiSZorz+0YvOcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721397; c=relaxed/simple;
	bh=87aaxEo4I0KXfmBd3AwFH2kEBiWUGfwYhTkQuVR2WqY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iQrSkOhI6Bl+33GrS9rwfwgygvvw6zWfKnW5O4p7ppG9VqLWsP/Ttfa6LzkTKsEevn9gsPbycAglLX/oWBbt7KMxpBqlX676Mh8zDXa1EWOwN/EmPsXwQJfUyfMEZRXEw2wDOhz82oicj/LD2Y69FbAk/jULCRlXMSuG7pXFjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh7SVBDz; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh7SVBDz"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so4371705ab.2
        for <mptcp@lists.linux.dev>; Wed, 16 Jul 2025 20:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752721395; x=1753326195; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xJyHk+I6Lz4H8U4ZaqIcLg+qrgt88djPq4Go7rkHq4=;
        b=Bh7SVBDzb+eCVj5S6pQE0GEJvpsQBeV8B3TV9Lpaigul4OWd6U5+Tu86HADBpb+3sF
         LQnO0RxodZckVPtvz/yIpEMagvhOnu0jqsrR6KC0HCx0as1UrwZp66GCTdIsvqzTaAOF
         4e41kg+sT6xbAWEbfmIfzQDSPYhHrWHITVCBYpEYzLZfX7KYVoGil58HRRrWzbNq/Gyw
         XOnvsvxJ/Wpi5tj94JrlExWVwiX/OzoQJTrqd21HzyVTxJ875kCvHe0Q9faP1TWd3ykI
         CTKoqDNmg5xCFFhRDA5zvCUf5BoHo2TiytgUdPzV48y3ZSIzUQmRJAzQuHrrM6tEjfn6
         0b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752721395; x=1753326195;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xJyHk+I6Lz4H8U4ZaqIcLg+qrgt88djPq4Go7rkHq4=;
        b=UFxBHfeIWIuPFRi1YybBfqUq0R/jg4gpuG1RTYuiCJy62U7S7KTVAwoTTQAgndL4Fz
         fKtorHHVUG9myApVWJPwGdMgKvYxsvCOgngpmSOEBNUD4X0V+qX/qncfoIUEK+JHynQQ
         OtXFvp/RaOMz4bHEktMqvj33KaW8j4NzW6s0TPn9JiAcc2XwVbO8Mt5jKAc3EcVmBmip
         LP+wT4x7ugzXxpyWdcuglMZEuCJvmh6AY6vbPu+Yin12xr2kt1Q3tnGwj9iHPKIXohWK
         zL8972efGvtpT6rMlUEEO05xZhQFqZ6ZZhOVvRV3sRpXOZ7+mkNGdTOiHlaMrE2/gJ13
         IY3g==
X-Gm-Message-State: AOJu0YxHD2I0kstTfMWZhGSLvJexII45vw12VQ0z8RmqYyvpkK2Vq4PQ
	nM69zJ5Rjj74bF6Zl8EOAxmw1M3R+i04Kvn2+IOz8X877X4rloGE+LtB2xP5
X-Gm-Gg: ASbGnctcyweGlGFuqJO6qvX2LK6D1PhFb/7wNsXTv7ogo0oaoWiK5irHQiM2BVJmk7h
	jc8fURNFhRO+kWUPWnDdKGcO6iurFyXEB4xX7aZsSbVRE+L75Inj7QPoIOuOkVCsvRgY6WPYuNM
	Xn/z3Mg1ONdffMi2xCq9u82aAd7szWfs0B4VlDZTzoNzNAq2/cXnWZOMJhM4OVonjbyMDtmGVEV
	7qLiU++k6bR9lMEpceKIwqUnQAk28k/ahDAoUtBaYPXF8DZkVeWgaDUOycyVBcFp4YwVyx78GJX
	Wy2BXsew5cYH6xNXccLE55inb1Ndvq91ca44rgq68ae+iVBkZ3az+7WkuVtfXlZ3DGWKTolrBrn
	ShJWY/71rEEIB31s6qKvQLafed2/SLPgIL8tlv/2M0ADfbg==
X-Google-Smtp-Source: AGHT+IHOTW7mjvwwQiEgDlxC4+0YxW8Ov+aHXUan4lwB643cTNTOHAP7r7VMqEEl1zujfxpWHe6xLg==
X-Received: by 2002:a05:6e02:3b0a:b0:3df:4234:df7b with SMTP id e9e14a558f8ab-3e282d62ac7mr60224155ab.3.1752721395047;
        Wed, 16 Jul 2025 20:03:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.181.18])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e27d35db5asm14435395ab.42.2025.07.16.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 20:03:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a1dd4d6e5774b37769645f1b415b2e843822e2b4.1752716203.git.tanggeliang@kylinos.cn>
References:
 <a1dd4d6e5774b37769645f1b415b2e843822e2b4.1752716203.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22tcp=3A_add_tcp=5Fsock=5Fset=5Fmaxseg?= =?UTF-8?Q?=22?=
Message-ID: <4ef2f9cb-20bf-9934-51bc-392f1779adab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jul 2025 03:03:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16334182085

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7792e3c7df02
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D983148


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
