Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DC188CDF
	for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087618; cv=none; b=Vg5pCrVxfuHWJIrA4+z1uzajF6Rhiv+9HQlDyNBgjFrgyFsUQOxNOGKgXROYR9ArIGEWWlPXrxmI1S2hd1TtC4iXrqZZ0ogHeiwEKm7xpj4Nz5tGW6G73KHx7LgrQIttWj6yNlYVS8YJiJc/f65ZS9/FCYYqLWvi6S4ueIluZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087618; c=relaxed/simple;
	bh=bR6t6azTF6Zj+hUvWsKgiLCBQ/Lre+fikTL5l5PUhpE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SuvkPPB5aoJ8aomnGEiOngXGyzKGV/d3aJjAgnScK0DDhpKrsQpoip4uVl2tYRw1t47BMHiSHmcCflyk0fSVmLtT4Wo2hW48ycnCwmeiU/lMMeFKu9pPNZuhStLjAQDl3dOH3oEaq/BKyYsTUN+0lKRz04pR84JzobLZZIEHgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4uGZgDN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4uGZgDN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2023dd9b86aso9097985ad.1
        for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087617; x=1724692417; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYpAD3pIWA9uufJX7Wfqkox0QdKAlwdsr3j5aFMYTBY=;
        b=O4uGZgDNF4PmUV4N4LtvqYlpcLuAQYenA6pY5JQgpyLptF5+xVXn2ysN9yrFtXoqkd
         1N77Ruw5H6MZ/30I2/f59NXppyjqhi1wxX2DAU4FmHLteTDlDMTqBhFlS1Z2sYO43BBi
         46fxziBPDvIDmG8TSd4OySfx4Eh9LEKeUutqDDZ0iW7OJcg1ecR+5JCl6UGlv5a52K0G
         81UFIHBWqB5IO1WIfbjsUOhJ2gt0HKNl3xsnLX0IfxbmgZcrNh5ZzyTXmPzRfdDEOaNo
         RVUNmm1aTO1T7WASyhIchgWxQA6loGYXKx4zzl2D3sF2DjWsY0y1PTS+u0FwnJ8UBXeX
         cz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087617; x=1724692417;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYpAD3pIWA9uufJX7Wfqkox0QdKAlwdsr3j5aFMYTBY=;
        b=QgdX1jfziO07hhz3qsSKAHp+4kAi99kzyfvNq2z42sDQ8+UxxIcHa9eXjQxFcOk83t
         75WYtG3DeYD/9IZ9LJXbXOFe7gwOqEhXfwgdnEkch9xHhgTn9UBhUTxMoovl+EN5xXTq
         9EE/Tjph0IBvcoYd8vBv8uCAjp2zBOpPjGkCyt2F+4GgPVOSyLo3VojtGbiPGV5gxp81
         OMrvmS4kyD5P3FF2DPXsHsQNSYn5+6cAY2tLHDCki02j3vC3wfdage8LXB72A3lc3Gz7
         9knD2BgAST+Cq7WRrfpxCl1htv2lpGLhOZhqFQ6tswjuLe3Ln+Phs61YXVihdcLs4R77
         v0iA==
X-Gm-Message-State: AOJu0YxzrttfLQTw/AWN2Hgk88VJXSg3IZlvT2mMhS9qMFcNJdUQLcxU
	8RM5TrgYMwa9c56wMjRsNPsEwN6dvs05QNqObg00g4PJrcIpBwPN0UkR
X-Google-Smtp-Source: AGHT+IHMpxzNFOeiS1ywt/Wb4TDy4fwp7I21nwrpyPreYb0e0W0NIGgdzTCJHu7sATS4KA6/SiUw+Q==
X-Received: by 2002:a17:902:d4cd:b0:1fd:ae10:722b with SMTP id d9443c01a7336-2020407d87emr94172395ad.63.1724087616586;
        Mon, 19 Aug 2024 10:13:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.38.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fb465sm64642195ad.51.2024.08.19.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:13:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
References: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: remove
 re-definition
Message-ID: <bca0df30-3a8f-86a0-207e-cfd53eef2637@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 17:13:35 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/10454345821

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d1fc17f8aaea
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D880916


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
