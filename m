Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B23612C7
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707015; cv=none; b=ElCqXfhTQPYjDDJK8YmYGCheMwvTvmoo2oDwZaOFwzh9I/SORjigLBAyu0Vk8uCtWSAtKSBKsHEUcM6lwxY3Hn1f3Q3LliUvKKBHAqCifIke405U7whXeQx7z1DRD6WQ9mrn5gjaNLbEMokiFKJPXIGgn4T56k5y3j7O8cp4st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707015; c=relaxed/simple;
	bh=DTCGh3I9bWTtWz17PFSHGw4044TNztJc8uofc53scUU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=MHBc+qMzf0prxXHTRNIgBq59/Vdie2QvemU1EhP/2swGOZYmfrZiqHGvN34sDWR+7XXmTT8HGdFza53iRxghFMTxf6Q4Un8vaNz1DhIto9tNtGZ4fRQdmKZjiGdO4k/043SOUZOJdGiEMtZ7+XVUoYiGQ3qjN1otMj6/yeQrBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxrATc0w; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxrATc0w"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90d042fa745so1708978785a.1
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779707013; x=1780311813; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy8+XCaFL5J4SDjgwXBEhH/5ya/vxezphFgk38cMVm8=;
        b=TxrATc0wJM0IgNvDSLOvFZC38d/+KSCmKUnXnlJUuOWFTjvu+1luHURvlUU/b0nAbB
         kGEc2NxqrPa1FHUs0JknjCxvJFqoJp8O3yZ2WwrCuVQA+Pxs3gTpSXAOFP4vd2nL7m8t
         zZaSrKs2YxnSHfixskpcxcXVd3RtR4sfdZqUla0QRBZ23ddeywH3bUNdTFGSEj8rHvZ6
         NvJscRBx5wIvnjdc6czMXnNG6sVQ2iOXgkTB+9ppjcfBVuGQCeIhGHtVMfncACLjtffS
         11AZ9hZhqFflklZziFr3JWT54NKGV1usUp7Mf+LlNZ4VGwegq2YvoQgrfeLIlULb/TVL
         e3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779707013; x=1780311813;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yy8+XCaFL5J4SDjgwXBEhH/5ya/vxezphFgk38cMVm8=;
        b=MFTx4D2O0th4Lah+4k+Q0srHTw2nD05NN8wkwnzhFUU+kWqA5hzR2Il9Bo9SCdpMOC
         TOutv1OIDkeD7GAnSMHjMHUPAnrdD+ZRWnF0YtN3vdQ2D0yjcOF+F86g76IiKlu1LtTS
         xRmL3wDJy6JTOSyfb4mgrhChNf6xCxOSpHpMK+gG6i2e83J2FCoEfaysgdEBsebDGkMr
         dkjBGYfhm1v1OENH4GgbTU3HlZvPMZejLizTElvAN56l47GF71fmNmBgCttd96NPPHgv
         YInlN9MlTmFRWmApck8jNskLvI9jt3Dd1xQ6X3n6aprtlslDLw+3x+Vvmxho63SR+tHr
         W7pw==
X-Gm-Message-State: AOJu0YxD2KR+mHl2UYZF1sEpQhdkaNkyFz4Yo/O1Yw2rqTGRj5j+HrmF
	/8SHODxJ0Ly176Rhk4qDsRKUHtOkWDjLYRSV/cOz/FqG7i1FdvFqhxSEFCwb
X-Gm-Gg: Acq92OGCwC5/Tq/rZIsOdL19GWG9FpI5JHh32QewCJBoz0VPdDanNwc9s9jmf9usBKD
	fETAwF25MCZAt4DkUj22P37wj/DOSUegusMNYnV+OHm6Auf0AOkC47SGQ7w0nWiJRBCxnCl2MhG
	dWGjA1ptVNto5pUTQF9QWWRq3ecUGlW3sn0FULHh503tO86FrjeyrUyMCDGEJIfciMj3nJrSwbg
	KCuuJOTMyHdt+IBYUq0UVg+ov/4tTLt9owtJc6hulal3OsTt+EIjWK+XTWU45v7U+4yKDrQq5wp
	grG0abNdbylH1QTnEpR9L4i1ybLlcMGMlaz3bnLsz7Ul2V2gk/ZjeE+fcqzIeni+c6u3kDveXLS
	aFEoYkfxpMkuW1hFZtdv26wD77WCxgnqQMlLJfpsmdS5C+2ulZti52kcyLyXS0/iEswTA0t0MaS
	/yq7ndI/XSNmYs6K0E7x5P2g9SBfNldyBfjje5Am8QH8T1nwBu
X-Received: by 2002:a05:620a:6609:b0:912:c0b3:7d99 with SMTP id af79cd13be357-914b46b8b4cmr2074645985a.2.1779707012536;
        Mon, 25 May 2026 04:03:32 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8cec5bsm1003947885a.1.2026.05.25.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:03:32 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v17 00/14] NVME over MPTCP
Message-ID: <1d2b0a92-67a2-9b9e-7f2e-31652d99f45b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 11:03:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

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
com/multipath-tcp/mptcp_net-next/actions/runs/26394440190

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0cc7d83d0766
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1100366


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
