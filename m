Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727EE21D011
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338451; cv=none; b=J3xmP74Vm2G0pUdaGz1znNJh+te73K5uLcYJHTh8XryutGfvii5a7C25EBXb9vy+jdgp92iN8r2XGaPJQsI8U4nFeM89MubYzNoP+4xSmteuJk00eeYPbPbuEwW9/yQRG0Z5QVj7Vm+laUj+TEewUKhowX+03kQFszB0kY+uPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338451; c=relaxed/simple;
	bh=+eH6AhJaPCK12E75CAiT5AYEzJfbhkx13dWBNoGaeGQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=l/2PL24mxw7k0Yk1ivyvunfmI1NCmaQQTn2ZkhFNh644Sdw/WNmZRkaXL6U5SbdLV0LYpzWYle7hxOpAZ0CvY/sioVGxzH0/VCprSSUEhTINOOhzAuwpRs54CiPdc8IAZISelnX9YKol8fR1nG0yuLzPpulzJEaBgiSYBRVDct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYGjHXGQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYGjHXGQ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1660256b3a.2
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764338449; x=1764943249; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQMv5HG1jl6BNunw/qdXYL5etk8vAl3wRABXN94gUwg=;
        b=iYGjHXGQ3i4TiP4KYnu7MfgJLh0DSv1aBWisqMK/rfH4+IV1yoi5mNs6c44yG5AXnE
         vF0AbMmed/JPLOveu8JNw8UNelvwKtS3dWaJLcQeTKL4LZNzm9hSNT8C3A98rSVgVxGw
         FW2TcZIxAtCkqkyH8zajyrv6uach80QRdlb8t1K+lw/0xQCcHB90UPGVU70zdDYpiUEK
         MWtT53VKGZtd6JJ7kzhMyuu0dOEbmAzwSLAU4M3JYbHpfLuerSsSWeCCwiphnRJ84lF7
         GSeXxfSfouTyqwdIFV7qCo/SOqSD6O7Y4RnIlW043L6I3KI8oIXb3PS5nbRq8c9YBbbt
         8Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764338449; x=1764943249;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQMv5HG1jl6BNunw/qdXYL5etk8vAl3wRABXN94gUwg=;
        b=gWtAJVQVzkmeYXukb4srbPQkSxWVxjHwZVZZk+OkbN1N79aVuRBnf2dsadd3UHRYFE
         5qXJb7ABzOqMadna/PWdsauKhI2v0LUk3XIi+/BluB/e5Eg2b9jFwbFWZW5L+L9HRYWt
         AP0wbp7j/TMgMNdyn4Q4wWQTD/7YItsje9Nhnz1J/PtCz5mF4wyqNGSRQbH8KIGTeROM
         HFjCW2H9vGEPCfvZgT6R3KhuZzbCVsyvSqCTA3iA5IoV0ky8H/yaK6fNT8ZPhL9Cp7wj
         0lNSl9n5x6ZcPGpzXK4kQE0ykFPLhi/gVRuDfn+Ovic+Estbf1nUEoNhbagBSzbmQBU0
         bE0w==
X-Gm-Message-State: AOJu0YzFj+jhhXFzG9g2obuxnxn6rhvyF+0Agc9NjnoWF81kpCQ8tnZH
	bTLQsmtHSX8TLlwjRi46aJ+hVCzDG1dzBfypJOYQ73Z4yMNr+WwbDJzuVg+r
X-Gm-Gg: ASbGnctr7QgFT2cNfFnwKuW+Itfxen3sC17cYrRAgvPcOGajJPhQpsaoTdQvWAWFdXQ
	+dNWiiD2bbuQgczSXJIMqL2l72HIX/J08L6l/8UMwNdqUnOWmfQaWy5xgonbq1zoTgNe1Y485+r
	tu7LIXiM++Qc4Ab049cnwGANEnSZvckAFYT3vf9SZqKUueLYpqvQ2ChtQ3Z3XsptVAN5TC2itiP
	pvHulmyjtuNkD6PnQcaUPYEvueaOwsktSud7ikFArpz/Oxzw7cNges+RBsc4DDR2/O3cKtxm3Uc
	+9kM0ryamPPxsyv8XHaU8JgCb+5xmwZIBK5sFKF5b40BMNC66VKnjvsGs3XdrcLolEkWGC3Q+FY
	aiyqD4t+J+NQNEzbXpp/IKnQVFa6F7Yz/Dr0gnn8DG55qFiKKKsodMjiOgPJS44T/IK3V1YbCCO
	pPgWKRn2pUZRzwUP5NuyHGkwcnrQ==
X-Google-Smtp-Source: AGHT+IHMitbrJNmCYBaZsvM9qb38Qpwl/hmNI1OQI+CmhjCvBrXlncRYp19fyeK09TUOuBHdWSHmag==
X-Received: by 2002:a05:6a20:e293:b0:342:1f0:9af3 with SMTP id adf61e73a8af0-36150efa300mr29310529637.29.1764338446836;
        Fri, 28 Nov 2025 06:00:46 -0800 (PST)
Received: from [127.0.0.1] ([172.182.225.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be5095a1d85sm4769501a12.26.2025.11.28.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:00:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
References:
 <ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next] tls: check return value of
 strp_load_anchor_with_queue
Message-ID: <56d942a1-1fb8-abad-81f8-c620c4e58267@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Nov 2025 14:00:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19764761036

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2ddcd4f5ee35
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1028659


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
