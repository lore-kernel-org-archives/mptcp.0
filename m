Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E335CB76
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814740; cv=none; b=Fv1K9X4RmDgBCuCYFR07dAZzmRaX46utE8bVW6jIPXRaqQ8y0hhkopAsiiAit0gnW/0VP1+9vxPqPnnQ/jrrUkIDWNP9YZR5vWbZnvbAsOAZsgZwCDqNbCgSnB2j4qiSd+5wSC5c5b2pdLAre1MOzA2lE3Vzr+5vUIflOUpRJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814740; c=relaxed/simple;
	bh=lP8BorQh0DHJhDnM+wwWNZYTRLmq4u8BYKIUJd5ZzMQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=L0eV/hLeRGwlP3b5MCtSP78yKFplBBaAJ2vIAV8G7m59fJFz9D1GfFYLdrJCGDQWEEU23XcsnxYO6lHMMIp1UfFX9TIcs3DCsXRXfIoQEavUlt4G+GWWiHdDsw+2aWZBTSVFxC1+vlkFuCe6pputiCvd9/J5qvw60GNY6h3gswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxxZU1Ck; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxxZU1Ck"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d891442388so7206777eec.0
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776814739; x=1777419539; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nr8YyrnQZkYayZLTBZJdA+wp0NxRtO3BTfvKc9zzTQ=;
        b=SxxZU1CkoOoiHFl8BRuHVtz48UminZz/jie3eWMHrL5Ar8xBmHDQ8td1pc1RxzGxZu
         zz4/SGdV/WmM3aWi+BrWSXpiDUcdy7+oOlpOIanr/jSh967tPr3Y8qtScOiPukeoXEuz
         GIdVNf1/XlJ0JWvdyEApvWdgu84YnMK/KQc45shIBPoG5BJ5pwAcFYoimrBj8CDmH7v4
         5AMN1lOWNBwvLe1klfO/Ra2S2hZ8XxtuY237R2oJpIG0mcr7TUUYVkHJvuIUa2dfYerE
         u6u+xHIcZ8HZEywIdfpRnj4nRzb+ChFmdgDU/+pbCUK+PWD8HDdyxRueFE45oRGvHlZs
         rYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814739; x=1777419539;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nr8YyrnQZkYayZLTBZJdA+wp0NxRtO3BTfvKc9zzTQ=;
        b=P8yYulridmro0p9PeGE56rYGZuLX10/x0bSq7cAF+vujNBYcrCJtDvHcnnuY15Cnsp
         ryyI92DwNijV7DxVaUnn8LDWHvXIURZzP9wY7EQwfhdHqm7x0tskgXTWrSnPTJov/3ML
         55/wW7V7ljDNaGp4UQZH3pWP47hDKnsTalrl6ndHSOupkscxpKQML1Y3+0NBlZBbPke6
         eLSraJwgJP40/rLNPBRdzamUuWQy1FPOz9MZMVyDYaQrBSKnb6Y40SfNRV29u/c+mat8
         uAoP9uc+RwTmW5bfutoJSxuOFLqQr12TnQNy00BYLGpCV7kFBlx+3lDUiHEtYzN4jNTj
         3CHA==
X-Gm-Message-State: AOJu0YwPqg8dvEaYnXHmpnyHE6c9+VJnI410qFfCu/ScfcuJN9StMPf4
	2uKlTlLTyGw6eY0/79m1/E8zoE6vcvCyx/gNO9JagkWA2Znj0EMLD6g=
X-Gm-Gg: AeBDietTkGArfIgv9vK+WNHYLOFJ/j9hTxinPXX58vE92Ljpxa3lZApOt8bgkY7tXOm
	QR6070lTw1XNEGCQrYkg91TtagBCrI6HUgPtwZsZkgEuFy6uYca/AMqKZVHU/nNP1yZzcErXtkH
	k2TTmJgh6/6JLod7PCwf2dhwQL8ZNgDhHk6YB5rHnn+Ye92rFGBeYca2QA8RILW7kb8wI/y5aqv
	+QJd1RvUGGketBALJFI9V3T5suepGA5Jr+dKKxOaLb8FsfQMlncHLR1ak2VLU/V883j17L6Fh1X
	LXvRFt10Z9YEEj+zanrwIzaq8p42D3PXWiOvsp7qAuOqya2vbKl3Tonr6FJ+TrHmWInCWBdNYNp
	H8pdyZTtP8DBNp0coidL5vSYUSRQpTU/dyqYgezfTJ2wLNMQOVdwXtdosZA7m5e9oxmKlTz7buw
	qhItCXDPXGXItlSJpb5iM4FILfMGzcGEtirJNyA1x/SHwf4A==
X-Received: by 2002:a05:7300:748f:b0:2cc:600d:2ffa with SMTP id 5a478bee46e88-2e4788392c3mr10445133eec.16.1776814738634;
        Tue, 21 Apr 2026 16:38:58 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm20923613eec.27.2026.04.21.16.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:38:58 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260421223338.52743-1-devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v3 0/3] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <799ae70c-9663-bd95-010c-eae3692fc509@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 23:38:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 1 failed test(s): =
packetdrill_fastopen =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/24750414123

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3d39e1ac876f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1084059


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
