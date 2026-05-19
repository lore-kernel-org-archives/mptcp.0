Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CD23393E
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221648; cv=none; b=pnDbQjLkzErkrZuZQlJcT30qClHIkN46BQ4KjIy6D2zKgQXcy8Vuec1cLdZIaK52P9Qlzj8zeV8sVF2xWBATuCF2pwJgYca47lSkdLXQ4Ldsfa+EO1WGVO0cAeSb0gxQfgO9XCu4d/xpNpVjffCZcsjhGnH0aUNJ9cZLCLUc+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221648; c=relaxed/simple;
	bh=9exlDx65OxEdtWy4u3nGhnhfualG2e5ycwjneHAHI5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=N03Zj88r8y5X+P84pdh494c5+ozF75bWOHRYO8Lqu201a1++4wu2ZcHi7hCMq6FLnbwUxbp9rcFjU1BNO+W2vKYHVa+lOnTM4uz8wcxC78Zwif7vA0U3X2XVipmf25iliDe+kzOhzgOTyoCNXGxE503wn02V1oyd6Y9mr+MLauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/CSD9cr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/CSD9cr"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90fc979d84cso270181985a.1
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221646; x=1779826446; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JktMHgQlEILvqAayWZe86G+RdzEsdFf5rzHTkYKBnOw=;
        b=T/CSD9craJYx5Kkzn6LlFhAsINga8fj1sT7ENbK/5gPHbLbesDNVoB9uXq7S9VIiXq
         kxt7xAHqqGU9KClUhHM3ONPPoNAapf01Ov9oH1FAgu3XQN0mRN5zOdqJhJHlnWQQZQSQ
         +UUcUlj+9feWa4AeM8qGPQH5RiP5H0V/utIdRP7L/HucnKIZCRGtJqBF2sCaJEf+KisG
         dOUGbeOHvM3Pdyt0UrWCjnqfHop1nbUCgqpSyC/6PtJjg8T8K8sPSFbEpBYdxV9JP+dU
         eZIaYOUUOWeK6mRPNc/q+TfUarZOmpGoDOd851oEAr6MzdqF1TDrWEz2Ro7iwuOBxrXC
         Bvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221646; x=1779826446;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JktMHgQlEILvqAayWZe86G+RdzEsdFf5rzHTkYKBnOw=;
        b=ENU+dEnCIkY7kyKHNkD5XzXHndnBw5dyhmqXImwznwbrz49rztb0b8swY0OfDtuR9U
         pIt4v2PirLmoU3Et9ChXqbyp8Cj6hLf/U6tDRZuHt0o+aUF31D8CU/0/wFnYSqgK8XOF
         1GabsvMFmbA5HEkK4gJeXIsPQQTUMOH3DpX+WjTAMo6InsVOtopHKC7tFVRbeKCqq26f
         25BRFyLnDEa79m3rkHAGk2lRDaKLL05AiSBk3y+qORja6P4e50hjU9jJeBueo3OpDjjr
         7PDNV+N8GyuSl7Keu4w2q3XXICwlRrM6cEEVeqVE+gd1Fqyp9rQiRhYl9wTao4VjWQOX
         Kx+w==
X-Gm-Message-State: AOJu0YzXPNbeOYcEOZPv7GoV/6rRWH0hvLXqwZa2AHmqIRqT4cz12ir6
	jY77OmyVOKAZJt8kJLTu8qFyzN4tdKPVvtosSlzLaEuQCaX+xLHsp74=
X-Gm-Gg: Acq92OGUK6qwZNSYE//IVa2TsQiEoySpIxbgvwxyh42AmW1RCVEQX8r4MXoj9zeKY0/
	q1R7PsZTqeB1WwEB3saQD+6O1iz2GaHDt8j/pTzLyVxASWc+8y5RCuE37/yYK7D32WrELm5o9iJ
	sCWOCZFTS/rVwuDEfzHxDRa9oVvRLgKdVo/MOk5XRnx1KrAmVC3VLAxiiQIwrzZu1Qlecur9RfE
	WWUcE7AwnvJZCDuNS0i7JVxDjcFkYRSzBZ0OjCwvvYnyutQGoyFB/DA94cB4QAW2BEuDLo9A1vj
	ghwY27MFQAxGVBXT6pIq/hXkrbZMbT24fiitaw+8XybZQ8SxXsw78jKGFJUFlRjqPI9DwAh3QhN
	6SdUN4crnGdTZrCykudN5OWhDaEpZC+nLVQXxYI/xffOBRlFWkxjUWgxcUgpHjf24FRFOxCW/uL
	lqXIG9nMpT0QRUDmfb4j3opYzVdWZlP3OV1lUOtBIcFT0UiQfD
X-Received: by 2002:a05:620a:4453:b0:8f5:9a78:2fc with SMTP id af79cd13be357-911d01b24c8mr3127637885a.54.1779221646306;
        Tue, 19 May 2026 13:14:06 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm1937358285a.37.2026.05.19.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:14:05 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260519191207.1110003-1-shardul.b@mpiricsoftware.com>
References: <20260519191207.1110003-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH net] mptcp: pm: fix memory leak from
 alloc-during-teardown race
Message-ID: <12364e30-61c9-d92d-1d78-a5a188720521@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 20:14:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26120116974

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9d4635b60d0a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1097575


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
