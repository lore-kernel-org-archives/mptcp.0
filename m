Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBE14284
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 19:11:34 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-563305e8706so662727eaf.2
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688065893; x=1690657893;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsz/7AOy434SFPB4TvCAa1P0Py4cnEagrro+BVqJXyU=;
        b=fJBp50mGknXm8msZOHisGVuhPo6p084PGevUqqAKxqOPg+CkJE+RuIiVzD31E2B/ht
         e2i9QfUb5PpauO+88hGoO8ma198iaLxDw6l5iaJSwJT9ooKd1PoHyobW/0p77vpRHsjk
         qlDZR4qL0rVfCpdV6Hrr3WeQq6ENux84C6KV0cA9/tIkoI1Km1jKU1QmL+X9yQyQu6yF
         kNk3obr0hc2QY0DrYiPcRKGwL7MRc/5AhI2QEC4Wy6MXfyIcd4KB1ipLnQbwqbBnYFa6
         x+xn+zs4X39xyd3F8JT9e6smW91jDcZOOGhdMR6ts8DzWk4T2fCcGzog3pB12xCelWFD
         YuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065893; x=1690657893;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bsz/7AOy434SFPB4TvCAa1P0Py4cnEagrro+BVqJXyU=;
        b=Gs0EJ4dzFQwxLG0JbXlgMOLjrLrGrk9b9qM27J0JVJL8kzByzBuSOk/WuV5BTV5UvO
         whlUCXh0J/K62KZP+Gd7DARMmvD6FjAdU0y3flYgLuFp/5nnbdygcdSm3GFz0b0KbVkF
         McD5+Z1gdHN6PQVHTa4BTFE0rxW0mv26Rqehc5Yv5OtiVWNjK0Lf9pKZeLDRWr+wDnc6
         NIXzhcX/Hh54gzept+6XmcFwFxowiOTDh6RmyG/EqZXqwoAuYABGb6wjRWRqBjzj/HIF
         xOAOd+vUaCyFeh7gOr+rMC1SyfNwRCtPaJuzR6vTKGzLueqQiAyzbHQBpO8glyepdnr3
         1o9A==
X-Gm-Message-State: AC+VfDwhmlRdRJZBui7PSikCTlOQ0yMPGhSd/aVUTksT/V374aVeDWF8
	qIT21lMbKW8lJA2i+TCdTRaotzB2aamOH48=
X-Google-Smtp-Source: ACHHUZ71lU/JXulYwEcP6GlOiNzTYatvM4QEsupEqsM+jZ5kkngumkirgzonFyol1mq0ttx81eErcg==
X-Received: by 2002:a4a:494e:0:b0:562:eacd:9935 with SMTP id z75-20020a4a494e000000b00562eacd9935mr553404ooa.3.1688065892955;
        Thu, 29 Jun 2023 12:11:32 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.139.247])
        by smtp.gmail.com with ESMTPSA id z11-20020a9d65cb000000b006b884bbb4f3sm1422484oth.26.2023.06.29.12.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:11:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230629170551.3043312-1-matthieu.baerts@tessares.net>
References: <20230629170551.3043312-1-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: depend on SYN_COOKIES: Tests Results
Message-ID: <2ba8f34b-ad5e-7583-c6c9-495cd5742814@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 19:11:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5206230482812928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5206230482812928/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5214121377923072
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5214121377923072/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6581812776927232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6581812776927232/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4725594617806848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4725594617806848/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e5c49b1c15ad


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
