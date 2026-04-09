Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9113BB48
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729210; cv=none; b=Haj+mQwL02geE/VR9areDaW43Le4WOStgVRlZea9jCphlJgy+64Zja4fmPXmMDhi5+O3d9s1pKmr9dVfly9YNRZOqB7ElCfUzW+BNQRF24rpimBmMiui5hO7HOSssyzmx48tOVVCn87Kiark0V+W6icv3Nwr++QeSfdPHHwN2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729210; c=relaxed/simple;
	bh=Zto6b/U1YiXKWIxJTHpphNnA7kBCo5szuVTI/ywNEzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=N+6BfEcoLIfI2+LqvgXUxXlTOzqEh1MmENg3hpDGM+rRWEMAns1ihz5KO7aLp6+vbHMqnblFKz6vgt4hn1VPw/OamzX5MCjMirlNNL5wkDkh+ubnvX+MOqtGQ/yRnxlN/u3N8Fv882pTeyg9hPhmbnSGYd2I/sovIV5Kxu+bRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hby7I/Ev; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hby7I/Ev"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c70b5594f4so62908485a.1
        for <mptcp@lists.linux.dev>; Thu, 09 Apr 2026 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775729208; x=1776334008; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syJdBbbPMjm1fP2luJNc2cfAckIUfiDy2Q/rITGElF0=;
        b=hby7I/EvDM6lMJ4u0fvrUljSwWnL5eH9IiODXmFXW2AJGaTwuDiCFetkloQJ6K1u6O
         ilamvkbEN+q/oUWxftbj8jc526Izh30oyfF8OnlObNsrKkckgtydcG7voB2fVkFl/F5i
         EyRefCdlRPc2Fzh/tMeX4DTdqR2b7MGd5ePRE7FhcpdhvmuFQcH3kUFxM8OEmg7dm6xZ
         2fFbyD/LeouD+5uLk2ZAaTHMJmKXJU0EYYj5GG0ZyhjHH8iibZD/n+BMFeFVlbW5qemQ
         aqZzExzYJjU+x/kXrWqjBObzB7fkuX/MHcPNVHG+uFCSW8uwDZnir5+CLi1zajxNZs2c
         +T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775729208; x=1776334008;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syJdBbbPMjm1fP2luJNc2cfAckIUfiDy2Q/rITGElF0=;
        b=TVXzgDu1Hcf4Aks6u1N9nnHZGc0wSHauBU9DKQyLXFDIRhREB7ahapmDANz1BQqluH
         9ZnxN0DI1GqMZQX/7emTUmKxa9ytCU3Y+RDbUmlWyyvaVJEq529Xw2BCM87XAr/to3/S
         KBo1NkcIU5egEPxo0+eLSIFhND8NBjd3wLy0h0K7P0/W4sjyCbjek2l+DzsYF7yDDf7m
         bXRVH+iYhTEXJBk0tFVH2YHKOF0Z0B4Dv80mvmG3trNmkdE2NlmOg2R+4WGlXQg9lXFp
         5tNPXQyT2Y3cIhAnzYI7jLwfAqrrDLOfKEeWRlw7F/wVby0KAbHR5cdyM3rifFRNR5Gr
         P31g==
X-Gm-Message-State: AOJu0YzwjZlLv9eHoLrP4t8zj7w8Vp9asRPgtq6Z9+1H91OhRAig4Dtw
	5Oq1m/H1sS2zfjXIOfX33zMdgpo94Ft5EmFNfsvtU+AdbnMbWRzIdn8Wf41B
X-Gm-Gg: AeBDiesK5wc8zT0uBg1uH7wFvpilfhzxQzBKkKlELMj08PZrcBrSB27YNzixNkfflYX
	FrdSUWo/zIaZhLRX6jt8jYFp2Hq5uh6k/Ntf3OXDiS7N65v1kto71FxwGZujoNQLhukm1q4tEqf
	P5CakDQlcDH08DBM4j6Kcy7/fdLBoSzgSDYJn3ZSZLIEjaEUO0eD1xu0YfqZxpG40KJ3X+yCXie
	zfYoPALsJ1wbdD7Rmly+Dun/iuVB4hd0qRgFHCsvzpb+iR3ETlQuMvS8jnIPJ7tB3ZpbI2cSyeT
	jrUj3rqjsY9MgfU5SCSP/pybXIgO7xRG8frJFA8SOD/SEQ6hxy6d6UgwKnRHUK879JzFYNouT6v
	69+1xYcUYlgaAV86NMGuS8uuXINDf+RwOAKqyeZ7ukM5dvZCptM75vbSB4CSgADb0nXqPMvoMyQ
	bljDQSlxWVXLbSxFf+fRK05qq8p6IVVxedbtMOFg==
X-Received: by 2002:a05:620a:7084:b0:8d6:d217:96a0 with SMTP id af79cd13be357-8dc40837ae1mr363307985a.0.1775729207648;
        Thu, 09 Apr 2026 03:06:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a864b516sm1807349585a.37.2026.04.09.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:06:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775476921.git.tanggeliang@kylinos.cn>
References: <cover.1775476921.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v14 00/15] MPTCP KTLS support
Message-ID: <364d0d58-59ca-409c-91c4-7c85a9ef6ccb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 10:06:46 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug (only bpftest_all): =
Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/=
actions/runs/24181709364

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6ce226e90a=
50
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1077649


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
