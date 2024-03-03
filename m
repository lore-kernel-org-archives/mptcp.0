Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889867F
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709464049; cv=none; b=u9SDcL5N1fOMup6fcgagSUid9QAoK9CHRM1irzWdjk0ZJOD0fpffSBn/yfPMI1EzYg5fDNGKQy4m+yig3M0/lB1omqKSdiNYZWuZtz03VSpzUJiNhfN5QmpXRCO+393RLaBCrXcf/sQvRP+GwUi3etfsJV7NoWxVqa5/Ssff12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709464049; c=relaxed/simple;
	bh=bJsHQcgotV5LGn0ogRGENbJ4+2BcxQoSyqtwrL+G1WA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CPmhkYTqoF4ZYxte9gUlhtgYvpdNsRqx8shGWHYM3HSNPQfNIf8rtBookqXWKbKjQf+MQstS3qvARXYpZpeMAX5AZKmzZ50kZF3BSIyLXncPGKwJLQo+t3aPG+kDnfV3N35v822AQ/4azy4lRvPl3GMK+GB3J4T975K0Yt4xZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdunkoL3; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdunkoL3"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68facd7ea4bso16472536d6.0
        for <mptcp@lists.linux.dev>; Sun, 03 Mar 2024 03:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709464046; x=1710068846; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRhp4Pe8D67ARiuhrEPfA/GgqpjXcy1QK5JWyd/5xMw=;
        b=OdunkoL3PSmnRjU82g8rpFOI84nvMbb3HMrQRs6/kmBzCnH4KyGjB82jVOyIrQbxdw
         xXgPRTzH4cklqLkdlTelPASBxvnXxasOsRM0ZZxhc3Vr09nMsZMxQp8qcvoOGXUYbmB0
         Kp9Mly8gjC5FBebUn9nK4sTmXrr6HbIu9GVKj2m9pU2fOpRylxSlcruiAm4XonVZ+zDT
         LhbJrv/PLyOtCSfhgDCQWdoAQATuqFvC6ZUBzxFK+OnkahpK0Zsgmf4A2dT9BUWVm+ps
         2OnOwWN2Y7LYe42HD6RDKB7nGn9OGOqYB6N2KUEXx0KrjLNISrMKvWC/tBXesr0oqI2r
         tHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709464046; x=1710068846;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRhp4Pe8D67ARiuhrEPfA/GgqpjXcy1QK5JWyd/5xMw=;
        b=mg3SoHCPp9FrKTScmGRDYXSJytsVOmaGYXe3AuNTvHV4/BLhHVTEkIsCB35PA2rlEE
         xEDRtFXge9mQP5qgtA0sA8+4708dyU9gENhc9aOawDEeJIGcJldpODPC6m+hVuBIOzW0
         J9aZS62uZ30K1EeEMugCwD4sabPcmWBUwZINKxqLw9O99W+r/zq70+iX10rN1O/wzfZl
         w7UsEUp8p1friey7Gn12MVihhH5yK7T39LPHuwAzEQ1tE8oR/i3qP86tUV6ibVCubhnX
         w0V2+U0QhH7tMiH80f4OjiLOzSBAx1GzuJmyiKri8JU9TvGS0fdqr3glL1frkijpRl/D
         VYNg==
X-Gm-Message-State: AOJu0YyzRRFwxeWzM2PG4jfUD0CyWrVlIgSEGc3/DyKPglMhs+6r+fTm
	T6LmJZyFSlO+uGULXfGfTJrFp7xpsbcI9fz0bvHGvPoOBe5+U9lznusOAkg=
X-Google-Smtp-Source: AGHT+IGpGe8W67tjMdkXnNtonm/PaP7pEgLWgAP7M5Xaa/kkddNONpZJmBrUUvZIxhxvDglN4p6N+A==
X-Received: by 2002:a05:6214:1802:b0:68f:f768:350a with SMTP id o2-20020a056214180200b0068ff768350amr5636859qvw.45.1709464046410;
        Sun, 03 Mar 2024 03:07:26 -0800 (PST)
Received: from [127.0.0.1] ([20.55.118.241])
        by smtp.gmail.com with ESMTPSA id op8-20020a056214458800b0068fc5887c9fsm3935762qvb.97.2024.03.03.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 03:07:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a30bdbee01b90d4725ae09c19fc782ff31492e9.1709459360.git.tanggeliang@kylinos.cn>
References:
 <9a30bdbee01b90d4725ae09c19fc782ff31492e9.1709459360.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <7c4c69f1-6391-377e-18b4-36f4dc26d78a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Mar 2024 11:07:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5888218009174016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5888218009174016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5325268055752704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5325268055752704/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a2a80d4555a2


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
