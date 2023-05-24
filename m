Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD319BB3
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 15:42:01 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f6affdb6ddso12310391cf.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684942921; x=1687534921;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsjTHz3yaIhgNL5b2bcAiFRqsqTRZv9BnsDDGb0BNAM=;
        b=Pt0Gvb7jBCJyzrx7A5+eAbBx+Gy4lQyRLRPrgZpNNqiN8tAdnQkwymsDGsQz+v4Lnf
         922PETKKJvxYTtYOye1I6o6kxALXFhlQjcNdPBLAVsnOnsUFqsXiqtFdqmI0lv0VTP+3
         cqPFpHafh9us0g8iQlYoO3S5aTLBh9yBLB5GCBYPw8u+Ab1NZENJETbb/ABVk9diXJFF
         QQg53gHlXgfd2SCIUNJKZAsIppXrcrgay7dszNyUj45g59GLfUAmq4cyAZh3HUjIJVIj
         AD9wpnV0u5GE9ikmU0ZOslRPsR0C/BHt6i9ijfXoP/oUMUKL+vI2+paxAHFPXUOg5Ig/
         /xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942921; x=1687534921;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsjTHz3yaIhgNL5b2bcAiFRqsqTRZv9BnsDDGb0BNAM=;
        b=dtXIduWOPvzqGr7cp0wRDv6MlUTCSjCi22D8IIo8OjqffgcMNC3NP1NU9iwgYZRDL2
         A7VFzn5soEJj1NtGIicvBAGU6PYvjHHG/Rur8wpal+x8Ud/yzxo7QrCquqxRVOY/bbh4
         6E1XsLCg/5b9FrLVcb7ZJqgmAg9ODZkzhlW4oQ2mfv5MWDz92C+NBXdmOaKVrvn61FeZ
         Di6m8o9IGDD3uXzf/u3EIRpW+6spUi+IwRxmroCB0Vi4VX93JR7Sf1c7whF9qASfx0Mc
         TBOQ3NY4G6t3YAiOCDRtrmPIBhTz3ihwPsidg+WY4tUVLkcinU9RKLV1ikSY1PfsmbuE
         dFZg==
X-Gm-Message-State: AC+VfDwaug9xm7qQ5DhvZE8qY96EjLbApNGVGbZgn+uV1JwNJkBbXdeT
	eYPJvDQ2/KQcEa5ywKYe4w==
X-Google-Smtp-Source: ACHHUZ7X9kgvyBNlSaKkwYafZQdDpxBizpOLHFphWT3HrIq8KLf1f9Q3Ie3rgTRyH7RyqgnMV0CWwQ==
X-Received: by 2002:a05:622a:115:b0:3f6:bb5b:8111 with SMTP id u21-20020a05622a011500b003f6bb5b8111mr6730115qtw.60.1684942920678;
        Wed, 24 May 2023 08:42:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.72.51])
        by smtp.gmail.com with ESMTPSA id i24-20020ac84898000000b003e388264753sm3768141qtq.65.2023.05.24.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:42:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
References:
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
Subject: Re: mptcp: update userspace pm infos: Tests Results
Message-ID: <b17a8ec3-0790-7990-257b-c19c9846e02b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 15:41:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5532371710115840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5532371710115840/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5743477942648832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5743477942648832/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6658271616958464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6658271616958464/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4617578035806208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4617578035806208/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b551debba8b2


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts =
(Tessares)
