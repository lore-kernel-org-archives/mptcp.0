Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF342DE6FC
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995178; cv=none; b=BlRb0GEDLqq25zf1paWQWF2OoiRT0N9xeiZUyOJ7ZPr91rU5SrU/twfmy+/3JhZkxGP0hFytGD6D8uQIAk7csU+reIPwM4dFwECV65JvmAFKW8RJjfWGg79kbMiW+l2iQ++zehRXIUEk7rlWC06zq+Is9ZByRxQcMvaY/aabWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995178; c=relaxed/simple;
	bh=IRv+GqqQL7JDwT2krlTQFLJHTmSmIBRIf45hmwJShi0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=glmKL67h/uXmqQAjxYO5lkmtCBAvSHBzE1U7jWdop1+MhogSf4jygFtAAd0XtQEXidYZOtw/vuYZbV7/4VSe8PHIljhEpQT1e4jCTUfq8Wes35IPzzZTIbRAkFfwi4hLeJqAqGRCtwRRbwqSh6dRj3ITwKyz5g4iRaY+Uy4OZao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmXj14j1; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmXj14j1"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86cdb330b48so318894439f.0
        for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754995176; x=1755599976; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4EHe1NbkK1CIKiuPNPfX8Pb1/305PUTvW/urlmuhqc=;
        b=XmXj14j1tL0hDFuETY32+wjplb2DuYyM81dlt7SiTHRPh8/vz760Hv2lT7rCY2S0aM
         vK68XfGk4arejRSDBNxLqT+l09EaRSMALCaWFJ4+E6HB3XTWB/4WmtV9livVl929KmqK
         R81ejY2P5icuIyNnwvH3m2QgW+VT0Qc4EaxuJXm9Ti45QJmx7MMfWg1ZyqlEgprBORPt
         LQvHUtjCKfpx2kE1olNi/Uh0YuTr58D60hB4I3YeDK0Ep34Giyo65dBk6YQ+RcqUImbn
         59m3obW8g3NlB+lwypLYvxk0AiPIaPRDp5akPvfJCFPR+MM5WZ2NkMapKl0VwBeFQMyx
         Rm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754995176; x=1755599976;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4EHe1NbkK1CIKiuPNPfX8Pb1/305PUTvW/urlmuhqc=;
        b=sBsu8yHp2EAG8nC5xhWT62+Krw669unSYusDsZ6UGpqBNGDfgVtVfPNnUkDjLz5l8O
         RjndX5vP9O1+lTboWw9L93jEZhCoNygNn2SItcUR2T1czWnoS8HyKyih0NT/OcnJKrm3
         ZfGr0oP8/cPFTSL8YZYl8PMMQS223jb3eFf6lO/uTX0My0/NzjvDsQMjk0Ma744coVWy
         JkOFQykrelfT4jVDcxzwgo9YqMfhRC5+L9Mxzdg5A+87gGf1GHhCJQkIa2odnGnSYgNN
         cr56bHixDzSsqmTkiHzmChD+n5w/Web7u6zHycklIdoNrqg+qKzYShEYa3OZIbXK5Mu7
         eDOw==
X-Gm-Message-State: AOJu0YzD0Oov6tG1hjWt31Nyea1XPZnJyVvjpKKUfjNzvgfPNXSqoXOr
	MMlCVur97QESw9Tht5UEljwrvBfamA2/35kxwg7RSIY6wTqci1ngJFEmSATh
X-Gm-Gg: ASbGnctnTMq07iD3EUHOlucA3IAG6vN23n00z1wKpANwdWom6H1cxpoMw2BLryhA+SE
	0VQeD4CKji55e3KPJFZq7VSWhcc6oXVjdW/Mto7/Utt9NYYfsCreaMGJL4lZ59m1E+yLS9lVTfs
	E2uA2aYD6Jwl5gM/lr+b97NzMQO7xMTC5Ia8NS2vNCdSqdOWz36AJF37IGxQLjfEiXcy1yObYx+
	jinjUBgVLiFK1Yw2f7LcCFJPCrMMoi0pPLRTcISYo2g1AWGMqj/WsRmsFn8iJB7Tr9d3ha/3roG
	YKZXfczb4CPavJXV5E7lyMp1jfqydLGUdF+4folAMmvkyJyYs7uDrTTScgBDTqhd/cseBv5ZnAW
	ll9jVrGQlDmXK5pk67DHbd2M99XdYkY8oMloQ
X-Google-Smtp-Source: AGHT+IHvWuH30K1jIgKRHWDksJ3KyqD/eB9LnTBQe1Vt19TiD/swxeswHkFHRq+USu1HhbLtRn+Y2g==
X-Received: by 2002:a05:6602:160c:b0:881:82bb:94b2 with SMTP id ca18e2360f4ac-8841bf27d2amr618452339f.13.1754995176421;
        Tue, 12 Aug 2025 03:39:36 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.185.16])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f19b58d4sm346874239f.28.2025.08.12.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 03:39:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754986557.git.tanggeliang@kylinos.cn>
References: <cover.1754986557.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] refactor MPTCP socket option handling
Message-ID: <34478fbe-bbe4-da8b-a7da-4d5ae76edec4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Aug 2025 10:39:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16903519178

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/54fd10adb571
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D990414


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
