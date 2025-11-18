Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B377265CC2
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 05:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443964; cv=none; b=A/r1Y6AjgU3ViPP7bHhNxkflodQHH9xORhtDtwfhWYhYhAEMJ64i+mmlxhcZXwjCih6SdzPrBMx9IoLdcDotgMJlBzDj2LuzN/2qC/2OgCg1GPsj0HXFLFxrwQC3WakPEbpVbKpL1c9HE6+tFqIJPuNrb+lc18zHZi80P2OSEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443964; c=relaxed/simple;
	bh=tg6UZMx+c7WEPFl8mB+Iwvh4PXDJmRSBNuVp9vE6RIk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pOgKo30yGzUmalhxeSCR+c7x0is7ipnkBYI5uZPNDFz3BYGbCHIvluWd3u97CHQkQm1gj/qUmfYHKHM3ejWpogdOngEFhdylwRYTde2qLgSn4k3GrtnzWGD1EhcBhvPY4z03Drr+hkfSikQWJR78H6W4uEEx66CTtdSo+q30m1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3O3+5xJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3O3+5xJ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso3941990a12.1
        for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 21:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763443963; x=1764048763; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyEweyL7IPZeOQPsd7zkVE1lrFRqGdPqbZO3Yh8XwYo=;
        b=O3O3+5xJ1dqSJNw+9kGgAMj4nznIAAvwueFwx6oArNqeBT84IpINTvFul8rOK31s+v
         dVLSetbrjGGgGQF6FPMP9M4YP/+7CRgd1iUQmiIf01bTiNjTA5mjGFe1zETzxXjJ0QLo
         vRwVKs4GToQn3eTkV4wDiQCrgBAaVqJiiKHOjQ96G4ciTfZ6Ztsx2iV3ti/K14waRjKJ
         j1QL5BGabi50KFq8CUihPIZHqCVbzggQsvfF6JnmBJvovxf1ua+OkZUmO/dJpYM4mKwQ
         bdke1B+jL9CaJ78Ngq23yJyZFyx6D2DN8zzHKsAGuHq7IV0588GLNr6R1uhOYD247ADB
         uTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763443963; x=1764048763;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyEweyL7IPZeOQPsd7zkVE1lrFRqGdPqbZO3Yh8XwYo=;
        b=L37FB/53POQv/rWP8dmWnXwJ5mgAhvlqp4V9UvHxd4vLpdxUr1H+qHPkhrPVkxBeNt
         okvJ51Zqyl0NwMFtqa76PI+4QW3HQ6hrXvvcVZUAwTyqhrnuNnAGb3m4gqrTfAqQ1LXN
         RYh5BHC9MIpu8ZuZje44XStq72rRIqWrEFRqrPNMxZZ52FiUqWqWVYHRlnzGqAQZTAed
         SncIqkblKQr3ZRJobYw6Rd/n68xRIMfaDLlykbb5wgNE44c+WeaBKZVDZG5k4ghb8sPL
         xKJNs1cl9DcJUkRmTDoAqP7NsFKMiBtzU5ZWnGxB6RURxrZVkcBjTaHPuKptgJQ45tKq
         hHsw==
X-Gm-Message-State: AOJu0Yypdm2j5G8W0vLz23OYn5oiMbKSbvAD9iZvlLCA1bNLmqtRCnDs
	e6FoidTIudU0gugCMU95QTNDjv171fRJKlUBEmbc2bIWVu7OCffzEwGyy4tK
X-Gm-Gg: ASbGncsTZqa1tAnTf+HWDmnZLiq0pzY2PfVruKI6VLQPFMTYRPovd2vo+6tjtPQIQWL
	xMintTktlicJkGgLdf4WO9DlKM8n5DD2b9TcJaTK709bImBTxtQ15lTT+SfXGtYJI6CZ0x3bL+G
	Wq58XZyO9RVGLRQwOMZ6F2dR4bv66HWxOdoCuMb3J4QJJ9uGA6IP6Z41zlhVAM/fyoUEHS3Urs2
	4HDYB3S1XvPDDUhcCAoVQJlBf9PwuB7JW3s+XQVY0BF1xM9OqEDyQLbhqlXm68T/7pkm25uTfJo
	KBz2U3VPSS3sxmqiEIDh6a8BKd37zQ3hGWJEvZn55PP6ctNGrcEiWfMsxSvJW9ENC2ffvux3gLz
	itR5rMjW8Iv5jY1gT654kisEZik3zSYN/z0ohM9Z/zVmKnOQduoZCQJZrpuumcFc634Ggk7sMYG
	ousWuregVQXI7PfDzOcpGoheXDL2gWGFExCybVg0SKlldn53w=
X-Google-Smtp-Source: AGHT+IE1YGeIMyoATaecMWOeFZHGS6LQa2RnYETKQtgdet1bA7+q/u2FgMsW0BtcyezFz5J6xvzgJQ==
X-Received: by 2002:a05:7300:cc10:b0:2a4:3592:cf65 with SMTP id 5a478bee46e88-2a4ab8798b4mr6884423eec.9.1763443962392;
        Mon, 17 Nov 2025 21:32:42 -0800 (PST)
Received: from [127.0.0.1] ([172.182.213.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49dad0aefsm41144042eec.3.2025.11.17.21.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 21:32:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3bb22c78b078988462e13e72aa6fd9a29b07a8a0.1763437914.git.tanggeliang@kylinos.cn>
References:
 <3bb22c78b078988462e13e72aa6fd9a29b07a8a0.1763437914.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_implement_=2Eread=5Fsock=22?=
Message-ID: <e68b79fe-7cc7-6a46-4c22-4e2b88c3a817@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Nov 2025 05:32:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss selftest_simult_flows =F0=9F=94=B4
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
com/multipath-tcp/mptcp_net-next/actions/runs/19453838924

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/19b94f025bc9
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1024634


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
