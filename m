Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC18286898
	for <mptcp@lists.linux.dev>; Mon, 15 Sep 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966444; cv=none; b=rdUguWpYfe0ZNHOsFrLNGitCrPSYJYyf9LQf2gCJ+BfSeirpO80xK/CHvAd9+mxZa4rW/gjZo9lwcxv7IIwfzgeJju1Ttzet/dOzJCqMYT2MQdCKvNrLyfC3mY+1gnCMXf0m5b09aSwCpomv4RxCWWmCd0hRXiYKwVYsoLX8Igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966444; c=relaxed/simple;
	bh=QQ9prDZOuPo5Ewh6a55IYsD/xUSgGoHFiaiME05HuWA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Yo03/WnwhwujauOHIDsWZn/nxwmAWWrZJty4s9c7ppGcRSj5mri/FptYIcFHhXddXMGhGMYCMM8T/D156nyPu5+NeaWOu1iGUk1UxxwglrApQVS2HV0SEgC2Xt9av/NGmOYBTYuJtXSiYHwK18KzAu6fkEwS0lhHklk/4G3IbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V12uJuhk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V12uJuhk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-266914a33e5so11581655ad.2
        for <mptcp@lists.linux.dev>; Mon, 15 Sep 2025 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757966442; x=1758571242; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgrdfcyl1SBH9Z3HYjKs4UqsklcpTnb4Cz/zVS83aKM=;
        b=V12uJuhkY9gCj1IJ5ZZSV1BfgkEEPV99SqtGy6R7PaaOvyYjnISDeWREFZWzVWkP+X
         Pg6nwL+WIW1SyfMFV8gndwAQmWzttJW1hcAdQudqmMcioJKRlScRAbgyxYtgRZHHmepb
         xmhJyk+LAxXMeZawpgSVCXJTiftQKZleL+xKG3Hz17BIOgG319zF2+0UtfoZSIbJsSIg
         sIpoeb7xrmRxXoW6KzyPADIVdNITJaxsuaQaGpivYVxRmNxQygwE8+6yjoeE26SmLpL4
         cbQaHST4BtnJWToEqdfMOjrCQ02b4HL1qfD4861A+uQlkBR7vbeIJlJuL2Rhf3GG3m1j
         QXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966442; x=1758571242;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fgrdfcyl1SBH9Z3HYjKs4UqsklcpTnb4Cz/zVS83aKM=;
        b=E2PjgxoFb6o9f8l1oB+U75BjOdJOkpZsFR6gsAeR13oVcrstXrOx08WuwnBvnM9h6r
         Lr+Slo43XV83PNy0Lmnbcs0jrWqd3l7dz6rwWCplbcETxhzSLjB2OeA9pDx7fNL/m7xu
         aU7veAQ5d3wXwyvB+kc4W9W1KjBh1PJcdMTZxHcGonRikVOPqxPj5+Mo5iT0l3rq0Fmj
         77Td0xk2LNUBGReDK95q5qZ+x3M4Xt6a8/sTMEJSOdSH2LljgawS/8DwpSMRe5jXJx1F
         KtIMPqNeEsKpLexDSouSvQEG0d0TWycJtXgt6tlKfDscHUEdUITfR7S3xNkuhIAiBJPV
         e/ag==
X-Gm-Message-State: AOJu0Yw6H+ajmF48qQrrG4PTtV75y0NZ20nfYoB+ZGc0Gin36wWCRRJ8
	auBu02w0P9NlDpJD6B+/FQg9M/XWNHWk5l4A5wJptFngnSWL78GK3LnXCWy2LJo=
X-Gm-Gg: ASbGnctRZiWaokfl22QPhU567V8tzC+I2U3JdZj4b8wd/cEp5GpKe07Pb7U/Qc4ndb8
	vomUlYJ/qex/l6/8kIlAj+ckRBQmgYCfUoiALVNc5qFKuBtXMO2Wa/O8hafG5mmc+5zE+C4DGKZ
	7Dk5a4khSCRNbCMfUpbYhwpACTIFn3F2PPLyJOu9cxj8I15FoWLNMQT/9bwWY0epZULxWXWQy0P
	QjmflU+O/3NSoWff9Xgu1e2OH+Mkjj9UrAAe51heIqKkNLFLDKbhNR/OL8LBjkVw4LRe6jzevQk
	EmUAjgyNcZbojrJTwOamfdnheJI3yHplMHxm1MCZJjGveM9BHTagnpdD3UNf3PximAFatmWh8Kp
	T/FM6qZ+F+zhEpcWt5agw/uQfrJ3KVof9OW8dS+GV/2JZm8wK
X-Google-Smtp-Source: AGHT+IFjxj5mJP6bOnCCpncMZps7jS5a4qFjPXK56oXHf4yE7a0jHRSUN6QvWC6Str8hJfOlK2/9jw==
X-Received: by 2002:a17:902:e78b:b0:24c:9a51:9a4b with SMTP id d9443c01a7336-25d25b8922cmr124394175ad.21.1757966441940;
        Mon, 15 Sep 2025 13:00:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2631ee2ceb2sm67761545ad.141.2025.09.15.13.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:00:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
References:
 <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Message-ID: <60af68e6-7567-c11a-a1fb-aaaf4d5543ac@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Sep 2025 20:00:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17742884126

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/078cd3767749
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1002618


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
