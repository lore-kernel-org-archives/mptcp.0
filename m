Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F151CF4B
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065502; cv=none; b=AHaKVP+Vdw0UnGk0qOuH3+wP6l5bJD71LrzbFeuRL4afSE/sDBw4t5j0a1Df17CrSWgDmfhXQ0J10JNV3c+CT/yaMjTlvhhcxISjjB8RS5SQdCsoxWWejMtyyuTI8Uc/OVSRk1g5RmHcULop5CGSNTInCOuOt69ipkcBY7TFAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065502; c=relaxed/simple;
	bh=W8bEQfgI7aSV95FmTKT0dPnsQiIkLNZmrA13wBmZeWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mSimT3oe3+e6YKVl4v180CRvIdEEjR9p0nU7H+pB5A68Swsh2f9DIOpGAOOav2t5kY1efwbgbZLyFWF5LZAknmDdzFtQXCkSYfU/V3nXcMBTQKc1V3S27U8Ve4nBAJUf6KaPCmYcwEMTQs/5SmoV+KLuiKmVbrtql0f48NISiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrAP8Nd8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrAP8Nd8"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5350d9ea106so63527011cf.0
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792065499; x=1792670299; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kghl4kSB6Cj8FvJ5t801OWS0tB+B1MQRl4SvNgZih/k=;
        b=IrAP8Nd8iUTFSH8l4hRIjwzRY3ngojHok5jyPgEbuicnn0GFPWQ+cBVeF7TshTZz4N
         YhsVR7LAjm9s9Vz0KoHbFwfWDcYY0RDIVZVc/eYzjTxfVsgkiF5H7aowkghKWubhEz5G
         2EousKaBTUdSj4Xj9YNnDo2iULcT/1nK9JqFU4YFELUnBiqSuJRfg5yJMni6TIOeF/sc
         QXri7LnLj7pcFLGwW5FE7Zw4RQrU6rA/+XYrh77vJVfTmtV5+2FJWCNKRq4Zk6mcLWUO
         2/k+lG4VbAGlkwEe60Kiy5LsI5ZN0WZcsQGjRStQMfkonccXZkA5BI+JO/fc83DaUoBk
         4GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792065499; x=1792670299;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kghl4kSB6Cj8FvJ5t801OWS0tB+B1MQRl4SvNgZih/k=;
        b=0Hx5c54nNy44uwz/2L9o2scO+PqYSjM9NHyPPHWMdfVAFp4sP61aR3ep5qcWvB8aeh
         5GewGjvvZOGol7VpJO/Z3cbQfQKYnDuEsvptKJhjfRscXlZqO07QANDiSSvy7GEbaiQm
         EP+XXzZdfaV2pAnNZTzF3gXWxpdy8V6Yg3nWohD7q6/lJ0QSiwroA9W0eso9gOVAhrba
         AJ+WnHZZ5uHR783hVRMi7t7S0DSlpxw2gHEJz3TlCSJB0wl4tGelHPjt4Dj7WFndcIw1
         0w5KiwQMqPs/6mjaFJHeYzyIntGkRerHkjFQcS4aIuZxwO4QhOVhE8n0CsAKYUHrGG2J
         fT8g==
X-Gm-Message-State: AFq9FYLsHymeSKBIlJ8rVhDxET+9zsTO3NawOpVp7bisZbB331o6RF/9
	SCX3gKfBP4y74WkWhXtA2bc9fFgmn3zmgB3DhzHU0mlKggf2fCw91eU=
X-Gm-Gg: AYBFou3Xhu2OQoXq5o/cQAZQc80BjsieR/UcK/lgAFAz4MCJzaE065KXOfR0UEnX4D6
	t8GaNTsD0nszLuQ0UuWdn/p0LO6EzIKVpxUh5UNVPfU4/BcXcjMHeHlIYwuYtJJ0/bkgbx/hcM3
	dM/JQgxdE4G1+xQx/fczYIIeRdu8ET9RGHbNlgFxmbqaOtMTWJBwM3ZYNRUsJ5xNGbty0wpOrBz
	TlvO8jif+uAEPoQ1L8a0/4hpCe8Ky7UxlDLS/Bs8Bk2Y8SxNxCuHRFG9F6QsOo0wh8a8VtU0knl
	gnsPyIMd+ZopJVeeW/x/NiwpH3A99wI6H2OI3N4rxplX6UwvWDaSEz82q7XRgkIOvtEQl0NrdCL
	9hSzFyK7Hb6x7Sl0OvZt0WAfppYuX5cqSkhotT/pblXGWeY99kvkddS/JyKch959MDkzGZlM8a5
	N2i+4iXj5CuNbb6+5oln+ok1Nk8LDibFne39//NYZ3GUcoVj/aj7+qo/RXniMVEXPi6A+h0taaP
	RSLHvvyXtZgPI4=
X-Received: by 2002:a05:622a:a1a:b0:535:16d9:8cd with SMTP id d75a77b69052e-5359fb84bd8mr301386321cf.44.1792065498504;
        Thu, 15 Oct 2026 04:58:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.206.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536124551a9sm24366051cf.0.2026.10.15.04.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:58:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e@proton.me>
References:
 <20261015-t-mptcp-scaling-ratio-kcsan-v1-1-db146f55802e@proton.me>
Subject: Re: [PATCH mptcp-net] mptcp: annotate lockless access to
 msk->scaling_ratio
Message-ID: <c8d1ef61-e911-a0f0-0232-ccfb77d17168@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:58:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38724491426

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/75a65162c4=
c0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186377


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
