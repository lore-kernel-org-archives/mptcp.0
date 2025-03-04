Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0B41EA7CE
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092144; cv=none; b=DCASixdy8g4mPTMewuJr7erfd/eSSkcNpUxoCLrIQ2c1/JBFUouUsxgevrf67bQRzPBuPqf4PzISq2zXPkRbPgLqdyTQMxdZGvhWtoC3ZcipbVAtO3uF/gpxy2TJ8NEOEYf6xfvWF2JUt6YO9TZgjn5LjKbi9dQN+6jcpaTBdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092144; c=relaxed/simple;
	bh=iN89CD6bNWvnl5RxXOXbkJ8tGcHyqVfy1oQSLlnh990=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KgnHUZbStfrrfTbDud+1Lnph+R+ZD/Kf7TJHyUHZsT+6uu6hd4PPdEtInJhmdgnWzGTFIZtC1999gfis23M4PEuf07WCI/Incu9rGVayzhmqcgCZcKUooDmJ6vZxNw9Gj0OtITrNt5jozsNbGCaxKtp6R9+CPcr1fC29XyzzV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BArsGI6D; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BArsGI6D"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-474fba180cfso7622861cf.3
        for <mptcp@lists.linux.dev>; Tue, 04 Mar 2025 04:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741092141; x=1741696941; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGF309mxz2SxFH3wkMOk64nnpy7kmDF2UE5uyxto804=;
        b=BArsGI6Dya5cxxQRlf0AhaLeYw0I9rjc8B0WsXKFCnJP5qqTwq2EmzZVVZmGSqCpJC
         ULtWIBAa5Q8j0Wwg19Lir2asIfgcPKdNomXzBfLKTcazF0oiknx/jm//xussqJ26E2qQ
         NgKNV+/qEEXEx8c78IqROnJvMe4IVoVajQhdfL7RS2veP/rDO5abVnkFslktbn/ZvsIF
         P+SU3o4HDGzNSxw/7MVJ7tjdQqiinvSGmPXM6L0MKdefZO6DmXlp4jUoCP58pOXiqIEG
         oQePIEzziLmpQgy09nUaC81ItSmJRBqoVhsH2tiW6IRHm/ZWn1r90sQsrsYvYn9jw6jI
         Wx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741092141; x=1741696941;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGF309mxz2SxFH3wkMOk64nnpy7kmDF2UE5uyxto804=;
        b=Uv7jK02VhL0B11tz1BILfbZGFLYzkfBLZ5z/3khQIW30amtqchM21KO1W9Dg8jaev+
         od4nZjms58F5uRgRrekOkAdTGPJWVAGqpudTCh3iZFscGQXH2F+w5qdH2viMcPvKVVF7
         UrovQK/C9MDFRFGts9s6ZGXkz7mGoaPI4x2NuOdE9fjFh6avzo8DLjgtL+BPiN8hwQ4p
         2XH2+/XRpPyglknQrdon2LOLGxgoptCS36V2c1E8veazcftLC/yXW+H0FHy5ojPo2rlr
         wB6xvSmLs7PvwXPhTG30NpJExhqfhLEyp5JNPTnP2ja5tXNeNy6aZO1nysK7Aqfcg++w
         kFCA==
X-Gm-Message-State: AOJu0YwhpbEQOP212DXp/LzhRqXbO/UgpF/kS3YLjLJNFmI+IiEV4BqG
	knlsyHnD2OWVEdjjEB8H1pvMSodDWD8WB1LrqNdvmMLU1x4ZENEAwN+T
X-Gm-Gg: ASbGncsl+aBkB8iKfqcCW37fMptNQTaYJwxfiYwyECxu2OGQtKhwbUIo21USkHIo6zz
	Rp/IKazN7s0xD927sI/7yOrTCOKP1y4ACeifAElt2QfisSgx/guOuN/4vyHFSu5LJxz/77uDL8D
	fVAsu84kad3v/o8iaC90tdMOsGNFS5GWc1hUsxImj8JxtZexdvEFFvj/kJUp/taXuWtPUEQMRHj
	N+CMHFWgLZuJqHRc0IzLKd3C7MyFzaGJcRJreQrfUWaI25dYGL2PAqbrZwsGWv83Rb9IbFvj9RQ
	rFxvx6tkBUaduCoL+o7anB7HqcgUJHVU1WMm6NDHjQKA3xZIvWFJKu6S/leV
X-Google-Smtp-Source: AGHT+IHt0ClhmhE8PH57C2QqOryLmV56t+GBiStpE8QCpi14GLUvTjogpkv5adJGZEkmEtZ+CfX6pg==
X-Received: by 2002:a05:622a:306:b0:475:6bf:ff59 with SMTP id d75a77b69052e-47506c0014emr7998371cf.51.1741092141424;
        Tue, 04 Mar 2025 04:42:21 -0800 (PST)
Received: from [127.0.0.1] ([172.183.215.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474ef1ec19esm23796751cf.70.2025.03.04.04.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:42:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
References:
 <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: sockopt: fix missing get options
Message-ID: <b53ec688-1346-1ed3-2340-9746f1f89b0c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Mar 2025 12:42:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: =
btf-normal (only bpftest_all): Unstable: 1 failed test(s): =
bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- KVM Validation: btf-debug =
(only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/13653022673

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c0b81bfd0e61
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D940005


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
