Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA892305692
	for <mptcp@lists.linux.dev>; Sun, 17 May 2026 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779001638; cv=none; b=I9XsgHclaK2+xS+bLp0p4HiXt2EkPPuWcOR9E1C2Vij6XdMucoLgrbz9f+cBt72DjURxbOfZjdtt2Chg8c1bmuwM2IHM09nMDEM4B2/1kw3uGhXynFghFLpDcR8j57VliuwmGCP+3f+W240Or4PMQMa6nnG372YvZqfJp1CJ/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779001638; c=relaxed/simple;
	bh=y9Jd4qcgZgVbem10JHQBCxZ9rTS3U3QvuO1ojV/9HGI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=c7j2ZiRbrYTPQJHM9KWyztpL9xgvcydMtaYbjyYRVaHRfbUneHteRQtR5zccslgc+2mZp0SFO2XtsLRHe+AumKPBxPZ07dTJtecQLlf/ld1MoHM+GxBthTBBm3bDVb0xFP5kjqYuSgK5yNZNnPfweViC1dW6N6vY/EFttnWfYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBlTPpto; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBlTPpto"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30246cfd41aso2669051eec.1
        for <mptcp@lists.linux.dev>; Sun, 17 May 2026 00:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779001637; x=1779606437; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5uDEYt65x8L7xZdywYlEqfzp0Jh2tDtxTL3czwArAw=;
        b=RBlTPptoJpezRcblOs3f+4aL2rw9q0eLC9NMui/YtWJG24xdfl/iMOG4xnQJP3Qo+i
         eLZNATkyHhO82wPKlBc+WwqYjPr85LQhX/AkCu5ZqnexueJkSMkvMo2vzYlNpwSneVu6
         MQdB+Hcv9gnGyYH6fFqeZ2DTGc7b5uPkZ2DtJt0LFEOasUelySAVzlA5vuRfoNhBoIAH
         PVmXSmxiA2ehOgy6r/nr5drR6ZKK1LVYa/7Ousj2PYBH9kFntY2r2Lo4+HAyRcuMpSU5
         qiTzZQ8mK5ifSh5+IM/0cjXjZrlkoI4AWsNU6Z8IX6N5EZpH1OzQ783kg3FIuX9pfb64
         EkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779001637; x=1779606437;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5uDEYt65x8L7xZdywYlEqfzp0Jh2tDtxTL3czwArAw=;
        b=Eu8le9mR9Jl1jjF6+XL/wK7N93XD35FBu73f/ygsoKTB2x08cHhiyKhz7rFoyFfquc
         V3/UJFQBUJL66NhMbG5VW4kD0Ytnthzdyn2v8xjITq3CnDMVXtZgEIp/Hf34wErAlF5D
         QXE00mPEz+71vnzN4h6s4oLQMtVClJssRguWaC2Ej8zx5tYv2T/SqPDPVSdpgh0QOd0f
         2z1ahp3oFxf3TR0VOCs5/+7qw+KxpnHVsB76B/AUptj2ziN6qZQkjaDs1KggxNjeDPPR
         aBLnYvsxW4Ruc81kXSnc0XTGvLedm1cKNyGQg3MTt1DZ1omLkSrQFyAyIIn0GMmiKh5c
         isQA==
X-Gm-Message-State: AOJu0YxSiGdbPgyGFLg/kWHJr4Q0rjOzVw2vMFouDYKVN1i3FPHW+y3q
	aEfGYtBxGe6lB7K/ixo2/76sgqNOnBHl1SLsrRuKM72n06+1Yp3PANKg+TDD
X-Gm-Gg: Acq92OFxHhB1/9WUx9L8eFysDP30XK7HyQxa3MZdl/xmVrQTgVCYzetecWd3cnHgQA8
	5WHITRXWqmtDeOEDmkF2l/z0vHSqpYNjzg34kuUZs820CNuikWG+MbQ0FSAJHx3ufUpFd08Nq+d
	UWnfX2YQ5a6M9S0714SKWyWIfPQFZkC4o+rALxmuDFlPCfrZk0bbpRDQVqvZRzZGIkkSHfucyUu
	XKwWbBYrvAv+VlAOWnDAfIujh73C6AZHU3QmlrGZt2pv8/qKblmMtYIyjIOtZcPYGee8P5eEO72
	XVF26kdKa3q1R8B8auhFHxHg3kBLmlotdrZ03z6R1aVPEnfPWUg6Wuz1X+oT4R/2qSbWp7s2NEp
	KURAOZqSv6eqTj6q/oKSejiONYuHJ4+PzD6jpsHyxZm4Vqzk7AY2aVwRDj1rxqsNHpe/XPHAH86
	hpVJQOP2XSlaodjV11L60uHh+EsfQWLbG6BRlh7N067D0i0b0=
X-Received: by 2002:a05:7301:3d12:b0:2ea:5057:a304 with SMTP id 5a478bee46e88-3039818a65bmr4779240eec.2.1779001636666;
        Sun, 17 May 2026 00:07:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.107.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc8ddsm10879895eec.21.2026.05.17.00.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:07:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778997507.git.tanggeliang@kylinos.cn>
References: <cover.1778997507.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v11 00/10] NVME over MPTCP
Message-ID: <ac7720c8-9b46-6a2f-95af-f12058c79442@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 07:07:15 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/259831=
62704

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9ad43e390366
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1095977


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
