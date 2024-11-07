Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85118A95A
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974744; cv=none; b=qrIPaTifyJQPDqIrIFIBc6Hx1/ZLmSsj3qBPd+YHIxDjR1T+zU+OLFIZi3N1eHQkvjbe3RDcQX7zlCEb+m8CMY7PgVRSiBN7HfUQPgNdntKGF3hq0ygfC6ms/F6y4ICe7IOQx8VfFghKhsbYv1gJmjmGIa4Zfmlsvkom76BX6q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974744; c=relaxed/simple;
	bh=zJWapzhVyixj9MZcIyFJQqjIksBKnQrcWLhOrk8NyFE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Of+vAKZ77RvcIMHG71t8h3FOMATSJ/3RLn/UHsIvFDR3XUuBakYd41E/tUbVtJU6TcpydPF7hxJzQ56afMBXSqv9ULCYeuUz8ZD294mzbtZcSPFSMNaMu4dUQ5hpzZrOZF0Y40BiAa8zzQdLym1+Yffg04bEc0zatPkLaQ/3oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMZ/GLmT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMZ/GLmT"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1507c42faso144564985a.0
        for <mptcp@lists.linux.dev>; Thu, 07 Nov 2024 02:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730974741; x=1731579541; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynr6g/CauEhS2GfzRS2iYA47Avxk04RomRxSQZzCV2s=;
        b=JMZ/GLmTjbOXrED9bCsyKjBNz/vA38L/BGyTLRLa4nfRqvQZBAaXRRykGQxQ4E2By0
         YGu+3iBZBmXfHT9siTQUjNolSSUIRD1tPRxeRtSYbNpFKVduZEfZUrlV6APk4v2BAh3M
         vMbHSmuLS0XO3UXC4hIvLd2W+dvMOfdDhIYGSjxI10ukHPIvydOnsZCrC/mmhhvHPwMI
         uAUY9e3H/OazO5e2DC8wyEHZTNxb53HxNY/p2ODgJe2FoJP8eYeYOBCv63am+U+jSTfd
         iFK8OvgQ0ijzS52/2XwWIyp3cBoCqYzZqm5xqr33Op0VVA4MldOdMcGbSpuQKeYce2Yu
         xAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974741; x=1731579541;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynr6g/CauEhS2GfzRS2iYA47Avxk04RomRxSQZzCV2s=;
        b=DOXAOP29y7s26mYd/XEci8lWCZSVB5yDEgcB+BQF/dBbLZNMnnX7590ZJU/95H/LbJ
         qwMq5VhMib0J0W0k3QbmpqfzggKolxuwxf3CxglryqPEDIISyhxIfKcyBdVPPvW4Mj3p
         ZYXGh+Q3bH2sIDXpychXQFFf2KGy4z/3yR4GrZKWVEdFJreMDv8mXl1eA51vBl+L80xP
         mzuS/x8BlBpQa5uYWOQ6ib2COhpNAWyyxrtm7mJycc6IHD+69CcM9HNyfe0LAwdw5uqZ
         /AygZWEsALWIaqxg9DTROO4NZz3iTTeP7ycIoAv339sZZfeHc8gfj6jdkG3ResbhmJb8
         w1+w==
X-Gm-Message-State: AOJu0YyhlRdI1/GPhp95X0qm+maXS/v2FO0RDOT4j+eGfRmnWKdDnDb7
	wkv2RFCMR258nnyvPcc0T5vkfwAjxdE2nbNfWVwYFr0yz7LXohXKobhK
X-Google-Smtp-Source: AGHT+IEwioMDeXIC0pfKo4zQ9XiH9p8pfFfK/qEdT0f503C1YAlgs7jhUvEctKkvHIcPg24dVZ/AHw==
X-Received: by 2002:a05:620a:1a07:b0:7a9:95f6:e372 with SMTP id af79cd13be357-7b32dfbd49amr71065285a.2.1730974741497;
        Thu, 07 Nov 2024 02:19:01 -0800 (PST)
Received: from [127.0.0.1] ([20.161.77.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb0546sm48676285a.82.2024.11.07.02.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:19:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
References:
 <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
Message-ID: <db4ae0dd-845b-fc87-aad0-80450d7b29d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Nov 2024 10:19:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/11720123635

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e0cfb9d208fa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D907253


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
