Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FF3C552D
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774870693; cv=none; b=dhJmGjFUbW6NmtgNhF1Eccj5V1FlEEGnmtTbrBjq1RrV1CDsHmd7P84lBRyyGPq4CcIyKHEtAJ3YIJeZIl0ee6qG3unO8A72cBVgaQAU3Tt5xEFyp/SKY8D/96r41bZcffGWrz38sFKaA3S8Eo5NdsiVEw1tnb/W+5CW+n0ru7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774870693; c=relaxed/simple;
	bh=F18YMkD+cWvt2Y6SnKNDiEEnY+zTZE0FjO+v8wPQvDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rtbKL6oOlpsj+R8KNcMPsXcmYeDBVgQiSc5aEQ4Dzn1S+OsOYnRe0FtX+fb4N1urNHKIooX/CDkfAJwIXdJHc5NJ+Q8q34/TYo99qOa+FqywQWXRzAFyyRZcIrwcM90hpVam6LiWDUFZZWIgI0fdHIsK7EIrCHq/sr12fNbOB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVYfpO3N; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVYfpO3N"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd7ecedf2cso459196285a.3
        for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774870691; x=1775475491; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxWyt5zpyURE5E2TJpMvvcK8C56A6evaefl3/w9/lpo=;
        b=oVYfpO3NNHE56DtkPo2Gk0b7vl/SfD91T9R1DrB99N5UTQ9jyhOImg7k7R/527mL0v
         2xr2hQeE0MQzxJ1EG6dEX0fJB28S8WmxbQwJ4Fszp6qIzKs9EGYQLRJ64tNvRryJsZVx
         hzAsygdOCkA6pjnteiC39PMEWEgso0TtnW7Bc+e6qGfcjhfnEGPr3WhcUZoYamBQvPkp
         3PnV0xSvar8fpscMB63eOBUmMRALZy1TdIS6BSAmV9Gazzi1/d03WEgHmjIsbPg3/HLM
         v8ueMPFNic39UdBZU0kCxETwqCXKB5cxgaXBabDmxx7kdYKZtYkS1/jOdyVUtHukDwlB
         TPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774870691; x=1775475491;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxWyt5zpyURE5E2TJpMvvcK8C56A6evaefl3/w9/lpo=;
        b=WVdbpyRX3z6lYz3IvG6PgaOeV7jYw6vKlVySm1/HVwyxtrmgUVLf8VB7cMCnuPc8eG
         Ysrw8K7PYmZiImcf8zZl/NqvlbcSlIpiW4GrJR3K7t6M6VsXsjZwT+7jtepJcFRu4r4v
         zGQDUelfaVgyGbO4niUYQ0/nUf7qlvS+fUpFDyNcvDTJSxNwGnvDn5cPEIG2jXdADcGt
         d8BKzYDfXLZk1j2EVvo8M1o/9Y35HyoTGQHE2B3OwHp9pI5lZ826WHUwUtZDxLIs8dV0
         piU3GmDo4QUruqY6rlJSBaARsUt9dSfGDGKVxQdyseThqUOwOKJ0acKthJjOVDDwAZKU
         HOsA==
X-Gm-Message-State: AOJu0YyT5EgXsEG6EIquKzxs2KaGCjMvIuXILNV6hV/LyVpAIbmgXqv0
	Yl/A+6RAA17Z7D404KYIpaCIumFNDSVdYpFsdHnK09Mwq5EBm6WV5D4resg8
X-Gm-Gg: ATEYQzxbGvo8NiQqejuc1hKIohT8TCwBo7ZEoPguHmd4+Uq3KJv5WS6cQ1deWWzZ9J7
	VdMFNpGfqtVHPG9BSKCiJ9XN3ncKrP4FOB9heYeiO0aHQjQwnH4V62+59oW8qCXoYvTcaVuttzE
	5RaWrwfbuv0OdvfF40VFfmadDRcj/zLx2EH0sf7Y2+OM7uTkQxd+fhShlfdX+X99uxX4JaEjzja
	jfX0pB2BFAOgNUa4ZYv//pMJ9bvV9517A5ThVDEfum4MdfBIC9y0tKawc+kpsw4OHbECMRVS32f
	Tyh89kzw4S90+M6rtOEUzFqFDKsH+ecCsCJ0eU6KjvHt8GyndmW2X8d+58QvE3E7NQeBoUBTpNf
	yqYGLH2IepUdlXJ2nkjvGawtPLrxIxcGAtlj08xWYDFCjVOE4y6fCgW/Dy17UAMm3B1eL8F6Gcb
	x3nSnTsveuhbPUyKNE29MNyxh0/odKwhkjmg1lir4=
X-Received: by 2002:a05:620a:179e:b0:8cd:8fb7:7b06 with SMTP id af79cd13be357-8d01c7fb5e5mr1570217585a.40.1774870690826;
        Mon, 30 Mar 2026 04:38:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.125.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02808af7asm590756985a.44.2026.03.30.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:38:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1774862875.git.tanggeliang@kylinos.cn>
References: <cover.1774862875.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v6 0/7] NVME over MPTCP
Message-ID: <70fb1092-972d-df00-5bac-6ad3f022820a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2026 11:38:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss selftest_diag =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/237389=
44825

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6cb584e4f7f0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1074466


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
