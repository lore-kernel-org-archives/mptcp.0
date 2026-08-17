Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530926ED3C
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933912; cv=none; b=T4G9SRf7FqwXZNfctZh68npMzCVSxCMN+TjSnyVRb78OPKVL+3atbhlevki6pOqtd49hk3a39E3VfvnhCqE4zVDGyxntvIZAtM29mQdPYu5rFcq4Sc8hcl7RpSJUWwy+7t+GZq2XWy19CCmXogwHgCLE2hccIp1RdsBYjdnxQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933912; c=relaxed/simple;
	bh=gJ63hVa98Ozskao+8FbCcpT2gvOn1h1Nh5R7w2qnYx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=DwvuAyrWcOP23eovmm0o+wylT1W5DG0oDWkfaXgDDQmle2wdK0xAdJIEqojP7B0h7A4SKruP5VAuGpwV8utipsnqDwtPN3E4K/WM51ZQIFOH0TrdVHe3ukJ0F28eGum2cW6+rr4H7repKc4C6dZDNCKS9UBxiWuRnkMxj+y14hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0fG61is; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0fG61is"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so36388355ad.1
        for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786933911; x=1787538711; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nmzT/TazK4WV8GHg4wchuxt2/5E6+3Fnj4VDeWFpAyo=;
        b=i0fG61isnp9LYzcgoM78fYcMnZxCUBHVTtHDU1vW4JIgUIHv9j6qyN7JAE59PJ6vqz
         24gc3gP/RpbxvFMzGO5BrTl0mF9f0tV292NoL+Y4gCaqM3n/TdqzHlk2m4Pn1b05Bspa
         bWQRfTKValOaTegpzUYWF/x2lJmb5RSfvPG7rOHtHdP3tNhljsJlRX0uoJ57vbmzSsMS
         zmeDCBL/RUSrGiaHlR93rwKZDNoI7DEF+J/lvilwZKMQ7v/RWYWhKlE73HZdhJRDH9PD
         Bnr3f8jh3HkbIrsRUOUGwWQmSsX7nuaIoWxq8bz564XpIzBnaKF7XagJ9wESxKLjuxti
         z93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786933911; x=1787538711;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmzT/TazK4WV8GHg4wchuxt2/5E6+3Fnj4VDeWFpAyo=;
        b=N7EZmEkhkXdLfBe+0Vf/324lpJ3JSvjFQEHWW4v3j3uFFBVstYC+yooEY9shmpAASL
         w8uBI1eXDJ/7jWlRj2xC/J8enMa2Vx29ugcxxNPWOHGTpWDAnaB3TYdu5KYAe1U8DXry
         voXc2BL7zSRQ6ENcq2h96vV9A28BHTse1qIOlDOno5XTcJNNtRtlmrgeDWKiYUV+UBE8
         6BDdbgV/LsAxy18k0tK5ahj5Ettx4agrXp9sRja2ln1G9bo8CMwKlbrC/twtiDuGMQfl
         t/4SnyY5MhGVTpdOdCdbnYYJsfUEuvfUjnuwByYIt8BP8uIAcNZUhZNKjYYkPVsro7+E
         /1vA==
X-Gm-Message-State: AOJu0Yyozcd6LeP+3hHdkg+Q02RNbvHDFzQlT593o7ewxXxkQq/zfwJW
	nQ6DX9z61eQ4iExb1WHTcTE41QD2DEureQpQdproksegRzl3GLL/mKsjF+fr
X-Gm-Gg: AR+sD11dKa660gER3NlL0zxnixhKLtYmMCIcy7DOsCnuF+Yq/vSZSqEa+GcogiFS/s4
	8bsL2kD6OuAb1a3t84232ilzLj9jmFb9eSJDyf5kl2FW8Hc9OImXuwJpa9nvfjycbNxUxnW3uQ/
	1LYiRGkI80or4SVhclcgiWplSdPe2Gmoe3VPOubE+W6ho44Jz3XhXkusON/tn4WbqohWfwZv7Oj
	aO3M3KCsVPPrsqpcPikbKIXRlqJ7J2+Mj+R5YIsLEburT1izB9bnJk+upXQ70xvcrI5plSW1JsL
	QEBNWARKYFl8wjDU8G6eegIniuhMc36hEZCtaWPkSa9qbRxnIIzYVZsS0DW3keyzNmsaQmae6FM
	3p0Lz6MF8MkqLRwyup4yFlE9huw1LgiMcvZ3paqNizpH+CABMOVBxWpQ1vIBE++q6YK09miQ2R6
	TVvTjL3DALf6EXFL56IBB4kOkHI4TSvbwlUUU9cVzkolekAvXqvRSK8GPkUgeT4tfemPadRx7yA
	QY=
X-Received: by 2002:a17:902:ebc5:b0:2ce:93a3:c16c with SMTP id d9443c01a7336-2d3b0c67d8fmr265315195ad.12.1786933910544;
        Sun, 16 Aug 2026 19:31:50 -0700 (PDT)
Received: from [127.0.0.1] ([128.85.44.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae50bef1sm28195785ad.0.2026.08.16.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 19:31:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260817012452.7519-1-gang.yan@linux.dev>
References: <20260817012452.7519-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: avoid data-races around the
 sysctls
Message-ID: <955ed682-e1b5-0579-300c-e147565ec711@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 02:31:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/319860=
48689

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fa35ee6d384f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146872


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
