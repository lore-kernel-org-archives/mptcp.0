Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C4369991
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511311; cv=none; b=HSEJlQ+VOhpSpAMubLDEveAkNKXgiRwLuEj/sACedKEflmaSqW2J0rUF4RTg1ElP6V8HbF9roSZPGemjd3ZswYrZbfig39w927US3CHE8tf06RM4tt+RUidiBYW7Akn4b8K6r+Cl35EthpyjOEHzRLqs0MoslQKMwoCeFrDQ9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511311; c=relaxed/simple;
	bh=lbVBU7UxEc21dWi6oR3rIsb5M2wv43+sQojPeGBWAKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LndbtCL+oPcPUxa9OifMn+PeuujCkGJKo3/M5SyTayQgK2q1QFlzJqBFKlQpZbBRd+mEXBH8A9OKhDWJ3+JaVDjD+QgltBrXMqJMMyH0V0OGkrtwK6J/JVR5x7Rry5p0TpkdvwfiQU5hsJsdBTKbjo2rHH7Sc/fbX8VXeV+PQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQAZM+/w; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQAZM+/w"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8568e3ed034so555218b3a.0
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511309; x=1789116109; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xv/h2tPKOZYJ26bVPTvoe4AlC5JrW+hL3Owx15vZDGs=;
        b=BQAZM+/wuu23fPAyloeKgqruKcN7cU8ZJKoxlo1rRpHCTJr22lDcbXZ+fXYTQPc92y
         UX46F90z1pddsayer0+cJFKykhGpYZvBo07x4TfmlyBsPzDv6HRGWP1Z1qegylDV96Sx
         PBos2TRyk98V7tojnip/9puYJZec8Jp0hCLBC84qQOAxvqzCB3Pi6pNunEguJSEloJa/
         X7uoAdalHoNjoARtki9tQ505bgXNsLkzo4fdK2APt+gYjZV0JNMgRhjCIhQjw3GKBJ92
         nhfdKhKDXT/0E/rgCYTUSEDGS0taiI89CZPLiDUoQL2BV++VOYJJGH1DLqWRql8yGBHn
         OTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511309; x=1789116109;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xv/h2tPKOZYJ26bVPTvoe4AlC5JrW+hL3Owx15vZDGs=;
        b=bFWfF/WtJTJAPvTYXW5PapPWhDuLz7iFjX3q3Ek9v/UW5cSOzzKZNxwNxQAYvqsTai
         1zI017UeaavdfCAsiTBJ6xTGpYzkkUcDTFbsUCCSw4Fc6z6sFgX/dU11QhoBiQgfwTbD
         +M9viKGITrerHMJY/El5az0Q1XagMZB67CdWz0ILWUvh6/yTcS2cjsxDzwkd2yYRxlWp
         TBtPbU/s9fdxt6UW8pNKt9k2/doM4QKb5GhYH+5jWTfrZ9wer6+UjVakZzA6MGVfkzcR
         lv205/TQlXRfGGfvfomTDZ3Gpvp6bSSKv0mAJDoWtSs5GfsjYuSAqga+EILPlVuPS+7b
         LYkg==
X-Gm-Message-State: AFuF++kJYzPS8ixfmqh9Z0Wv9r4KvkFc/4LJTaiXsAElrMln8376YlNo
	qOmDCVDICZD9P0jXf8AX96n/OIpHRRgXHxJrlD/4ahKrMiJmFtyv8pW8/1T3
X-Gm-Gg: AYBFou3MEWXc6c6YsY7toTJzj2LfOUKfhXKZnz9PnZfD+6HQeFdbcCI2UD9pBkL8mnL
	bRZJQn+P6eDXF5dSPEmwCsW4VeTA2Y6PQDuEGjQUv7C8rTTSqi6eM/sHLYg6Kw3T1DB5bjRCCij
	LbvOrGmxytORxnmCK6IjmoI1cegdEmBYHDxfEvriKvo/+qOxPHDw7MEOxeQCzjPLEnYUC4PVSe1
	c2Qew627kBo2CHq6ntJfdedceUiLqxBm71AtE0M6wybeZBR8QT0Aq2W1ikQkk4IVUOtq+bUpNyl
	+2Z/1xCnOls0Ua0G2D7mCiuza41VQyFvMFMLrheYm8FWYNBl43alz2WIYE/GoTe86vFM/5OwRK/
	ybnu793ssIwyLFZaUrTCdfFdY7uj3HmetVCUXIVfhwfgcoVrsbByssS1hqcYIv+Fy/zrFYeM/Q4
	rMoHT6ZdOZHy/bHV/77gcgCOsjCP9tcQ7FSlcMBRSuNj4IPc4mWLpeyIfeRLE1H0DvF0TLlJCJH
	6qWMsRCNLzIKA==
X-Received: by 2002:a05:6a21:a92:b0:3d3:b00b:26e8 with SMTP id adf61e73a8af0-3da3a17ede3mr7831353637.28.1788511309170;
        Fri, 04 Sep 2026 01:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf44ffsm4643454eec.28.2026.09.04.01.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:41:48 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
References: <20260904-mptcp_nft-v3-0-4abedaf00bf9@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] selftests: mptcp: convert iptables
 to nftables
Message-ID: <1b0291c8-2ad1-0bcc-4154-32c042094ecb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:41:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33850602816

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/54e93a0f92b7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157667


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
