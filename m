Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26474C86
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 21:24:36 +0000 (UTC)
Received: by mail-qv1-f47.google.com with SMTP id m18so1300360qvo.12
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Z/Sgw477Stzz0XVCGZyXnwKKXQDy4ene2zjJ/mit9YU=;
        b=LUF01RJ/0Iw1a1rennVo8tfsuJ1VCNb1XlieJZR6dIzF9Dpp+96m/+EN6ojam+9lpo
         OPK4FzDHiGbzK3xQmqRYddgVUFUXZi9gtnTKDiBgy5K2W7bOf+Cx/LhySigDEMYpMAoj
         9TrU3fNBDgYRAdzTuC6lq6M0PVKJICe0qto0elG1BT3nER2DEpv03OOTOGJqF3N7GJ8e
         idvz4QJHqVUNe2ElIhJXhJ3aIECe9GiOcirXSx7jZhrCP8q8Dru63yRA0w5tsbVGdddc
         tQaSl/Qd2E6IAufgefJwzv4QdADbhK0HtKXbUZc2Op2BkvDwIIvygTPe+d0/bGTD1PWZ
         4fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=Z/Sgw477Stzz0XVCGZyXnwKKXQDy4ene2zjJ/mit9YU=;
        b=ZFMfVAKsEoFRiq2b6t68190kNBrF7cj3wET6P6twk1t2/WldnIA0iIee4biw4aqXyN
         632EtHXYhJAOdiDjnbC1bhLZb7eiazA9N60/4z2DAKkAxyjhXORiP4Y2wcisyZeSup4U
         93Iz8aXfyYjc4sBMrhBBA0sigkPcZE7FIp6CjwPYNjAIHNnJY2nkpjxlyYoCbBDK+E0C
         sZJZhq2sWIERb54ZkN1+QU4mwbovbRVrSIINjH5TsTIlCuSwMWznXZoZVlt1KYG6yEGK
         Ll5DPKuN9voCKzNFqdzLflW8IkQcRXBh7z2zhCJGe7F88OdRxKSqUzm7MrzKI1e+saZ/
         Md+w==
X-Gm-Message-State: ACrzQf3Wp+rPllYCQjwBVjFjremYYnCcf5d/tlotTYzuN8vTWeU1Ikys
	C3AoqRebCX0XjBS4maLbgiD56/eVrJG8
X-Google-Smtp-Source: AMsMyM61F5SrdJJ4P6sGDRRYl0hzmRUsNNehndrWHLq5BR0zZdXuqAb5OmghGITequzUz7M4+G8eGw==
X-Received: by 2002:a05:6214:f6a:b0:4a7:fe99:a39f with SMTP id iy10-20020a0562140f6a00b004a7fe99a39fmr23206808qvb.26.1664313875751;
        Tue, 27 Sep 2022 14:24:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.110.54.228])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006b5e296452csm1469617qkp.54.2022.09.27.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:24:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220927150306.1552795-3-matthieu.baerts@tessares.net>
References: <20220927150306.1552795-3-matthieu.baerts@tessares.net>
Subject: Re: mptcp: add TCP_FASTOPEN_NO_COOKIE support: Tests Results
Message-ID: <81b21319-a6e6-de34-06bd-8b44f0ebe0d4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Sep 2022 21:24:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4851555361882112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4851555361882112/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5977455268724736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5977455268724736/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/91a8d06ab5a1


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
