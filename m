Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585889;
	b=lODdxbF4H9hsB93nHvS2PeNY1RtxPNCh60Xb3TssoJllp04Q+IQ5FYy6kkuktGC6yRtP
	 m7EkFLUKxZ+ofdkdDdCloaF2QTXQ04p1QNOaflBcE+h5Q8LMYi89lGuSlGn5mPcLkzEGA
	 hxJgBf7oA3x7L26Y4dyv1r63jXC2q/g97kkq90VWTw4J1AMJez6ALmRiEq17pyY7OKqxK
	 j17JZVjjNSd5riVDjZyZz7KosEtdgGBSDN+9O5QTOA+BFpYNdHQXEOvoz/NgRePrzZiD1
	 53HGCKWkhEh22nfFpBGulnq/98LxsMJ1+WqP8M3JG+dCbky6i2G+DE/s5p//U9/BtpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=sUXVgupDszvD4Fo6Wx3FTSGIoqtzifZ+tvWf6In5shk=;
	b=swoj+fgs/1EA3fFMmMuTsAnrlFYB5wqglqeh2af09rtFcRXTPjx9YVi8tju+vLdaxSg6
	 Sl+HRNKlnxsu5n5vDS4GssXjoivpVaVH9toGIpF4i8I1sDj3PVGsBR1igEJnti3Gtl9H9
	 KntjGyby3D0ZLubWDE8dEOWB+GNlHwqH/klN8AR4YYLqSik50je58hDbl3utEBxhJ6kjD
	 Yw5QO7uNsPoGINKqCSBXtAW3sEbevPKbAOaZxyeWRvqBs1FwYByEYdVNiou8+dhkHU65d
	 Ow7dghEWkUKT6F+P84l+tG8am3cd7vLbG38pKaTCegvxttp3S4Ff5zATkmIN/dwme6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=drB0JMp0;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36900606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36900606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=drB0JMp0
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so418703b3a.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792585888; x=1793190688; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sUXVgupDszvD4Fo6Wx3FTSGIoqtzifZ+tvWf6In5shk=;
        b=drB0JMp0VpGDVYdwVT8gNDVenYkfZiosi+kdZqQe61b0pzJeyBGsAwPZU/kMKddKaE
         CuKxOKsbgBsEQE4NavZoosEZtGZwk2PGva0JfSHDEf0tKhP+A9RIZ+S0rVO0kTaO1aMe
         /9WU451XRJhlIxZUqxenb2xhzXTCgrYVsXvtSCz6B2xRLRO6OOHtddGv50V5PeZbbUpm
         q5oNojPf7RoGmk0uoyHTiOA2BHeKDSXqVqXhMTTk8HrtvLp3kkZbvAchuu3ZM099Qq2s
         47RAQ4owqzKi0cEaHa1tURwaMcPlKrIE5ZC5L4iGITNUUdMk48G/a3HXYnNilaxi1YmX
         8Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585888; x=1793190688;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUXVgupDszvD4Fo6Wx3FTSGIoqtzifZ+tvWf6In5shk=;
        b=GKQqF4qfscriEUtX8e8HTWQG/iIBPO5Tgone/MMv62+YasD0UfGATCRZiV06Kp6ve4
         wk07YzKNgMI5hEYrV+yAEi3LqgHTgAB8yjEO7lG0DnwRrq8s2mM4tIBblTH/xeg9WGcb
         /MncHUZNv19p3QP1nOxYaaCt5hdm/Y5dv+7GE8Xj3p95qGJ7thdLF8+nqXE/rCbqRuj0
         fe5Bqpwu0VWQa2zQY5j5wlLPTEXZoJd9R9DHWFFlVZqXMsIfYuii5EqzFN29sHyQeb4S
         5K+T1sSbxZaK75ZHqOVpPtZ8YlINFqialQ88Uy8v6paSMpksTCoHZ/kGEOlsrG9qJw/8
         Zttw==
X-Gm-Message-State: AFq9FYLLYRkdRxPMEXBkQlzLslFJ8i6J4xUw3Lq1EzdON8VR5+wP5IHl
	0EnxwQCdyP93waXai6cBhROGg9/mzIzTlrrY8xNaUSq+jkf+BqHIirJmJpWa
X-Gm-Gg: AYBFou2ERfZU9sAICc+iBeuklaTHmTWSNUGY7pjdAN8WhOodJRVPq+FPKV4JxUx0YQd
	wZovm3iHnZKJ5c4xBU/iOFgilra9EDRX/l6b+qgWH+kZUVa72MvfyoQ+HX7ESPPq7q2fnwWTB7R
	HsibbfX1bih9NULp4Z1iDzVmkyVrhg3UR91vNqqDicJJoo2tYBBYiDRV7buSMM8pB9b7oKLJi3Q
	e92b5T9PN9UBxN9bI7U9ZnCDUlGZXk39rhwEG3BjG3XDQBR4b+6tWQXM+RJGnHTmZhg0GF7kpC+
	chXpavmTDpO0s5GEYGd6M8/QC8/PfOZtOv5Rv6yLW+hZF/S50TR3NPiiDcopOKqvb0XAMZ1C0X2
	G2bhN+RVNUFfbt9+n1/ahh863W5VjJ1T7luFT64J8T3jWBjG4+V2YZXROI5VoE6J/I8jMb9swky
	M/JLGEWLfeYKVekF79v2XwksLGVREBoPWvw91olu/K4CkNHj4UFvcEIq2K62VXlkE+l7BIjL5b8
	z+ZTPnvprqCyC4RgV0pF1H8ggOqh7FCxGii7DLx7OqvvtSvi+9uKcd7Wat6Q/9ANuCGUw==
X-Received: by 2002:a05:6a20:d705:b0:3e2:313d:2da8 with SMTP id adf61e73a8af0-3e287eb7677mr1661218637.48.1792585888329;
        Wed, 21 Oct 2026 05:31:28 -0700 (PDT)
Received: from github.com ([52.159.245.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a8711d27sm733269a12.22.2026.10.21.05.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:31:27 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792378794.git.tanggeliang@kylinos.cn>
References: <cover.1792378794.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] add distinct lockdep class for MPTCP
 sockets
Message-ID: <7c72e170-475b-1086-6489-3ea04360a6da@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:31:26 +0000
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

Hi Geliang,

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
com/multipath-tcp/mptcp_net-next/actions/runs/39579356584

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/18cdd207f3dd
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1188566


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
