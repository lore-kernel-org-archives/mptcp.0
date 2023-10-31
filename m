Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29D1945A
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9OpLneG"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b2f4a5ccebso3845078b6e.3
        for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698773317; x=1699378117; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aORqrhRWOLpAEUA4oXTImTbbIoK08aVXmDnBtrgqmk=;
        b=W9OpLneGfbX+J0fcxdFY8/G5dML6lg8M6fPf1kwgDaZuT7gSDPeJAIUEIZEMxUZ36P
         OCrEmFZjx01NwuR7RJfUumKKaQTAmAGcuoeK58iTvbogPslcdhzhohI+n/T9i99t8s00
         xTBGOB1XkBieAoLTzHGfS8/Nu2Z34WXzgdRP3IvDWEkFGwFqHMvF9x56BkXPLAkDYKHQ
         +vnFBj3dIh482CbNhcDU+/b+DnCQMnqoDbWU4bQkl9Jtuo7sLM+LXWqDNRdJMWsbkcGl
         aRX14HaGu0iq//5IlAw0ic+7OLjNMeK/Ea5wfLpMotp4bCHoRkRgqGaSRdxUH+0uEsO6
         vlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773317; x=1699378117;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7aORqrhRWOLpAEUA4oXTImTbbIoK08aVXmDnBtrgqmk=;
        b=gpH3zCAhbSntYXnkpl+DaWluOcJ6KVI/LTYDOl1mPariC0HGBwQCr5gzD/g9oV8s7I
         H+SPRe/jvB4KEmZq8YEknUBDj+ZyYGG2HvwAY6O1z5uZ0M4qI287sSAp1Lq7xuWHi1Xm
         4PwvEzHFQ79y20eZYCt657isfNJiTfBeOBHU+QYPNrEV4hHqWeiWqw+o+Fe/V1XG8P0P
         mGSqDvd2z+g+hAsvTFN8PVa144OQOTWgw66FqtQSoVhBaHzXNAXBzC2SY97FoUoCw+9l
         iOFAIdakGjQ7DfYHlVykK8YuCwzRTbKfJ8LZs2KQmJYhcmItH2SAA6gKt/QgW/TirZbz
         UYLg==
X-Gm-Message-State: AOJu0Yyd9yajeCqe0T/TQ523vnUGnokDX6UhvUVHdNpkQ6JWLaqe48mp
	SkjnDi7Qkte8oQpfnTYcmw==
X-Google-Smtp-Source: AGHT+IGHqfjTlLbEoNFhGhswZx6nPumDMMiPi3ZkD094RysBJuCCMmLMO6TgccjCco8oPnjtp+3DXg==
X-Received: by 2002:a54:4690:0:b0:3a7:aabc:738f with SMTP id k16-20020a544690000000b003a7aabc738fmr13138977oic.39.1698773316732;
        Tue, 31 Oct 2023 10:28:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.171.7])
        by smtp.gmail.com with ESMTPSA id d15-20020a05680808ef00b003b2e2d134a5sm324455oic.35.2023.10.31.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:28:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
Subject: Re: bpf: fix compilation error without CGROUPS: Tests Results
Message-ID: <473766be-908c-fb6d-7912-a603a0dc2b31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Oct 2023 17:28:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5146402590818304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5146402590818304/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6272302497660928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6272302497660928/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5990827520950272
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5990827520950272/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4864927614107648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4864927614107648/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5a24ddd35f49


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
