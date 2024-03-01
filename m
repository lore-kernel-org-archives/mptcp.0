Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C92AF0D
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278820; cv=none; b=T2DCRPr4DPr47EgCrYpITfaCmdy4pJA+2EKx1eRuE55jwoZyDrLlwNnfIAJpTU50M1uMzJqQrWmoMkIPBL+clJ/aR5Sc1h7LZCd9pkPHlAPimY3NKW/pwuEqHJnRJiCzOx+OEK34eRBQOixnHrOsZy3RkIWVQQrHjIBe+DFxb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278820; c=relaxed/simple;
	bh=tNN4CS10yem7dxgmFcgKeine1j5i/T7/62Yo3zmng68=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pU3GZMpNZgyg3PGIxoQE/FrQEQ2/gIfiqLT4t+MiBsxkhj0Wik3r/dFShZtoLZYWkSh/l15mfK4MmOQm0HZq0OKemK3SIgagVf8HcaWgvgLdGagRcO6dbJALd1wkCvsTFJU7feFPSKVafUnj7sk/cZhV42P3kR7fqKlJ6n2Iz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AheskECR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AheskECR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso3812125ad.2
        for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 23:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709278819; x=1709883619; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4loK1zOHDQGLCiK4AhyVJutJvm4nB/XpsVqfyxX4P8=;
        b=AheskECRH0yYZnLLsIhTQcZQqDeqRdZw7lV9EiLtVFqOUJcdfKF3ZXOqbE+Ar+sm/n
         Ln+COQFfo9svX6551KZlRJOURaZL2utbR7UzUahEo8Fz4Pzg2Mev/bXQnvH/rq5xpqke
         lJ8Hlm/V4qyNZS664n8t0N0E6FPfb+9ZxdsusSqu6FW+YMkhoo+K2x0TzzecuEWsvjCB
         gKvqSQ9sWsWG2ZST+IrjPDG8KdtjlfYFLpuuGF5hXxvBqzS0lrv0bfu75EIglj7/HxqL
         sqDKUjufuw8TG1nN/Wpsx0Ymj7l42Tp8IHnbRqP26FzuIsVQ7Mn8GnU1fPJwcjo1YiUQ
         puNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709278819; x=1709883619;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4loK1zOHDQGLCiK4AhyVJutJvm4nB/XpsVqfyxX4P8=;
        b=txgQl32t+fA4iheoVrLh3rZH8Vbbm12Hpgf93KuxOOBneI/QEFVTwjyUAFD7rLVZJ0
         Xvy3XNtj8Zuy1MQLIfRkL/ZOp+ux2IH+lWnzBAubdLkfniqvbrqVew3V/HuGfUtZxLf2
         efkfWPW661PYQLYG46cNUPv56i61xH2hhVudRGcR2M0Oq+rbZaff0fmnIu8BS4pTtOTr
         kS8Z2CKGOhW4VfeYiynxo+yKN9pNXrxyC/fwNExEIackXif/xfK079LCwPzSvw0Z8+F8
         akJzFpEOk3mXNZtqEOQf2XNy5GIJB/2QYxzhWdZezXTvqRgO73kLnK/vOxcOin6ZY2u2
         /GyQ==
X-Gm-Message-State: AOJu0YzVAwwoSRRRMfUJHd3w9zRHiNC6BnCmVy+0A/oaZBa+gRHxvmed
	CeY6ol911ZbcLYMCemqTYajMj5hpEFvRwfxITTpMrAIxAAyy+pjsCm5vQck=
X-Google-Smtp-Source: AGHT+IHty/5EkRMl6VQuZ2yOh41N8aDgSuVoGUoH2p4d+xC/h4lAjVK6UYn9mN23KAF75jn4FaYBxQ==
X-Received: by 2002:a17:903:32d0:b0:1db:c6ca:a9a0 with SMTP id i16-20020a17090332d000b001dbc6caa9a0mr1158283plr.13.1709278818682;
        Thu, 29 Feb 2024 23:40:18 -0800 (PST)
Received: from [127.0.0.1] ([20.172.5.32])
        by smtp.gmail.com with ESMTPSA id ju16-20020a170903429000b001db5ecd115bsm2748143plb.276.2024.02.29.23.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 23:40:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6e785c5e53b8749a8bf0cc2402d6575a8b24c42d.1709275290.git.tanggeliang@kylinos.cn>
References:
 <6e785c5e53b8749a8bf0cc2402d6575a8b24c42d.1709275290.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <c57e44e0-dced-1b78-cbff-06740df2f5dd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Mar 2024 07:40:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8107769376

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7f390590fcaa


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
