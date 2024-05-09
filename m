Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECF7EEF3
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281222; cv=none; b=G2h2VG/AQDgbejga7dm2AuNEVwZnRTiCZTiSETob2i2HwXJregJu44ZoAWyF0ddvQ5N1Wit3JwGSreduvkCYPPqeuLqI01+FjsCqy+WbJ+6I9tvH60ImTNL8GRmFT67FIgbEaNEzeZSCFxAlVEbeh4xU7+jRPZxdEPQPU/zfMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281222; c=relaxed/simple;
	bh=PdZVtLwwVQHMdLfKJ9m/7Bc5fGucOOX2F3sMAjkSbzU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MoHk6xHAIzXmzoqOk1d/E5SNL9hIQaaSQO4BNHDCkR4SM/Y4A8evHtRQRhGssrEuFX/1avFv8fb4fbEFms1KwenoQAJpd0LggUCvL1mRwiXavnwM4pauKsOUCgEy4y30GA6abjQDkN8VuZTGqkJLARE/wGKwo/JKjxpZ96+o41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE4jtaP5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE4jtaP5"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b24162dd6so8156806d6.2
        for <mptcp@lists.linux.dev>; Thu, 09 May 2024 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281219; x=1715886019; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnfV9q+ViK8kaYB5+D9JHZeUgO2MkTHNM2aWvcYCGo0=;
        b=cE4jtaP5BIsOIbIn9hjGedERSZUIpM40wRoP3RSWW6s/fMz8WfyuWZe9Y7QCY7IVDo
         XDoMken3FuoBSB7115oPg9G65q1+xPvoKLqu2y+1iBt+fNDZS0tPN+dVryhzXXlQgilM
         zHSYlXPkaAvA66VcwwzqyukdClnP/gl6xMtaVMbWlCead/koZ71yj6dLMx0P7GceSPRq
         KOJ76ypP7fBRR6nDktGR1dX62R2hNheu2JNexQHIXwqFpOU7d7Gsi3C/W1ZPyvMtZzLU
         AJdP7lzRDQwqaGVRH4X22KONA5DUfczoDwcAs7cXZx8ljxBcVL5zPJs01se6cjlCE0fE
         G82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281219; x=1715886019;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnfV9q+ViK8kaYB5+D9JHZeUgO2MkTHNM2aWvcYCGo0=;
        b=GXxaje9B/oQ/ycM12oABPYLONlN0diIqypiwyXLpdK1SD/ObuHU4ufEeM5G+yE1mUd
         EGzSZ4/DOgmP7M3RPM1CxXahDsFcX7WLBEv6z28/6+/qkpkHPETFexKWQQTXZrosyPct
         eFhQTw1gXHpUmXckV3/zlUqz5uKE3UV0LCz0yGSf/vJf4S0zNZ4SqeLatyBhsRbe47ax
         mFPg/He2TEVQdAoziV7AU84DM7Ejf6AiezetwFtRqA0a3oHiMr8WXRxvHe3RCj8N4hg1
         eZIFok+ANU4C2OGn+4e5k9PmfhSPB76oBjrxXREFIxGGXrQwwxA+QoWrV04RqUbv4dWx
         ZdmQ==
X-Gm-Message-State: AOJu0YwKl0oU2LGWMttWirnbbXkA0R5gPR/UFGgXaz/8Ujo5ihpWobaZ
	bxFrfM46JPdG6QCYwFSRKih6ZvUduET+A8fQS6V9eB2p6v1xGckwTD8Y
X-Google-Smtp-Source: AGHT+IEgePuNgFs63Ubr7i7LB2XkgPXAoYwBC/+bu+OVM6tEePC8V4T6s2QoJkL9QTPunk/kzkKAOA==
X-Received: by 2002:a05:6214:5f07:b0:6a0:c95b:a8c4 with SMTP id 6a1803df08f44-6a16815ff23mr2544876d6.23.1715281219560;
        Thu, 09 May 2024 12:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.162.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd282sm9569626d6.78.2024.05.09.12.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:00:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default
Message-ID: <3f59cd64-1d30-178b-7328-a59320b7d0f5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 May 2024 19:00:18 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/902174=
7950

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5506cb76c43e
Patchwork:=20


If there are some issues, you can reproduce them using the same environment=
 as
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
