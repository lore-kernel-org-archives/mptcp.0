Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF861E32A2
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336924; cv=none; b=YqHyocgguX0T/P+AGe+UsginzeYTP1ifMf0oBYgoeUxRlxsyxPR9y7Kdc5aUO37fVbALKuErd0RMsfS2SgXr/iBT7Ms6+ixw00fz0PG17DR3/8kw/WdUFE6Y6IvPa9bzvsGcC0ky3flnwiIl9Ph/imFwEWb0OhM5qQ7XPtgqFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336924; c=relaxed/simple;
	bh=EF75CCWSUPZuYGV8xY8K4qpCUrlRQ3uMHazKX3Dj50E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PCVKQ/FqAQlJZqYDxm83Vw+AI2ZSKaiQwZLc2TBYKCW8VmwhqyxJYmdYyTuG/qd8l8KnjcXDpMe9wfxQyl9FEO3004ciW3m+DRdVyG+020LDaD+8THc+tCSFr2Ehw15xdYWhOgKx1hWPXMarJJBR1rXCjye5HjfkGSNRlNIO7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6+MMKHk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6+MMKHk"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee553ba7b4so6894241cf.1
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 05:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764336920; x=1764941720; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRVEWQsrb5xmUEcpdXhWWlReraGVmscIk40njAQ1Eq4=;
        b=d6+MMKHkFGC/Zs3a3WJOHeNi2jXHG/QniQnGPlanQbOS5QzPIg8u3mI71RxXDjhGtJ
         L034XWlFtmp+1rGZr0rp1T4W9Z8R5C/e0EXe4UTFhrSRLxeY3t/7m1YH64ZdC38dOW5g
         NSfis6OGIdHQJQhHgp3rgdhoOJ+o0vzOODncvwpe23aoqwY5aBxNJp6erKrD+SX43jX4
         YgucvTGN5vuzpasdw62B/65hdD7EWfUTdCNyrLZaovOvl8oEBQIh0w9JHW57NGflrAXu
         VPUBwVFqkxxgWvH4tqioPfDOUCIBskOSQG4qVJpu2u5Ic+ayBQzIVut5xaGpYcT895qu
         xiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336920; x=1764941720;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRVEWQsrb5xmUEcpdXhWWlReraGVmscIk40njAQ1Eq4=;
        b=tCypP1wmof8lKWWNNWzYpnEz7ozxGkOBykG1hGRvKHbH1FUFlaNkZzmV2/z6/ZpEru
         fdOrAn0hEcOVy7eYG8Gp9ZuMw98R0pX3RYDX/8GSEfAz0RRpspnVVk2oNldaPmFIjrsc
         3gTfvKwoZmIU/z/Yt1TC3KPSwmamvYbgPUVHHh9oKrA1XqFAYhdX4PhCQhjRkZkoN8Bp
         6V38MjTz3TXQVbC4JXKLQcJxTp4B2VkxGVTm1qhMRmw2thehIZo8gkHsrjdVQkew5XJ5
         Z8CceorEofO5cqH89gsp19pmNuW2bOgipC23Zwe+b/w5WbrSCDU6vkQuodl1B6i3pDpc
         Um0Q==
X-Gm-Message-State: AOJu0Ywwi9hPhGIib0r9uJuI1nFIJVDOQc9EwTcZTP65iy2BB6ZN2uOv
	wGl0wXV/UqzhYwWuFptTD0LUf0C1EuDSZ/K9PpTDqYHrL3LJw0ak+YU=
X-Gm-Gg: ASbGncv0usoSP5Tho2uH6xpk3dduRgfgqR2f+M/RSMhqTIUHesQng2kKjiOKt8mYsO6
	agVzHLQslfql/zUdpKHUfpx9RAwo61fuQPX13xVbC2obhgcy5NRS10R6pKoYXc1xuxOedGP3b4I
	lqLjlSqibefROHWUm6w8f2jHA3dCY6MrlbL3NES630lBuEG0D+T9dDDcNv02HzQuj1X0JKq8BLq
	xsUiVkezCYEjbgZd67OTgmaZcy0udXTOcUku3H9vmKdeDK+WaL/OiIUG55cduT/KOgIBjIu96KX
	rlMh4CPY4BkHSuprLc4eF4GxHdZGmO6DwAN/Div2PDxgyJpaj6l2N0DhLSTpXw27oYQ15QJIZ3r
	GU8OquGOoPtjP3F9iz5M7TeWwJxRMFPB+APOlqC3cHmSWgpOx0pH2EXbBJ01IPZsETFKh4LH40w
	9uUfiTFh7plWMX6cG9JW2V/XoVgyaGkmdL0lDe
X-Google-Smtp-Source: AGHT+IFuRAgiP58CP3DIwX5Q32852VPpZd2GnApmUaniLIHjjagrKrbdWrFtNxo1GwOrMiBSmKszUQ==
X-Received: by 2002:ac8:57d6:0:b0:4ee:4157:c052 with SMTP id d75a77b69052e-4efbda22aadmr224705781cf.37.1764336920497;
        Fri, 28 Nov 2025 05:35:20 -0800 (PST)
Received: from [127.0.0.1] ([172.177.209.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd3436275sm25536601cf.25.2025.11.28.05.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:35:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
References:
 <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fallback earlier on simult connection
Message-ID: <7bc3d452-b6f3-ce84-f163-a2fbefa71e55@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Nov 2025 13:35:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_syscalls selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/19764025304

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/23fd9c22f527
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1028652


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
