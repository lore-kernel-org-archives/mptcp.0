Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854015666C
	for <mptcp@lists.linux.dev>; Mon, 25 Mar 2024 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711347898; cv=none; b=iyiu5/0tuKJtPFSDdDQdpoqeRa9ZOEBrszyWUipdSjE64FZPjt5JxtzXXRGjWRYxqgyayudgnnfr6rAOuEyukZSDjgRCsJgyUHQn7KtfmfObX4dDJYLmSHNfV5D466s9iiH8VJopDhxaJ5OaCSD3QvsQyK+EVZ/7F96Tlr16PIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711347898; c=relaxed/simple;
	bh=leQor5iJFZe6DTDn91VizMybZg+kcWJY63K1iAki6qI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=iQjaFYw/s1oytqtwN7olb9sLnuCziZTdnFwFR74gnWyX2fMLyAyTAH+C/BkmDw0IeGqL6N8q2Ge6QMKen1wW6QIsSm2cjPh9Uc7ai5AKnlHMhPWjx1OKw0pNyaLJH4eEr6aCAyiyTTrB3AC0SPelzn7D1YJOFd3zGQR7KcNq8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD/ex8rP; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD/ex8rP"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2010983b6e.3
        for <mptcp@lists.linux.dev>; Sun, 24 Mar 2024 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711347896; x=1711952696; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3yI13ju+z6hNYTuQcC9ctsWDukxySTjV1K/TPOXYL0=;
        b=KD/ex8rP146kjt5ef1VEB58hqbHiImm675gvMPWO7cBjDrHLSzl1izmJEPpiC8Vh6g
         IrHqu3F7PUSD+0c9uZesFaOfGzkMqOsc0jbqrLTk3ZF+wOPDQsgDtop7o8OOpPxBHxRM
         Dd+mgFa3UsTWdAZG7eAK9I3JwZc232tc25g9YIxqeBLbTc8Js8VtjgBPyi5v7NJ2oCTf
         0qrEZNH2MdMYSndbUGt0lJJb+gY/7qkfqRO7Z6Io0nubGalpOROkUztsiIUHy5mfBlXS
         7fmLsneI2BdvSWzAPxdBTQgPVTw7cbz9ZN6e8nUU6QAzfLxu5SHTfuQ/FkPwWJF4Xp4g
         9wBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711347896; x=1711952696;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3yI13ju+z6hNYTuQcC9ctsWDukxySTjV1K/TPOXYL0=;
        b=BqMefC2VYxBQh9JaRTCxcye/uuh8/T8amL+hQSQvzdwqXiIUxp5G3skWmA9XpaLSq+
         Tl3TYPg9MwnS1lhhSr6ZQmG3/F4f/TrwlCge1a+Rqf5TETn4WloFW8/hr8azWQqMwLC+
         GK8J5B8W3xkOs9JgY2Gwhl1gAILZh7BVFAZWGGtJHjXC7znUF5WV9CwxmkbClwqUhlKW
         kqH7ycDMrIYvtWljNlEK0xrvP79Rn2r4BlczZh90mE5Csss8LeWgxVB1eyjEUiUi2xIZ
         iFW7AaswNJ5QJj0wnPBQBHIidYVIUW0j6LBIP10b3J0v6LQhESB5mx4/t0HQgF1nhEyr
         W/eA==
X-Gm-Message-State: AOJu0YwKDWR9pSOEcqTysj0e+zaEnRdKU+8i1dazWNoKnycNcWK/H5nI
	6leGPvAfPNUjGC4hwTQI2nPAPAlG3P9/1hKHhsDgRmxp4jnCjTqNr6TWRRY=
X-Google-Smtp-Source: AGHT+IFj04eMocyMqR640WCwQcJcy/BvDudwE2XIgnMYmcdxVxT/Hpwwfv4xg58vF8DqQ6aX5Cf46A==
X-Received: by 2002:a05:6808:23d2:b0:3c3:d201:1136 with SMTP id bq18-20020a05680823d200b003c3d2011136mr1004630oib.3.1711347896423;
        Sun, 24 Mar 2024 23:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.76.20])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006e6b2ba1577sm3535384pfn.138.2024.03.24.23.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:24:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9926a79118db27dd6d91c4854db011c599cabd0e.1711331517.git.tanggeliang@kylinos.cn>
References:
 <9926a79118db27dd6d91c4854db011c599cabd0e.1711331517.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH] selftests/bpf: Use start_server in bpf_tcp_ca
Message-ID: <1a804eb3-905f-3439-c441-076776111f3c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Mar 2024 06:24:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8415695895

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ec021e6c5e18
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D837699


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
