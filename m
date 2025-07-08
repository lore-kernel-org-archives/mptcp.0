Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79542BE042
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988315; cv=none; b=G8BmolFuZZvyi5uV1rtI4AKzHiMtB5K4qsxe0s/StSj36n0RWOzOtCxsAeePRLYpoFForRXyTXeU12dUdvD0TPIx9nWZBMOvy5kgKdIxJ92NSmSY6hradE4J/RZyTat0G5Ve0t2+j/xkC6UGrVJrW/fX/fraR0ftF/bIjkFbcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988315; c=relaxed/simple;
	bh=9+LPd1L0Ev5tCAAxvxmrG7evD30kMvOi7tbzfaJ8M70=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hVxROsspUrWQzHM/dvQ9qnKltDPhQmpeifiRAu6D8lm7UZNhDprFpzO2/nC2IuzNubqRiS+lqjAON1YCjcB7fquCJLgxxqICq88/SsTfs5Mx2QfjCJqWWq3JBpzp99EIvpJ4wXrXktJofSZfgcet0835JAnG9iJ69FZJHf0crTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9VySlLs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9VySlLs"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d9e2f85b51so107647785a.1
        for <mptcp@lists.linux.dev>; Tue, 08 Jul 2025 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751988312; x=1752593112; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV0Egni6aExgtOHkmJpSpJh8eZO9eISlmV3l4B0jwD8=;
        b=X9VySlLseD321YWz1vGDXjy1/jCime0Yf8GxyuBYUOLTPysX6N/DXLY5HtLaY/ntAr
         Wr51OlMvYAdv9LOsTospO7op786mD32mQUspammU5S3XcAhm0qGeu6FAlELYDMr2X6ZS
         Ckm1rXJwp+JekVfwn8smEjcpOHeFdy4o9WxhXUY5BKQoUiDCp8swiH7zvxFdMp5/LT0W
         gwifG3jYq4HlhldNPeCiG3XTvEXWXfyhL/c4intH1UDPhqCM+83BK0viE1AoUUAwGVhG
         hXf6yC5ArLxnLpyLJkO8EUtjjWKqhLejeeWoY8D4+1Y/0qqUGq5Vn84ebJABB5LAqZTF
         TluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988312; x=1752593112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bV0Egni6aExgtOHkmJpSpJh8eZO9eISlmV3l4B0jwD8=;
        b=mI00HrOZeNBEaj08ATfrogJRxRdLamgH7rs0YtHoopcmgR+hTTFUXxL41aMP546SHj
         iTzkCxCDiCIcNjYnz0QpJeyM78snXXJ+JVwJxNuV5hIck9vlsi3bvicZ43MKP6ZLrwFV
         jlQX1dNwt/v4wd4YnzXZD7FrBF96xqo88tN+vfeV86NWK3GnGssWVabsmVyqiINjnp8F
         tzyEQAGkFq9yaRNU/wgcn2QDD9duC7Gjlv1H+k6MSFqKdrArvd+z+YU+eiXT2vsBsWp0
         dp2zGwPzs4WMQKKrrkEoFUBhbEPcVwSJJBu7pJ4qeFyoU2Mv+56PabQzenah5xKiwK7V
         0ISA==
X-Gm-Message-State: AOJu0YxK5k6EA4y/SZBciY+Ncb1vyXCTSmu4EKaV520FGCCFRGmbrZK7
	RUB8kloZ/1So6IspYoKWnC8g8yBmrmJDppxcPHR6uSvqxjuNWY7kEd84orXs
X-Gm-Gg: ASbGncv1cWP6Ubu6PkhKnU/WPtQlWkp7qyW5VBKagUQoe61M/fdmYsuIVXx5z+NnYyC
	zdv3MayjCMUXqRvhhJBR+wzQBT6gKe2zMo8hu+gmBaW+LYylQC4t2+JrbFvABI71cFbRH4I52wY
	FIbxh4iJbLY2MqZTE6yRPumzFtcdCLozrsW8QOXKS9PsiYUcjEk840CGjagTtCAvyyX2sEX1wnL
	r1zTZtNxe/wAM/AzMiTOLPNuwl0gPm4OJ/WzETwQMUvgkiQZ1grURul1SUz1/isN5HT60pOR0AN
	8qW2u02HTSev4nAHmhJPU/OIa6EY/2qYzew/WxWAyl9KAM+NXQFQSEpg7Cv2dQ+N4WVjxC7NAok
	4
X-Google-Smtp-Source: AGHT+IGBsWdb7nCA2LzeyxQS0tsTyQ61P3IdQ9/O7yvb8ISSDzfbmdnu8LPkbwN9eDm5i/4AdipyAg==
X-Received: by 2002:a05:620a:4885:b0:7d7:32ac:3381 with SMTP id af79cd13be357-7da016a9241mr591811885a.1.1751988312279;
        Tue, 08 Jul 2025 08:25:12 -0700 (PDT)
Received: from [127.0.0.1] ([52.170.249.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7baedsm792319085a.57.2025.07.08.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:25:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1751880561.git.tanggeliang@kylinos.cn>
References: <cover.1751880561.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/4] implement mptcp read_sock
Message-ID: <81f5d18b-5338-3c26-e5d3-19b22bfdad2a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jul 2025 15:25:11 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/161452=
95355

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/47721d9b7e6c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D979613


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
