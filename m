Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F53CF20C
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951032; cv=none; b=gsOkGL1kKYz1mSdmmDafFObDQUbjl+YVciPtleBL559gNdslmecUtmwuO8Ss4vQTShyQb24HZyiFHO2SD0h+nEHkOcarU1316khS61aIliX+TwZwc/73oqf3dvuGkAkPUN+LCd/VOEk2E78iC2SKkcK5XM1vK3dko1MT6jrPz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951032; c=relaxed/simple;
	bh=VObrPBGLRzDX9EQZTiYnuwpwNYIcLCE6JXnzlWnatKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=djg6bsgbsiQxP7/qyfoK9btNW4oJ+QG/niAUC3EL/qPhFNjOI99ZOAEbayY+bTUeeN34pbiQvFN8ZPqr1eS+dln3v3jAbyC1kCQRvDi5G0ojVzrntXzbSUr8iM8NjR0te+Bfk0/4OwO5Mk6wH2m9oZIsdj4zEX7OG09WU/RU72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg326u4q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg326u4q"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1031430a91.2
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951031; x=1786555831; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kolrqwjwb7a61sLOUTqkzBM42DStY3HjONn0dirgnaY=;
        b=Gg326u4qzNjtSQBQda6vIiGZ7vNDivxbkCmyMhNkx8/4RS0aYh3Kie//9iMH/dzLAe
         u1Cs4Pkq4VmnMLy/n5GoL/Q9mhQmZFSOOxB+OAygKFFaDHZ7JWB5TtJNzsZVDcc2SnhO
         xGLhCY8bNfojXVfCVgLnSctUIOUPSAMJAQP6SneO6/4B4meq6Br1EhmqW2Ofn/bPW+gS
         wYrCZXJWOxR0U2e8i0C7p8hCkbL63N1JgnbvYikCRLl+TlbBHJsrgBm/QLZYMTOY3bk8
         RcUXaA76d2dAj3mkZNN9/e0YPayDNxJrPIWfPzd4wzQuxzWQnqfukRyvWhV3/saegFBY
         Qw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951031; x=1786555831;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kolrqwjwb7a61sLOUTqkzBM42DStY3HjONn0dirgnaY=;
        b=SkuhJQqm6DwwKk2PqkoIREY5TSt3478xy/IszgqK5JfjBfhK035GBzMAajae8H5d9B
         VXD655MVtq/rWXAhYqa6/cnuzT4mPFIjza81/XgepFTVj3BvIGlCSk+Tdo9ckfDsCri/
         YFJ4EzsLctlBQRI6zRdKTpbJI0BCAXDhDnOFNjl8sXt207q5GHnJR7tfSLmrYuAAS+V2
         oyoJY8oqUQ9416w98o7rmupdkkbYv+o//kMlQDhxPFuqXw5MJAXtPFijFVv6qpVqsNga
         MV6pS/HdaqsmMvrhvdTCPmtZwrjqZQN82TvBGAFrrCBRcL/6YG92FgjU0gFPGg+qTRbA
         PAZA==
X-Gm-Message-State: AOJu0YzLTSVejYYzxTOrvP8lFS8wNex0mGVM+mHHjDgC50caO2kkfofC
	vqrxb6cjNl60C3Sknepj2upoJ2R3pru7ljitz9pZGcAjO4nSALaAav8=
X-Gm-Gg: AR+sD11YO1Icf7OgHKtv9PkMzq2FC1gZBooIVaF5es5bO3sJMY4UVuy3S/QuFndD91Q
	E77RtqicrXFQKeMFhjlXzJUaIZiRdnPtscOHdP1DNvZQRKiCumJ8iwHyjgKyhK5Wrxh29fVmmyp
	6i2s5g8mMjbH4NfmHnSZddSf05/1jHLXi40PCLtMafbCre08UjTjvQM2NWXH781GbH0Nfiin84D
	WxdfE+SyESeTlbMIAFPSkdTNdTgoDvYkfIzkzn/AA4KXFQsGEeUk+2dja1dOFLq4+W40DtdLcyu
	OBXeFtJJg2jL5GN5r4FEmhL/oajbn2tlRsx14qADrmQ3RSb+bEMEPyRw/xihHjtvT8x6oADu/i7
	7LTW3CpSUx/Uui09C7APomIQajVNRXSrOyHcXF975su6IiWSAX+qtnoZIa1MbvKEQdLXkEIzM7w
	QzWLpf4UTvjTftDY0QYm6hu7Ml4FmgFJ9O8C1TbnfS/p3qOEKNHnH2sdwKUB69GofcWH7WZ+U=
X-Received: by 2002:a17:90b:1f8f:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3903c596d74mr8521577a91.14.1785951016484;
        Wed, 05 Aug 2026 10:30:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.98.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392d4d4esm3677805a91.16.2026.08.05.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:30:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785943854.git.pabeni@redhat.com>
References: <cover.1785943854.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: address stall under memory
 pressure
Message-ID: <53bf5917-392d-34b4-a12a-3e5d0ac31d29@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:30:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/31026237379

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/503660467176
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1140906


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
