Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB861D8E1D
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155209; cv=none; b=mO7c+sIPrepelGvsJPhO45F4ZcYPvsv8jt7RsBlD4I0fcExEe7zcoqyCCCwRvfzXXSbtbTAM3c5wzw8pnew09B4TLoHvlvo2I1zfdayQ39VTkSvFrf3jnQHxkR11q76aStxmvNP2bnNp2BRjDbj1wXlprtY6ZYg/9G2Pl8ohCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155209; c=relaxed/simple;
	bh=yM2KovMF3On5iVgR+Nd5TZNvF/jIfcTUrG/VePW4Btg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IbrRr/KRlUYcl8Gg5LRBG7aaa3xO+awtRtWqRhM+4B+uzpkGiVW/PHX/0UgcFFMfzZb/16cH9sPFaYtN16eLyFRH1YBwPFzgAi8MJGMMp0z29dTY0XbmEtlWv0fOi4BnOR1jeb8yuKcgUs19l7YDrxr3eD1W1su2VGgQXSjbc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwAFSPEY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwAFSPEY"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b9c6c2c44eso904596885a.1
        for <mptcp@lists.linux.dev>; Mon, 06 Jan 2025 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736155207; x=1736760007; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn7rvcqIHlh3YfudscExTIu+NPeoQ1b+V20GiVFQJAU=;
        b=RwAFSPEYvft0KiKOd4i8AhVC1CWwVg5AFdqbaQxyAfnXyvxt2P6SgWPrdQ6/FIOS7b
         D1jZ3CdJcWZNKO5NOzw2K2Nlf4Qi6fTZUi0rsDdRGXdUrB4qIoGTAm5kmx5sBg5hs5yi
         HDBVks+aswDOkf5TTSYqsRScNdlyi45K6h02+TwKiXVLsi8HNCOvg2ayxUJjYlP4JAiB
         IL5+D2ou30wxZ4oud0ph0Sq2K6u1Me813hITxiHUgSU6tW7VNc5KseVHUDEWwmEoYOHy
         Z7/dkbVgF8BIKdyDPWPiRJTJWXflXd9sl2ljTrscjpurG6oEH62k+0FuyQZKBs76TlT9
         /Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155207; x=1736760007;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cn7rvcqIHlh3YfudscExTIu+NPeoQ1b+V20GiVFQJAU=;
        b=QH13x01ghDRchdjgf6rLLdEqB0Iww4I/dEQNlANU+B0+mJ/ePaHsEGFUjMp1TVhwJC
         sWTZgVoYDkMxCDnkNg2d5GkfGkUbcFYor0WM+TWbKGxxFp+MQ/McbrLIHcsrGBirwEo9
         wwkEbMXuAPZROSgYgxuAxJ/wyIUv1lL17Hod3Qn0gd87cBJ5NOOHn4DDqck4R2YZy3lV
         eVGYDwD6LO3Ctcrzqa8qCG1j7c6kV1TlkUi0Cot45FmElbRZAbVJ4ApZdJI+apcn8Z4R
         BXXccqFcCI7yStW1aMRxeAsRUnCd0xYscXoQRfHreHcgKC1AgxqRjR24IA2VloIgNXpO
         X9QA==
X-Gm-Message-State: AOJu0YyrCI1pbMR3e4OqZ5mqoHK7kQnNVtxAI0Gq0PmtMOcSdK9WoI7A
	ndjZdTt7KiLs8aO3ajxlHbwcK+9Ei9a15qOdB8xVtw3YV4seQo8zeguC
X-Gm-Gg: ASbGncuwxj79yYrHfgeZUT137yJMZVsctsQXVxIvXpgOixoN6MQfa3Vg3tps7M3dlBs
	PFkE/T2irKC7GaudMDOjDTIAERKPNG0IkuiRVrA6y1ypllwZHpzS0lSQ8X3Jw/2PLE0eAGN7z9M
	IdouWilxBeEuIbRHYDlPA+pNSwpKg/wDyDLReRXG/btEURculGwH5aV5htTYCe3qJ6iLSTWIuo3
	M5c8WVde4i1vHcorFLZkvj/qsO6M0EJlRiVoPMrSBV6TW1/gwFGMsTCYQifmcjjFdRO
X-Google-Smtp-Source: AGHT+IFeEV6e1C8FYN9Cp83FGB/9Wk7nQF2/e3Apbvjc4eFqGdRlal7z3hptynbeY+oFbmf1Uox+9A==
X-Received: by 2002:a05:6214:e48:b0:6d8:95c9:af2b with SMTP id 6a1803df08f44-6dd2339ff71mr892316356d6.35.1736155207264;
        Mon, 06 Jan 2025 01:20:07 -0800 (PST)
Received: from [127.0.0.1] ([40.76.106.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18137367sm168944756d6.65.2025.01.06.01.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 01:20:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736150983.git.tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 00/11] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
Message-ID: <ca37e8ab-66c1-a35d-cb48-128610cef968@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jan 2025 09:20:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_userspace_pm=
 - Critical: 1 Call Trace(s) =E2=9D=8C
- KVM Validation: debug: Unstable: 2=
 failed test(s): packetdrill_fastopen selftest_userspace_pm - Critical: 1 =
Call Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/12629204806

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1230ba468eda
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D922462


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
