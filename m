Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFACF277CA5
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890396; cv=none; b=OzBS99cyayfT8y5pEdCVx/mO6Maqahhg9uZaGhShCPrknsiHSRkYOjE5mm1JsHudrUouNL5a0kvoJQ2sRtVKUUqRPGOXAQhmQzquFMhjvJ4lVKNw1cs/os1gMhAJsSKxahPWJhIwKjn5jsugiE3oMy5hV2uIbGCynWqdsbHJ4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890396; c=relaxed/simple;
	bh=Tfbahqwmx0DCY2/duiygd98KbtpfJvUueyzgIhfp/10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JFqPvc6uRDXbDYkqoQX0kQsmMojH9LNdv3Pd8f/8qecgd1+BdxgFzqlTEI99fvVmVC523qwdiftyhIjAMrsY/z7EA5ohuYoR2/NeObmo+kXIkmHTq23NovyJRaa+YN6JoAAY/MwGUcEcUx0LPAQ9OcazibWYnlcIjBWkk39W7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1eONWcq; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1eONWcq"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0cea8883so2129361cf.1
        for <mptcp@lists.linux.dev>; Wed, 01 Jul 2026 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782890394; x=1783495194; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQlWHCiVfOA93vpD/zgNjgc1gndQUJkgaAvGWSgz7fE=;
        b=b1eONWcqoe0dZQYgLRzqUTKx3mu6CwbQV8VSSIu6zroCYAngGxtuHKV7XSWudzcMfs
         IzF9e0WWUgiSqUvjhhWZ6hbmzfY9AA+zb3KMXvtaVGRy31o6lNNsKE7dursfuYvytRlq
         OLgyur6ktDVqITdKOYR6NUmZx0M8VTGE12+BN4aJa7ypsOi6F118zasJs7YIw8jSNQWb
         vXkAwXRIHVnz3q7JrYGQfEDoSw9TwkPlB4Ickqb1RsZJzzbssE217ilhtrBlKqbOSSsN
         ZdFmwYFTk9JovXw1ECSQMuHFNrF9G5tufM3FVaD4qxW3x20VZSF97cToHCZBoj+t1q9r
         RXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782890394; x=1783495194;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQlWHCiVfOA93vpD/zgNjgc1gndQUJkgaAvGWSgz7fE=;
        b=UN54LVMp8wkn9lT+c3CfSjTsPBLX5E0A8gIkTniENRyT3eMOtTpR0f+5Tf+NHg9g4Y
         AH7RPViSiltNvL0+KpibY9yT5AgfyLVlE/yXsYZ45YXfhKko+CU/v/vdzHBnS6+YdOns
         WoPEUVBOd2L60HvLy6vZacJnjPHhD0ZJ1j896do0SB2Tf9F2/iBEG5Ln0BnPAF3kdfW5
         B4wzjRxZta6XV4cZ8Uj9/Y5psEMzQe0bbkUuI8NBkYldF5UGqG6B7hw11SIZ4Ig/gVDn
         4ttghzxhbxdiutp7qNwkqC67yM8+1pmjXSBRHTudMIWMcN2S5XmQ4Le0oiOjhxPQOh6X
         1+Iw==
X-Gm-Message-State: AOJu0Yymd8Y5DXn+x+GCBb9kCAoi2h2Czfb7kArr1aOwmmhoFbR67dGJ
	EY25lShd91jywyNEjei/Hj86v4FxlYKNagzclQB38+G3Yc3ypL4W3O/89MLq
X-Gm-Gg: AfdE7ckFnNvgeQM655529E3K15dnWexguZbnxT190kHPwdLPrkuiz3RhsHI3cky1E0l
	sk24qP9ApvA4bhe4OlyJedBC0lICaPsBwaKR9nGmvcWetqNzISCRUFAUL/RvmvdJfiC0uiznMD8
	tez9K7jLuYq+GB48d3DtPiOCJ0pwxWSkLdSg4eXa+ouuoHPU0MxgX5f3qE1weVnEAZ+nTQl4Lu+
	FShit1IUMAe9k5M4xWIXEfmHw30/rR0wsxDWjq82+P9lByu5Xdsv0jEphdcwyEDKUTSPaPYzVyj
	solZni5MIWsQRLbDTHvjCpfwzyYyv99yon4L1t1viJSGrAJ/75KFjT8sasr5BLza7MtHxKGCyT6
	8a3A3j1O3mTYCzOGh3wlkNTfFPuqeheM3EJA07w1cmE47RIGlRlfJv71T8YPF5f2/fYvAS4GbpV
	qAYH9h5RfAfZc2sY3FJ9mZjYdDvfY=
X-Received: by 2002:a05:622a:15ce:b0:517:8db7:caf5 with SMTP id d75a77b69052e-51c26a3e586mr6168141cf.5.1782890393844;
        Wed, 01 Jul 2026 00:19:53 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10882b66sm37446651cf.13.2026.07.01.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:19:52 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn>
References:
 <de8555fcb235d0e93c02c20bf47231846d30841d.1782886142.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: userspace: unify entry free
 path via RCU callback
Message-ID: <b2a656de-0f8b-217f-8694-099bfe808fc8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:19:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/284983=
98551

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a0c22b619f0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1119431


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
