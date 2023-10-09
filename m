Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37092374F0
	for <mptcp@lists.linux.dev>; Mon,  9 Oct 2023 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2lfZubW"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-65b051a28b3so29223166d6.2
        for <mptcp@lists.linux.dev>; Mon, 09 Oct 2023 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696867173; x=1697471973; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9WZgK0x8lIO9iB5a8/Kb97XD8/k6OxYFzwONU/7oLw=;
        b=d2lfZubWhpOlZBtHIWU+MYjXedhOIhE6Z7QfFB0UywbhoNNA1Xd8+jQ9f+OYUro1dT
         3O/pSL8OAGpADmSwNrr8di7Bf6Ni04iyeVp54M4XrRZ+8jk1GhONokdx3+y+OoVDqEZ5
         jnFMjVBvpWd/lsQCq6XXLBD1mEKYX/qoILHQJ/xNkH826DYwbLSOtdWzOsXzLFQm13IQ
         lVM3AWD7XTdvB+A7V6hgzV9cV9BXH6axBt6SoTrVBjA7HVlZQYIj+1K6v8pXsoAq6CZs
         Vy4WQwTKdbYDBSmI4mXfPWoNA7Lh7P1lSbvcBr4MdFW/sJq+ryMKuhAwDn+efAIl2zkz
         K8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696867173; x=1697471973;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9WZgK0x8lIO9iB5a8/Kb97XD8/k6OxYFzwONU/7oLw=;
        b=qefaRIncRJX89kit5+7xbHmgFfkRm97a3wu/Z9i6gbEke1+i/4jFHvGtwXGtTE+uf7
         ikodXgqbmGmJRYsXBVjbTQTsEOcDd0RUkBnOFLNyHOV1yhP3H1u0AmeiwJWeIHfLDe15
         ujLSv5T5GvBLF25pLgfbMQQdkuvPjFDq7A1be9FsRMD+kPJZFa66C6dxbN71nCR0HG9k
         cvi1MwoAbz0sHUQwCsSVIgrMxbDSMTrThSXW79wrcmlFhxZzkqaZTZ/bZnXji0058rH4
         JvY8kk4d6lV6kyHyPgHdqWJ/1YtBxCejX0sOpHAXVzdkVjuWkCCeWSmkPRwa1WupYvWy
         3L+A==
X-Gm-Message-State: AOJu0YylQ7Yp1zaplkQd+2guVM7ZMpsk4xURVT6PrfUo1o/HvGw6HNE6
	9aPK7ddWMDVpysUC4to/wA==
X-Google-Smtp-Source: AGHT+IFVYfty6/jJUnsgpxk7o9ELFMB0uVlOgFjZ3mTLgW9Dvn+igsSea4cagNUfzU/L+zKo+yA5+A==
X-Received: by 2002:a05:6214:1fd4:b0:658:7f94:3978 with SMTP id jh20-20020a0562141fd400b006587f943978mr15041197qvb.13.1696867173086;
        Mon, 09 Oct 2023 08:59:33 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.205.200])
        by smtp.gmail.com with ESMTPSA id a10-20020a0ce34a000000b006575372c845sm3929617qvm.119.2023.10.09.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:59:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
References:
 <1d0e4528ab057a246fd8c60b91cffd34f277b957.1696848602.git.pabeni@redhat.com>
Subject: Re: tcp: allow again tcp_disconnect() when threads are waiting:
 Tests Results
Message-ID: <8710cbea-b1a2-41bf-2099-c827d10d2407@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Oct 2023 15:59:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5338936801755136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5338936801755136/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6183361731887104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6183361731887104/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5057461825044480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5057461825044480/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6464836708597760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6464836708597760/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/75398488591a


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
