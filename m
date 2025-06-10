Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118692BCF47
	for <mptcp@lists.linux.dev>; Tue, 10 Jun 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565696; cv=none; b=uR+XMHLaKIAnD60uWnw1uckFn5Rrta4UbrNGJ0hmPRKQsdiSicCekhKKMRJh2607tproKXM6TmO5rXWlFViANMGX1FnBFwAFxv6T1Pl1MD7u2922N1RFS6+5TCWUuFpRRux9gy7ixqTi9w5CoLxcBnQxvKq6/b0j4JTknXpyRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565696; c=relaxed/simple;
	bh=I138ihodNGpSsYLgz75QoZxhMFu7R+oh1GNjRvmb1P0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KSV1I/63PMIU3fQbB7DRRLsZ5j78hF8eD5fsOWfRfej6N34kBSHH0Cdj3J3+7HSiRt18WlLwf8d1Jy/yAZeOXL0i9Gj0QGnu3Vpp9SmMH9ZUtrl6xtL5XSmV8U3u83wfOC7OEgkBRZxjXSc9RIn+zcUpwvdCtkTCJX0tHUa/FcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3cCbd5w; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3cCbd5w"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d09b0a5050so334185285a.3
        for <mptcp@lists.linux.dev>; Tue, 10 Jun 2025 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749565694; x=1750170494; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZQ14lH68dSJqxgiGd0CJkOAz2vWLZ3VGoc9lalBX9w=;
        b=D3cCbd5wJYIyaERiIRpM0qckQgCAX24HvTX/cHWGY79oMqQctXrRSiJG0Wyc3Gs/Vm
         0WKy+L8blukHnVWorOp0sFfy23t8amIOhf3niU2mS8nzRzyLbbR17ePlQqOOPhsL4NHY
         6qzs6lM2EICRudKbq/hSz+2PrY9tY0FhD4bmOeW9W+7p+F6t0ps3BXe7cRPagm/+zO2A
         FudcY4lZF69NgPmXY/UZclgUKHsNrw/P1iw3Aw3qTImL2+7l/ImNbAW3lvcis8J8oUu6
         QFHgRrtdXVYFaE1scNHQJ50qo2ZP6rLtk8GAxr8EoCW1VJGjuqUjCGUxH0V3UJAS5Fl+
         KBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749565694; x=1750170494;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZQ14lH68dSJqxgiGd0CJkOAz2vWLZ3VGoc9lalBX9w=;
        b=nhUfQzP6CVe76KQ2O+neCYwbBp2hkQFf/8U3UpIrQSlXP3Pq0XpFAzxwS8q8Ja3DU1
         YhjrZxWI563aNu61UWRJJvzXSu2Gx44zBgqyWwyPMcpa2QN06Mayl3XXPaVOjV/11SMY
         cwJDdJn602Sg8807Gm3p8SECtFdrGleZY38lwTojdTMmvIKNv0QsqqdqiFV1qXIa/FCs
         p3ltQvLfXeEE96N/pV88f62oAhNTFZ/CxA+djWaxKxypIMFkn/ZxbFu6J98Gv0GAz14x
         2dvaA4UNBdXE5Qy6Vk+lezBHaMXb3Ttb7YUssdEzRRpBN+27i61XvrtwWhelACGiNpFz
         8ejw==
X-Gm-Message-State: AOJu0YwTrmC97+ZEkLVm6ctqS31D0Bu95k+EZ7Njg6/PzlVQBIKjbPkW
	PueYljIb42mjqidMPqMQS5LmKEWKvRH+VGjjSaYZPfRwrGaUR9/aWlY=
X-Gm-Gg: ASbGncuJBuvS9WPVWoqsQljQd1mEtKtAkpUYOQazvJH7mzn7jJd2j0/SFisCy4Wvr5s
	+JXcvqlz0d2TkvLFW5hGFhpB3TGRetpY+MwmSH0ixMeGn3aAVsM+DuxZIgmEXuM7vVKqWWoaS6s
	faNfiPgav+0SLq7haeWhhxbWmDdpzlcoBwLp/p3nQj5KvPrO3IBTJjb6NHp7pcP6bU2ifvG/Z/E
	ENO3uGac2HeRlwV5MKJ6VQ8sHvSpAEiWoc/mk8jhhxVd82N1CHSfEPMOVy+GMSLt8iPUcqWQq5M
	mOrHhBIZFkpZZzP1Q8As4sNDb48hlB4KSONnvw/k0K89xEtfRYCKv3lDbhxOvpz+5ZutUSm8HdJ
	qTg==
X-Google-Smtp-Source: AGHT+IGdz/RFo4eASlDvZNBd05kne1y2IUgHvrdBDdKSQO0rEfv7nHlEs8W+dGgkEmj+32HOJRSoUA==
X-Received: by 2002:a05:620a:24c:b0:7cd:92:9f48 with SMTP id af79cd13be357-7d2299cff5emr2095117385a.52.1749565693719;
        Tue, 10 Jun 2025 07:28:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.213.203])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d250e70898sm696729185a.20.2025.06.10.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:28:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Subject: Re: [PATCH net-next v1 0/7] netlink: specs: fix all the yamllint
 errors
Message-ID: <8616dd13-85f0-aade-697f-f914fa9003d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Jun 2025 14:28:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Donald,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15560674628

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/86089489f3c8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D970350


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
