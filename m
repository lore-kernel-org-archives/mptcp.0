Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A70146D7F
	for <mptcp@lists.linux.dev>; Tue,  4 Jun 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517136; cv=none; b=o2QQEzOMmX8Zexon4QK/Ys+hoNqb1TIGufT6fOJfv/G+zW/3qXHw/hZvqF1pqoWzheLSGipG9zt/mcsaIK9SVif7v7z1vOQt1YwgdC2/ClecYVJPz5ppeQzQTDqE4XUSlGzLV08pVZ7GUHh3P8bxFYyyz9/Y842d5YD+xhS+A4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517136; c=relaxed/simple;
	bh=T4YoSNv3vWdoi9PzqS14V9Jm3L5GoEDenZpjlA6B+Mk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZLUTh+GY2U+3SmeqAHnJslLam2+i1bHFqrOfpZ1iX/IJkM/veKAhb7p4igxx/GHcaF/Cnuu8E9EQnuTOWFWgO1U62Obv9lDcFReQCQ73zcJDg9jD/pVVeFyfjytVgdIrQxojxEIdjd2ld6T40oEbCbky0YPy/eVUPqHTsBoB5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm4leT7n; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm4leT7n"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44022c9433bso3644191cf.2
        for <mptcp@lists.linux.dev>; Tue, 04 Jun 2024 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717517133; x=1718121933; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXLowVG1jlKkvdvrwhbPt7vKAuAA0v2J0ALJOGtf88=;
        b=Tm4leT7nThxXLhNdsUfMx7fxWrcU8HwyoerebZwdCGr/Xp08kY7gvtlSz7q+fOlL/W
         1yG43w8LIoJPhTJGfxgZ7mck7I4n/AJuUbkg+ULg6m9DiD/zL5GI2tVeVIuWikj78yMz
         AH/LZ+cqsSLnekAhODrVh2H8wrfuAMUhyxMZcAv5ZmfHDqcd1snRwOpWHCSvWtEsCI1p
         GFKrhFu0CTdTTZsmYM9zK/Siy6W0zPvMWBMyF77vRgNPko2B1HFCZkTzZWHd5q2ZWIxi
         rGQihkQG6RVxNxzD47KifLYHZ2vul2evFbBKucNFRiO27J35j2qeOekm2Sfr+hCd1vii
         gT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517133; x=1718121933;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/hXLowVG1jlKkvdvrwhbPt7vKAuAA0v2J0ALJOGtf88=;
        b=RbP2xisxiKUASXiLnOHKleri3sGFtKOxxFIcYy6Kd2MQQ9ceLJjK2WtdEtHnYVh+m3
         O3/hA32A+W6X+zD2s9E/O75ngy8yCJ5FYVG5I4Tze363N5m0C7Z4AaJsWKXGbL5aJKx/
         3ddbhR4mYBtYapIUpeziW1jJpQB1DxAE4IE3wnhUpWmxDjx3zLUm3ydZaRED7G3Pxsrd
         m45HwLsmX0gQTzbzyBBupJa+NvHw2Nv28vH4RfGkkfGe9OJMMjpFeAHkTwIOrwf9eEm3
         vVy/Z40Ak7nZoB78MftNNKYF0QtJBcQPX8448/XgWTVQNu7Vj1Lju0NthUAeb7Ikul8J
         6mkw==
X-Gm-Message-State: AOJu0YwedYA+CBts1efeWbDX2rGgbB+Skq7C2nz1mCp6xVHVdxhua3Ia
	iGPHMznntni7oRShcpDQucSjk6/tMDjckhnPMKm4cAevVjq8KXw=
X-Google-Smtp-Source: AGHT+IFDNdS/8BXHRyBUMHuwrEHQ2oPy+kaXNizBnMar2GIf5BTKNgsUzzbE20TgUjFvW+Os6P/95Q==
X-Received: by 2002:ac8:570a:0:b0:43d:ebab:d4dd with SMTP id d75a77b69052e-43ff4fab76cmr147600401cf.0.1717517133310;
        Tue, 04 Jun 2024 09:05:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.169])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4402177fd6asm6510001cf.66.2024.06.04.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:05:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <61aae3730b8c35c2e0b8b70f5f2fe5170067f5c8.1717512099.git.pabeni@redhat.com>
References:
 <61aae3730b8c35c2e0b8b70f5f2fe5170067f5c8.1717512099.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure snd_una is properly
 initialized on connect
Message-ID: <90d4c317-f0b2-24df-30b8-476122f7b201@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jun 2024 16:05:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9369952349

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/45ea564d5e7e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D858724


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
