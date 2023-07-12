Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6B20E4
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 08:53:37 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-635f1c7412cso43966286d6.0
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689152016; x=1691744016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DSmT2u+W+jFvhsemKuLMoJzM74tMk6zq0HxVy5gNzBY=;
        b=jA+cPSah+NwLFDUJOOfGnJs4gRGp/2czYvuNIqmJIZfNU5SzzdZzhN0vCibf9hqDJ2
         OOo5TBzqvnpRTo6qrI1g1j75wwPANJWiyJwriaZXgeze/uADh3Fm4BXmCRgAPj3aHhH4
         Po1VCGDvPuDmNopRkUHIFwThK3ea0Op03kRZcogFhfIAa1uIg5IwUKrDMo3F6CZPy/eB
         ux0GtjE8uj8H2wXqISnvIP0eMMTbtQo5GAqi8LDnecx5xXoUl7nAielTAqA9fFi1WBqM
         r7SuAo0rtZUFDTZWtKa/5QU+T5M043M8ylbYqGJZwaSjSfNazCwTgI9h1NNXrqkfQ6Sh
         Py7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689152016; x=1691744016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSmT2u+W+jFvhsemKuLMoJzM74tMk6zq0HxVy5gNzBY=;
        b=hFI0y4DpT2Gh00HkTlrlI8/DBpvHCj9Qnm7tQQbB8k/A7FGDGVdaonlcFQLkoKzFf3
         BKlwWXLFvQvIgz+MwX7qwcFgUsAsc/yL43pTfO+gOwIbn/vOE/gYfniZpZVD0EjH9TfN
         x6j2iYA6tKmZ9OL6VOo3YutfrTxfpG/p2fQpadN93/LCvjRs07ASu5dh7XrixcZTd2CY
         QPG3JYMmZa0sW4IywgGaVkvsDMjiXpmeB1JxTjs6gSG9U0yrfXk4AHfEg7IG2mto7QsK
         mkOAqzpwAF0JWWpfw79Tu9zOiQDQUToXo2Rj98HPxYjB/aS8SAQufvk+NNv5wQKpVT+T
         FDHQ==
X-Gm-Message-State: ABy/qLagIhddqkpCrLO0PtqYkUaW+wC4PMZB5GU4Th+1CHn4wh9LzcSc
	5HsJmjcxVvq+Y7qjlIayJZcSHWbhjCFUYWuKDlufDb3L4YDaLciY6KQ=
X-Google-Smtp-Source: APBJJlEqW5in3x7j0+wlkAEhnQWjLYe/ET3/H/Qw5nT+bBObp4pN3H2Ybl1NQIuCrzhPMZz+neOyXo3Mwu+kmjZfozE=
X-Received: by 2002:a0c:b443:0:b0:62f:e714:89ca with SMTP id
 e3-20020a0cb443000000b0062fe71489camr14947833qvf.16.1689152016533; Wed, 12
 Jul 2023 01:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a1e6596b-cffd-9860-9146-f8a41defd22e@tessares.net> <9c00808f-ee54-d8c1-1be9-65d508c1786e@tessares.net>
In-Reply-To: <9c00808f-ee54-d8c1-1be9-65d508c1786e@tessares.net>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 12 Jul 2023 10:53:25 +0200
Message-ID: <CADYN=9KKSjvD=TVqO_U7y4tamBHDr09WhMq2WzwcAk8WDfwPBw@mail.gmail.com>
Subject: Re: Linaro tests: parsing of the kselftests results
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

[ flollowup on what we discussed on IRC ]

On Tue, 6 Jun 2023 at 13:59, 'Matthieu Baerts' via lkft <lkft@linaro.org> wrote:
>
> Hello,

Hey Matthieu,

>
> On 01/06/2023 19:41, Matthieu Baerts wrote:
> > Hello Naresh and other people behind the lkft project,
> >
> > TL;DR: how can we provide results for sub-tests like it is done with TC
> > selftests?
>
> If I'm not mistaken, it is OK to provide a TAP output in the current
> kselftests TAP output, right?
>
> The parser seems to be this:
>
> https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/parse-output.py
>
> We just need a line with:
>
>   (not )?ok \d+ Description # Directive
>
> One special directive to mark a test as skipped:
>
>   ok \d+ Description # SKIP
>
>
> If that's just that, it should not be too hard to support subtests. It
> looks like it should even be compatible with TAP 14 if we add 4 spaces
> for the indentation if I'm not mistaken.

I created this patch [1], thank you for the suggestion.
Here you can see the result [2] from a run with this patch.
It used to be pass when it was a "skipped" test.

Cheers,
Anders
[1] https://github.com/Linaro/test-definitions/commit/85a05ee0ed531cbbf1dd95c0df8b26d451983a3c
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230711/testrun/18267241/suite/kselftest-tc-testing/tests/
