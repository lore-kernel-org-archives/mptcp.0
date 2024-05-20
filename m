Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF3224DD
	for <mptcp@lists.linux.dev>; Mon, 20 May 2024 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218727; cv=none; b=m88AzeRXA26ZJFUQrYNFnB+jqdMhlc/tax0DLbhQVTihLK+A9hfKDPtEKxjpJX0fqD6lOf5GhVTQYn98zFGMTGzhxWLNlSTQqKoYyb7wg/o01wMV95yBqim5BTAssuQ4dOQddr0j7pptrtfWP5UWFWpTL0Woa9nn1OJVX5ZefAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218727; c=relaxed/simple;
	bh=YzY+DCiTuUAce3chb+vPEd8PQTJLKa69vhK2S3quih4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=S1lU0U+EZ1twYM9Z5Qm301NvHHtu2PrruUDG1bGKD689hkDg1mZWFB1ngGfNCI0qhcnM817nJ0F22Vl2Bhei/5scxADsY20LoptRyuLRloEeokLcQKfjQ3FVmUHNord1ND1KMfrCqY+4h9lFpQUtEiz9RWTVDpPSdvc62iq7xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af4Knd8s; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af4Knd8s"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1eeabda8590so72872465ad.0
        for <mptcp@lists.linux.dev>; Mon, 20 May 2024 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716218726; x=1716823526; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9SURV0+Qljv+m+kMB24iKuAyR5c9sVpGvXQ1o069wk=;
        b=Af4Knd8sKSHIDfMm8yEiiApzZa3Jv2pIhqn4C9WPITP6cmMcugX2qn5Cr+mIQnmGTv
         geLsu7K2qVjh+gjYWmFr7PQtugNKyBN0UD+MgNqRphX4H50Nu0ddyZAmquxsP7QcH0hc
         22S/svqINPdVFQJymF3g0ATOM7O1gWHwbQySBxptiFpHfsN76ktXmtLpIYW2tT5R6MkO
         Pm/12nuZnvzg271MJiI5/4tOQ1h+f1/3e512sJrBsq8kIh1bnRHW3ruenVRsEdyX06fk
         P1onInnIBnH+xCPWzRKW0vk9NyS/ZDIYGdQsaZGWTAN6RRiRjYfw0WZN34ta52jykPLT
         AyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218726; x=1716823526;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9SURV0+Qljv+m+kMB24iKuAyR5c9sVpGvXQ1o069wk=;
        b=qRdCeHC86gN5tzgokVPeLFIaryKWp7i61iydVl2d6NfNNEH+DVf2b8rSXY94uYB7ri
         ZkwC65Uera58nVEuOKuED0tegIGa0gtcItjWMOjn47KNHpKeG8Mjle0wQqG1BFs2wykN
         NUaDequIvmSbpnvcvEdPqQDuMI/6ZMKTpFoJwU23OWuSO5JLzWPRMtWp14hftDuUJ8sJ
         wYVvL0oS9QWDl3eu2NmKTy44W9veQz4EtRj6enpkHzS3NIaAJCL6/G9GLrw0FhJSaHiT
         g0DP+PvjFZffqyQLW5ftnNDSF2hDXnGjQkFhkCczZzeMCzBV32cBxy8xlOiGXRonxWY+
         sHyw==
X-Gm-Message-State: AOJu0YyEXTlxiGJtrB+W0jv0OK8nTtpuPfSJQCu1Nv41oxGP4wlzcT3f
	BteUDttsBcihJZ8Ze6fNuw2T9amaLRZNNXxX/SLaoif+C1X69HNDv7uf
X-Google-Smtp-Source: AGHT+IHvBloXacnXYsATbnBuR30GPOG+GxJcuzFgJAjrpme/yaRRusWKbC9mNPxs4eV0I3Ko6lbMbw==
X-Received: by 2002:a05:6a00:391a:b0:6f3:ea4b:d1c1 with SMTP id d2e1a72fcca58-6f4e0298a60mr30007907b3a.1.1716218725694;
        Mon, 20 May 2024 08:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.142.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b26cf5sm19209888b3a.195.2024.05.20.08.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:25:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
References:
 <20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org>
Subject: Re: [PATCH mptcp-next 0/4] selftests: mptcp: mark unstable
 subtests as flaky
Message-ID: <ef789b90-4fdd-c18c-e45d-d7b58f473aba@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 May 2024 15:25:24 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9160572069

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b4fc99eddbe4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D854426


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
