Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181722;
	b=GWzvYVNcUfhi6Ef0nE/q0zgEfvSSat6NaAbXjnHEXPKqXDDdhwS3OX96Trt0TKgcRow5
	 B1vhvLE7JFv8DEHSxSGPQp+ofo0El496hEqO70GODH9wKVGP5+F2H1DixXNPh220z1qN0
	 3aN0AhGN5nvImIqdT3As6TAQkaF8s6Gh0VWTP6L1gHbYi1CKy+U7ap1zPDf4vZ8nZnRlr
	 CtSdqg2Sp2VQydgJGwuAKsgNd5IrCTBJpTdH5bZyyNiKNkuX8zSjIAoEAwjGk65y23VDl
	 wgSA/1cTAtmt5+HtXX4qjUGDt9f04g8mTZbZ1LihIuUNbIZBDkb0iSgYFsdWAroZBJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=/TGwR9cF6cv8vzJtOTfjXDtbsuxNYIMcXvx3JPFjS44=;
	b=Cgg9IO+nN6b2/Iazc/7eFw49tB0jXnSGcshsPR+LlDdRCdy8VxTdOzdQvZj5tpm9Q7P5
	 KQgmACx89kMHzh3oyD6Zr2lS52zDhAV8qPBMVX7mmSOVr08UBN34UHv5PRqSbDorqWEqr
	 b4KrlAx6AjeIDAoNCc4tM5KXrQVp5mk7kzguZ60X8FKdsgdQzA9dSBMXFngYQdTI4VvHz
	 0bANe5azUzmPjZyCjRPbLXm8UMqUIMRTVah52J6KxqnwmHmpiqXKIgrsXdpPuNpoFN7L5
	 AXtLR1elp97evyXm0jgrESTXX4eHrcxc7tvY9ldOQqMtfnV8lBMZ0NONM+pbEmx8FAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aD3XjMfm;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD4606A31A
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 10:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0CD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aD3XjMfm
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so892903c88.1
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181721; x=1793786521; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/TGwR9cF6cv8vzJtOTfjXDtbsuxNYIMcXvx3JPFjS44=;
        b=aD3XjMfm9DYCd3xDHz26FKsvpEZDdNj3mskFZMGRMJJ5+fI3dz1LOEp32ae384riuo
         P6QIt6YUaZLS1davFkZGDhxs1d9C7aoWE22VgEn02Q7RaRYBFj7dLvM5d+O/xt5Rtdf+
         cG89PSacYIJnffnRHfqs0PrLTr6VSzVrppd6KB6ljnAqm+WGFDT3xR4F6gvzYJ8IOD5D
         LojGLtqH3iuj8dm9otd3PtrWZGoRROHoQBJ1xjAzXpEDpWz1ML8pCxQRwsVMf6U46h2R
         yWZ5isNfqLUL1TmtWuXAf0PPFtS4ey1LYajU3abKfZz+gibwv1B1IkrciI0TrvdIYK4I
         sqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181721; x=1793786521;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/TGwR9cF6cv8vzJtOTfjXDtbsuxNYIMcXvx3JPFjS44=;
        b=dhHE1KJD5aWB9uwYPWuZbJItYKdM0lcLTNihxXvc7gP3/jSJdhcrJC3HAKlR3FRm9y
         e0Mjw/pgQCV6g1Z5gDZakzErtbROQdxukJDwifmoCUrceAEs5Y1cOTvV3fAZYA0bwhOB
         YcBVe6jG0fY7lthydJidqNTyxw3C9fH5y01nO1cqC8lXJwnOWIZFkZAS9yYd9gknNKOb
         k9va/YprTUTmk+/z+C0g6i9PhRZ5TAekGcASaOEGd9TPeyrVLUsy4SEEFb/Y8ZZdxp7H
         O8P5ocNW/75s+j0zIzLrLB/be+8wGNHrFWOi9sdD0mJAQKVOz3tP0rPsngxjMU7fCkmp
         Xdxg==
X-Gm-Message-State: AFq9FYKe4J0C2CLwB6du+XtP5GKITntgFz1jfbz8O1/1Jd6U2BookpdA
	rOf4skGfuWd0FewBPNfwgBn6RBS+tLgK+W6xIHqzmpPbpBp3S8T4Fq4=
X-Gm-Gg: AYBFou12vaKJNKT/sUA7T4br/ajO1eui+pTHruPEo69167gmzZfFQSUI0CyMNy1N7ox
	VTSWwQcmE25TpzPDQ3nXKmvYNAL8I81t5wgL0ljmSJu80/gggm4MKxDYW5gGzY/u8s9611dAS6N
	P9OFgV6b9EWqwOlxQctbmXe94V9tmvV6jN7l4lOWdmGfEl2qbrMxpOZJfIi4OaiXgYWBd8DJ6CN
	+A3IzaYkaitzlB9VYPJALzasccgxV5yfjLt9r1fWp6AMihFsabIUglmSYcUD28eXN+3QsZYezV9
	IQ/HPFizxOlDnWzDfFQFn6Rq/+Ix86Fu3SWdANaL/4mSD3I5dZR4j8v0damT6kYkwZ/MObj8XFo
	rcTwopJagcXGXLUi+jOlmdJQdTr5rmAH6zSqPR50Rs2LDWj3edQAGinWFoHAvQpfI8+YF4+xds7
	XK/Vom1HKOXcQo0dnWg7PHWVgyWYdsx6d+skDkD6oohMISyCeo5DWf6RWm6BusNm2duTGDc6uZO
	ePKjBEUR7Yvq9pYux1FC3fjSHKHWtWcogLHJMIzmdPaMQ2f/wixmiy5bsGULeevzIHRV7ukQhyO
	hX6X0M3pX1lqYYRbVAi55S6WQDaOmuHNrxmitTVzmw==
X-Received: by 2002:a05:701b:2405:b0:143:26cf:8615 with SMTP id a92af1059eb24-1a6d02bd6fcmr2501754c88.25.1793181720851;
        Wed, 28 Oct 2026 03:02:00 -0700 (PDT)
Received: from github.com ([20.169.103.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c814aa1sm6980531c88.7.2026.10.28.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:02:00 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261028-fix-mptcp-issue-636-v1-1-1f1e2ee07a1e@proton.me>
References: <20261028-fix-mptcp-issue-636-v1-1-1f1e2ee07a1e@proton.me>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: connect: fix OOB read on
 read() error
Message-ID: <1d3c9c71-09f5-0759-14db-8ca67cac3d62@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:01:59 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable =E2=9A=A0=EF=B8=8F
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/40664161219

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/06b5641fc3ac
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1195263


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
