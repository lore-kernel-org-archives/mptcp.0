Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C11F61C
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611177; cv=none; b=lW0VJa0QBuu5HGa+K/tpOe/IRVo8nH2spzFZtKTqII4NvfCpRAi9Sft5D+FnytyZAKRWubfhUD9mqqTncgf1syQ9vYhunjGfpC4iFyb1G0hzAx2AjwuQdMWUYVGcl9wCnDGofCMVaZbgcT13cNTeE6rLDjIz1vmadd+DLzeMz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611177; c=relaxed/simple;
	bh=fOQJISY1q91ASva5rF7vjN81OwUlprmsJRoX1+HIMV8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uOAjBXqbMvax8t6jqFLHbDHYIFLlDL2Ex0Sh3NJ0Q+hGeIxUxRK23aUKRWYrNM+mhqLi8SnaVnELaXVT87963vmDJMSWVYaVgAjZFqYCjJbeaU7yZ5sldlZJt1vV/aAJ3y6+jNhI6CZsDwmPixm7S+l9Mzx5F7y9aVBIiPD8ekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP0i4Oa/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP0i4Oa/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ff4fa918afso15323195ad.1
        for <mptcp@lists.linux.dev>; Fri, 02 Aug 2024 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722611175; x=1723215975; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXCDQCfXSU1SmDgGr+3yhoPqF3zfcqYkyC331TwxRuY=;
        b=fP0i4Oa/szK6lTWCGyVCLxNcafjkEgPzxkqoDsGqYC+Qwb4v4PrExZRvHjqSL+IVpt
         qKBxL1rk8WfPhQbhA3qYY4kSXzVD5CGrnhOLlxIxhSMVo60Dt8Odz6yRj94hXxRR8kox
         Y/O4cJBlnNAnIPhSftjG1IMKTKL2vparfGLFvGeGWlm8QtYkPJXSIwlxi/p40PKbODJy
         ZmQCTyIsBJQ0nPteYaaLy1YlGZnv0J/YVrIzRmNco/25kmyv5FcO5dzLbdBBerdriDI1
         qfFGyFqQDeoTtgRiLyffHMfaAJClJDYwRkYB6FMeyM1k3WNHdXaoFi9e/evfIc54x4mF
         V5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611175; x=1723215975;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXCDQCfXSU1SmDgGr+3yhoPqF3zfcqYkyC331TwxRuY=;
        b=D95Ru6M+/ablRmvSXC5+EQEZmGpCR1imizL9a9CMYyQshaVz68mq/jCAS2uad6rkX6
         K/DwmTKIVJi2kP1Z1Fx8tc5xR8TAb5BqSO/k8lchmIeQFBSekts3e+/l8IkOJUa3xWWE
         JQc2Ii8Afz1TEnPWvYKhx50ch3CKCpV+rNalxhoqR1hLYUMDc5d35wYHZyJ9UweTID2s
         w9XbltZt/bV+46lmoy4VtYEqpWh61n2TfrsEDjlOeHgczvBMqFviE89U0ABdEhdUlJLu
         Wi31yCCOcSvLUe1JJ55A7hHNlPlzBHAHbBMu1kuxBjUiKH2N2XgMa3d6xYILpVFqyy+A
         87Cw==
X-Gm-Message-State: AOJu0YwwSBMQ15jHD1bjPhBNRs+ZqkBSOG9AnKcdj76a6mnIiWwGELtX
	0IWGS9VKZQlCgrX18+jd1HjvYOpMtsZmJj3cJlcetrHBF3owYlE=
X-Google-Smtp-Source: AGHT+IEfJ+fiqxwfg4YH1mcdq2BJYRkHGP4fpVj0B9RsCuD+jHXkb2+hYRg6RJqDjX8ss/f1jwPKaw==
X-Received: by 2002:a17:902:d492:b0:1fb:8419:8384 with SMTP id d9443c01a7336-1ff5722d6e9mr47658985ad.13.1722611175132;
        Fri, 02 Aug 2024 08:06:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.76.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346b7f5sm1220633a12.21.2024.08.02.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:06:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
References:
 <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
Subject: Re: [PATCH mptcp-net] selftests: net: lib: kill PIDs before del
 netns
Message-ID: <8c203f3c-112a-a268-b7bc-39ed7bac7b2d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2024 15:06:13 +0000
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
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10217280630

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e914241fbfde
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D876244


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
