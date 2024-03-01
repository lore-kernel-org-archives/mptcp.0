Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FF17BA4
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316066; cv=none; b=adFQUPhYCBG9VFB0gvVQoV6AJKhUQ0V7P8Dc4u4Y1tBZ/sN67hgrdrAKkVIFI2IQDaDJe4x708fgelUOto6mBwSZFhaRIxjzU+Kuaj0ujrzzmyskCy+UfD66YPYAkuvJB5zD96uZjdXP+uIhnxov8nzO73N7w39wA5cXoZVFj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316066; c=relaxed/simple;
	bh=xKFvgYF9w1R20IyWWoYINLMYZW6E1rDrweVNOJknjCA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=e7xucHjf1FHzRiHgHcJHUcatDp2jYplLVEiI1NbuWLjhE9mg++1a4bxck2Y3IJ+4vsDK+XXUkZ4qLl/gQ1I3FLJf0i6ssfA54VKbkw1FCiCtCqXUvLeHC5msKZyISTvpMoYjPvrzHtwxBzCTg8LBr9zvWv8kbwKHZXjjslYlTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSlN7bJ7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSlN7bJ7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608e3530941so26677277b3.1
        for <mptcp@lists.linux.dev>; Fri, 01 Mar 2024 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316064; x=1709920864; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YLydVzZtVEhXEtZoveCzl68RgGLKgYNx/oxIdvWIO8=;
        b=YSlN7bJ7zkYM2paKX0OgREf+On/aN02VgWpk4u7kYOYEnCJy8Gv5zgkWBlP3ipEjRj
         g4m+aGvvLmW3cwH8JFM57hstseaAsLs5KwPdZNxvsGHsRH1h6ZqSo3+2Ps7gD2u4ABQB
         kMyvtcD3XXLKiz4lPfvWYBTzgcY7AQdB+MvKdzCRsFoOk3fNjzxBISQxOneitk1pyMXj
         KnGsK4hHe06V/uvIOXLr0yNp4oA4HyMlJo7MnXuKTAYemGeiX549lfLLw5Q3BpiQIeIj
         Zj22NIZpuFgvsMfXJOt+rIbghRXqaoIMIbGKZ8pwE+mh/41gCOXL/f5tJxEAVgGzATSa
         M39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316064; x=1709920864;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YLydVzZtVEhXEtZoveCzl68RgGLKgYNx/oxIdvWIO8=;
        b=YwlPeUqYKFJdOYYXAYMGOJVjNDWiaJ5WDQ0VD8yyGVxeoq/qMpYuRUsBunVtDy2jrj
         3tiFLu9rZrQ+3hyum8/VAjfiQ86EDW2C5Pou+aqi99CW901sles/NSqye6r9e4gilp6f
         UcneNP/Ka4GJKKshujObLQjdOm1zJOAl7QldnrhfTYPjHrsfc4RDqRWTqh7EooT+h4Jy
         pmmjFCWSsbJUEJwUO3iDs+7+M7fhZNOJTwT+LIyDLMilwHmCC5Hlk0jyN3+3AlCvcM1B
         WSHRsOuIcMdmJqmchhpcTONGxu58fKJXuASrzexf0Xw+S9WIOwIk2Eof6YuYFhfCQd7O
         DbBg==
X-Gm-Message-State: AOJu0YxDAX0OU3bBm5eDY2umxR+AG53oy4U7TPSWoKlvAF9MBufeBize
	tgps3GMfozAGLriQFIypHOwx372vp+HH9A5iI1InaTp7N0iSmM9kWPGwP5I=
X-Google-Smtp-Source: AGHT+IExP1vEs9cO5aECDBdrfGxVpzgQI9UdzA6T9zjRfJJLvnzQc10FzpLtN0UVffMQMckVifbqhw==
X-Received: by 2002:a81:6d08:0:b0:607:be5e:fa27 with SMTP id i8-20020a816d08000000b00607be5efa27mr2511393ywc.13.1709316063191;
        Fri, 01 Mar 2024 10:01:03 -0800 (PST)
Received: from [127.0.0.1] ([172.183.51.112])
        by smtp.gmail.com with ESMTPSA id fr2-20020a05690c358200b006079f55766bsm1030169ywb.68.2024.03.01.10.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:01:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default: Tests Results
Message-ID: <8a818f86-ce56-f2dd-6738-72e22fbe93fe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Mar 2024 18:01:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8114876257

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cb52ed1610d3


If there are some issues, you can reproduce them using the same environment=
 as
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
