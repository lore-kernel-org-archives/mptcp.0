Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145F10A09
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117778; cv=none; b=EUgLPQiBjtqjbeW7dhSmyoDlH/vPiPUW5m5vuHVsyK4pcPzszBhzs8/OfFYKUTrvZqNc5xXtUzj16nqq+NoE+s14zOsSgeYEEpr4H2EDfiXT3gomyoycoJkgJzXbev3h/KBt7CathCji9en+XNepoSqpr7kpAXs7GDOCJ9RqpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117778; c=relaxed/simple;
	bh=rK6C+f5AEZx/TfFFNn3urBdCxQrybXqjw/6c698HiV8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HuktHeDgu4KQC8ogJke7z/yZGRSscwhI2Qji3whxUTIEpdWOxPUx53FIlsqaKi0aIG9LvPUfiaH/TJ7Dh18deoPgtyZ7xb3E5zBX7gwEaMOYkGcJqWr2kZSjFgsQeTRu56B1bzGTW6FMm4QLzkQKLCKpnb9549+0CIXe0B4Pb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZczQPynm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZczQPynm"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42bf5d7869eso22628241cf.0
        for <mptcp@lists.linux.dev>; Sun, 04 Feb 2024 23:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707117775; x=1707722575; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQB9tqnIL5NVHRb+346fedVi1IqXY8sRShKGGNP7wHk=;
        b=ZczQPynmtI3T0dAkhc7ePqu6Q7Oed2vikXU7AUcdWTN695lYmQR6VjiOzDC32+ATQv
         m+6wW6rVewEW+IlBlEG0mP6phRnJQ6ADz8+DfpfTFWPRPmPD4b2tSt0LNcGQrPpK7vYz
         UgCWmWR+4ygSTAe/b0yR9/cHF98QTZFT8U9Yr/9eclr/t2jn1yNNrzRCfnfvDpJYlBZN
         WD+f3I3lGjfkvFrogk9BYYadZYW+OASa5n1yStPJGOszaqcva9lzgQGilnPhhn060OIj
         vQjrVro55PeXU0wE4R0yt3zLLsGKPDEuNeNrWq10MefoBfK+CfpKBovdUrgMzHViC2eA
         drkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707117775; x=1707722575;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQB9tqnIL5NVHRb+346fedVi1IqXY8sRShKGGNP7wHk=;
        b=sM8qlwoRuRrEYedJSomAlOZficw8kPRHz+2JVti2J/FHISVvZQ2vXoR0gYgKrZt1da
         fBRIxE1PEpvGJzHjRwel1P5+Bgg8VDBmaJMZWwvwpFsgr7TCz9mh9rGCHGNYLr8lXKAS
         PtzhrG4DZyOpT76dvi9xl1XVcIzvTEcS6VDT5/wgJuB2s1RbXLqMqWXyQ3bZ5YVNAr1w
         6ynLQWyLdNt4omDPwYseYY+C5L+VehpGqqckPO0c/BgM7X1/M2TaYwr2eCytv/EGnOZg
         CqBKVwCH/kYJtdqxyj8LyboDM8UJ629FqXgL7LLoZtGP0MxBKr9vBwFNPviMKTP/oMpr
         jhpA==
X-Gm-Message-State: AOJu0YxEwf/HO81LdopWA3JLNmphvLd4mr7lzFxGjeYR6AQi3uEZybhg
	qxWQUUigrzIgUvS5x+zQkSZFmQfHE2xUsm5rlYL4WvIUEYfZIlLjuPwpFJ8=
X-Google-Smtp-Source: AGHT+IGVPVXrLorvwgvqQzqlqfkWlhsRSTZOvRNJeqrUSZwgVVxWyTKbXbR/7XeIvgmV5W/dMxa16g==
X-Received: by 2002:a05:622a:1788:b0:42a:2e15:81b6 with SMTP id s8-20020a05622a178800b0042a2e1581b6mr7385312qtk.26.1707117775277;
        Sun, 04 Feb 2024 23:22:55 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.141])
        by smtp.gmail.com with ESMTPSA id ga23-20020a05622a591700b0042bf1cef27bsm3460710qtb.8.2024.02.04.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 23:22:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
References:
 <e97e306f73ff10b437eef979b7d5d82b822e2f52.1707113244.git.tanggeliang@kylinos.cn>
Subject: Re: mptcp: add a sk_is_tcp check for sk_is_mptcp: Tests Results
Message-ID: <978c8211-ca5b-de4e-be98-0425654cc193@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Feb 2024 07:22:54 +0000
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

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5648630539878400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5648630539878400/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5085680586457088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5085680586457088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/502ae07710e7


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
