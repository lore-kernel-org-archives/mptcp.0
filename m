Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B671DD0D4
	for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212642; cv=none; b=oYn77zEW4ma9NGc5ZTME8fzgYU5vyRwy2GKFjk0KlK4eanfwsMNG19KlwRqsgxQJ1lV1IX75TuA8Tx4CeYDOmpuUawapv81KClr4mrPhn5wlIs+wKxdNdDMg8JXxscy+KsfW9b8HlfoihX933OOy30jhwMEFPN65Uo3L9pCXnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212642; c=relaxed/simple;
	bh=uT4n+O507j2BKlV4NkAvGqqTDfsFcvWq1IN3JCZKS3k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qJJmA62l0tZiFsGRy9wSWmyZzyjN2k77VFbrwoyKOX72zsSS/lHiGLKExPSW4/h5EzdxbdJ5vbLR6Il4KtUsKwZDkOYiA1qOELfXYtbzv/dNANUsaNjit+GyhyDW4pT4sfTr4Xd3y1bHh2stJ1mTNmA5pMRMaXT7nkdb7mrSwJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkeUzW2T; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkeUzW2T"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f04816589bso183240985a.3
        for <mptcp@lists.linux.dev>; Tue, 26 Aug 2025 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756212640; x=1756817440; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EniYKbiGfxzUARHipTEeLWMVJwTHjoRf4wep0IjludU=;
        b=AkeUzW2TAbQ4zQ+kdqDxilN3PsTrf5zU1Rdq7DmEw+9FNcwhCu2L1DGKL+zlRKiHcn
         3w+VtwYINicCHg6iPqKR849ARJgkAxnVuVUQ7pPGxseyjpZbBuQCLFnsBzjA8UyeItho
         IX1wEiHCagRWJOnzxH/8uxue//ue4AFF89LW5ZFIZTS/GmD1vcuSGiL/oyoFLkughkHk
         Jm6q6EHEsl40szdNodLdGF/l2DDsokZha5gs0q1cI2t9a/uKOKmgBT5najsSCTamak30
         h7bjkFNvOfQXiPXxpsomOOx4W8jHVuvilpnqb88/Z+U0qqwBbra0MD3rGup9tGDhA4gw
         2CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212640; x=1756817440;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EniYKbiGfxzUARHipTEeLWMVJwTHjoRf4wep0IjludU=;
        b=SAPbfdAhr3INcO7pESmV3YyCly1ls79uZ4pANlg/VFhgF/1XrCygv97e3GVqTSb76Y
         gOl8W+X5RfX8F44WJaFqZyFSQcmIMJm5kpuf3AeRXVJyBRR8eQs3+MBH0uFts5wLP6Gl
         PCtLeNhhj/c11bMQYByi1+pZRq8UnXGnXsRZCUR+SLAG1OwhZvdWIjNn7OVS18xz1gxH
         z/chQDwp68PuS5grvkrqg8DsHphUnnDK+dzS9Uno4FP+e4/3RSMKuvqX9P+vrSA0hbQA
         7BXNWqsofAc2z2UZP243lO/2ZJ52cXYx1PFaCyOdv+htmMoPQicgO4QlGdBtg6s/S0KG
         TaPQ==
X-Gm-Message-State: AOJu0YxEduzaUGE0SFEWJ6i4HaDPVJeULfVwv/Ni3PIEJtgH9DgR+znP
	cUt/dzqsbETbshfn6j3EYRjbLuMXqq2qukLcvS9GJg4rBP25Eu2q4ph7PjEc
X-Gm-Gg: ASbGncvOLbApPu28C5AO3aXT4RtQJjts5zptV9tIR2IHkyxnDo8RAqZgCnwTETZg9Uh
	eRPuZY7hHMfFqKodToG9s4Z516Un7hXgKMmrLap9cEsPe3BvA9SdJvuapuvQL61vxoWSTh6U/fG
	5RoxF0itf/gq8Fw6Zri/UtVpiOg21HU8MZiHyp2gJnB+ti1Guf1kliUMlBvgo/Q93g0L4+AFZmV
	7w3vLKRoJxr9soR4yOsVoZN8NxEQRg8o8JhfXFGavVXOYj5Ol3spkZcIkK2JpDqj3VRodPntm6v
	HuSgC5XrGDW3fKNJnpmjFgv1de/EeyXWp9bTPANJEZWCwPJA8j7wkJWFSa2XnwT5GnKNcBiaFMn
	gbSbs7kLwUMVhsFCKIfAnHvLAsBAR89rKuw==
X-Google-Smtp-Source: AGHT+IEVl5OTQdZ2619xWEOz09lHeGojaCIo7TcUj4XuH4WZnUuH1o/fcqA9npb1n/DLwAqAyeV81Q==
X-Received: by 2002:a05:620a:4452:b0:7f1:b0e4:4102 with SMTP id af79cd13be357-7f1b0e470efmr705105185a.26.1756212639978;
        Tue, 26 Aug 2025 05:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebedb7265fsm677997885a.23.2025.08.26.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:50:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1756200029.git.tanggeliang@kylinos.cn>
References: <cover.1756200029.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 00/14] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <6a4bba4a-0235-df63-bc4b-18d7898b7ae5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Aug 2025 12:50:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/172342=
97108

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2b989c1de52d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D995595


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
