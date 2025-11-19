Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272F2D9491
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763594951; cv=none; b=aNf73jm4SaWFCpEhsnEZb8q/c17Mo2nebS+uj5t2f/yA5rCIB+5TuSNCeoaqn3a07/pWdgUu2fIXF5emkR8juY6SPuFZcHeQm2Oe+TypzQ00Bjq63nsBD3pvUwbErcuuhmYqdKa+4pLayE9W2cusCoAGti0+ZCVBf7g0JEoZgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763594951; c=relaxed/simple;
	bh=fLg8hGDP8sIhNGyMilhS3KRWJzosTr0TaLIPqtzN1zA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UVDRMcAK/IlewNq142r49Pbr2NGKvzeoUmfIPUO+Ldqj7Tg8Llrsj9aOReLKBlUKG9NB6tsiyLeFMMUaev8HKDLf4OcbxIGt3DvvDo7DldhPXPXcSr3V6oLRpi0mGeqCtsyRqgh+Kf+uIFuNuKmv/EJgMze98Yn9lRGdf/L4gBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3BHD2XO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3BHD2XO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7baf61be569so275293b3a.3
        for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 15:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763594949; x=1764199749; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF9eQsJbaDCf7w0niFbxbU7J9ViJrruPcpoeQr/EYPI=;
        b=g3BHD2XOrNjutrVH7WZdj2Ej60Bm7s7G3lSjw9HKophRib+pHjdCaEl53jmDRagMgH
         VVsgPfP5bApMWqVzDCQns65mz2Apws/IVY3kQkbimdtrXh34DfY5w80SNjtgqs8mKGya
         YUNRh+OXI8DP4F2CTZuQhRzN0Ijuqz9uEA1KAxhwdZpgxLQo43JiV8CZGd4juw1T0kK5
         tvoepRxoREF4iOfgh5SwrgKZod7+hnGul6K43qZS2gR6OzvWuuOZMAEW9t3l9Jc3Qs60
         MVwocTr15GIQp9xJTt5Ebv+RzHQPweNMbo9jwD2GFo3ffBAwODFpfnFWAoCyBgDNZIWn
         22gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763594949; x=1764199749;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oF9eQsJbaDCf7w0niFbxbU7J9ViJrruPcpoeQr/EYPI=;
        b=cAh1hjH/pPJXBGVeol/CTtGIOUjkszoVe16+sex7l6+1NiO9KRST9HGGIdL/3/7B2t
         UsE20qM/8tZ9zFEyeSxFZMWh/pOmd92oz6h96K/WNpweINTURHl5UyxYDmcWFvyiUVVc
         7xXJFn7/Ex9h0An4bXKGN1N91zhPGr/3VMYHBNfHvDuRkkDyUJnTvq7HGdvvve7qThpL
         pCFb6/6I9GU3nZlx6tdgfy1QKrjnuJVzYsF4g4PUl8wiquHNB9t3q1T3CnOFS/wVFlTX
         qejIYTrjyMTGzRFatnrc+sG+Tcb7OAt5KZb+DzUL4uzmBXP/0Y/4afNaePWj1X/ySI1M
         QYYg==
X-Gm-Message-State: AOJu0Yx2zuPpvFrxvlKk9p+x1EbaxSJAFbJr/m1ZWD7YU7ztTyMthZr7
	rydW/tzz9dOYokvijP1NPm6gweFuZD5Hy8wJwzfbdZWBJAYQAwPlezM1XXB1
X-Gm-Gg: ASbGncty1sybravwvNXBId0X0DDiQzr0/SYBAJCaqPRrUj/XLpdM/yFIEELUZPxlR8x
	sai9yfbviWfNWqfu8SvwHd9qf8tXpSXruOC0ffePi8BEPVgu4Oydl2/Vt7z7Dye6IBmWQzv+m7J
	EOrfu7Bg/+q9eFM22XNcRSE6JauSYo0udR2CGIkKGxeRxRpoxmoldGbuKaLfQCD6C4WrV6na5eM
	eR8f5GhuMVAwcIp9ldCRIY5O8t5S11tnK0ZZem/OVlLlO2SB26SoL03CdbKW5TPLgbOkYsOQsvC
	/nozgvo1FVmETrqBDNAK+bWpuwG0i7QE+15ugKiZUdG5RIYKMhS2UNtGWkpto6YwyboEBrHpeT8
	cz7bqIBVG7JIj8WbYbZNazkAgbWorZo6L0ZnKADR4g6a6Ag7ZxeW8cr2lWfk7xSWqSEXYBDneh8
	TRtyv77qt3sxb+QDw4K5YRgornKae2XMgG4t5T
X-Google-Smtp-Source: AGHT+IFbsApsh7ban+eJEmuk1HqDBmcMChSdehfaYtOo2HrkaAIBlpRFOvDMJd+bovLYn1ZXGF9BXg==
X-Received: by 2002:a05:6a20:e211:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-3613b4c021bmr1325444637.12.1763594949370;
        Wed, 19 Nov 2025 15:29:09 -0800 (PST)
Received: from [127.0.0.1] ([172.184.210.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm546542a12.26.2025.11.19.15.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 15:29:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763588352.git.pabeni@redhat.com>
References: <cover.1763588352.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v6 0/4] mptcp: autotune related improvement
Message-ID: <f6728dd6-fb87-edf7-4a21-1f83fb779bd8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Nov 2025 23:29:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: 1 Call =
Trace(s) - Critical: Unexpected stop of the VM =E2=9D=8C
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Critical: 1 Call =
Trace(s) - Critical: Unexpected stop of the VM =E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Critical: 1 Call =
Trace(s) - Critical: Unexpected stop of the VM =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/195183=
67759

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1e2aec772c74
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1025526


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
