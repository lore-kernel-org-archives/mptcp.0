Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4091BC2C
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078464; cv=none; b=hMxyCWukbHw8ICfor/uEXf5bgunOoiMGqjJyiuj4auiiSLEoduJGd09eGQYt9nr7CPyHb+7olIWnsQAxjZAC75U3MhsyvCQqUmmtm15AeEtLHLQhq1+Pm0VydySTixoPzWHsWmFucqk/rkIweDYjoXq9oqFg9UIii4/MZpZeJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078464; c=relaxed/simple;
	bh=SF8JrW+B4qLflXQ7T2M9rwka3tqgutYSnlp5l/ZwNYY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eTzg3J5XQF9KTa4Hhy0Ylzl5DE18zd35Z7xhN/X3QifU1YEStjPEOACQGQjn5gp1UHQWDwiTjdDxLWoqrWUe8MFsNQYnOqpFCbbe4MmSWLhTaPqGuDs72UoBgItaALy9A9AtfAM0XtnNxu2OWpPi9jL+J9UGYjN2/kdARjj3BC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7vNMBbR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7vNMBbR"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68f283daa21so10903146d6.0
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708078462; x=1708683262; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+jtQJj8tS7b84NaSyH1yGAV/ItCwm4ICNGJs+P1qHU=;
        b=Z7vNMBbRqKIxHz0/7CwsY8nzfGgp9KF8trKGRONSZ5hwE5WZni8oJh8VaFzkvjc8nW
         GlQmkaDNEbOFdBEh6XkMsjlDvLiEolRWyg6jsnPhpN1iRHe3wzCtQHZ1TNug8Ppr1dSm
         uR2SS2S1fA+34kWzfvU79gOh/Zkx2UiLSEJtkkvQggcqNVaavkoQncOsMcHM6oNuIjDs
         jrAbzltvG9O4dL10JsU5XtrxROkjt6HtySNGgKZGS7NW9++oZLCBNvMNWam5st4Qr5pN
         zwtoEyMLfKXyxpBoNOjerDmoE7OtgXhHgI7HU0NCslqCPUp0sfJHnw4BCoMhQoz34aEm
         s8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078462; x=1708683262;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x+jtQJj8tS7b84NaSyH1yGAV/ItCwm4ICNGJs+P1qHU=;
        b=njV4N5L1gV0WW6hXr2KratjQ9VJ4HX4FNlObaQLB1drW48Fk7xWvawp7xp627LbGaL
         uV+iwHayKgSa8jmUuRWsFITFTuXJIGYhGef3LqSJUxqF8eInW3M76ndkEN5BaXf6benU
         GCCm5JxgoaeXOh2KEus9OTS0LC/1FW9j4SnJ5Y+AYzs0ufmi3Xb+kXQ1K/4rax6aGkPZ
         +e5JWdSHPygYFwemxGa9Q3qQE/8uJKKzt4P0YEGLIhPBDOYxlyTEKhhRBxZ/sxOufiWl
         Y9oIJPLZAPVRfSdJK5JkjOgjjKaY+MzZ5hIyesGroZWD+wrn6Y53YeXy8X5CkLgDNiFD
         ZnQw==
X-Gm-Message-State: AOJu0YywnVjcbhXsk0qWp6/w380grxlVBPikCV/61BoUvUfWcT6TjROA
	tKuJhKMXsg0RvlKz5tSvwAxMcTxhgbVTDeTSh7cG2PJ7CuW/uTXCm/7IMVQ=
X-Google-Smtp-Source: AGHT+IEMNKvHbwOdYLZFAkuosnTJn/rdPej5Lb0eTnvT2t0qCdkJKU2L/rWL2HqP0KfAkTyzUe93vw==
X-Received: by 2002:a0c:cb92:0:b0:68c:cb5b:25a0 with SMTP id p18-20020a0ccb92000000b0068ccb5b25a0mr6134193qvk.26.1708078461762;
        Fri, 16 Feb 2024 02:14:21 -0800 (PST)
Received: from [127.0.0.1] ([20.109.37.7])
        by smtp.gmail.com with ESMTPSA id qj14-20020a056214320e00b0068f2bbe8504sm1029042qvb.43.2024.02.16.02.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:14:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
References:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <2e1a77da-4d28-19e4-9409-8b890eb35588@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 10:14:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- {"code":404,"message":
  - "Can't find artifacts containing file=
 conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4666244045996032
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4666244045996032/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4694403713859584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4694403713859584/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ce45d1802870


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
Bot operated by Matthieu Baerts (NGI0 Core)
