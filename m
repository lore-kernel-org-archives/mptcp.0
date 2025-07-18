Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7989191
	for <mptcp@lists.linux.dev>; Fri, 18 Jul 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752800361; cv=none; b=tzFoEwUzMAfRP2aeJqMp/zyTDkvYLieTydMrIzCbg9Kfyv8oSCwZ/x2aLjm+Qqe6CVen1EkViO02pwAMGto6yNQqIzTQ0OJH9qa3nHSVf/45KqitvsQvjRRlnAldqHrXWn5mfFK0/5LNDfoZfz3MD/pX5v2yi8267flVe/usD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752800361; c=relaxed/simple;
	bh=RVsOjYeELCITWiS8ihOpWMDqprCUR6tZMgL+8Ai5uUE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Y+xM6jWVxLlWfhh6uSCysTTF4lFeVi0s8OxgLqLSygCu7TSmoXJLXZJwGYvVvwZjuG4vYrQB75K8uMXL0WXdHIhsGr3aqLKN+8vx8DCCMoYiw99q3UUFplVFJRaAlNtZYDrDZ9hGYnXQ1qwfE4cobiYa3AEqlfpSMnh+xx9cfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4k1rRPU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4k1rRPU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235e1d710d8so17695465ad.1
        for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 17:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752800359; x=1753405159; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSha0afi8g/sZ5jhND6VXT7K/C3Kls4GzD4ggvGhR3w=;
        b=X4k1rRPUO4rVIaQa1CjeNzdIk3ZB/E2kFdxvWkeCF5ht8yTh3BVAWR+/c1FhEOUeeA
         +GUYH07/fLTSgUfvuB6pEf9v0k3Acm5DAVgRXQnFyJF7dFCwLRvjfFIboIl0Qf1h4C21
         6dR8/3Lqr5W/32NM1IUQCoCixlT1GzR/Ds7X6KLCWan3EafnY8+u0LIFxlZTwRRua8A7
         jNfka+KV4fClTiWK68PrJcP95cIIUHckzin3d5yvdg4Pz/oDFT9NnV2BtIrGTzTdZ/a5
         JxS5xVIKZPFmLMh7k7FYMGo1kbFSU75N0iGJCv8LgI7GuYuFNnRbrHCCRixcq82GPF1H
         MuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752800359; x=1753405159;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSha0afi8g/sZ5jhND6VXT7K/C3Kls4GzD4ggvGhR3w=;
        b=YLqGvybLgJXf/Sm6euuCOAuoEb06ufm/rGTFuV8ayMpXuCFCiP15v2wzuqdHpWTSDU
         eyO/HGaHZRb6JVOPJeBMZ2xmAa9m4Dlka/t2W5NLZg0ZjMHgg9JjTJw9CrVFqhd7H3uD
         CvTAGHfuDsjYXnKpC5CErUzBRWf82afBwe0W8x8PDlbVG0nNBAcvWPsxkVSnFFL7pNPJ
         JIf62DOs+2MMxuXdB1R7fonlUChHJA7sbOlLgrctx+waziJ4enZDahFxU+ygyGautoBY
         PoVClWUdMcuA8c9s34VF0ZDsHYHZrSGelGDcYSIpKMhOW8wVFu7YybkdkeZ636UublsX
         9tzg==
X-Gm-Message-State: AOJu0YyBZv9pWJDMk0cMmQfR/ucKZ7fMgeMXXZAyhdZ0TDMDOThZqdkU
	LB18lx6kaBD7I5TAN7/kbp+jewkWbTVK+CmuyMQcg6wStmrEGNSxGq8=
X-Gm-Gg: ASbGncvNLfvdbj3G9ZZQM2XE2GK45vE3FA7ISXanX0+TdUyt84B9rRpDx8zW7+GynfN
	gpBo3qJlj/tbnVa5GjrGXgRHRxlgemhl4XY6kr3nzRQRf6rQm7O1qlBZn403sxcUpNWS0MbEk7t
	OLhmKOK+FF8zDG/chSrljlyvPsTrkSwhy14IP0Dehs0EOqEMsBGoBOYdihT6KbOtKacp+dnJZ5K
	s+IoxX+4fRciNi/jaqa8AOwboMvXYqYIr+qlOReOQM8E8JBpSxAw3j5UF4yKkEOa9nkOqVcihg1
	knq08Ybk06A5Hkv079qzXg4B63PzXFT2R0YBoY4NBwTwSDECL18yzmbQENWYvd03kf2OODy/B6F
	0GHrrrEjMY6RdF8hmRAfiE+eivwlza8fqQP4lSZKfIG/eZRk=
X-Google-Smtp-Source: AGHT+IGQ9jWijEU5MPTKMm7Fh8vsCa31dyyjIMWc6X5H9ebgF/hT0rlIokSCoegn24wXcX/cIfyZ5A==
X-Received: by 2002:a17:902:ec85:b0:224:910:23f0 with SMTP id d9443c01a7336-23e30381595mr70605795ad.49.1752800358800;
        Thu, 17 Jul 2025 17:59:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.196.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef82esm2535975ad.209.2025.07.17.17.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:59:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
References:
 <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec
Message-ID: <ab6e0528-4c14-7e5d-0e51-3ef29a3bb48c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jul 2025 00:59:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_sockopts =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16358285418

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/605f4951c4d9
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D983523


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
