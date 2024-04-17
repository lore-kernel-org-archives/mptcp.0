Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE51E53A
	for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346891; cv=none; b=lIQQp2c5OoMZJOJ2ueionj36VrtuPOCQtArkzhmqFtOUJer7wgmrDCbgi2uXMMiWdlyp63ydbbV22yS6Bi5bVTYlWrUHWPGIBJ3CYRR8vFUprxQ1ROw6nlNfSpQMSIrBLhxVfAF7Evp+QUGfz+Y6IgID9sWCucSv8yIli2d5AwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346891; c=relaxed/simple;
	bh=LS12UY/vVSgD421tlBn9R3x1ehV7uDlfgYITkSYQsHs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CfIyF4CLUI1ArdfWxll8czt40+FQRBGtmXx0CMg7ZILNC628UongyGRldq9hfhzGuIPsS015BZrYLqAp99wXtlD4JOxu4jBPpTC6n6DiMUT/tbzXS7ouuPk+/hft9M8YxhBBxmkftrazL4M52rbtSoFMwMaUpV5/niLlyAdFwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUFwIlQ1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUFwIlQ1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78f05e56cb3so3740585a.1
        for <mptcp@lists.linux.dev>; Wed, 17 Apr 2024 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713346888; x=1713951688; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNqpNDYzgPUIUvawiwGYIK4JMRQY043SIuzsfcN4iYU=;
        b=HUFwIlQ1ZRVRrPl68BDtkNPcfRKj6A6vLzDyD3arQ7aZ3w6Q68XqhnI2EZMbErWsTk
         I0dD3GNFQN1erkyzCsYCvdZuJg5EQFQPKkAvFEjV6KjHVPw4fRsVozTYfu58t8xoDpAa
         O7zxDXq6GEPEyE7kD2+mWac/tHqG4XNEStCaWcDkwYXt4yMIpGNVNWyun5p/+Qiq7UgL
         El2bEB2jwgBUssbCxw3o8Jc7Va/vR/Cz+j866IxK4gYBD4bA+HWtS9Eg2AkPLN/F9lek
         Yqv6od7W2y9K2VHsV+Na6tD/kYhRvIR/wYR7PgV271qn7tPcthMccvU8YWZhmaMaDTHD
         Wk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346888; x=1713951688;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNqpNDYzgPUIUvawiwGYIK4JMRQY043SIuzsfcN4iYU=;
        b=KscM8vy7oMzAror2K5xeKXiwsIXvzm28LoS1wEQl9LKISqZY8lfUH0/E1SzZUn6eTz
         tv5nsuTzttG9XRfhCu5qfvG5PQnZSDE6RsXkzicQD+CcVsm+vaZVkQR3rjsOZLr31o8+
         tO8Xs5Odayx3PSJxPAFUrpHjgPNN2pFsqklrkbaxhY9lev88/jNp/IcTQqRYMwtjHOCo
         eflVUbayH8ZeqU4lmP1IH9K/m5+rAj0ha63fkjJ3wHUlDO8Mkk/i5qeGpX13Mk1zQSOx
         AE+zSOUTDUJrZwKQrTLrO5JhYrxX6ZcF95LE6IlMB3op4mzukOy1ji6vNHyQ8YOOvY9e
         Sh4Q==
X-Gm-Message-State: AOJu0YwChE2ceERHbXDMwCVamXamrb4BDZLEAz/XII3o12lHspu+CCNX
	lHzut86FmjgII3EIcLe33N2754pNuukrPsNEDJ3X7yS6yyobAHQ=
X-Google-Smtp-Source: AGHT+IH5w8N7yffpOWebS8Jwe4MYHDLTjsVX3d2Zr8J3EuGvrlWKpp38v+UEbKnYCC3PNlVKVTQyaA==
X-Received: by 2002:a05:620a:13c4:b0:78e:d154:2ae9 with SMTP id g4-20020a05620a13c400b0078ed1542ae9mr14214029qkl.63.1713346888465;
        Wed, 17 Apr 2024 02:41:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.71.163.68])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b0078ec8690764sm7275613qkb.87.2024.04.17.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:41:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240417085143.69578-1-kerneljasonxing@gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to
 detect
Message-ID: <0f106293-3e31-2d8f-7983-8823adabaa05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2024 09:41:27 +0000
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
Unstable: 2 failed test(s): packetdrill_dss packetdrill_fastopen =
=F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/871922=
0506

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a79c83426c9f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845351


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
