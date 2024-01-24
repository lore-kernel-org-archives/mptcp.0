Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F4135403
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136234; cv=none; b=eQm1DfHe3Cn45OxOyiLfyqdaUmEe8RPJ7EqD4aA+zr7c+5HQXADJkYAhcLiyvlYsRM2GfFlDarhOpkRoHQIpEvB1y1I6KCHfkBvyjmsN2BEzgbXMjZGwWOc1pqgjjd5775QoIhrS97eBNtK9IS9jIdkVYifgl3Fqb8rq+uCH7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136234; c=relaxed/simple;
	bh=wK5pIiU8oV5a01lelxJ6d8sD5+uuHpVUDt0NS6WTzno=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mriZHE02THh6RCMetGaZkO+5ItfrC8Kq7ztResL7PPDx3MJuoK7dkNOSI5jVeqi6XJdAxrvcF7jNOfwkAqYEil9qzUVr71bPo/fEWWJ+m2DdGbvL4hucg1dZAC0qafFaJng2+YeuGNHzgB/xRSVm+2KhubZ1F183+AbaivvGfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CagMcIOm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CagMcIOm"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ddb807e23bso739014b3a.0
        for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706136232; x=1706741032; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx0gbc1N4bjlwCoHr8uPmGQJy4nOjzd/uQXt9yuxt5g=;
        b=CagMcIOmw07gOMx7YFfhNEAg40Op7TcplbmXYjny2Qx+ZzmktNmjQn/mCClKXkoHUu
         58c7TbiCGxLKnqatavU6YzFyS2z47Q8MlkNweD3BPGJ0oHTVKoxKFAgkhm7od0Qi4tWG
         VL93aYeNpCHSzVy34X5yZ2sCj12cMBnO+ayR9ojY7EIKqkWO76/B6J4D0FIeIwrR7965
         qG/TW40h/wlzhP3SDvz5SBqc2kpNDjucYu14tP6Z6+TLOHCfdqF+8BT7dwEsU67K/gQQ
         rCd9NuOrFUa2VtClJw/wM0zNHPeqCcWHpaXIkcAx+tZ4AvknCHslj+yjxjDnpHB2wxvX
         MV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136232; x=1706741032;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx0gbc1N4bjlwCoHr8uPmGQJy4nOjzd/uQXt9yuxt5g=;
        b=BUui93dFfDzA10/k/usm7VC3ySzk7mCzajEV/cH+m3YQfH5GEbXd/EzAfxHcfUZhGY
         bs8dQoN7+e9nLDlY/MePjyUBYAiNCNuMzp4HI1hOs5J0c5zk0vfGUFTju13Uhhr95r+c
         PC0Ol+6cfgcFqDXcESr8gSzIGGYqLc2OogtWhI7SQUHzIrU/qmGTFi2CRwqSlO+YqOr9
         AglYAfM0WMDKVQIQHxwDXJPEQmBizKEjyHDTQB31M4hetWAWCETqXgxzED5vuZYiFglw
         pb7viQ+9b6hoNfGl5HiFhjo77e/P4S0OfYVNHc+iUJQNm2fryS88pN6tSo/SvMha8UVH
         SmKQ==
X-Gm-Message-State: AOJu0YxC6PMriTusEEUCu5nuZcHbDVm16rN5I4kMGdY+3GrC2UtfDLqV
	wItuQvNsdhtrSLU0LOt/pet/GJjkWoh4DGT8394I+0awPNo6hlY=
X-Google-Smtp-Source: AGHT+IGZ/HUt/EYDNRQXBL4gvAR9mJ0aBTBPhbVmE4fyYZFw8VMYLljRybu2GBTCIZWa8mBmJuGOzg==
X-Received: by 2002:a05:6a20:cf04:b0:199:ffab:9796 with SMTP id hy4-20020a056a20cf0400b00199ffab9796mr104182pzb.124.1706136232260;
        Wed, 24 Jan 2024 14:43:52 -0800 (PST)
Received: from [127.0.0.1] ([52.238.28.185])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a00198200b006d99f930607sm14719664pfl.140.2024.01.24.14.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:43:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
References:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Subject: Re: mptcp: really cope with fastopen race.: Tests Results
Message-ID: <52750ed1-fcb8-4dbb-dccc-2c4c861cb353@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2024 22:43:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5675809764016128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5675809764016128/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5112859810594816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5112859810594816/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f24f750c6f62


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
