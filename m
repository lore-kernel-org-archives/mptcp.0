Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD12D5C8E
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052299; cv=none; b=gyeIaK7QAKp89Z5WpkQdA87unynVC+eRanSfMdV0Hku7LC7DnZTcX4QydXtuDLNa/XKBCDxnC6Snup0Zgp1u2FJriy9k+y0E9b56QITtS/apxEMMdWmZJmV3ZXuwcDJhuJj+f6dLsUuzw3lS+WDs7Sjho2rXJT2x/gwQdqtqbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052299; c=relaxed/simple;
	bh=/P68g2zrVB7WYq3RAwi7kaGcD4aK4q2HJE1NBm1waNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=rMVHoUTJk+J6ftKElZWiIvplEP5qmzyBkiZ/U2UroXZ0+hTAvSxFIMg05cyeuBAdytU/Npa6OLii0rbyEeZS46nZZAhHpYDQik/nzKkmF4nDF7GTf+tCPbBlbIrjs+Rqx2rfRk/18WtrTYuDUZ3A8kgm0vx7Wv9kSE4+9v8o6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlUl0t1F; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlUl0t1F"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-467fd082ffeso4329394b6e.1
        for <mptcp@lists.linux.dev>; Wed, 01 Apr 2026 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775052297; x=1775657097; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVooRHZVVVUd09nqcvUiCUVmW2iFdjd54bXUDiZhs1M=;
        b=OlUl0t1FVGglU6jM8l/OrIP3zGhFz0K00Ia1fUUwiU48GgBwrf156BrcLjl19Lnvib
         BlOGlu4MNnpHxZx7UurktpszYkKcQmaHQhOvAHYCucLqKLklpG88kseL60hRsdLQNaG+
         rkIbs+IBIWwNnwlxGGhO2CREe5Ykxd/nbQWeLu0OdYw4s/JlW9AGxs/yZZnUZKqro/eV
         me7UYdSbk3ZgeeyvpNoL1zYDoABeVgfgD5EC8yERn+LwL/LkRlyiByCYuILgpd5ubm0j
         XvMcRYLbi7Q5BCAnMiwD2ZD1lR0cZcb5L2WIdpbiOkuUAjDTSG63isseE9MFvhuKkhBj
         RUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052297; x=1775657097;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVooRHZVVVUd09nqcvUiCUVmW2iFdjd54bXUDiZhs1M=;
        b=iinn6T18P5cdTYax5qWtW3UMqyvxlZ3fzeSGZc+4h2g/32iQMZSVZFPNO9wysnScqm
         wWs/H8gtVbWObf3n7H7+sNfkk3EOLBViYLAADCOXoQKeOMRN09akQgjLpI1wpGriOtMk
         Gm/ZOtdFGQTIae/hE7r+Q5+ltM1u1ErEYXPNIy7aCDxP9U4whNljEgdZFnKfMVR3yjYO
         8Ayt4DTBU5PE+laElgN500g0rsl283LOD72I/oTn6WrL+JYe7+oFXhWnuxHU38QgnAcS
         4bSLOFMv3JRkJ3ac1CbfpevMYpcloPu6kvePXq5JWT0bnvqpTTqlrdF0EX8YjiPBy+a0
         Fcvw==
X-Gm-Message-State: AOJu0Yy9vuuXtHLbR3DD8gVb+WnmrUHmu6h/Mh+2LBQYKLLPtipZnUj6
	Mxld55HLY0NxA5J/XxjD2vLdrQW9YeVlsXaQBA38nNK36K9sgND6MAoDULLDPSc=
X-Gm-Gg: ATEYQzy07L7P/VTubFm0ObuOc/wsm1cxLdTjtTYz0P8RwMy35Jq0SvylCqq0bDB52Jq
	sBIdX3Tr4rGMauLLn+Qh/I7DGEv/rQk4UAYEFW/Oo6X+ZXnik/AaDebuoDTnD/3nGWz1Z5sIGQT
	jD+jitGccq0nWk+OsFbonRpq75Uye/eixZwXP8gjMVJSupEr6xg38KZscdvOqgBc9B2pBVRtbAl
	pYD3ZjmsO5BkZ5M+hbOY466JVKret6XIq+p5D6HB1TsBUxgVPdAjF7ivxM8glMLXNC2l6E7WUIJ
	NjUEQBEhzTJt/cPyuOY8qk8XIG893NTDNlvZlqJSmXngVIoTZvBp43bgxvUX/09v4xma2DkupW1
	/gJ+OxpN/1hV58+QnHfmqsmBKNLoh+G6B48lxJCeYlCehi4bNmkWXRbNs965VYa1tAj8bUPDQ7n
	qkrlfhUkx4xdL2sgt0TbYm9ylAIkd7jJi+Zs8W
X-Received: by 2002:a05:6808:13c2:b0:45e:b5f9:8a1d with SMTP id 5614622812f47-46ae0140105mr2245995b6e.35.1775052296671;
        Wed, 01 Apr 2026 07:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecf2852a1sm114838046d6.32.2026.04.01.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:04:55 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775047736.git.tanggeliang@kylinos.cn>
References: <cover.1775047736.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v8 0/7] NVME over MPTCP
Message-ID: <29d505d4-a120-f987-eb0e-15d5de0b5ad5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Apr 2026 14:04:55 +0000
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
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23850182531

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dd36aba092d9
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1075844


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
