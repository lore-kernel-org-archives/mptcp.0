Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF171388
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525438; cv=none; b=MKl7yLNc2vNw0velL/UAhfE/101Jxwnopl6udZsHIql6x0oRb2kfW7oc8syFZhXVs2OUa7+/UbUvo+Nr0HhU4MzbfuynMkPLW/bMtzGubEcW3w42RUzvZfb4hFoPfD+NumqYoBbAi72UZ1q8eBfbw1RT/AmTamMraxrqPbUZgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525438; c=relaxed/simple;
	bh=A9odLIHSfDsuI/4K8FAGLS9edpV5hvcJ49H2y1lr+88=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NYBHOvtyMuYIAspoLA0+dKLdjk4UxgLYD3EWgVrAFApEPYCLXN/qEpVCiqSHODiC0/j+nXHwK+2JLA+Ng96/ZRraOCNB0HO95nS/zci3l+YkXQvquBpcGRuM5OjsedWaNMM/ukjBYUiKjTkZ/u6e4fPneFkawEUFbA8k05qfQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvoDZf8n; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvoDZf8n"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769b16d4fbso7871651cf.2
        for <mptcp@lists.linux.dev>; Thu, 20 Mar 2025 19:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742525435; x=1743130235; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBrjtjTfN7v9EABxsXb58XYug29C3ZBW7uzyWk6eygY=;
        b=TvoDZf8nc6NHrQrue9xIHKKYmdoQK3cir7+jZP6dFsWOliwtQoEDYCs5S7E2GiJIYG
         j7G7+4V4Rp3HPvvTuTPZOj2yxmzSklz6gTBkUJUi7ltW4h5vG6pR7Vzu8+Yec+ojdACy
         dDBDE+YXpShQEk2unmtoz1n0CWSye50uavDoyNdnf08MK8RwPiSKznkZU06Q2Mljr58m
         4S0AMarr1KRK8XDbN9ejFCXSwSB9ujx5eAFbqIxvgmdiGt847FdqBIfC1Zvyd2Tm0ndF
         lD+Btbxu29firaQcTn4hzOUSrxOdePTgPYFpuuFbKGM9u76rQJ+ph7Kx0u5NyhT70kkx
         1whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742525435; x=1743130235;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBrjtjTfN7v9EABxsXb58XYug29C3ZBW7uzyWk6eygY=;
        b=uHi1L+vCJjCvu5k7AjRYGzK2cDJnvSxoQWcGYHNqnktTJU5Z4PdS504v5JEz4ZamgW
         Ud1eE3X9BEmAhmQgcUXi21qy7j5CzqUuHquyFfIl5EjQeRfmusn9ZsN722QwIH2NFUHD
         hXoL4afwy88ik6Tz11l5+kUtOfEY2U6lBmj36eEguQh2G/R7/V8rW8b3MNpHbdgwJJFv
         7K0+srOoUhTDgY0Cu49vtYh+Xnm448HmC91kUH1YFhXO3Im/ndSRyjpMbr1A3Nytac8I
         DwC/oxMchHqpu9uxvkgdm/sLYjrW1OjKJ9r5twZ+eSNq7APzR6M1qnZavQAzbzrKuehe
         Tq0g==
X-Gm-Message-State: AOJu0YyOdH0KW61IfJWjqPFUrE2bA7toBo/EPKaFVoPaeWxBUm9BUfzx
	E9XDYvp768GMwL1vZBs4QO9iOSeXBa/U/n7kUOSwaDgqx7HuoeYD0GDL
X-Gm-Gg: ASbGnctHhwwQXcuTOBLuV9/OsBARxAL5AAqhqXa0nZqP3JdJVa8V8pcn3fIztP9ekiX
	3IIssOYujiObbzotdC/oWv+N6K3Mad4e+M0NFNqeEE7rZf0clzoZmpwNmn3h1dS9Ez7ujDrvxlG
	F6lLEe2l8cdrdEYgoLVTjAexOaSd4rXjdyk2e0okFLe+rycEOb/7r4cP8OUkp3lD+ErvIjJyvdA
	+MPRicNUvPGhw9M8TlZesXCntZrOD6+od7G2WMddOsED7svrF+0fuVTpV+LNN3eR49DWejwuFrY
	p1xe0de3mLUkj+h8pyiad9NXaJvYogI9fxFeyY3d8suYmMr2ZTfAw7OpEAq901cUXGcGeA==
X-Google-Smtp-Source: AGHT+IE5J9Mp273WMbxG+XsbMQl6sDShJ03jK54llvU+GR2xrxTHIzrNv+CUcSKmbMIKQoNTdEs52Q==
X-Received: by 2002:a05:622a:802d:b0:476:89d2:8234 with SMTP id d75a77b69052e-4771de420bamr20554711cf.36.1742525435595;
        Thu, 20 Mar 2025 19:50:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.223.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef22c26sm5709816d6.47.2025.03.20.19.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:50:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/10] BPF path manager, part 6
Message-ID: <80f1a5d4-8279-0835-549c-8a3124c7050a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Mar 2025 02:50:34 +0000
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
uns/13983025381

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/78680ab6871b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D946093


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
