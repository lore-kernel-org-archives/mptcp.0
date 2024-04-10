Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381717BB17
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771578; cv=none; b=t/e0bxlkyuwxgNonn17Xfi3vAOgtIe6RfTtpyDI/wF6dblXsZED8gZq5uIzPTNjEwlVH48faPs9DrLkMB2/C9XsutIbnZrUJ3HX9QePuKY1s0p/jShZuTUGpck7OKdMIi2w6iBffZOELVwQc2WulJesO6qvFI3/SmavhhqBYTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771578; c=relaxed/simple;
	bh=54uT3TCeLxM54+sJQdhvk494Fltyx8mejTBzMf76i/o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OQAyOjRb0JpOIWFAzGbMenJRPcKbNPZuWafoqtCQWeV/xMTMvdw6n7bF3K5XkFJSzOTuYfkMwjnnGY4M3YUEEl/viYjvHaz4wRvXI1AaxmeDDaBLYZSWF80srx0n3FxEGmG/0TjXZSvahJPMbAnXo/q24D1HuLDhkCZN9WddtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXUeFA8P; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXUeFA8P"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b3d05e945so3957976d6.2
        for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712771575; x=1713376375; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Eg8W/9tiX/CQpLPQ9tTb0Ej6zKQ8Nuq3rLR/62LZI=;
        b=DXUeFA8PmeABAaeKTBisRsSzBWXmHz7fcGejTa1EaAVrPvPeXq021mBTKUGSLsoBmt
         Cgy2FiFMQlpyP4zk8Bz03d7doMAAOwdEvH+RfTQmcQ+B5FR/s+FFcQGs6ejntmtYCG0w
         aVUmuRoS8CDfXxH3BlgYqNreFfUJnEe5kOlHL5zTjLDwqeAkuwQaqZ+tTVnJ2FuibkHe
         rVGoTby+fiZa2ym6Bh8uVQYPI7zCgr5LhA+1iXoZUBwG64TLAK58XyCZkULdXJLviWzw
         JSgi6o0DDy9bkI5aeoLxQlYqTDwBnVRvgl75epNewikF0qgDOMMFTYSHlW04cGs1kd/4
         bF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771575; x=1713376375;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6Eg8W/9tiX/CQpLPQ9tTb0Ej6zKQ8Nuq3rLR/62LZI=;
        b=cKeyF+6Eg3xbVMsr7P0A7U/7yjfnCQP3IjPdiGpyIkOTeeTbMfp7MjQR9lVK/S9tNi
         0UO7PeB8Waw7eLL4BmCBgWonLaacGW6kmertXuHh87ZkLeYtnJL1Jbl6VR2gUlElAtwg
         l0AZkar0KuTiJiXo5ndyVgGz5AigE/+YCUaK5Y9Rr+O9bBw9bzQMUOu88+dkgWbNNzWk
         xbJ+8nb0QPuxv9fzcLRAbhNQoDGEfQXbWggNbHDrFG/tsBfMMJ/MWKqxC0sZLqXxsrAN
         mr17O20qHAze+eVdKY5oL/ZrII6HTkuFZzeHmHUP1T67WgOfBBUPUMRdm9PpobEOZL65
         QIGg==
X-Gm-Message-State: AOJu0Yyspjl3jb4L4scGWIbcHggSxoLm8Va35wPQpDI21uoXyRamOUwz
	w3PmxUomcfYhdEzZq0BHdY0dtKEfqvqWMo3eT2T8MydPeMBZ1NWBG2TmqVA=
X-Google-Smtp-Source: AGHT+IGRSX8YYh4wbX4CnQ4D9wGU1QSo4myMx+khTyDAAozuvuc+S+8X8lzzHDjMetB+SDa6S3dxIw==
X-Received: by 2002:a05:6214:20af:b0:69b:2aa8:dc56 with SMTP id 15-20020a05621420af00b0069b2aa8dc56mr2745805qvd.36.1712771575648;
        Wed, 10 Apr 2024 10:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.227])
        by smtp.gmail.com with ESMTPSA id dy7-20020ad44e87000000b0069903766e06sm1600010qvb.124.2024.04.10.10.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 10:52:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next 00/14] use start_server and connect_to helpers
Message-ID: <d521c25b-d25a-1286-2e10-4ec3aadc91b9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Apr 2024 17:52:54 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8635157069

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/338146465227
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D843118


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
