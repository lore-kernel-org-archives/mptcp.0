Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDB21C184
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249652; cv=none; b=ocxbK8sojhvvm1AsfHQZmEndP+jjxlRvNuNCM66vuAK46fXULfkwl9rGruKXW1HGJO90UhxmFb7+ksHyzmhEa+VIgdy9taKTayB+wAM2yHo7ihRLwglcWTpt7tFgdSeCTQfAmAByjnpfb+G0ujG9RG6ZQ4lny3BqEOTp3/5O+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249652; c=relaxed/simple;
	bh=kNIOYDOnEfwcxIHa23FNrUGxmjZP0KWN/My9MCnSuyA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ggy2+esdiFzdqQYntX4c0CSj2vKwknMpa9M161bjsC+OekoULpj4IH3Gwp6aX6qYMNt4c1FCe9nSHBLLFNIvnh8hLa5WzQr2hO4lasKaTZ/PbqOAqTZ1SqSgop7MwGQ10YllkBApk4ZZXS2wwpNwPy4aTXuD54/JMXjhMpcJs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTSbDE5T; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTSbDE5T"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1099192b0so28876871cf.0
        for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755249650; x=1755854450; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/a9gIwNZM1eNpDwZIYT709zR5S6g3jBd5704DixjkQ=;
        b=LTSbDE5T98XMb43FUYZeCvj+7Meo9NoYO53sPUb0WQgPDfUTVexMO50q3hgwvbzx92
         Q2IvqjnvZ4RnpwcFubJkMRRp/7QhgdnYqdbvpcU8cITBR7AaMAWvCHuUNqdlGWaWvxYg
         GRigLhbWh6JgXq9wRNrxZh3MRjS8ZoyoStPyQHvzKfVbuqSS6oTLsn7oQoj1jyrxiTe4
         mireVOExg6GxIY7qTue78FOGQSKmm1AHD9E+dKsqZyL7xSNCD4CTs0SQK57c6kAul6Tt
         vMKYPSObtDySsxS5EbFPCgYyHrkzQgg16IMdyRhWt9jrzpdeo3mgVDr+GAVyjzBh/Oug
         hliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755249650; x=1755854450;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/a9gIwNZM1eNpDwZIYT709zR5S6g3jBd5704DixjkQ=;
        b=gAfT3JO3GLwTu6TCI/5Lf5HKOF9QMw0GZBTPbt6Hpr7M6tNgVrMKqKjKCg/oZmmBNY
         QO1D4scp6cI9/XfuGUTC34jM36nn5H7wMmHZy43zZDB+CwHNMJtEVEhaQepcV3HS9qYV
         wWg/gHi72yniZerFtHcZT2Nw1ehzQxT5R6PgVqmBSkl0bA1Yq5wTJkyvhouS4TenwPEe
         iHQlWLTbwwoavvfZ+pfEwRFxfgrEItv0k0ndVDoKzsaRue+N9B3fgo6u0pjxppAzxVJT
         4s3nDoZDr9tWl2w10IHGQacSeVjk5mHVGsN7fqyXAWXJpGVHQ51fKMj2RSqdr1HOtY0J
         Gt6Q==
X-Gm-Message-State: AOJu0Yz0SHT+cZS76YkfuSXOhqKEwCqjvrnS/dOqSNF41Bj66vKufdIn
	EqTMPajN+t09ZKaPV9T3kKzFDPKb2uoBIcpVp1B2OwTXGlV+9OfWpLIfr6Il
X-Gm-Gg: ASbGncuFycexhNTXbEHUtCSNlfa07ODjnhFlEXFnVzRxtoL5MtlfR6AIWRGF0NgxVOc
	TMA63JFK2KQ78MFbWf67n7+aimc305GDghWfo2oE51FYML5ynk8uRLY8G9TtB2ziUcV50UFpgyv
	2/t4sgcAjx7Gb1tCrMAJ7XsEOKQXUqt/dFHxJoT+EVgu5f78Lxgg8KvfVlDOexSMrmigC8s7yxJ
	bq4xTwIRhI43SiW60HlTTFnPGFw+KtLyJEWFmHkLcSE2O9+UkD1pAG8sEst9HB/TQlBgQLC27ct
	pX1egV/03B5PgmPBhS76XiDcVZrdWCZRIwvyPkz49XaOw5xIRIfIbIX2QZ8/1aBqJozIEZV6i69
	SUlzmiRQ36oBzyH4Y/ryLUNXK54MIZQrvl84=
X-Google-Smtp-Source: AGHT+IGITu499I6INbnoUkSKjoq+9PEKdrdNHj8s9EoeUDfQMzASyCwER1OiL8dPH+UgGRvCgfUVNA==
X-Received: by 2002:a05:622a:4d06:b0:4b0:ed9d:60ca with SMTP id d75a77b69052e-4b11e170b5amr15104651cf.10.1755249649647;
        Fri, 15 Aug 2025 02:20:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd8727sm6596821cf.39.2025.08.15.02.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:20:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250815073140.29077-1-yangang@kylinos.cn>
References: <20250815073140.29077-1-yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3] selftests: net: mptcp: add checks for
 fallback counters
Message-ID: <4453834c-858b-c31a-ca11-54a54264892f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Aug 2025 09:20:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

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
uns/16985622382

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9bc01d13d25b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D991819


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
