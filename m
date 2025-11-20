Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45D3644D9
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665310; cv=none; b=cVBDP7KMYMUtW65GVaRADlozFrvSONAoFcClZIng6TU/Qta/ScpDV+l1PJHDnxeehqqaWhLmG+bnxKwnnSWudfqpXhFVm4WfLq1yAt/VLOaWVPIIEZg6PGzDvNKN2YiLbDKLfegbbZ+DWbX9nZjgg+zwWzr18flFpgW6//1uIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665310; c=relaxed/simple;
	bh=MMpy61hGyXTLj1scCDZl3xmCQQa6rNDcMDQf2O30yV4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=clTYCDXuZbD5oyfCNJwDH1EWEXGE28C28gkPFuiSZS0s//GdREV+l20zDfD/TLSDVgmLPQrYKrFVLbgwLO704xTaYCRmKVnlpaVI1I9jLw0AcTaVdUilqvtA5tEg21DFKtZltsJxatHVtwqaNy1cvVfUzwigM6T8LApvnYcIUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcaeCZpN; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcaeCZpN"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-433100c59dcso5000545ab.0
        for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763665307; x=1764270107; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWPnNkM3SFvOO4wMb7lvfqgws3zGsHBUZg+DF3VosGc=;
        b=kcaeCZpNPLXW8AkboFbpFgzf5ciugU7FvuYTjp3AOvQjOqnjq1zBQmjCr0RyIiVS4Z
         LLV4RwN03MHzZeIniWv6lBs0Bc1B309Gp20Hsoh85x1MqCKibhhQqmCFsPvXBxrqQjX/
         BGxSTyrZ9Cc8gEh39c5RRE1t1l/LYBQnZRm6Ek4EVhyMFwFLBrB0HqguooUmxlWbdsa1
         fU2dtwBa6bfF/gWnmefJu8UuS9FS5VHuB2BpwYdgK1oRB3zoNGXVQGGotemR3F3tluuo
         B2wTJTinDW6Dbe20lc1vBsa7fKGKrwmDli8QfSMo+a2NQcacNsURs87SIO6uc+Lirqrq
         DHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763665307; x=1764270107;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWPnNkM3SFvOO4wMb7lvfqgws3zGsHBUZg+DF3VosGc=;
        b=X6559hQoJVWTXVBNpWSlUZGIh5tPbsQNjTdj+FrGhjCwXMp1gy+/Azm0gbqdnQTx9T
         XMho9kF4oCG2oaXcOgTrwf2t7qy0DVwiiae6ObwST9/7Kc7ESqHlpCGmfVQL+He9t5YR
         uTSqkU/EoGcp1/x2JolcdC67eFWwvAn5NYpUU6YRM4eAmb5xb6UiV70PvmHbDt6mELcB
         KUFRhx3RsBwWl7H7hUhYxOgs6aULYcDPHHl9Z4GtpC1XQTVpvRAp+zN+025Y+Q47O8pb
         9GzkSyh1uOH7l9RgDnJhkoBuoa/22plv9mzMRVC6MQSnTbkvo1bnGD0X1he+As5NO046
         +6jg==
X-Gm-Message-State: AOJu0Yw27FWLkyBmISCsAFbAst8gfc/K3CYH3YwNrrLztBNEFVhGGTW+
	2jtH3qjHWQtCw7hvipgNYe+T/mXSdh5tejLqpxqITBeqAHpHN36vK8VWtX1J
X-Gm-Gg: ASbGncs5ozmuLuCtVcY2wkwwEOrnHLLKwLChpOzqN8XGD83bE4J38cvFUYn/ePBru5Q
	+JryKuS4yWB5q+3ZOmOblbWN7LonF/uWMWFB53yLDGl4JGP/eyy+HdMRyue9lw5T8Q8jchxYnPd
	SsbwwpeNeysTabA5ctlimduTnAqPjf5mUiTxPkOXUrNPil2Sif5JslF5IJsMlUokKMA/H8S4ZSJ
	oBVwcz7CA4/pgyV+APwMztsFw5T6dc1OqxH23XCEI7y8+lNgTlsby+VxREhHTAfriVS0k9aaV46
	lkYQlZ+0a0VfMH/7APi+z92Px/g9HdL8jD929bdcaaX6OQpD8NuFkxSfLqgC1uxuFETemxaNcLx
	Ba7Fl12Je/U5Grb7WtJHPs59LPT+wlhHaeL3wonrtBsl/BDwxIjKlYEXI78ysftcyVancs0qcpN
	5QA8B/+mS58A==
X-Google-Smtp-Source: AGHT+IEm+H62KKAMmrittg3eLvMWEKxPInxe7dXEB4P1FqXjFY24MJ2ZBlwAEJvj9Io8kB+WdO5lBA==
X-Received: by 2002:a05:6e02:3f09:b0:433:78dd:18ed with SMTP id e9e14a558f8ab-435a9074ad2mr38576345ab.26.1763665306885;
        Thu, 20 Nov 2025 11:01:46 -0800 (PST)
Received: from [127.0.0.1] ([52.176.138.177])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90c5adfsm14130475ab.22.2025.11.20.11.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:01:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251120174429.390574-1-ast@fiberby.net>
References: <20251120174429.390574-1-ast@fiberby.net>
Subject: Re: [PATCH net-next 0/2] tools: ynl-gen: regeneration comment +
 function prefix
Message-ID: <6ad82c56-19b5-20ea-5e30-8e45ce73a67d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Nov 2025 19:01:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Asbj=C3=B8rn,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/195468=
18189

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f040cba4ef2e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1025958


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
