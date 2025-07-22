Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907A21C19D
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177517; cv=none; b=EuoRWKzzDpwGQD4tDb8zK4IIsJWwQvqLiZZLGJfFVZlZ8ZsSKw6sAj1O1HFIAp9bGVyyUr+s+0M0SFYq2Mv9hjdtG8iUtwtIl4apn7YcP3+HDri+YGEEsX8OP4SQoJo28aLNui17Y8jboMQ0aWimjxcJsI1tflPJmUQ5vHpsSg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177517; c=relaxed/simple;
	bh=abXIetpWq+TuEjqdG4jECtfA62pNDIELDqxWvWAjEKg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=D+USzlDSWe2abR3DcxKXCVGI8fw8m0YDS1OV+Fc1D7NfCMVzd4p2XiwP+W97k607p/DV+2hI7pcJlOzkXY+tS0VFqnx5+vYoXaoVZ1CDJzPOjL8POCi1Cspfcqe2rrG9fZTfzpDgOHyJ2R3iAU+gDwCSfAjuzO2iQ4MDLkjsHZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0zUyAVo; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0zUyAVo"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab81d016c8so73478451cf.1
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753177514; x=1753782314; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wE9MtrbRN4Lf89E4eGexLl4ygb0mkE1rtY7dtj5ojfE=;
        b=R0zUyAVoChCBYefnfN4twEcQ5JZp+sumjyjMPsO5EOVdxAL0LZSWPCzr0gBNB5i+lb
         grEMZkvvM/gv+rfvAPXyY9g0g7Yy0EB5KddmHAvLYODza1ehVTKRzBmN7XXRuybuLbOH
         N+B0AozMUsfg9hi/cA1WXoWhvD2cvcu77WzvPfYx8ID0BUGvY7HyYxGZi4xYOq/zu9ID
         1mj26CG1JuA8bXu9iVX5HIGuDFc6YeWu9vq56dr2A/N6Arb5luN6flDMK7d1n9Jy3zF6
         5dJGyIO1uYYGQmGyQr0v05fQo/N6E+AAD0aDVzG76jBccPiDwOdmMgQ5HiD5puZiUl/S
         l6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177514; x=1753782314;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wE9MtrbRN4Lf89E4eGexLl4ygb0mkE1rtY7dtj5ojfE=;
        b=Nk1aKUmaSmkSqnqNC8UUMag9ip9/mdcRFjWiuMraVqLBlOnz3O15f/ETdnJfKqJ/iW
         TuBOMsINcXodBfbrh5XdCpci5PmPOHGCfHpS9Q0lUua1nFt3gpp3XxoFHT7ClE4BuFWd
         6Th0WwjJt2jXRshHSCOcCOQJp4cNL+8+j8I3xu7jtb1PqGQevcG4o95rbnvy3TYjFEEV
         767O//fDXp9maC/ykDs2OhpqGwL5yf38JIswQZExJy8OIINblODevo1hyB42kzOMpBi1
         n4cVZKF8NqZ88UPZdz2XNW75f5TMUrwPbB2QKhpgq52aA135IVBRT3GylGRXLEGF/U8l
         1rZA==
X-Gm-Message-State: AOJu0Yy3iLwlfE4pxkDH8rfqclb0ANfgQWngMQwh8cgQYi/M8X3I6IRh
	tHuAPtEUpkre/LSHdb5DW22T39aS870G3H6qfgiuWLkKYxnx8uIlcZ/naJCK
X-Gm-Gg: ASbGncs9jA9groY8Hh6D4ADjK9WIYbkKjemVY5iEJMn1uF/DSBb1DBOFU6iHT0yxhgp
	s7LyEymoYNyrNbJvBHWZzERDP7MdcaNcVdp2OjSIKTC8CVUfa9TblCenvsGn4mIwG6wwX4BBkDc
	4992HGmGofR2BOSlVYYjzTPPnrk9VdMLcUgUGjMi1wgBCOgg1oUDyATyB5X//qZOoE/YJkv1hyz
	1/PuqNHqwyF5dItzbdF2QYz0Bl7EEq4zP1tpf1ydptbJTx3JgcakfE166Gf1EmEavX51WTO2VvX
	dVQNzJgZpagUWeHzLtptKLpYBa1k82Tawai6xnQjJVs3TWAQrTilGGwDcer/akiN7ws6xVvcfNT
	98EEnPema7EO9MrBJKDLrQFEW0jSkcKzFLZY=
X-Google-Smtp-Source: AGHT+IEurS0XkBqDzMn9kwdyp/9RsKJyxTik+rocVbSmW7fMytE9dmRFNzg0atXD/S6pIB5tp+RaLQ==
X-Received: by 2002:a05:6214:33c1:b0:704:7b9a:8515 with SMTP id 6a1803df08f44-704f6b525bfmr405845606d6.38.1753177513656;
        Tue, 22 Jul 2025 02:45:13 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.213.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4aee328sm51715481cf.34.2025.07.22.02.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:45:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
References: <20250721203624.3807041-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg
 from sk->sk_prot->memory_allocated.
Message-ID: <83932fbf-9526-3cd9-2df9-cd089935c9cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Jul 2025 09:45:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

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
uns/16436561761

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fdb62a4fb078
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D984458


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
