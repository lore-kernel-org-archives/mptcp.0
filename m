Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A263D2FF0
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875026; cv=none; b=EiL0zE/Z/Toy354q0/SSO4r3y3tp/2EdsaJ2cCDLG81l+02qcvlmaVBsNabALsXv1iuG3SDnrRn4AwcEAhTsWMn+ekZVBUyj7n8OB7grIepGhd4sVa1mFn1N+GFWlvJQaaROZs3tZ02XDrFeOs8eMuFiQnH9dd9C1Ld3RfNcGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875026; c=relaxed/simple;
	bh=l1sAMnPYahH359HDLaA8REMWPbqEnXePfeMPiS+AreA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XqdScsX7dSaZQoI5j5a+1npFzEge2O/PFH7LnMarEkmbyYJXyZbo5Bi1z6bLjp4c179tLIUh/U7Zm524Iqc81n/yaZZzXftKkvBmB9OBrQYtG6VDoGejBJYFrnIn3ErXmcA3aC2XNPOeChj4b2rHcOOZ31kVNuG5/9xj+Tyon0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmArgXxN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmArgXxN"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb38e86cf2so480778585a.1
        for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774875024; x=1775479824; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1onEgnsYc+QtTB5JS28aRcHFM/YoI1YnAyKUfEb8tg=;
        b=NmArgXxNXQ6yA+umlXNAsrEKkvRasUFDbWLIsU5rVOC7g55FpXsTfMIXwOcd0sSl1C
         59vy3nVjKTpkB5tKP9d48B4tm0gsIH8ogxiyXb0HHwcWA9Jq5ww+h9RHsJRt3ORycqgn
         Yf5VG4JxkOuDVBLVs/Gh4aENKoL3FMOgxP4lfPifX4dr9pTQfm2pAieX4Ec4hIP+uBZL
         8mtkW1HXR/f3jgf/1hLOwmCRUGq3CvL61Ujw4rdebRWV2pk9mVm7DmHparh88gORd5uu
         t5sDviKbWXPpBSUYpC7OB8UYTXjYeRsxZVdZvpwBtO2hhwc11f2OX60rnBAiLiUyVDmx
         vQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875024; x=1775479824;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1onEgnsYc+QtTB5JS28aRcHFM/YoI1YnAyKUfEb8tg=;
        b=W9cq+zPUcRPtjDrWmPnKe5053v/uuePF96W2zd1nSkAWjpDMgjDR7oc0nEy+P83OmP
         BvN8egDmsZAfd0v4w7v7fxRGtd5Crl757n+x1yCbhv2nvzDCE5uh45W9w0RmqNfUty61
         Eh73kUxU+FNkvcDJ/iryChO7TILMUixgjqp2Ldx5IfOUZyOB0dvqZZzachzbUnIzadyy
         oNyEEOc5ehyEz4sRX8OxHC4vXNTHEv8GB1C/pbz2BrHjYTxnQ0gzbMOmOv+H/WBGq+zG
         QIsDhdzHBMN/r+ciwRIV87SGLXlHpWVA/a6sMlkvqfjo9I0c9MHzM4pYpYB7X6dQ+Anq
         ObiA==
X-Gm-Message-State: AOJu0Yy2aeI6BongzUNdbiDxd2GOjvf3uL7XYSnr7fBzHoH83InKmUGR
	/bpt/evg+KFKEy6F1Min0V+XsBgbmkMzQS7KR7L4OCg+UN/s+HykLS4=
X-Gm-Gg: ATEYQzx952GKhGFn01QPCU2oQakWnp7KR47VZUkbgH6Ms/qdPrqxv959Uhm2qcbCgiI
	FlJKiGD4jcNGTUpiRkAt2aJgfP2xUjKe5Meg4j6mb3d/xGhO85WPxJWBZ6fGXZFEj2l/8ejnkpu
	KDFc17W0JoSGXXdcSJyvLl0KsUkrEwjWCn3lkvYytnBO16lAxZIYFOO5p0MOU0r3xmTn0AfOqzf
	em3MsHhLsLzt8h2D3c6KdwWleqNBMuwSR2AW12VtJvtITNO4J/c1dns0qgllTa01O7o2V8gjNox
	7DFqQhhzF6j6egLCh17YG2K2/0w4sUHA25iXA8NkeOqgWwgVmX4fB2vkkhBo/K0iabCzklj/QaB
	T1PO092uCqQWCP6t765GkcNlOdytCpGoe/RwF5fcE4AgXkwkGe9UeLcw+T6LA5VgyhIObogRrUQ
	XbIpo08h12eGZ8C15w7YaXuRjCDYjsag3Qcvi0
X-Received: by 2002:a05:622a:2307:b0:50b:36e5:ba0b with SMTP id d75a77b69052e-50ba37f5b78mr176712171cf.18.1774875023820;
        Mon, 30 Mar 2026 05:50:23 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ed0521d64sm61529366d6.49.2026.03.30.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:50:23 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260330120335.659027-1-lixiasong1@huawei.com>
References: <20260330120335.659027-1-lixiasong1@huawei.com>
Subject: Re: [PATCH net v4] mptcp: fix soft lockup in mptcp_recvmsg()
Message-ID: <3c73dc30-aa12-725b-824f-b7ce0849e8b3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Mar 2026 12:50:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23743540784

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d71e80e5a45d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1074553


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
