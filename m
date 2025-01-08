Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0113B2A9
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314236; cv=none; b=OCg0kU6381aSUa0bSHPu0Nui+32TnydDBd1ottOIuhElNL9p6CARuSlLqNb5il6/iAjjSe1qT6Yzm4TXddeEEW1Z2Er8eBvp3eM3FbdMGYFdTlE9WsRKiti3x84/XAXmBMwOQSi3AE/0WQt76bUWzsg8xrHFokuUrzwNttMN/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314236; c=relaxed/simple;
	bh=SkSYRtJHcO8THU2tTwfPw3k9OXlcWCZP0NeYVa5+baI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lOaubWjo7cBE/NNKEyVLe9j/OTmum07B07y6EkwFa0H3DPSdsSTuXfOLFtC7AknmCY4lORc1EUFm9nje195EFbEjUTjW/EwN/4nSqotPUbHJ6FR5MaoawP1t+cXrmJyo9+N+syG8NbhNHeM7/SjU7hparOLVCeVMXRMQnBBCvoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XigUTzWo; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XigUTzWo"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46772a0f85bso136305371cf.3
        for <mptcp@lists.linux.dev>; Tue, 07 Jan 2025 21:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736314233; x=1736919033; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyevuE9fcdOq+MFrhWtdIbbqRaFY8fjVTGEt5/CmiS0=;
        b=XigUTzWo3EnXJkekKqBkxJAO1hyyUaB89bx41iSUlJMMprPJLixNDLiWRgfzMl4CTD
         YyBk7q6K8G7ZMy932fSNMrXYYCmGfiY0lZXEiB502D+rFTz4S5sOQXIhyjVS3K3bbAUj
         CVwVS0BpnfglVRLMawE9FmSq7BWM3RJWmqVIaXCkiN+Thwljwy+jQT3+FNS9GfefE1WX
         h/vI+ayPcvFTbfusZcHg37u0k/I4KXTvfyiHoTsuW8SFYHBO30ip8hU8KGoLavku1ABB
         D2l8kfEWxUT4d239tFEgmpe7c+kHmHH0w+KWEkowZs1Yq6jVlHsvUCRKqRAx0q/Qt2FP
         MT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314233; x=1736919033;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyevuE9fcdOq+MFrhWtdIbbqRaFY8fjVTGEt5/CmiS0=;
        b=ZCou/fGAMLa5fUwmSUUXlS2B0YvVMK3cNPM7Xazqp5WTuaXdzqa43e3zywE4sPOxwN
         IlUmFU9QSZnU3EEgJeZ7HZ1fwmIyizuAeERlN/Z20XgWgkPEqazowhT/cJZ/fy5ZeoKP
         tYd0rnBUXrrxVSApY3rkD9m+ERfm4Jyly/YyQTXiBh9oPPOwTlIdy+V0kdXqRGQdTOfp
         56BBlnBLJ5jOPfY3J+p4XHB3FSSW6Kj8YCiP1Y4CRzgb75E0LDU5KGlC9P9ARCatQVK3
         mIcEEUtdf1GJ5e7iYPBKAuXkgrWSZHEHTUERMwjm6nZmTRrbmbUYbRQPpRUveHC4DB2h
         qi9w==
X-Gm-Message-State: AOJu0Yysi5lZrUlGIY1yeqCZo99d1zRM7wvoFD8bm2tvJAaW98H9ZtTd
	K4ZsxMfOVtAayGO85bF+qtbcLlZd02alPZEaRLCs740NIkWAvgWb7/aB
X-Gm-Gg: ASbGncuklMQKKflcININKTaEq2qPXT08P3o8Ep0IthvMhdqL9rWgVwCWoYerd9fS1md
	oS/K3JjgVinh8xM0eohtewsyZ2TvO/Q5f/48xqGpDkFMXB5GNQnpc91dFYgcMMWyS8PaM9vTwsL
	qyhE7VFZK5hpB/nOJddZJs46WAxFNZTwwK1elePxLLYiP119nG7RERUyxpBHYzgp2aooqgyGtO0
	29Dx5LiQRU0plFxX16B3eiW8HVcHRKHN3Ow9QR/2lyNy+7WOFg+6SqVnvh4aZs0CQc=
X-Google-Smtp-Source: AGHT+IEvgfLGAUySKSFmF5N4BJJ6Ak7wJxwY4tJb7Kry70kCwkN02WRnq+wEOUI8o7Rq5dfkPI/fJQ==
X-Received: by 2002:a05:622a:114:b0:467:51e6:d861 with SMTP id d75a77b69052e-46c710abaccmr20817441cf.31.1736314232940;
        Tue, 07 Jan 2025 21:30:32 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm192330671cf.58.2025.01.07.21.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 21:30:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736308884.git.tanggeliang@kylinos.cn>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/8] BPF path manager, part 2
Message-ID: <9a01a36a-c60e-1d60-6156-b929b571030e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2025 05:30:30 +0000
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
uns/12664174127

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fb829086465d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D923223


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
