Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61711CDA35
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634557; cv=none; b=C2pyDcqU+PFCTJeBklk/DN/nYdFC0j2UX1qW9056oPOwNHGVwvvkL/bv0tLy55VjZlGRHCCle6atPlL0/BPI61L9JrB2PLF1ar8wudYiqaFeQQlVMXxs0YoC6f6dAieHyb3+7f5PQ55PIBF9nePh29CwmaPibu0pRIwbZtHc0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634557; c=relaxed/simple;
	bh=XzZZuTh1T8+uPyxVMmj3nswGvPx7Ds5lzzBjK44HXHU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=el/1I9pLOj8SprY+CkAJaxqSQO7PCYAGqT1gAiNjqe0VT/7IOyTFcXqfO+bDUjOS62xUkyckBNHH2fltHJsvw9FeOCGKYqJXebEiEfRlWsGw9szSOxRJlCyzamVGqTBz89dxsR5MjWlGPPnb+RD7zFLbegWKjY3SuArtJ8Wq49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPAdB089; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPAdB089"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c714cd9c8so61449735ad.0
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634555; x=1730239355; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUEdvOnHZa7c1943/U4mTGWaxlCw7ssc9A+g4TdrZm4=;
        b=HPAdB089lUvQYFFBJP394YO7kMumMUHCAW2ibJDuVdTbMseTA17IvHLXCu5ihqrNwE
         NNJ/bLNlxkg733hAMtdf80wSttuNRDq6hA29d5JLIx9eMRThB+VL5aEingNu+SGlXcs0
         jSjfEPX7ymdEvj77EtNQ+fs/T/RbjPaHdiuVuBUJ3oSoSR5Y7yrtevHDobEysH/W/gBj
         RAH+1VFRSA+ldNAGe67CQ7iTJrVsdani3ojFN3nGXaVpehB0H9QodFwFuWHJo/7cR+Jr
         qiuI4w7DRJACWhdg4WsDLLWjodxCHxSyp9jF7otRchTZVQoOrswlZE1ox8cGTsjLNFZQ
         XdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634555; x=1730239355;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUEdvOnHZa7c1943/U4mTGWaxlCw7ssc9A+g4TdrZm4=;
        b=qMJdJ6N97Jjwxxqv8vTQnP/GBnlPRc+qTiATPX/M9yfWr/jp1RV/OKnuezpJp2LWSy
         wddZUv+HLwQFm/T2oC/K4zLhLfvBx5NR3SlkN834sINMaIPe5fAanbvzyTNkwn6b0y6y
         +pKOIWlVBWLEtuep31ZQPqcUWXI0isvfCmsXNUtHG+o8hsz00CJED6BvMxfYbujL5BOg
         dbJ1dUT61CmoqXioFz+17XRUvvjlbdOEFCcN17FlOw9sCpzBR7SR8yRRywuhtBsCLrbB
         jNVNSGKlDwarKV12VjGXXPqdAEN2OAFE0aYkFFYt3Uvwv2U9LZR2fNnthPXL7al5hY+l
         EWSQ==
X-Gm-Message-State: AOJu0Yxn0be9DZbJuXmTM8F1/RniwWcbGcZGaL/P92dVgiVSKR/zQnJ+
	Fa18bZktQA3DT+LHFA+rvXUm/b1gika+wbAYM0uPbtbP4S5M8Zm7tg/2
X-Google-Smtp-Source: AGHT+IFIRgzRRpCAgL6EW/0vFq56WsmZ/fPZg5w/93I75n1MpTGxEv1i2GQ5XlsWsiNca6SHDhpNaQ==
X-Received: by 2002:a17:902:fc8e:b0:20c:7485:891c with SMTP id d9443c01a7336-20fa9eb5b1dmr9239025ad.54.1729634554633;
        Tue, 22 Oct 2024 15:02:34 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.70.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f83f1sm47048655ad.298.2024.10.22.15.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:02:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org>
References:
 <20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: use _rcu variant under
 rcu_read_lock
Message-ID: <cf88d9a2-c132-adb7-98f3-8428c327fa40@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 22:02:33 +0000
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
uns/11468538757

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4c879c6d556f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D901964


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
