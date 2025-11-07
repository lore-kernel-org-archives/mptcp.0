Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE42302154
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504257; cv=none; b=aCVEGanXMpn4JlxlR9DL7AagLby4A0E3NV124a0TotgzaF1muqBcQjOuOiul/rNMQytiS1O+rWCFrGIbBOqasNEdhRVqdnDsDa3SgsrHhS52vPW2Z9F/u69k0AoQNZBu2/mpvJRL8Ian8qSpV2+x2rtpzK+P/58MJNmJsDUN7TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504257; c=relaxed/simple;
	bh=sUQstPGXxaw5MjDb2VXKBplfI5HnXRPwewz3PgIjls0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cASAjqzDgVjw7IDQEjwrzJ+AymrWm1W7TWTGYAzAD9eYqit6GtRcsgXpoI/mONJtyP6oBiDt5SYXi3y4Ys8Ia8Rgiz74rvRd5bZ6xdHg3SAo4jP5x95uLARS6FBqvV2Z+pdFj8O7wpS2mnwLaXoaZMdPbr1+RLfNdW9uGPMcH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP3i5bj8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP3i5bj8"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4334f402e17so2347285ab.2
        for <mptcp@lists.linux.dev>; Fri, 07 Nov 2025 00:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762504255; x=1763109055; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC7rP8GqLr49M+QjjqtZKHaAWi00fMEI2MxjEF2cF4I=;
        b=mP3i5bj85D/oJwAFG7XE08Fvb7zYvWCosUldB7eGfG1CZsZVzC/xciHU3sfR0L0oBi
         54z5n4DV8hskQOd60MrTL7unWdIfOEFX7cvsSHb0nfB7DNcdY5zmGN5MTfI8IXjlKmH/
         yqZwwGv1h08uhwor/Q8sb7pA2gO43ypxoaqA/2KLEal0Nh2DS0vE7gsNvLoM3p4RYNHu
         V99U9lYRftW2Ln0YToZ6rnweaepg/3Ez0cIYWW2jxedE/R41pEKFspUJlyTB30F5RsTb
         ODdVFKxlzt9FyfJD+jMCHHr5mBcaNYC0CWA1rwjL2v6/iHx2reQ6x7fRyWMNX4VFQtuE
         0WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504255; x=1763109055;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GC7rP8GqLr49M+QjjqtZKHaAWi00fMEI2MxjEF2cF4I=;
        b=SHwWUar4lsK1jcJYWmfy41mJKbQjTiVJ0yV7NaOZLAeKs5+1/wNWIaTr+bNOGhiqB3
         O/43g4NcowaKmEtGCh37+8mfnYGFwxThBpHL78OBkRubyKWA+bFYA3mABd3T8+Q4z75w
         tp2fGydnWtpCeganoXLs/Ysd0vf/rKBpyv0sXcWurARJMR6DES8tkMAPFMWD9ux2CJXt
         UF0rDKS51459MxB/hShfp5ZXfobV0TnrO9vGn9S+JZauv8C63Q/PWfmosjBSRilhPx+S
         cfRuPH9VhlxhzsULlGe8on4K1xUdZOm/acSAE7ttXDiEhZENGFAxhtRxaNud8W0Pe+T5
         NkZw==
X-Gm-Message-State: AOJu0YwM/swdtkiFGRdGmz6dD0Awcq2vzAJnvhFKKnpd+jInJp0L5K1Q
	rX9E6i2kYOgYuLGzredx6Ol9mbNd/cJ+4AQudGhfd42AZo6/atp2xMiTpBWY
X-Gm-Gg: ASbGncuP59xzj4VUdFE0NQgXTc0kCCsty+oZHPLKmAjpyp6O3+MpArv6slJp5vNBF7J
	BCPzTVoU1SKY8J9n0/U3isZiTmXdSPWhfkrh3s93/jttKiRI12ZW/g5GYLn6VmhsBcdNIt1JmyS
	A7e0zi3wetFsg1oI7fv1F0WP1vYoqL/FWtsY23Z3/f77V6U872OCdmXWHbsvfWcLUXr/8WQ8ccR
	rCWk6riC+evoS6FmNMPZbFS4mzXo2poXAmbvA+4klxJx7af9WVKPEOBZF9L930ZFHf2YAFHmtly
	zSwkENKzLQq+DWROu62zH9ZvV+yoOrISTQazLtdvBsC01iNjcRpC899uOG0KDz8EePEJ77LF/vl
	6AVeeB3VPMs7d/kPU4GQGbqhRMYN1RhmIsj6C2GEtUqUNTBVcTcvhgssy1YTebOzS3kQAQ0sKdh
	GtdYz24y14+AO7WA==
X-Google-Smtp-Source: AGHT+IFlZpWHHXmBqMFa4PA1UcLqHeXqdlkhFSxBR7q1wuMQZJ52+r5H8GwoQxHd4s7r5yN2sGL+RA==
X-Received: by 2002:a05:6e02:3183:b0:433:2b83:340b with SMTP id e9e14a558f8ab-4335f3ab037mr36554735ab.2.1762504255121;
        Fri, 07 Nov 2025 00:30:55 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.192])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888c34964sm72259139f.13.2025.11.07.00.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:30:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762500073.git.pabeni@redhat.com>
References: <cover.1762500073.git.pabeni@redhat.com>
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: fix duplicate reset
Message-ID: <30e5b3ce-bea1-6077-27e8-eeb235f599b3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 08:30:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: normal (only=
 selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19161574021

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/92f738c5d9cf
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1020769


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
