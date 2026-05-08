Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D027057D
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778269547; cv=none; b=u8B9qkgB5eQ0NiGBoi8xdz3ZAioNT9AOPzHbZnL70BIRiDGfZCdUN1N/JHIAQW/lRYXnGY2DvWoiMxNABx0jCArjUZ38S9m1mEnUPRZskcKJjioRY5npbjvVmtyVowFBpXughGRovgDI7limbtOkfgWMbheAKjf/Cgyz9QBZxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778269547; c=relaxed/simple;
	bh=I4OpASAzmcmFM20UasyI4iL6pVZqRVFDpf/WbKoibV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=EpaOZly+odjpuOF34ki50MwuGGcqyHyOBYb7u+ogGEQchdx38+5eIsguXKoBaWRgq7lxR8q17ew0S0LnuWct+Yylj6UVxlsCoPbvnidNAAcRzBoppMvuQzeZ1H4xwkocIf/R+FKwTD3GDSmqQXEW7E0pjchgp2S6uXlOK+jJI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTRx6Z5N; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTRx6Z5N"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-512f09ecc67so15940211cf.3
        for <mptcp@lists.linux.dev>; Fri, 08 May 2026 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778269545; x=1778874345; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im5reSOeFa2zaaTP4jjBefY0ClJkmzDigdLKiwT97kg=;
        b=OTRx6Z5NcjUlRsvQcdIsmM1S0TtKV9VFmmLf+gWZF9Bkgtqq+sfUrEgpFjpb/d9gou
         A4wO23Z9gOQfDkQxXYXQH2FVMDjedf51RyKaQMfLiRuEeLQi1e0ykqIupno63TwOJFfs
         OdpHUFWW4En1MaPjuF0WflUXK809kRBHOkn37gekR7eBcXEZTZOB7cPMX8I15gQ+GHCZ
         oHnw4kpTjjmimOmpAA4uX0eVC1ASiw8NenuN08XM5ERLyIplsVknukH6MdVjqjGYq4RF
         gRuO3X9Vi87oAZqylfG4xCQk8uAGvBjY/T3KgLqMavFb0fvyH8G94ZpqeU3IwTQpjaQL
         W5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778269545; x=1778874345;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Im5reSOeFa2zaaTP4jjBefY0ClJkmzDigdLKiwT97kg=;
        b=j9exJX52nNJAjzJclnpC646+RdZUZmkGiQWDOF5YXky5i8d+0A5v7xJwwUAb/XLnAG
         Bc0q+cgnxLxz6QXXMEVN+twQhNQSM/d7zLh0kAaD2pETaucD8LQM1N0jY11fdv4XM4kd
         wPvTHPZtTdJgiBc9Ik091yGQ7wcOWQ88/TVjMcr6I7u9RBspoK1CRskmaubUJCI44RSS
         A7SwaAGRswq3Dw4BwRX36tWywSF50qiqn6tBfSpkm1VSglnuxbD3y1UsO9qtxCsH9gAN
         32PVzp6j+CeqBxQ64LhghhjdsrRpN8Vq1G2PyJio+jVvshUcxKXtWbqOhBlWTw0in7em
         VWDw==
X-Gm-Message-State: AOJu0YxqLsGwnWd7hyzlmc5isRm1J02zz6f+Imv0edykPmX75pvKJLJO
	KT3is4GtCEpQJ0gi94phXDZEoJ1Q2/Vd3yU0U4v01j331FzAgaywD7U=
X-Gm-Gg: AeBDieumjHQXDlC4xa01NqZWF9Q3KWebFz2XviFQiOI8QmCUbtXJflEiEGJb0x3f8n3
	iOChUgrRcz3An+OxcCNPLzGEC42EeJPRbOtfr6sFNsQRegcjHCRsNE7PIIVgoSiBWuEZLjUM+ho
	e0CKgwA7W6jw80EkUl2j6ivQmSM/1MCPEpr+j7T7NKN8tRIuKeor45l6A+9YOrX+OrAcM9kuzD5
	8jd97C/xeOIgzBnJOCdEqO/B+W18S7RBXTa3hsDRmPLVgBQXBQ3PvUvWGykKPN63yIfxmrp3IwF
	+FfPVvLyKJD29x3OHY/42mLwgfn6K5OUpwWhKG35VcnS9DG4H55GbDT5toFu9Ulr1vbQbmB1i9+
	RNWKHbShVzY2LGVhv34QnqL3O+lDoEnXVU/Vozf8Echmtts7iGi9fxU8/MPdQIPZ0Ccw6DuN+79
	e+FsR2iGvuGCv43nswLOZkQDC2bmsiO5p1Pg/xow==
X-Received: by 2002:ac8:7d56:0:b0:50d:7406:8f05 with SMTP id d75a77b69052e-51461bea4fdmr195919581cf.9.1778269545339;
        Fri, 08 May 2026 12:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.195.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bef56sm25045541cf.15.2026.05.08.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:45:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
References:
 <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] selftests: mptcp: simult_flows: reduce
 bufferbloat
Message-ID: <af20c830-2f7c-993c-6fa9-74df28bbe3cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 19:45:44 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25571380159

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2bbcbfb2925e
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1091768


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
