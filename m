Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87C1FB1
	for <mptcp@lists.linux.dev>; Sat, 23 May 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779575177; cv=none; b=pBvugpGWZCnlmDtT2mP6ymP+ew8ZoqVlbDGXUQAx+y407AoB8gf7/iaEhrwzcJknzXNVeaaavmWfFhshUbQ5zJMASvYChwkkIZmOYmLSSOblQ99FOC/Y8JViE916VobMK1xSsePIho0qHRmckm6VXaimHOs75udiFNCniqKMCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779575177; c=relaxed/simple;
	bh=SdTstgaKzZhSK0AKaoIaFfrx6km7yEZgftL4lyY5w3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=u3E+BnGYSY0XhsCuI/u/OXNlzThsHC3LWM17gkVmu7S54Kq6kkxIXcniX4wW+JJLv1aQDrGRJVP+zknhjd0tqN4xrWCmAEjHXVPquTViaMP/w9mTbpf8VWzYG9Eg2u0c42gO+laEabFUDS9hsCA2S4UwLmE/FY7Q0grTWmW2ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9US42u/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9US42u/"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516df90c167so12677541cf.0
        for <mptcp@lists.linux.dev>; Sat, 23 May 2026 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779575175; x=1780179975; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES54o3jCBkM7NaWf1ctuLPYEGMyVtirEVmm+7AsNTWA=;
        b=d9US42u/qxrT+1LQxaAMxXml3eT/AAzFaENwc9hqPopRMhktv1AH2pdurC0osY29i+
         HNFFbMTfJxdjRUzifl4gQeq2eNu1MfWTLgd8NT6oYmdKJ3xQ5WVnB0QnNHBgM284Gj8r
         yXvv612yE8iCWRxQSqamNPDuQWb+xwrsA5qZRYiH8IzMhmngLdfBdfJOmCj/l2vyYw9C
         7TFIme6SWLtNfeSBdyLJi0T461PJ4SaIGHxLO0GcnwiJw2m12Ni7TehppJzA/ts40ToQ
         C/Zc4N9ojYZvigqFPl6UhrTjvMQ0ecCgywVUJa+fYqsQRJ71YMRIoxvWkNNJuue0BzoM
         1n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779575175; x=1780179975;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ES54o3jCBkM7NaWf1ctuLPYEGMyVtirEVmm+7AsNTWA=;
        b=NkcdhTbfcek8NzpyeF3XVd6FKT7lkmcOhyBVGvMMZGdSMt//trmbeRLWIq7zo+65MT
         atxLlpRjiq+ilW7yvXUJmDZgPW2GEOTC4LLmVqX9btexhvT3BWvt46YWmasM6immQuZP
         b2vqFRb39IPe9ZHjbFqCg+nBpvzyKs41IC8FYoWYcXHKRCb3FUgR/fyoLl6TjgFtP/Oy
         nifeH04t6JRDscJY/EOhOHYe9tsvOJSbgmMxzadQ5LrapeQkeMU5CBoHtW3KhJRyH9D/
         E9oGiqRshy6m793/Lm6ctS+R9zbUm0kxYQ3S5JlAu6Wbx6AA2XD8x4gUPnOIzcvuxwrE
         OP/Q==
X-Gm-Message-State: AOJu0YxTPThHYoJq3J5yc1uhmNg8H7PraixSsDclfAiuPqS1PyfLYj6X
	YyUFg6nYVbLl8DpkdMntrKPqZ5T8egqoT+8LDEtNljoz4V7U8sB1rhA=
X-Gm-Gg: Acq92OEDZUNgkX837m2hEc3GDIt9fo/rxnLeVtK8UfxTO9QISwbgLFL3LxOMV4atb7o
	N+nANKGBkLd3BhBmYby/sHAT5u09R/vtkWwTLfi1XkpDILtvw10ONWgDup/d4r2+EV6nFNrzsyi
	VJJefVkWJ8P1W6YEFFwGl3l9P/KwdIYXLfHZkLbXOL2TH3JGAy053uvVN2etqV50K5wh5PnIr96
	B+Mkoo8T8vXsqpnFlJAZqHmMWKgn4A+hu7s4Uvm8NEHF6Uzu89q3SexYuRgFp6gA/I/wcMNjNzD
	Q10E+J7uVqGW+dMTywH6O06LD/ESW+uxYsnFN84LUEzX2TESo1fDtWrD18ImJzlmkKV/4T14I9J
	VOsPGkwF7J3m3Rqfe0icpxRBU9PjvDtSh+mIBJIy2PxNdcxrw9lReDuIcDI3NirapcRgftmxfsu
	FPplbkC2uaNyzts7utAvLCy01qPKnm3Z4iZC7HmVq1RIfcRUc=
X-Received: by 2002:a05:622a:652:b0:516:9b30:f025 with SMTP id d75a77b69052e-516c552c550mr149983391cf.15.1779575174659;
        Sat, 23 May 2026 15:26:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.86.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8d07bdbsm48510231cf.27.2026.05.23.15.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 15:26:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260523211800.2952905-1-shardul.b@mpiricsoftware.com>
References: <20260523211800.2952905-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
Message-ID: <0b9cb8b4-7a7a-de9a-cfc6-29a318f1fd89@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 22:26:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/263441=
78577

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/720d0b3c4bf3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1099905


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
