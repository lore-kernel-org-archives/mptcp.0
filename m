Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317719;
	b=4pnLHa4NrSnVh8SDzslctj9MvY+3wGmSj5No0++JV8WEDjEj7FJw1o/HWxODdLux866t
	 RjdXD75Oqxp0N4fyvxE19jYfcAhKEJnA0zDx4cpG262cw2fIFfV1NZKpfne2q73dUKkM4
	 N9evxxX3JGrRtPkA2LZMaZZ2ksN5w8mxX3KleEshcsmEK+AeFisC4QDXXLNr2C44AvbZq
	 w56V1P4DUdwH176wtRbqpMIpXWYZ4PK6NvzUYmu4oahv7FR3qfPFiZJ+R0HcDawoOUW+N
	 utYYDhzQ4+8/T4LvV7uJeanIkDJct5xSvt+LJt9orKLoquYgYzGVdJu9ztOOXi/hQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ulfBY5bs+tdP7tIlv3WvKi+Ww2XFVFT9BMFBhJFiayY=;
	b=Qgne+sndYYXRIP4v5ySaESsbHYhQ77a20oJ5NBQrX1LvjMeUFpfWnylyMJXFON4ocIv/
	 ilr3DvpRvhInQ6tYka1Pctd6LHV7mLqpNbeB8qEaqGV3aJtnHWoJ/dUqD/weLcvtoZoLP
	 t84Y5BFpB3I/hfOAEtM57EWv19NG3YNiSYMANTq3697nYaZbsgksfGXoRtsjqzZvoNdFc
	 7+8d/iIip7ptUaox58r5UV2SsfEnSUHR9mVWi42ijQ9WFjpupiXO7Q83W2bzfHLVy72KL
	 xSRVwE9xMD2Dd0yoqI+Cn5LJPapeZReanlfTgyDfK9EOJtI4wXIQoW8XFPsCbgtW4bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRAnS9bb;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A654606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A654606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WRAnS9bb
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93ead211f14so18363585a.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793317718; x=1793922518; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ulfBY5bs+tdP7tIlv3WvKi+Ww2XFVFT9BMFBhJFiayY=;
        b=WRAnS9bbS+SmiQR7hsECNt2/ht3KjA8SRZLdiUuMPcBSwOEab2GJsGWlEHs+6pP+xS
         jwhD39F5jh9EkWHma4FbuVvUI1UewEJhKyVqWOJppEwdRTyR9IGNGiktZQCDrCKqp+n7
         5M9ZVtwF7celM9iGt01e8gr7wfWxv45SP7lCC2iLkpmlFFQ0Ybtt0sj/cTlOrITYq7RX
         m/h9G36OCJ3ilNS9mORZW12A10MboiwLkfeanxP5ftDjlcRO2eEJJ6dP8RWO3hp9zpAj
         DZwDqJ8nTLAtSa90+U7x8PR00Z37RXVSZTaRuje8H8HUG27t85l/zvnYN3PYE2soKBfq
         zFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793317718; x=1793922518;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ulfBY5bs+tdP7tIlv3WvKi+Ww2XFVFT9BMFBhJFiayY=;
        b=d8rcVHaMzicPnKQReFz26bPzTTOz2v7A9nmLq/nShxH8KrL9gGaK4uGvMYQ18Uq+PX
         Dz4sdnXETvdWeu0Pn32sU/NimVMkMJL1XaBMCxeo3REczQsAQ9Jn0+PsmBq0k0cMrpOZ
         PHlYSioRz3vXffOxHBzkmKZDKUPeiiTxopUq+ioUt7sih0RTT58JsP6Cbq45d8WJtojH
         rp8BeJIftwQL9GU1nm9QtBz9aIFg1v/+NcvPBn8TkE5CB9bXpAD6Qejdq/PQcawSQ6Kj
         XItaNU6JL4WiCeLn2K9H1bqGBUD6WU7O8ZiEtpt3Y+3uE4cCT64RN4ae+GTQv0OREK7+
         k+rw==
X-Gm-Message-State: AFq9FYKYzno2T8iQ4LpjL4SN+Gq1XLY8I5QC4DQ9yfN3tobjxGd9yPdg
	vIAhvaRKrADfyTdTolcCUPqO1jl4QqTmHxio7CNHX18epwkqfripg1c=
X-Gm-Gg: AYBFou30az5InsOhvFnmLwMl/s+TvExDR3M9T7tIAYibrvcF+ieuNrkoaQCWt3ouuxd
	hGotjUaJ/wPq1mY9gyKsrm0+9HN1Wz6sfQa1uLF6H6XRUagtRys21/m0fhwrLJkfkyZzIFkF8GT
	iqkI7AW4NPO6cRa8YD/eqm3ZzXejXErxsmgEv21oW/UNLCD27hpkTBR0UAuOIYItBrNmFSOiPwJ
	Rpit1LRgdCCMa18bL1PtTrdEzexkNsAg4B9bj7/efKlTDU9f9R031QMsMe740paRj8VDEacYUqy
	iE5eHEd0B2e4ikpG8XOe17Sl6cGapV9YrZHyyH2gWh+TbKPS5Xme86aNIOHjKhj7rn/CZkKgvmi
	jOxcKgLwDOYO37rQlyVxWzWdaKp+1OFFgBh5ti8l1qzE/TnEBAJd/wLjpbrKaPd4a+b+kCrGXDq
	zDNNxDQWAlGyICqIeSM4uq7JvnwJZAFnfCojCmFhSQD2aKC+hQAN38WwTitozuCH5YqBmIfUvKv
	PF749PwpSl8qwqMVCHTrwTieuqds2cnuHQFqkrdE7i+DatheJnRJ3aO0FVJijCTZB2jZaaG5N/3
	ISByM0nWnIFTuKFvF0LhZhVy2d7Vj99LWX7wGnBH
X-Received: by 2002:a05:620a:404d:b0:93e:5060:f961 with SMTP id af79cd13be357-944216191a5mr116311285a.6.1793317718319;
        Thu, 29 Oct 2026 16:48:38 -0700 (PDT)
Received: from github.com ([20.119.95.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442423a212sm8992885a.18.2026.10.29.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:48:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
References:
 <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
Subject: Re: [PATCH mptcp-net v4 0/8] mptcp: pm: userspace: properly deal
 with the ID0 case
Message-ID: <b7c51ba1-e1ba-b99c-ecb6-413594155e29@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 23:48:37 +0000
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

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): validation:sched-bbr =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/40961992710

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d3c16edd6a=
b0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196652


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
