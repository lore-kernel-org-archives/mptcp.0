Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DA482ED
	for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972858; cv=none; b=FPZRIqggdZ6G+LSZSSjNwOypMLwnEMLY5ieEOO/mKlGMnV6+h97j5dtNpqfqeABPwTceH9Gn8/5u2heimPo6BpxNoptawoDbYCJL47wmuLRNsDBzoRD9hs0ybTzlduEr+bRSfzYvyL5dGWNn9VidVB4RlUJBKY1pT8P3FluDOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972858; c=relaxed/simple;
	bh=xuqAdhWc6faAQF4X/idhZNTkPxO1cltOVm0TKbi0kfE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UvTrE/9e4xczFmTgzFTe9IKhBmYyh3gpFFvVY0glICCqN3bb/YAQAgMXQU2bysnMa0vb6s+28/BBVDHZd1kAZ/me+F1BAC/oTT5UN1fKBAClf2HtQFO+TWh0TOx2PrktkVMQNaSVwqFEhIzrJv0wNSkVQ5uwKdmyAYa9HSiJzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPEydPT/; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPEydPT/"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d24724514eso1121004b6e.0
        for <mptcp@lists.linux.dev>; Fri, 21 Jun 2024 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718972856; x=1719577656; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD4s8in15DNHyj7RPYlpFJL3ucewwG8hrjYDlS//nK8=;
        b=cPEydPT/K3H6rqS5INRZDweSSiQfbd+s2yYNgIB+1nMDHt2rvBQtsIs3i0QLjcH+tj
         ZXWv+LDZvlMy5aVRA59uUhxzaLbLu8bRVlBUI2H+OJa12d4hkbtUlK2Ayjfirk/yCOgM
         IPdVJemszxQwRYhaNmQywISffyZJ2Tmn92JvKD3MfWkL0Gkln8eIiCwTUsvEKg6vaXQZ
         xVR5GoAIytV21HVwBg/3ImYzgrIC2CFoO4qYGPsBZIWGf4kkySDc2zO0abfoQPZIDOFd
         AAsFiq7YXI8cuRTtU9C9MULN0gGtHHBXWaQ4hzRcm/CQnNOTpmeJFqq16YjNl7Vio7FZ
         05EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718972856; x=1719577656;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kD4s8in15DNHyj7RPYlpFJL3ucewwG8hrjYDlS//nK8=;
        b=Ci+rBhKpjxVlz0XJEFjB8Bp3H/fQAq17g3ONSo+QXJogaIoAIl55rtJmUYzEFtjbq2
         ud6UpB9xYJBIkxvrAo5Vzk8VCzTUea2ogEn/LPXeljmjV0Cvc7JagrR9HVPqaJhI+KJy
         q2XZCU54anKWKpnODNVkiNvjmWG8rQoTHtnjWrMFj6iqoquOBdiSNQBuvrva8i3bYxAP
         NcY+qAvSGmVezUc0kbil7U2tvxvV6/XLh9gfLJyfR0+MaPN7zSAf3cd3YfPnKL2zafJe
         KCKKcGUVFKiGGYoh57vAmUBEX+8RF8d85p20/gLEe6I2oSXyArQnD9GAtrm3D3DRsHu5
         uZcw==
X-Gm-Message-State: AOJu0YzEh70hpCSoRo9+uzb593P3yCx1riOfp23RkP3y9I3vMXTL+YxJ
	2pu315ho5KrDNIBvdrteDoA1Ndu7LbNXutcZ/6L48VZFj781BhFtdEzd
X-Google-Smtp-Source: AGHT+IE1kIq1mOha+CIbK8TbmFxxIgmC49XWqTLrIzNoQE1iy6by5wm+hRr1Hs07nFQE5+cPLMz1OA==
X-Received: by 2002:a05:6808:2022:b0:3d4:3d71:1783 with SMTP id 5614622812f47-3d51b9e3738mr8655974b6e.33.1718972855931;
        Fri, 21 Jun 2024 05:27:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.132.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b6a679sm10591411cf.29.2024.06.21.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:27:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Message-ID: <79fc508c-bda3-9860-8415-bfa3d19cde8f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jun 2024 12:27:34 +0000
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
uns/9613128523

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5b1c305d4d2d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D864250


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
