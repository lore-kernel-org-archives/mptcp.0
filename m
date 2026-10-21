Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586627;
	b=tMuQP60Vm0yBYLBO8MpAe4uqsNX1F3wucFJ9/nHnobZ8l3GsB2size2k7iBQIJYKBdP0
	 U/1JmaEAXkGDYP6UDhIHKk5lCw4Rx5GJA6i5Kv8o0FXtCvZpJlLbFoxkprBiio4zyKbBd
	 bJl60/BeIXZi6woC7PkQRugjbNHvomYXt7li/CMMh9Bo8CZiQDAKbVmHBcy4ueBgQmHmX
	 /vsyD1+ONMGudKidKX1dvPFKf5rdtMsVThr03RfzCrsxhkxJIK6cNR6PGdS7EM6EwWAzb
	 NwFVA1ZG3i7VKT1iYrjF04LHg0Up2IY3lSC60yPzglfb5yTMMfwPWnoaQsahUzfFIMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Z3seXp3aqikRPYV6TNeaWQ//mSXqGox9FmhiLsM58KQ=;
	b=ISHCh3Ck439IWrpne2BAxKGo36VMY82VPB4ZfpYCds7Gqzb0WK02rkvIIlI+kWTQ9G41
	 U24gf6DOllepSIxEaOrLRTcpJA6GjGDLW3jtyjZxWrApyw9FTq0eGJcWsIZjBrv8LOhxJ
	 kzcbFiDPSohOGVocFCX/+VsToqmCaTJg5n3a8KfVG1YQjIZfMtSkiEAZni22AI9+JONWp
	 jTdRGTgxwRB9ZgNFpAtiBPTEbNnZwhakaWua75t3QNhTVPGBO5lWmVb5AnXv/dt68/SJs
	 3pJIhcJvNDsVYbT8a1Y6DE+WG+KEQk5aKWnBcNBk7YcwrBHPcebMpmMYojyA+mpECiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="px/zgJuX";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF2606A31A
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35DF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=px/zgJuX
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so554288a91.2
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586626; x=1793191426; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z3seXp3aqikRPYV6TNeaWQ//mSXqGox9FmhiLsM58KQ=;
        b=px/zgJuXOfIoX/zt0sQOHGhIfhZ7dV5nBz5CYSH0fLJV8EQk/OyJpyVGlE64jVQtwW
         lqtpusVK+Gd1yS2FF4yWiH2SDH06P3/uTM46u3o594kuyWxFMJvCFYrw8zlBIbxD/RJD
         EfzwGIGt/R5QGcJwRolyBiG9y2p+Nmq9gHwUw2MEj+Bkiy91pWNcECAVADAnsgvfdFBD
         JZBw6s2lCVn2zXFIxq9EDCFGl6g5+HaXTGL+DQO+sVmF4M4wG5ccxWS7JjnRJtx3KeWo
         I6dtyaywS7+0VbSyWTY1O2ObHf+CCBlwNUPOxjXHx3w3EeWWNRf0nM+AfJ3zXhF1FWaI
         Kegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586626; x=1793191426;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3seXp3aqikRPYV6TNeaWQ//mSXqGox9FmhiLsM58KQ=;
        b=Pr7y63ACLd3ofVNK6Bu4CsnPHQXkdnTexD2F2kGkVynYzCAF0DSd5n7Q1sIONT4oLi
         D4IjsxAYRsshgqivdLU185vyQ3nxQ+13EZyxdg8UgSvKCtC+6qsrySMYJagbthU/WxIs
         p/GWv/aTxdvi9OCqYG1SR0dJZg6kYm0SB9fqgEnDhNnZ74gNYs+ibgBpVVcHXNn9SWKH
         V48F2H2WWxb/nwdoOsBmbRdgsPGjjc+ZacFE1LX6UH3pb3o71fwR5hoFr1acUIkMLo4n
         RqsAZKFTfV4h0ibYC5ouXDnJjzk81qzRGBq13HOts2F44TSb0omAxzpULHCiDPlv4ME0
         GJiA==
X-Gm-Message-State: AFq9FYKLcBCVFLLZdxvOOvIhm3Vm+aVV8t/0hEHZcfoucIRnIA23uLVd
	kjKiG8zPeihkd/0KTWcAwAyxwYYmZI/SvI5AaPFm46TOyEmLDZ+gZvcdNPms
X-Gm-Gg: AYBFou0vTRXl2vu67jQEO8spj0DuSD2KZeu2Ek4KSrKRi3D93S7SUPAhmpMTbMeEUyS
	ClRroK5uJkP8CXVH+bSs9ctjRewx3lTt9aT+y6nswZw5inha83tS6f6H9rj1Pw2/U15qAOjwkfU
	yV9Nva6PlPy3NRykTB9Xz26A+NNN4PMVfTw1Y1hrvrxh6VcMx5QjqX5vACApX61sNsBKpiEYOmC
	jRu9JnrPWgr7uLX74O2w8DHGR43ZIpC3S9OnubUdmJhtfm/Mgx0nrGrx/9jZnBfRiai7oMV41WT
	18Mfg47hO9gs0CWDl9KJdNKLQX/O+OeBVRJgIi5JiMSLKquO3U8a6zmiu3nu07EZr8NQPrrXuWT
	zbiQMYvNEWzhKMCCxvXmbtFScoMYi2SCzV0w+K3Ax7XwGZ6WEd8KiwafwvXhaRSjTDS1bQaKija
	7XYhslROFvwfLAMnUgHPduCFVbK2Ekx7iqMv0QgYxONj29JU0YLGSiyHlIVmk5a1tbFb7+5WGlI
	J+aiZYoxOHNxJ3oNbTXjQvJg9VmtPtQgcAPxVZ2Z6kDWC6eC0cfpUsRSNqUZWwOFSC95g==
X-Received: by 2002:a17:90b:55cd:b0:3a8:6a6b:596d with SMTP id 98e67ed59e1d1-3ad86f66862mr1594207a91.26.1792586626545;
        Wed, 21 Oct 2026 05:43:46 -0700 (PDT)
Received: from github.com ([13.83.166.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813de463sm4359733a91.13.2026.10.21.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:43:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261019170751.200446-1-w453y.me@gmail.com>
References: <20261019170751.200446-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: in-kernel: fullmesh: re-add
 of the initial subflow endp
Message-ID: <f434fecb-819b-54f0-d7cb-c61e84c66047@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:43:45 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_sendfile =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39579830342

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/563a766f9d9a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1189145


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
