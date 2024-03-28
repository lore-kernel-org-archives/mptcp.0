Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D57D3E8
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622422; cv=none; b=qACbXKz3GPfHUCNyl/SnsHjZ7gNnRCVTo56SDJUf0euwWEsOzIn6KfYPn0sP7o9uDkEnEi5JkSLUPS5JD/zUYxOXACFLznY26pglidGQvl8vJOQNx0OgDW2B51pT7cdvtAgE1cY/bS2NYM8Jbuglial6YMnXYysQNZFVSPM6E84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622422; c=relaxed/simple;
	bh=CjgbnLH9QV5/vjt/egpuaM8AAJEAKovY1yTDsPHE7n8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=g3YXJ4YmVh183IqqZoHCz6nYgz9gEiav3do/qTL8IH894RoikQBRUXTrISyeImHp7VvQCFwzWSIrjuBrKFUOzuZLAGP3+WWSdOLSmWQGsKQROXgCyIDfZ0BPkA8nWfGsiWiQ/vUPgxwmuVfacKtm187Ibo+fgklcuJW4QDxoe4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMj1LuRZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMj1LuRZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0878b76f3so6411445ad.0
        for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711622420; x=1712227220; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ/3xjnv02xWWpEORg+jmthLDRDkchJiDtI8YdCr6Zo=;
        b=PMj1LuRZ4Oeg424TubmsxTNClKK556+dL+zxeO2emQ1EUqVZFLD0IdVWAJEEh8WflS
         BIUsQPkgkbywCThx5FNnXRF7Il45yH2z1eoIaGyIWt8/eqV2Q+/Vt3qadtRO8O2g9J9O
         QqLi9adpbwURMCpuFo1P/doAKbgfgkZ+bDyv3Q/b4EmrAUraGKDubqsmHVDlApixkht6
         9e9GDRNTjWQHQqUO+hRuGq8KHM/Qp8VtXSPzVrU2H6iuHX4dtJfCuPaAw3uVFmzO/TbS
         8/yi5VZMvk/S2tYBpruIIr2cFJ5ZZ36Lxl8AumDZ+fm8OQrytSOhhuSXaIpg2tVmw3b8
         8BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711622420; x=1712227220;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQ/3xjnv02xWWpEORg+jmthLDRDkchJiDtI8YdCr6Zo=;
        b=fiiduiI0hkQlVq+Snd8y3KzyF4VdBzO871DC8EohbiJViIXD9UZvMrhRYCw7dQCPee
         RsF3rj1iRqdFmgnupK/dTiqQTaCCBjrk5fEduweS6J/0yTDX5LMizY2T+01H2Jv9mGB2
         +9uaVR8h5ewaCA6dK01OgTVHCr4Da+/i+kmPcJQgZrTx4FbXq+WtqlZpNdS4/Tdbx1r2
         rjc8nvKudYCPudrHr6zUXpvwnsNL4ntQ2LPlYrmwfVyz1DIMFYoUYq649noNIYKwmdH0
         ZRdE3eKEjfFHq20AWxf95vYA7OcMs/QNSLU17Bqi98vHNksdRGVsXE0/Oc4pVpqPro/F
         phkg==
X-Gm-Message-State: AOJu0Yz7+co+GYxTp6wONGY97cSujtym4qq6oxodt+LXIObr1B4adolp
	9lVIZTHt1git6pYWy/adMqlqA36AihG2UdpI/e0pkdomuQ8eHDNw1ObrQ9g=
X-Google-Smtp-Source: AGHT+IE/JQ7jOyHZR+4F0LG3jMRgBtJ764EKFzsORySVeif8+auLo9vKI6gNcidyT4H5KB4AADzrnA==
X-Received: by 2002:a17:902:784c:b0:1e0:a3b9:2e7a with SMTP id e12-20020a170902784c00b001e0a3b92e7amr2077937pln.6.1711622419879;
        Thu, 28 Mar 2024 03:40:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.78.147])
        by smtp.gmail.com with ESMTPSA id cp9-20020a170902e78900b001dc944299acsm1218716plb.217.2024.03.28.03.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 03:40:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711619108.git.tanggeliang@kylinos.cn>
References: <cover.1711619108.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 00/11] refactor mptcp bpf tests
Message-ID: <adaa3f15-fd60-6bf2-8d6a-cae820c46054@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Mar 2024 10:40:18 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/846555=
6663

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a52e0605049e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839268


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
