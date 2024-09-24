Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DB1AB533
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199416; cv=none; b=CVEzp9ihkILIY4Bpw5jLap0aWPE3IvWM1IZfRXTjYllEX9M9gpcXRrfcJZs+e7ymwHOqxxQNe670mUBuCrsxAAA/O0w59eeCcPu4VC/Fhx1xpMcQG0Naf88GhuqxlldKoTKs05h0ThQ6Bihnb1oohRMill+juLLHtAoBhS3Gurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199416; c=relaxed/simple;
	bh=wnzmnrQfywWSa/Qh1mQZu8prXcn2ybLvP6DFVqTFUgI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RzzqSeHJi6QEj5vGcY3XcufnocKbuZj3iGvXMDok+7+EocINqTtXLBnwAlSiUTKtJUBl2eorc66OZVhhhVFKwrtR2hRbMBkuqlIpiiiWFzpVZ+vgyaxhD4A9/Wzmb0+dv2LrWYv8pBYd225X2qRsX4y8dB/xnnuaurQkrjojqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlEw5P8v; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlEw5P8v"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-458362e898aso47405261cf.0
        for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727199414; x=1727804214; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiwoNW5bGd44ry7TlnWXRK/waqqvw+1Ryzq8boWr3B0=;
        b=JlEw5P8v/vVryz4220SnhXe1W8VR8+3Vq1xkDo/wMA+Gvvzc5PEMYjtgu86H4aJQTm
         iDmOdh/uvRmjWcpk9dvkTk5REe+mgGKAxcASoHtUtn4Y04Aa6Jr7GF/M3G4XO9LDQpYU
         /HUVQ0JzH/q9vSXygBHutu1uDwAGelYIkOy8+ZVghRHXhkovklS2WgUYPKAoe6rGoPBU
         Pj1pfaCRMWp960BaKr8ID9xW6eFcBFCsvJI8Nqz/F6BhEelL45g0wWX1eaNqr+ykXMSB
         EryeHCOT0G5PpHKpDFIrj+hijS8UkTpRF4+5dqiObdM57seaKIP9xIFi6IeqP6y2jjdA
         cXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199414; x=1727804214;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiwoNW5bGd44ry7TlnWXRK/waqqvw+1Ryzq8boWr3B0=;
        b=bkKe09dVQAh99Uv/hN2NCQ4nGNgwJXhFQg3j4wmEUASidx1ksOv2tmSqK8RLU6wYTA
         aow05qGcG6EOmIWjHbw2q7UcmeyThRvWSh2GjSXo+eQywxc1dP1lqe5N2RjXPStJQvYH
         YE9OhRw/4dKwzc+jlZfzimHLb0UREToljI+TeX8b7f7jbEs6L1gTLYKhjTqIfRnqsZmW
         NXRiRZJbjvHFYfpEPEqpdGLcCZ6KMYUs0Jzx5kwONYrPPRPbeEUg/O8EdG7oSDtTrz/x
         NdD8foGvDuLYjmGes5fU9UK9ifu2jdpFb/tP7oiKIH7fYfkQCAfJYRbRJyFBjp/5LWT+
         C7sw==
X-Gm-Message-State: AOJu0YxK/pxGxSKnAAn9ycwpvw50dN8FZHaaKIpZdv0ZT1DikkTdU7eM
	kTlZD8lAHjqa6Jkq6DIGAlYRTnybxu3ViMjITif25m0awejeGqQ=
X-Google-Smtp-Source: AGHT+IHPshsIt/EXAPRCO2hz3SDo3L1KCA5kWZ/7ai+oDfhyFsGTMjafa1xKE0XJ/v4IE4S3RQlpvA==
X-Received: by 2002:a05:622a:188a:b0:458:4311:f15 with SMTP id d75a77b69052e-45b5e02c576mr2158761cf.44.1727199414198;
        Tue, 24 Sep 2024 10:36:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257574csm8356041cf.21.2024.09.24.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:36:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240924-mptcp-gcov-v1-1-b259d5dc5fa6@kernel.org>
References: <20240924-mptcp-gcov-v1-1-b259d5dc5fa6@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22DO-NOT-MERGE=3A_mptcp=3A_improve_code?=
 =?UTF-8?Q?_coverage_for_CI=22?=
Message-ID: <b72e26bf-8ddf-6a68-e664-9aa528d0aa7b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2024 17:36:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11018378042

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1ce376cf68b0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D892525


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
