Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078634CC4
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351385; cv=none; b=opFwT8XV/aomc2DjgQldVRfDjSFYgFqFrTtI2gxb+CbxyZaBeDfZn3Qw04uqwIcYwMkWAWpdPAdjVxor7RJNF3oWTXqqLRUq4xRK6DQ7TGD8AQdEQgydZstYcBU/FxiY9Ux072MJpHLvlvWzaJesAoNSbNPfjOJrEi2dhCG+Oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351385; c=relaxed/simple;
	bh=yaGkbMiQyvZFGzR1Vp5kbOIZH7rmC4BkSu5O00zNCHc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nOIt4gb7vmqXO78ukZPrrLDtVJRC8jQZjqgH97UCHxlVypUYBkx6HMmESNUAJS1xlrAqdI7OD+lJnh/LfVLu+igyzBHmwV4MTb8Z/Og3manqJZ4s/bNWXWQsSnPRfSdeZ796RF2Nqtw/07FhSSi+Bjaw643Zg0Ov0VMBUXWKBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXnfp6OV; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXnfp6OV"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d88cb85987so35052586d6.1
        for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 04:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734351382; x=1734956182; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AeBuTkzYtHDspmUhU6Qsh3MxYeVMZ98Dzp+otNSu1I=;
        b=nXnfp6OV1wzX1x50sDQkStQTyJXaPAE+2S4ExnaKuef+wGGPWerQegrtSou3ECBUdR
         Ri8qHXxiPbq7qu3CqjK/7djPn5ZQYZHFcLDXBxvSEAFrbwLPlQRWBJjpvLKHcOurTwP1
         4jIenw+7zPoqdIgB6XQaAT8hfZlDAgFEI/OMW7N3+zsWxMmlrM64S7Zw+tADCy6NSvTW
         u881Ip8q+vvbkFZeliVJYNg0DyRgQPSY+y3hWq3EgESjz2Br82aZYhISW2r3op6Cxsvu
         EfXEJwL3VC5lulr2QyM0VSOP2usULP0oBeFILze2ggHgH6OLJSH36BYuVJ/1ZL+Klwk+
         jfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351382; x=1734956182;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AeBuTkzYtHDspmUhU6Qsh3MxYeVMZ98Dzp+otNSu1I=;
        b=eJ4YguVf7tCBL0LG2GCKRoBYEfSnND9hxTfzWatfORtLheTNr/Rm3b1UHWOFDPmZIR
         dIT+jAdtBo8e9J+pE26g/a7sxrYW9X2FK86NLfUaYtM/549bKn85+KVw6QxT9zbkhf3V
         t3ba6G8kuJLDfLabf35ZHwQhjpQTJTxeOfhna1uPNgJdACuqveHob74sCtXdE9DkTU/j
         xWPd5nwyULN3cwL/oyqN06R03wuDLY2QZZyAPcG3gkvm/LYMGPmOe0MMj4pVtG9ZrWc1
         ijrXcQz7E0sxJeNJjLxOPcMa3byPcVTRBzBos1Wwe3avZklKnVqScUFF7LYa8nJgZJek
         ry4w==
X-Gm-Message-State: AOJu0YxKs54PSmoeww2i5iv94iIMCfgJvq40h2qrTD2G5i9ctzVF1On2
	I9f58DFvKs4a5C9OpF+LF7Ix/8gj4tIJkmrUXYeeJDsPsat5Cn0=
X-Gm-Gg: ASbGncu2iCG3gJDENdX0xp6yFV1/bonTqHJUDlFX5ulWFrUHV/XMvNpoqQKrtF6eJCb
	bxsHelQAWMZQ3UStGMeASES+Ue6KnOk4/2L33wt/1pYTtHkq5xNROkwhfN2RQE/6efGRcWS3MXM
	VQmRIWJPmdbGzG1GoEr5KAELNbzenf11xRek/dwmvy5N+Dx8OXZePp2ZAB9TUQGmGfdZ+rpRbW6
	2yPx0MHLo5FfugbhJ1PMlgKWfkKa6agjz1UB5EMDcTyY8lj4tti07GzwK3obsvLcoyN3A==
X-Google-Smtp-Source: AGHT+IHswISYaQejkkOMjPOeTsA5iB0J/uBLR9mVMYEh/lvyJJQvAfRBkGNjoJeFrjl2782FqrzyQg==
X-Received: by 2002:a05:6214:2241:b0:6d4:1d7e:bc72 with SMTP id 6a1803df08f44-6dcbeba8dc9mr227599716d6.12.1734351381017;
        Mon, 16 Dec 2024 04:16:21 -0800 (PST)
Received: from [127.0.0.1] ([20.55.118.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd37c82bsm26548916d6.102.2024.12.16.04.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:16:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
References:
 <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/3] netlink: specs: mptcp: events:
 missing and clearer attr
Message-ID: <f9ba31db-4229-aa02-8e8c-a1a6f05f156d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 12:16:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs-no_alu32_mptcp=
 =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actio=
ns/runs/12351088918

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0e0d28f4501a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D918161


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
