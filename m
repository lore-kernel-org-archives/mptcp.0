Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A63A7F61
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041492; cv=none; b=l9uwWmQvC+tS+hNwKk66Rx4X7AjhF9GgDFtZNnIwYCXFKqufPDiixRahnRbpoVbn7IhbWBnutEFcDw3vAgMza+LtDDHI8QmIHkeEI3n8Btves7TLgPNPu+vzwwq7z0Vwydo6Kv76o5ecn8Hm85caaGLKaxOobHcHo1AL79LqKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041492; c=relaxed/simple;
	bh=l6nK9Y34Lhqapo2s1mq++hwq26s3e9myyEFtXKVkH9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mKvSa+M0FPFMe+JjFhECdxrq9H8hWTfSn7HBCh/rXmUuXQRNRI+KfkiG0VsugaJa+MdmZlj1H9b37oxUZwLUlXz1vdLGf44kqKJfDarsLV7D8X4O+OrH6eMkwGzHS9ufVOmLzZrc8XAYdFlH5Y+xg4mflUygI+SRrVnbkGUdF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2KnkaeB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2KnkaeB"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914ae4101b4so980717085a.2
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780041490; x=1780646290; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhiVhds289/EYez2C+WTVO3XTi5MoPXl3V8QW9XxnqQ=;
        b=D2KnkaeBoKWG3NCa1SpGPkEEIyxONK1YuVtKMj2xNTqg1piK3l8AARmU3KPQj2LyRz
         71iJ5GfKxlrhaSEPgLPX1SlS5PYMQ0RJXNFcPtJokvf7rz+egKxjxICp0qZkHC9tnmdu
         Leddt3J8VQmQtlTOCyREzcVp4bSsQ7fJz4YVeAvYXaSIQwtDoSVznUo33u5TYPBdS7Gt
         3eSYqDuiVg+IgGWqAOVld7JdPfX6Ufh/7Hp93wBXmunLE10od/Z7Ir3RuDbxhpn+1nEV
         baGpNWbXokJrDk15A/3vrNvlT702NuwSyK1v7JK497RqaO3smFhI2hexzvynmxqAcolG
         rdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041490; x=1780646290;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhiVhds289/EYez2C+WTVO3XTi5MoPXl3V8QW9XxnqQ=;
        b=IoYwZzu9TvAvRAdNxr634Hr8d+zKX9hkTPAmXyyPdc1ZXnZb51m06Dj6o3Je4h0xx0
         lmuSAYWu2asAhQPYTEdNDhHOZD9utHEL66ON0g130u0NZuUTJZM5N3ccy+qVRp1GPsUK
         QBZg7uFSpBNJ0/GPy90nx4gv3Mz+tZ4cBtMp9LQAccGUPCWzgwW818eJJRON1iVjedkv
         6KClzNl/cLoF62EFN84fWQcop6YGmmRzYrCXzKRsuAEOpdKXZ5INglQg41Y5O3doNg06
         tZH+RB4q6M+7dhsGpvsliE3HWsg2n8g7xyipvg0SJJhOqsSnGwB3Puca5VMZfYOf1mXF
         TsRg==
X-Gm-Message-State: AOJu0YyGzf+2rymf6LUhaA7KtmDMEB3VseyldLqX/R/ZsDq0p44yeI3y
	inwbXB+tx5z4qHEoSPnhnPPvvULBKytihi3kHDXc41t85lxh8C3BqgQ=
X-Gm-Gg: Acq92OEcFJVoTFp0u2cN7yOBOs7PNy/+w5neF6XrJ5SMuocyZ6kjqF6Cc6R2R1b1jNJ
	1M2NsZu5fvBgoapq4eS1UPw6vlpv+YxW1ZSY/N5w1NWFcaZ8B1nF1AOGyNMjsQtXIZc5nQUdAla
	Jo7HNmTqaRHLlcECzLX/44NBtRxVNETdKk2CI+yVj4tHJNYqUXhcFD7YrO559yueeNNaXQCEcYy
	C9i+p7cux2mvUQBm/KAxZI4C+La5zwZKyKoTZOyBGRff2hJuYCA0OnerJLUq+S6qm/oLGG10MwA
	HYmnqaul0LIiZKhIFjIFOz9c0xEnbkukHv7z0on2gZYUjllwjzDYxN/WS6yWIAFPTCYIIchZMLC
	EgnhGHhoXOlGjNQ1d96v2FkwVCp/Uyu3lkHe6yvqD5LTa/8W89qJALVVCNnd/B0ZyXLXpuenOSP
	icPbOZB2yzYH2tl+zNDc12h90KmWWNK5pm3vz3igTDzHhaGIHl
X-Received: by 2002:a05:620a:1995:b0:909:c82b:9756 with SMTP id af79cd13be357-9152fcd2f88mr224117785a.5.1780041489859;
        Fri, 29 May 2026 00:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.217.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532626982sm107472685a.34.2026.05.29.00.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:58:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing
 id 0 endpoint
Message-ID: <2b0a72a7-7453-9db8-5062-3df6de1d20e9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 07:58:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266234=
10540

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ed6268d8c29c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102655


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
