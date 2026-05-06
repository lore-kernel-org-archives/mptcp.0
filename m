Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED543E1220
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091125; cv=none; b=TYwPkdmcAXRZN8KPVED2aVAwoi6w420J+Dn445DkkBgKxA6zf3BcwrPsa1FOTaZZxkH7o1QvoQLYkm5HdU2/6bX94VxnJkY+pu0LJnwehiqrWQNwi/WH/XxI4FZvIfh4hJhVrzv3S1yxFfzMuEe7a2vkpukpwawxkmZA0CBVu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091125; c=relaxed/simple;
	bh=3smTHjjsmS7qkn3juVz/4kHwjpkTj2WnheNXucl/pHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=uxTtBtq6vlD5aGaHz+KNb6MF81jIE5XYUq72KXMemZ8Lx2rbyMzHrlCYlztLBE9AgLT0VoecHxXdrWB8gTliyQaw2X1FG80NA+Fa7h6bDOo0a0LCy/3ilNfeQfZum79VjeXxuEuHdC5AjtkY3vmJvBYJaeXhVHoTmIuJENm+PMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTNDeeuw; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTNDeeuw"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so7554795eec.1
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778091124; x=1778695924; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkDdd+1igxcCUvCJTRzL29UF67tiaw8ejRIbihWVSNg=;
        b=TTNDeeuwVJzwEa5xDujqZpgH16lx3MrOxY+yrhoLHA0IOq1399Z0lHPMjwfZPoqj1B
         6Zl8hyCril4jWFFMXQ4hO+iITg7mgsLWIG6DtXz+sFyjc2VpelR/2aACXQoQ/CrGK0lM
         0NZNnffravA2l6Mm8VkdMFvL5BF1QAC5vLFCVfXb1grb2V3EAv9fbgryYuv77WPGCaHe
         bIMJJg9S1lFBxpMLy28eo5+xdWuMM4b/pmo3+wiL4nrpMa1ccspOAa/xccIwIZrZlmo7
         2MclXUjR4xtEsi0jUEmKqJGShppRBGD8HPRnJOL5MP8ZpzYyDGcBLmzyaIOZej3koUSd
         CetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091124; x=1778695924;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkDdd+1igxcCUvCJTRzL29UF67tiaw8ejRIbihWVSNg=;
        b=CFQ4mmISqnQc9lsur0Elv+LVJMV+VmXGfvq0FRSOV+kIxkbfBrV+mBXOxb7fdfXnTU
         K6kRuyMWgBJ3Pw/VPmGSd34UHoY++Kc3kuHa8tvuxFQB4MS+lG31B7/iOq58ZDRcJgqv
         SbfTCcgQRQyfpVbsWQuXG2eCkH+1+IzUjfHPK+zYzzaY0MEtBcTGgRzwxpDx0bdd+z2c
         ZDp5zruscNBVsayMGkCFGza0D4Eyai5rsy0Y3/XDjb+l0nvwWxJQE7Hfh2FQfREM2Hmv
         hjYpHUJCgizQmkhXynlNBbpaDAEa3RUN5oOQkWHY8JaVRKR3B3yp5g3A1JUttCXoR0wC
         abfg==
X-Gm-Message-State: AOJu0YwUs5+p5T0XxGC1NZALeVAN9bbSkNMUKlMC5L6FdwPNQ0AegwFa
	JBxO5vDm+K1gM45YUxrgCI4FCUYjDbYV6ogM+uzM/0e/e/0V49Cyd9uYoKpt
X-Gm-Gg: AeBDieso4yW1VOqtEJI0XDJPnrVLujzhcrjh3dSuxC5jgXXDfr7hT7Ll7P537Jy0wvG
	wNbcw659I2gvpimmMTGge8wqaHNMyY83OvMCa6BdoML9piQcisgzvPp5V59d4C+FP6kYu4a/Idc
	cq3IbgNKRylgINiy1nHma9z+drirj1tzR2bJMsJ7ISfvskPlZYM9O5k6tl9A6w92yPMk2HIvz5P
	1rR0+gC6t2czFhTkIDLeXArT7HnB7TPh7vzeabGDll4ozg37KN5MKakmpcjbKdsuGHoRBSGgvN3
	xE69eNwV/FZGE2INtGBc8zq+Edu0chjpPxFJRBBwwzJzAqmDjrE5k/PWnAZ9d0OtzMa7UjfyYa9
	ZY5/kYMJVKIvERYtiyZs9j5J/E+JwtIwjoSsLXNKhys8XYlTo4gOH7CVtRAHERzIjr8DjUZpdoH
	pO7CtQT5j3vJiq0tJqpkmCfKTJQGC4uD4zyu9QnwWYKyC0cNWAfg==
X-Received: by 2002:a05:7300:434f:b0:2d1:299f:521a with SMTP id 5a478bee46e88-2f54a38cc95mr2590048eec.26.1778091123511;
        Wed, 06 May 2026 11:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f569f89b3bsm5279199eec.0.2026.05.06.11.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:12:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v6 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <921173fb-7c6c-3fc9-0094-e693fd3e3440@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 18:12:02 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/25450327076

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f8b0df4cf66d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1090590


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
