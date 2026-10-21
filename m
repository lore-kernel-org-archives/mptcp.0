Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584579;
	b=pfiYZEzMouPNsktrZ/xlbZOsGSHIrHegAdHruJfXjhwRCXrrAcFfNX124ublxHijhLEN
	 ZnVgzfrEotyia8Rtkn3Ub65szRs62CG6tosgYwBb8A9yoxZKjcYZ2yw0y8xtxGWJkPtkT
	 VouBwD73tf0lTttEURdlHggiWjZtV51kNFj84KX3MSdprdPOAjLXZajWymYkO1PASwSGX
	 cB1rcApLMsE+YV6lDvP6z4y2aTApgZPV2cQUy45u69DwCI/ICPUudzztmDaz+LO7XCtqD
	 dVLPrBiD2UBqfHclreWlcRP+AqeBzH8OZQAHPNgx7lIJwsZ+UuWrraSA1lPPjUAiX8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=FXWv/Zf7VMwFx/Yqe7V3wtmQQVoLr+9xkVzd88UJ0Fs=;
	b=dqQiA/4dK1nXsyXA1Xy1JrHnjoqvPpo73oZjcYY3aQRMgppOtwUEmqciKXzUr50sGvc1
	 h92VspfsQiBOEmIu24qaZ7a8eSCBJlWafu+mYiPSKxX345nJ7FBsWwEenK/YYS1so8sJ1
	 IVIk4dCf9V8gG3PwS65j8FEWCVdmsrxhTR3i5f7E8l3UKNdL5g2Da/8N0kO5WuWL6LYGD
	 cHK9njdGDGexUHRIXOUxSOI49G0MJwhNzkUaOeXIFgT+MD0WvPFaCOVO0MAXJm0P8O6B1
	 4MayEM/rlO2D965Z0vx0nQXszKoYG1wWUImOmYd4KUEw/28NHqb/1UTqlq2FsFLrDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DK2U31kE;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F47606A31A
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F47606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DK2U31kE
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c9879395so205388a12.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792584578; x=1793189378; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FXWv/Zf7VMwFx/Yqe7V3wtmQQVoLr+9xkVzd88UJ0Fs=;
        b=DK2U31kEtcq4fiwp4Tg+EwsKMaGNIdEaSGv0DIks7l2C2tQZjaqpiE+2jRcgRN7tGT
         HrsgvR++DWGp9EyKcNC89Sxsfvwy3uw3jb72nQgA9vZB0FG8R/MihT1v2qNhRCOEyNY+
         wQ0bOs0j5MZ17oYzYkHXBYaC0GOi8e72EeL/4pk+iC/RjkTYWBjZAUhn/hT8ZdMScaJT
         QXg/M4zxzjNbd4naU0iOkbt2asnZjAxIGQTh5ZtReCrGocZ01yyAs45xVjW1wIfSqC9a
         5cvrkhI+28G08u1NiaRDSupaLuWJSvlW0Gh3lLFqzrUOsnu4e2EkLcCjZPcjQ0eJL/0O
         E+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792584578; x=1793189378;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FXWv/Zf7VMwFx/Yqe7V3wtmQQVoLr+9xkVzd88UJ0Fs=;
        b=c3L7WAAooIEA8BEDvGoRtBa8Zl67fadllq55I8cVylnIffKGjeELoVsE0X9B7zty49
         l/yUQFNklLXkUOBFTd1jQAKeP8cgaLkaV1BhhKw9v6JR7c23Y2B5O1ECD2J4Kph9D9ma
         pd80mPAArXRWk6LZziZiIUJh9Zz8CKhvXHC+L6uw8cjrgnUVYsByd4jpdci8DItoPhDS
         9Z0YQmTfWFLEeJR/nOs499R5zi2XyNwMzPufdVTmuJD9TzKB1nbRzvGU6syy52vRknRq
         ZiDieo+WBpPSrLAM6AVYYQlJnn9y5a379tdHGV+AehjkG+/1suiwj0svnYQF5FYw0VNE
         D3aA==
X-Gm-Message-State: AFq9FYLZjuU5MnH3yfmLF3Ire9si2LyuQ2pDxLJYRnfZ2heORuDUKI3V
	b9EY82TMSar79EkqRfabX6rYgKMcsdSZfI0JxhOiyDtBaZsxRlx1XUdYBjtImxs=
X-Gm-Gg: AYBFou3sJ9M4S3yZ0tZqAs8hZ+zpUbBq5yZF8LpcdWiH6Xg4slO5oTdnSIBU90kmPzh
	O7hTh2VdBrjaIIzREVwhHt5gSBlQwEAmwc0DBX16/3dwWiT+J+f6o4ZekP2tdR/93PpoyI2pHxp
	xPi4UMuhQFHK+dxs6xjxaqU65SI0cwthDOul23S1OZv0RUD8mKazMfY8wJckfucDybjsry+sHwM
	x/BD8O3M+9SR8zmuJJU/8h8K+1PBWNV2KyEf3QwPPi0tMLQNlhcaO6ex1J3pPbDxjY6HTGB27/a
	U9hGw7OcZr+ARY4h0fbk640Ky0efgRebh+ln0mjK0nHYB5o7E/NxYeOPAgGw0MtNhmuSNhC3PjL
	xyGat9w7fOvNvAbmdCL+7nvVgD4DPFwlipNeXwVOR1qXgqt3qxznZGofzZmmpiZYZ4h4HCam/uy
	hPCEHRC45vbG9ohh++O+WXuajhy1C5D4SbZnX4norKqlU8sA8OLTwMr5MkIHrwW3dl9oPZCoHPZ
	lXzgKjVW/qghbX4kWcDroYypSb6TyYUaRgkEkyECqpCN68XD1/XXniRk1u9tce2AuZhorEykQM6
	xD7MPcFdo6KmnjNj
X-Received: by 2002:a05:6a21:e106:b0:3dd:a195:dd5d with SMTP id adf61e73a8af0-3e287eaa782mr1467590637.63.1792584577809;
        Wed, 21 Oct 2026 05:09:37 -0700 (PDT)
Received: from github.com ([172.184.190.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a85c3ba1sm688425a12.12.2026.10.21.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:09:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261016-t-mptcp-scaling-ratio-kcsan-v2-1-241d1f92dcf1@proton.me>
References:
 <20261016-t-mptcp-scaling-ratio-kcsan-v2-1-241d1f92dcf1@proton.me>
Subject: Re: [PATCH mptcp-net v2] mptcp: annotate lockless access to
 msk->scaling_ratio
Message-ID: <e81cc1a8-e82a-4943-98cc-4d269b961aaa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:09:36 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39578547666

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/119c5a744b91
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1187813


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
