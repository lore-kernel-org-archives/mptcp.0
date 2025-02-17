Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C8215F5F
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787693; cv=none; b=T2O/NB8YbdBbN6qKL2fC9bQXBNiXcv84Gb00vLDOwzusBGbFkGDpoN8dAGz+MWpJvh7lsUR0JDHIVlWCYKzg1IWxx8ttwkCMnvunPmcE1wzJBBPAo+XEFyXmkcdxn8DQhnRY3LFKWUGYA0dhWy1yjfOdOGFYbGbldTcWAWgoPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787693; c=relaxed/simple;
	bh=gxYco0v+cLWOxfbVegtWzmV9NvaeIpX15KU52LLfqgQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K+1BxpKKGLtMenszMfEonoVl+F+PLrH83WUNBXbgCfE/BaRxm55awiBeWV11CfCkSSKxv9GTvhnj73W06MWk6/BIJqW4rhjhmBVmZAoxATs7IqU8Zy70T3gW5yQLH5ur21DPFNzZeyClMtAKkdLkvR1/ggTmqM5BRR/rwZEVCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAUee+c5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAUee+c5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220e6028214so65999365ad.0
        for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739787691; x=1740392491; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhT8+a/lGNpqfNhPrLoMmA3JqIN7XN3ch38hy+1UgEI=;
        b=VAUee+c5p5GTqbSjC8dN+jiRTecnL1z3SNQEcBInmH5aUAhXMgx3TOTajWztQuLRy4
         YL+JQZyrP4sTz5FtTCrFJI/saNw6U6IyvcRjcr3E+gNHoMCkpc8Ev+qj557x+aeEXHJ7
         bcwmM2ngUM44odn6+87wk0pa4Fs4Ppta+YxCAbB+AKBnJsCbARl9lk8ylLMg5osTNyp4
         NmxQ8oK6+32+xw8GBBj2IfOcMCFkvF2JMJg0EabImWANNpXlCcwt9Q21XI75xxdT1f4p
         15aU0txlkjZoC7yt5uz/0a3MobKl4e/p9PbaXbIO0ekHlnqved5N+Gu3A2decw8c+a8S
         IYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787691; x=1740392491;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhT8+a/lGNpqfNhPrLoMmA3JqIN7XN3ch38hy+1UgEI=;
        b=WyJ/hOuGXyAlL+ZlQog1WyRT1dUVpxMeLez7SUchjQzvtMUp3TRFJIEcUz/pvZJHV5
         b/Co10qGXVN/pL+mT5NLzkEcBWmUUFW1Cw7xX18gzOLY7x4/+3oWeMisfrN/DAdzle5R
         p70jT3QoIanNHl/caVuBEOsv64LQjlLDgdSja9wPFBV+3XiZTtOJ1BIuOG3zttOYMLbE
         wBZlhbCiXgGMNJGHo/geUm3Lwb1CoNEC/P36bZBYPHnu5WzhCYD/MpP3QE6uFOIettkj
         KH+jS1MvG8SmhUn72eF7Q0micdf2o3my+LOtnUkj9yKR2Jh3VMuSGa+z0sk0c2b9ct56
         D5Ag==
X-Gm-Message-State: AOJu0YzMStPb3rmEajtdul1DgpgK+Xf3xNimm7REaqv14u5Zn6ZWdB47
	0c3vhzsf7KgErI9IppKdl8bMaZdOm17URX/CIdyLwULfy7DqrpvwjZqoTCc=
X-Gm-Gg: ASbGncu0LSZELLmzI9h6rCWiUXM5fKY5D8NnuHKMVzV29ETgF3T2ghNXR4DAKNLwJRi
	LKGAEnrcKnhCPy/pe8fir7GL+P20UV7U6MxAAe+AA0Zu51MVA78hxlTHWTTmElYv8R/ufpTs++i
	q4LNLQocqsym3/bQkEmRSG/oDLsQB8zReJpsWriyctRy9ForXeeLTCHrK2yc3e4AP2duDoDFK5q
	qGm7oOxu3XmTLiN9fm3uAAfJlh6akPXAFxf7rUahY2WhXhqTG9jDkDRd69PgQiVQqMe+uIn7Emc
	X2Gaa2P2ErdMaDYxE1Dn5wjxm6jx
X-Google-Smtp-Source: AGHT+IE/v4HvKWjVsu0jxrr/YhthM+4A0Fh384yl/0ZNp3KgSEFJBBkMsoJHvJ/M4ZQlMRq4XA/aaA==
X-Received: by 2002:a17:902:dac5:b0:21f:4b01:b985 with SMTP id d9443c01a7336-221040bc38bmr138844355ad.45.1739787691324;
        Mon, 17 Feb 2025 02:21:31 -0800 (PST)
Received: from [127.0.0.1] ([52.234.47.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585fbfsm68507555ad.226.2025.02.17.02.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:21:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: reset when MPTCP opts are dropped
 after MPJ
Message-ID: <a62191f9-122e-4826-ea01-b25c2c1cc7eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Feb 2025 10:21:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/13366428077

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4b6ff0b2c9f9
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D934579


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
