Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA67B1991B5
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962678; cv=none; b=iV5AqDrSO0br572GEZB5E+WVDwlDxy0OHDwoiMSWXVydEnjBzEw2exzNolLuaLji1v+bnWOnea4Fr0gBi8n+ZGRh+fCVqs0Xl7YR548W8/P8NLHyVdOi/NLdmvYt1eHB1Sd5QzSuvVCSmfmA1WyPrqov6zgfHVkrOdIHjZ3K/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962678; c=relaxed/simple;
	bh=hvYZPoksyJeSiwXW4sexulhuh70zY7e7laaItBuFtwE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nVEun6z5BHGApyd4Bn1bQjB1T+V+F5jgbH9Ku16mApLOx38IvfoPGu8e7no/nMhff/vzlvaPXJyB/81D2Hp4EAFCGS0Lc2ZxyiM7jeXRm96b6nqHwc2MeA4OZYhBjTyUGYY56oBQtvE5dOorFpHQzaiat3MUAPZZtadtWunhw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKHRUGis; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKHRUGis"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so3476857a91.1
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725962676; x=1726567476; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4ZR6b9MMDPYQ4UKaopwlB8Li1ktOHkotp+HZeJsqmA=;
        b=VKHRUGisGJDugLdpY5fpwX2t9SBT7WJVwOBBjQuxUFe2AY4ZCvSU8jKr+Coa8M3csL
         4AyZuajRfcq+y6u/I1LzVnJpOv4gz+UZ7S3+QerQAUD0KqQJjUf71GOeH3ImB8lhH4RR
         gYHpfaHH2kJiKbJG4+PiswMLMVGpScTiFJrqpojRTN7piYpSHXHO/0czdX0N1WWd8GZU
         Sf3+gamRNGny80Jt7AmUN/JoFCjyTvNmfaB4S54V53OI3yPFJ2I2HNEB/CzgkmUaiJwN
         c/rS/eWs0KaVPsMHsed2FmmtIAgzNk9oInmcOvd2ROdDJRIOBR8/9oghNF69Qd0t076D
         Or/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962676; x=1726567476;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4ZR6b9MMDPYQ4UKaopwlB8Li1ktOHkotp+HZeJsqmA=;
        b=Y2goxQrtijCO+ALV1c+WZUn1V0Lj2Hq1ShlGuniDAmY+tQt9sqXQa/QHZSept3Gfts
         i3L9h7VhXbcnDaA2Q7tD0S64WRf5BTtM2vEPh8/H0MC1znddxtw/3eJaA/65eT8yxwkG
         tKXVqdzQQBLe/B9tNm7Rp9UdEZojelcb8WGdZ1onDrkeeR8ZuGW+vkrMPjVddo7AVL+V
         H9/82/aM4rnHx0xCb8+AMBVSYMBwTkmW0IUPB3P3Rr3wzXRpl1eIoxfQMVzNaR4MCW/b
         mMIqSzmL4blvGlJ3JSq8c6wCEp6vWD4zUXEoWB0Q5MBBo3ho8trkULuJbKu2/P0E4SN9
         1Chw==
X-Gm-Message-State: AOJu0Yx9q3/KvL3pwDxDkhD9IpsDDcO/2Krgkvz+L4SibBCeWb3txU3c
	9bGRNbVDSxqeJosUThbBH5Q48KFVvAMbqcsdfMSez6IED2S1kB3m30Q3
X-Google-Smtp-Source: AGHT+IH6+yBnUesAHG65foV4IoyjAWDHIwFZESxbjNORhrnRbflZE5UESB46LW/UFYTCfhsGZlc0Jg==
X-Received: by 2002:a17:90b:1c08:b0:2d3:da82:28e0 with SMTP id 98e67ed59e1d1-2dad4ef2197mr15235224a91.9.1725962675770;
        Tue, 10 Sep 2024 03:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.29.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12a1d9sm8067717a91.54.2024.09.10.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f27360078ccfc5c9324d2f2fbd3207e3bc553b3c.1725959373.git.tanggeliang@kylinos.cn>
References:
 <f27360078ccfc5c9324d2f2fbd3207e3bc553b3c.1725959373.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2=5D_Squash_t?=
 =?UTF-8?Q?o_=22selftests/bpf=3A_Add_bpf_scheduler_?=
 =?UTF-8?Q?test=22_-_drop_has=5Fbytes=5Fsent?=
Message-ID: <f7c7385b-093d-8af6-17e5-02473ae75595@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 10:04:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10789624804

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/47676907625b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888786


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
