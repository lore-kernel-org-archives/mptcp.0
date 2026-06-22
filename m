Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA32D9EFB
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128838; cv=none; b=MXUkF21HgSDgCaKcxeRQprdUsQrkqh7jj0zdLPBmw7qa5upAH09LaQcf41V3Miga4aS9iia2OAyZQd66Fpd04nl51SHEEVZaNmoG7Ft83tEBRcryhToEEd+ZykJxLDgdX5O2d3bzcXueA2F2vD+6EPdjNxZMTxoYzfn2bsB0lYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128838; c=relaxed/simple;
	bh=+mWQDy21A6J0P94Y2pM3iuSOaYp1KbzKsMQBS5jVveM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Bn+rA+hqNJHHWbN3tqWcewYcNFEX/T7prOdmalqS8DqYGBCIEVfChdDy2+rdFJUBabiokOwSj6kGUsjk57aFhJTYdqfFK7YHx9LArQNDf1wVlh6Fh0F07FyXlqvfxKrirrWhB5BwuCCs46H76ybf4nW11kdirG5xZ29MJzobG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYr5tfKR; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYr5tfKR"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-44793168d3bso310641fac.0
        for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782128836; x=1782733636; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHYeCXSKpri+jXLFC+6NwMNKKIxZZ2M1ENE21scXN74=;
        b=mYr5tfKRqdvsFJ8JsowcCGKYeqVMe1UtNu8XJUKaMXPKdrp7fpzY6BF+ueC6kEsena
         CWcgzrKXZjFC6lk9qeD9ZyjhLFMLL483VB04XYKueWInCIJf0Ut4nNOa0MY3cQ4bxwzT
         QqzKGBKuFP0W7pNd52J2LBRBmaDKR0zFLnjBSXHP76JBxWbh3tZkxNmYtq5XpYftJLxe
         8KG71Kj8K5nEoIZrmnZdYjRLJEI0PHG8DuDtQW3wJA2hEZRHMKcQ0Pn062ZrLVnDCg21
         2wl6p4yKkduQ2WZMf1/xIVsbf9TOUi+68attuvUPlJpBEeEJyCvRExUe0O3gYdVnl8Si
         xHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782128836; x=1782733636;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHYeCXSKpri+jXLFC+6NwMNKKIxZZ2M1ENE21scXN74=;
        b=TYZMK4BiYH+movlW9mptVBRwUtnFAsaHgD/MSfi7BzIs8JEh8024nBIdX79fIZSw86
         LnMuK95OMiwReNQcGSngJQA3zNcjE5AQ2+t0HZOs/rB90wlO4RePOXi3eXvkqannyNAf
         LPdUVTOxnZQ78xVqpey8LpVz3zhzVdj2o4IBmNGiU3BVQclSiEP8G781haqZa+EctruQ
         iiNln1G7N1t8AFZlSjnldXJIc0mmVoBjlWGEjhbvaZcF/APY3Wbq+zqV8wa5kvizGKT9
         gAwy0px11APT75jG+K0GE/5qHpOIyM1rK1bDqDcX/6lXBOJ/V13yG7RsbjomukbiJS3p
         nUFw==
X-Gm-Message-State: AOJu0YyZXmA1kR+q7fz78WUl5s3ZN0c7QQ5ieRdR1wXkG3N7xuzzmpgZ
	zFDJTip4O6K1p1q80HbF/QnvStK/kmt6HIRZ3IgmVSLF3FIC2J4MflmkTCL1
X-Gm-Gg: AfdE7ckmzPkqvHZqFSeT1M7jq8CiWyCseIlfR0aoYbCx0ow+xY+B/9IuBmV2yZgowpP
	VhcEAaV67l7AFiSCXITgLAT6pWzo8XfPKMRBvRzPBUD+oWP7k50+oWrzIq3Q0qRt01ARtDrJudd
	ndSt7W8fpx7O1hnByUlGj1+vgJ4Y+gvbE+iEYbqjvsWiHJdZ1JYYFPOc8LXjF9iHiqIPNqGW0IZ
	+fTfGdF0qj9R0KCI3fAgDGvj6K4LwECe31C3Tk68qtNk6tAx44ymVwuOdWeP1KihDTrmKoa7t3/
	xQ+BQ4v3OCWzJdNskEvZZh7yW8H5l7OX4OcBMlFv5+Knj9RkqE2XJGEi1nVRlyVLMfKGJtpaSY5
	uMHOmtPnpLT78WhBs2TSOeaEtOdsikL+1IqAhxlx8RuKiqhOYw1B11Cpc37amgrPh1kKDUa/bGC
	5WAEYvu1QgMtyvQ00DvpKX65nRTg==
X-Received: by 2002:a05:6871:7805:b0:441:29df:3daf with SMTP id 586e51a60fabf-4473245c6d9mr7764930fac.18.1782128836178;
        Mon, 22 Jun 2026 04:47:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.238.27])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ec5fd4csm5999877fac.2.2026.06.22.04.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 04:47:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <5944d738-b4c3-cc1e-9092-3330cb28d2a4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 11:47:14 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/279482=
60475

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4fba43978071
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114686


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
