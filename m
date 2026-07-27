Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7783BCD38
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178902; cv=none; b=lzQq1viSGEfDboISafJCol78qYD1v7EumzBl+E9XxLJ/y3nnM8MWkEWIvEKAklJ+ukDtBCNoSHqVNHNjMZq0SBZUWmEsFtv3w5G8R8ld+qsTw/T2ayFnbvQ+BBzrjmZmPmsjOiLrol7uBnG7daAECCKV2xqLR/qBJfSpki+bM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178902; c=relaxed/simple;
	bh=A4dVH/IaSOWVyIv0UekkN1y7A5SiGh/UeCak556X8sA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=W1Qn8jF8K3xAosBaI+NJtb08yZOza5zDsC1fV6+PsXSxIIFbOmgrLgzVMHctXf57cZwPw2aiVT1+i3fyKR+tcuvXqkqdZEdMWTWMchmUHJtbfaQmbAvSZx2vI2L/00KtTMQEBGSFuVGPH2d53Yky5QLOoDc2md6QotJXCZ3fXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qt0hYPCV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt0hYPCV"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-930fad20240so175735285a.0
        for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178900; x=1785783700; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P22f20YcDdut5GUegeTYgRjULeiP7RQos7q7HBWMPWY=;
        b=qt0hYPCVqVorK69YNj2UEktaQdOnaTkfO5EUQ29IJ9eEQPoTr/d/PiCo8qX9HQxyfY
         hGMhSRVevmjy1YEcdZTIGEPZmQmgQlAdIPyFHVLiG9k1jdgeXrwY+BaEKeDd8rvpOh3C
         jIZpxnFza4+ELeFlKe3ZedcnogB4PM20uqINV+Ix//29pk12trqfizQ1ZQAqeV0dxRxr
         ioqE+ZaHOK78LDKSWtmLPAHKNdbzVVkS7fh4uvp8C2cLKPbdRROtkjQt04da0uQ6+0uq
         OfJ9PzEUzn+PGaAG6sBmfAkq/2qFRKqkG3+38Z/APWimNNkzrwkagstybr9G2T52EYg1
         ud/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178900; x=1785783700;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P22f20YcDdut5GUegeTYgRjULeiP7RQos7q7HBWMPWY=;
        b=q1g84ZpZ/ioWAnvpMt1Mg5WhDPOy0IwcTOgU8BlnzhWj/z7jp6lYBP+rmAQ4OLhJy2
         SWCHVK+1cUjLHO3E0ckYN8tpOVGVLuchJyCqcnLNiYP/QHghjO2j9PfwMpoInPIlaS1u
         wPit8P6LnN4E/hTUjHln/dsHWoZVZLdukTkk5M++tR6gtuOX/6gvFP9rze0nPyyEF4oi
         4jZKGIsLJ4kmBtlCgihvH1xznezDR8S8eqccLJIfHyQXmkUVUIP/uXMhbNGWhc5unX98
         Z59zu3o0nf0XzPrAGll0TpJSj2f1Z5w4Vn6rDNebiobzXPLO8yjJPs3pJiktTqaLullw
         7STw==
X-Gm-Message-State: AOJu0YwJsIG4sXvWui06TL47iWchlMINH1Ns6mWc2cN8Num3L+C+u57m
	zj+dLJeLkplLlDiNVG0WXNzS2PlifMEyLFvfj84n1WGFPm6TFbulYf0=
X-Gm-Gg: AR+sD111OdISdbALB5q6VlIYWcaFboxNK9gkXOuENPkwXgmIOq7fYmtRUIJx9+pZjnj
	dF6/WVKKhuae6RErMPIAtlVGCeaES8ch0Rh8cZ9bB3wSvNggMVOLHX+I8hvPQz/VBrO3gBNy1pC
	hd2Z5/EZ7u92iG1v3ABYdo8a9S//T5HMB9T7mNLDOd5eIpHOUxA6/3MhfAlHgvdXWihcVis1TRX
	b+qP1hcAThBaX6JX4AoiZpOiJB11tK9AjqvcZCU96aQPJQi6NpSj36btiuxp1fbs0LHiEBjucYS
	pCfDauIUSIL1HvxxPA4GGyj+KNabnv68fir7yTLUK1lJkjpp3lZ73V2TYsCqEcuqdmEV2i/Ql1j
	I6eEhyKqbNHuMwvIFgbUGSOVLBEFIJNUnH63KamNdbyYpRIkE/jWHMAgQrj+HpuLIpssKT6ytSO
	YrTlZxv3EN3IDc4bI=
X-Received: by 2002:a05:620a:1a10:b0:916:14f5:8866 with SMTP id af79cd13be357-932fe26c455mr60966385a.16.1785178900306;
        Mon, 27 Jul 2026 12:01:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.87.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de6523c4sm673213185a.34.2026.07.27.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:01:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <54ad24594f194dace522b8f1be3912b242708a6e.1785162224.git.pabeni@redhat.com>
References:
 <54ad24594f194dace522b8f1be3912b242708a6e.1785162224.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: reclaim forward-allocated memory on
 RX path errors
Message-ID: <ed26c00c-413d-0043-5b1c-c9440c421628@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:01:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/302930=
17841

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7426174234f6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1135333


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
