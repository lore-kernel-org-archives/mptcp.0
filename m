Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846211EFF87
	for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972953; cv=none; b=qHdZZVhD90joAiNjENEDVxRLxDQxa0MrpUpbqzrO7pCpnr0i0tDh+l0n8eEECd+G6nhBB/3Zxgsi/diEEmJQKpSzBi9W81VAqSorje0s+JXePSqeXXe7W6EQfNO1upiitP0jLpAhcrgutOPDrBUSS0Pmju0iy9Tebc4ikHtwVwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972953; c=relaxed/simple;
	bh=B5HTa0G3BKlg0M+zfhGpPqgy6yFBZdUIyfkAjiX3mGA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EeYcJK06JhbQjX7AzgVqNVsDh5r7iM5EbTd1zdGTAQoYmKEte3Mut9nLz/AHXUlkQfnUGxjN78YVJl8RejAYjUn4SxMn5QUQFocUiDq8RXEsVFT6UJmHztd+D9ZCwo2Xr3eRsdbIjdixPkFyCKKgKFu6cLtQa54bJ1IQur+9Mws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwkDn6Wj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwkDn6Wj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bfdfb3f4so137386665ad.2
        for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 05:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739972952; x=1740577752; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcXzZTj920g9QUn+OfoL84gSwVgj2b/P03or0snAE2I=;
        b=HwkDn6WjR2dmSjRcmDkBCXT2UyV0vSng/Gr4HP+r3psG9tKlTQq+Fzc3xGkIV//Ppw
         BXaUrG2jd8sodovmfcL+zktn1qIoyG6dMKfBlwbcbHosyduLAQj8TJCdSlzJw662eUYD
         As0fq2z9tu+N50WZEgLn4KFx6FPGkXdNc7Hq2pcYJnSK84Oe6Ia7aGsE3QjoPLixaDcn
         hnn7MTndcGj76J1zG9I8JJcrkllGsQOuoMJXNH/eSDp9rsxwY6svUoV1fsrLHgKWtSRb
         +xa67UZaVQp/eGgzlmzIANzV7az285s/s33dsBcJ7NknuBGa+/xdwt8DSeXRTexWgWH2
         1YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972952; x=1740577752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcXzZTj920g9QUn+OfoL84gSwVgj2b/P03or0snAE2I=;
        b=FCa3RvoQ+Y213sJ/8e/8FzgyzeiUW8DG/sCeoRZqRuRrWQRBFkJeWRbKqoJK6lRSGD
         V6tv5EZYql0w9FcYlnprxsQvUWKQW9k1Tvd7hErfK6O3m4Znt6dURV6EU7usxfNjFXru
         MAgtzLYs2erWv3di9ohkWrPf5ewFO/NKheAwf1xHq7WP+tVMz5FmwXZ57Mii9Lvo2VFo
         +LZHxx1FCIC5euJEr/sbmTMI7V+y4ryG/QLElVUYmVsSJaK8HCQhYcjRKDmXpuys6LBp
         Y8SHtuJnvH8U3OBWqgXix3vgPpshHNgikQClQ4ttWe9rBAiQ/D5kQ6lRNBBPjiTmScg3
         eztg==
X-Gm-Message-State: AOJu0Yzopg8R572Ww5nn5JA7ej50S3ENqk7MAXoNNCd1FU/w7Jt8iVsx
	s99c2q/aiXftvHq0ffXwFK1pwq1ciT2lrKLZrBf7eR4V41lu0+o=
X-Gm-Gg: ASbGnct9hATynJGSVmgcsnRc/FA9DwPiCQ9XwaYIW1FvYEPv94QUdriJ4kqoi9JRgeE
	ab6EH4+SQ2X/i6m4CkPYjZH/lVOAGBn46xlo01XVa7zdS5/Zc36pMJmVGbuVNB7+s1DBm5lb7Ly
	DmU5dHdr6k5wadJye2k57bgGYXnf/nIztcWKAjBVU+OEOGfs11zschw+SLbComoOmbCoxg1/aIP
	CUzPJnIbHfk5uXJhGxXo15kt7/bVgLZ9y9eY6iYE9RXOtk7vVt4NcguI/BOLpEhL7NvRADYUB21
	FKOeqGrLxPJ71gE51FLjMp5OtRs=
X-Google-Smtp-Source: AGHT+IHWUSUlFLNA6qpYE7DShEiFQQAiR3xhU/RbdrcjnaGtD5cdvfvmIHFek+OCrSaAN5WQOiUUzw==
X-Received: by 2002:a05:6a20:244c:b0:1ee:68e3:ff45 with SMTP id adf61e73a8af0-1eed4fd3938mr6516578637.35.1739972951653;
        Wed, 19 Feb 2025 05:49:11 -0800 (PST)
Received: from [127.0.0.1] ([20.172.29.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546301sm12054439b3a.33.2025.02.19.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:49:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
References:
 <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: always handle address removal under
 msk socket lock
Message-ID: <706800de-4f9e-07a8-bd30-d712b38b2d43@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Feb 2025 13:49:10 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13413108659

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f8164af657a2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D935572


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
