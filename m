Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570FD3101DA
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581630; cv=none; b=LAapy+1/dInA7w0IUpBjqPB4SLzhpGWaaFuMssJ5w3jSR64UGsvFkLNcsWiKdRkDd5v60dCKamzvXEDMWxHL4jv+1g0K0pKT2Bh5aTSWIukhc03/uiIIPND5YM2kMuzzwq3nVjb72E3V3ewf+YgxKnRVDvXNInW13FiBEHnFHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581630; c=relaxed/simple;
	bh=9sSeEe2axyc5zOOmegrJLJByr2d8JplmtSEgIjD02LY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sAaSEtMG88PUG3WuVBRYd/SQv8xUt24ped+H0ABU4ffKBMjTiKIWV3uUzIVJAhP6WbbTMSJwUGg4qQf4zYdjtCUEuwRaI3eUsVxDlf4oY/yxucCy2lcQGdGmxWpgmc3BmH19tfvoI4Nv5cNeY8RGNBnHJgSGO6hi0YR0hY1BMW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWfYCYSM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWfYCYSM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e8a25d96ecso78209391cf.0
        for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761581628; x=1762186428; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6s86tK4hbj/xY3px08e9KWY4Ftb8w3IAtazvJN5W70=;
        b=dWfYCYSMcCCezwTXLrMLrjfzNMvbRK59BEbRRy2YffakdpfFEVBTEoizhhVwhFAncP
         qTMFfUXTVk8opqsIkQpUF+PMdjln9pPPP4bGHn9z1uC+4RK8xbfSN/idnyLE0ev2rf4T
         uCeLXMhKMdN5P4qNwTKKlD3Xr0RtZ/NxpMLhpJZp5o9DNeAYi0XbM6YFF0I9w34ChxAj
         OtAN9id/wk34aqXsPFiE1pCUvsrNnq/ZYdNEa7kn1Q5mO2639KUHjcKR2f6D4hjv0I+P
         1/J6BaWonCPjS8PItkQRxO1PIPozkMj7jU5B+D9gmCgkofCOlLzrgysKIlqBqTnn8HsH
         nP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581628; x=1762186428;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6s86tK4hbj/xY3px08e9KWY4Ftb8w3IAtazvJN5W70=;
        b=K5E/hyd0LgeojAim6adVrBxdTIDePnlKAqKAgxsnqipiGiCnJhbCX2noB4k0cRVZth
         /DIdB5UhQYPKQ2u/fyU/iO7qySDO9Ap+Wdlh4zabAoVnUdpWSbpoSSuM/6n5ih5vd4c4
         BSFCzIVXRwLqmt4jyB3l0/1i20up0Rc4qspSHBkkHrlcFl3JejCphX/Aclonc0otCElP
         8DsoH8L4G5zGkgzjDmgph42BgECJ4RgNe7cyKospkcqs5nmH48DkeFJ1AkUHdW62Gup/
         rSTFUUFi+ddilolrMzf51H4TtKo6IwRpGvuuCI2gPXlmk4BY+GUsqe6d26ngqgieC2G0
         2gew==
X-Gm-Message-State: AOJu0Yzze65Ds7gohIEvMcc/Dum4to7x/q2DfDMtCF3r1fW6EgBlLXUq
	2k4iavsUjylfYDrgAhlpD5pKauIZxmaGN+722crDa+K7U62V8WN1wi8=
X-Gm-Gg: ASbGnculAEFbEF2B0QvtZW8n0qwSakuyJQJn6+q2lIeGaRkCNIZoxom1TNgiSAlAkqX
	4e7nRf8nv2Dhsfx7gcpqwIg/pcopwKVB4ySHjf1moDuodGlPGRPYHFj55JKyrGMLxLkqQKYI2KK
	tIP9VcDSYUfX7QSHC1El3yTnarR6MX0ZGpNdKjztNlbycyIqlFu59Q2bhHeekcFkCUBZd+fVEUs
	mCb9e+UWEt734N0mpxct2IxJp9+Bpo3kBoeXPSyFNre6LQF9MdlwD7DOQrixROoxFYXYCjFm2tq
	xLx0LuAjmEZs48XD9A8rOTP1RRXGvYWzmazvH/Qw5z1OQ7yg94ZU0d4QAUgCcISyYNUI/+jyFwC
	ZOtJpGgOA5kU1WDpJp40oxY3jeRinXNMhzeTwr1y3g7HxsqORKc9pLadln90qAfnHjco+6YJ78E
	cypRjPLKKZfeSDrLlvv+PGJws=
X-Google-Smtp-Source: AGHT+IHYqGxnBRgh1R3/w+q9eAZF0f/A0oj5M4NK8DBANXl0BR1/zDEsSpxPLs5FyifuYNAMHOrgPA==
X-Received: by 2002:a05:622a:342:b0:4ed:5ed:253a with SMTP id d75a77b69052e-4ed0749a3f1mr7414461cf.12.1761581628036;
        Mon, 27 Oct 2025 09:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.38.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3e193bdsm54215181cf.10.2025.10.27.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:13:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1761576117.git.pabeni@redhat.com>
References: <cover.1761576117.git.pabeni@redhat.com>
Subject: Re: [PATCH RESENT v7 mptcp-next 0/4] mptcp: introduce backlog
 processing
Message-ID: <44bda09c-a602-1f31-c100-d014b4180a17@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 16:13:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/188461=
83864

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a809ef68db21
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1016326


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
