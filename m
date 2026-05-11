Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16DB366060
	for <mptcp@lists.linux.dev>; Mon, 11 May 2026 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778500926; cv=none; b=d4VDpmt6W2+PbPamhcTw64PmGzS5k50YA7hjFDbb2GJru6Irb3hTWWlCRZsjqaG/Y1jCVLLSVBJIQx9ghsr7tV4NGP4sW7DTPDfmEC+xkipFLPn6sBUi4Fhm7snYweUpkF3Mxftn+ztre8eiZ+QALyelUWqSAPYXbCvoRSrdOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778500926; c=relaxed/simple;
	bh=SoU/M1Hjex/2P9xnX6ra3Pr5/j/4yI6xMGmUHE6bYGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FoEp3HPMtYohr0ibLUC8J7TUUWITIBMNprDutUWUFCSbk4+QWmTlSUjOLGS9XkCDKubGn0TDUuE4J7ZAC1AHbts/Ja2YSc/iHSdhJ9OMpYOMuYafgU7L+j1/Ejoe6Loa1bCUorBycEg1C0ET+GCITOC2DzIjHCLTmhmqaEwRiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLh6hg9R; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLh6hg9R"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6966f99716fso2100190eaf.0
        for <mptcp@lists.linux.dev>; Mon, 11 May 2026 05:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778500924; x=1779105724; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f8oSpNYfTY/6g7Lq0tJT6GLa25EsO3/40xFfzMSOLM=;
        b=CLh6hg9RtGrzNauErAMF/54SzKWE2dldBzO+y4dmUSiUr1ABOaUMKo/E4vHnOHUsqR
         jloY6VnMv+zFrShoVEsjeq8V6BIOgVVwOPUz4aZWLdgddpMPSvf3CkGp59pe1AblPBil
         NG180fSvLOO4vdySe0NHfdsEy1crxalimeFifOxf5ffV+VJ7eXGed+TGDHEbos7FKFKr
         1FxjVFdRdnEb2oGo+r+DXmRW3P3wFs7c9KWOuquzADFGGVJedOYoPDyGHK3cwHk25RVb
         2NI7HzFEK/d3N1bAC4qZs5xtQ/Uya+WgySvk32RxGfZY39ijkZHGWFh5lYRP2ekU/4YW
         wVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778500924; x=1779105724;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5f8oSpNYfTY/6g7Lq0tJT6GLa25EsO3/40xFfzMSOLM=;
        b=AHGrdTmcO8b0Rq6ZYfiEYzWHxN1otkJHr0eFEx4DjTbb34aqvyQDS0o05COcyx2V3o
         2TG7IBL+UkWgJps5rK65iertsz3KMdAiUYJ8ALotFVKedbG7x6dQEx9WxJ/pQ6IRrHGu
         VtZh/49l5GkyU3yIzBpz7RlueNNqb4mUhDyb/eAe+8091VTOI1UveJdCYZUCSNpNGWAt
         B70eoq5BUAJVotzMlBS481lCRTkWxhBFaczhz2+dzeho8mKRLmeDARfZxkY3kaaYiNVu
         m077eKeB7oATU8joOxfHnB9oGRPkURYRD0jWZOE+HdpdeoycbU7SsnAap54v/OirUtIX
         Ga1w==
X-Gm-Message-State: AOJu0Yy0OW1441mXaUr8QhOuY7GetfXjp2ouFqfDBxaGx5xHae/6jHJl
	yHojZYOXW0H+k9XLrveujKSUtLZsRGqIWSjsdWYYsfXedXPk+LodFpf6C34j
X-Gm-Gg: Acq92OHADS/0X0tbaJq/GFbPnVVpHQ01ZUQ6F4rsL4BllxXkvg4XBMpCZ6xeqJteJOD
	pnC3VCjJDTHkUyDrVxXo7xqV+Sn17afmSRFfke0qY1vgw06TMajCsTzKzVvHY3KXTD09TUUSYeQ
	zTde0sj1UK9UpneIvo/5l33aSgEa2JGXrOiIfGvsZJrSlyfqZGkIazAMObAHlGHSGS/wyCgTDDq
	m1XzEeFqJmyLbrAVaOVbxeCRvd5et/vOVfUnX5WaIftCL+T+o9UAexPwNWDgrn2dkzQe0E+CbR6
	Q+B8Xezx4nmk0k0JAQoWvH4Qp7bZwiOFE6U/LE9pVuAjMdyoyLO6K18DsT3Zt/Rebqt6iMxMMeC
	vndKJU/8txkeAWuw7h2AB7lp1F03bfYxaATFB6W18m8QYeGYYhRE9iiQq7uvMWlCARxEJXrwoBr
	LHomOJ+cKZY5TGo4gxTAlBFQTgh93uGjPBFne2vA==
X-Received: by 2002:a05:6820:180b:b0:696:1e8f:a03a with SMTP id 006d021491bc7-69b25b79765mr7471066eaf.24.1778500923882;
        Mon, 11 May 2026 05:02:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c7e30bsm92163806d6.25.2026.05.11.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:02:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ruide Cao <caoruide123@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com>
References:
 <40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com>
Subject: Re: [PATCH net v2 1/1] mptcp: fix request ownership when cloning
 reqsk
Message-ID: <35eb0c9c-eec9-b586-8101-ff573b753148@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 12:02:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Ruide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/256664=
76678

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1250a0109f7e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1092284


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
