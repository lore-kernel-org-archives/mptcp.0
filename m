Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5614F103
	for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946158; cv=none; b=CnxhT6ecdtVJEIxBk+CZBO9C7jMEyZKciIMf918+v68ScmAhwpkWFb8E9oavnBfuA/y468tkL7rtm5vyR5BWKem2pxnDRizHbrRt7r+p9iEVsbZbxmbwn8qAazOrFYZaBVBRslp0XOrvdOmDxhjzTpCsZ4MH3iWfMr339q0BXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946158; c=relaxed/simple;
	bh=hxsXFcIsuFc8Ov8ORXGY/kfWmxp6n4/yD2vZtb84frw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=j4BWpfN8Gb+6Ikj5zIBtCo2WBQbmHJrEhepmJ7DfGDnq7+WNBVAup4FO7LnH80QkdQ/4p3VOunT0npmUxSxdVat7O4A3EgJN053QDcei3XKGHS37W5yT82zik3KXdaVFIhunXzJnrBxyowDGL/XtZBGSEgBXGFxfkxNb+HMEhV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrIe/Umd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrIe/Umd"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b4e94ecd2so4014026d6.3
        for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712946155; x=1713550955; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcGaJdfRWJF2zG9Tfj+SDjdgvj8+oTIHtnpxugm2s84=;
        b=mrIe/Umd5VMW0lnyV32Qz8Uvlb4mfw+2GF3SV32aupr1J8ql1JcCd+VKjejKgZgYai
         iUQXR3SwRsuGm5mejVGAXJEkvyyA76wlXDw17AWfA4GE07iA/xGj8rgaOu9xHB/Ahu1r
         cK1GrtMjCy1tTRN3dAVsIg+6Qr89LMithpdBUPborkIIdd/RJcHNRIImLT9DIdJBjnlD
         2VqB+o9e/9KLUz6jud9d8oCXw73GoIkTIl6jXumT4wOdQm1O2fgYa72oSd8t2/lDV8b1
         U27IpBkMuzEen/Zg4Nb9qrQmGIXyotpNv4+8sLshSBI6g8RMawe2ciUNBCw5tm48VAdD
         5DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712946155; x=1713550955;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcGaJdfRWJF2zG9Tfj+SDjdgvj8+oTIHtnpxugm2s84=;
        b=r1E0tVVkEOXsPb4WBfQbBcUt3sXZcaLpaqTjgFl2Sn4qa3/dssDNEVgSp8WeUbSrp3
         5kjNAbXINlc1l+Ws/RqRUNJz0YKsro7i81u1erA4d8v03tDjLSOLV1yA9VuKEnkAHF0p
         obIAhGpEzQCWXMBQg9g4g121JDxwzQgVjYUzFfJAllFVYDIjc/ZuHanWRykWdUTseY9i
         /tRAefx4eTR+u5/aQ8ljj+/HvvJDnGKdRfa/V6yhVm7DjiMtOdaE4cY6kTtnQPfLS5Js
         XGmAeM7j2qk4L2l3yCW+rK9uxNl8989WmykzeGU2Qgib8TrE4jvnADb126y4mxZlqSvo
         H7Gw==
X-Gm-Message-State: AOJu0YwjWrjVq/AGiaJiY2A3118338wp7fZTnqRKt1cyGzjmjEFI4CWb
	zGf3zG49ZffqhVXAK2HL+nGmE9xg6xbyhsZ38+INSCbTTOw8lZU=
X-Google-Smtp-Source: AGHT+IE1N3sASrTPAruz7IrVUrc/rvY4aQgcBmU+QiSD1i09pryicZ+T6b5zMpVwDt/TIjXjo74bqg==
X-Received: by 2002:a05:6214:293:b0:69b:1323:5d12 with SMTP id l19-20020a056214029300b0069b13235d12mr4014727qvv.38.1712946155553;
        Fri, 12 Apr 2024 11:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.164])
        by smtp.gmail.com with ESMTPSA id d2-20020a0cf6c2000000b0069b4df4057bsm2302528qvo.74.2024.04.12.11.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:22:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
References:
 <2b6d11d0210f683cc0de8bb47a923d568cfa8f47.1712942966.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: ensure snd_una is properly
 initialized on connect
Message-ID: <57f7b390-dfb2-cf9e-7ac6-62e279082d91@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Apr 2024 18:22:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/866596=
2144

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f515ec3056fe
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D844133


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
