Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFF57C
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 12:07:02 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id hg12so3625927pjb.2
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474022; x=1684066022;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcbwIBFuUtenIB0YwjDqRqSkil1aYwqRK+FrvHP0jEc=;
        b=AvGMIZKcvj4aNMZFDREDcN/SY47YG2kTQX0AqXo4GIsvyhvlIHpySiDZN0UygFFPUZ
         7XfYr7RGk47WPywQRF+TdtDnYvCeD52ujqonsXXeGo7xQ8OvtwTizH6lcVffLKUKRHBB
         uaVj1Bt+fV/1IVBMSyB7+ON4fD80t4t2P1PX6BlF446+BByPM34ZwchwYUET/UGrMP7N
         0LVUvAf4vgz4nkkXgGjHyHl3rJneVBPHaC6nRIeiGdzxzAtY8uiUZ9rBHTm6QGfo6nFQ
         nW++iViup5sJ3vRHKoq7rxKfSq1oK0PWZC3XHpq5iUcw4aa8xmA6WAwymOM3P3sfiNlO
         3TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474022; x=1684066022;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dcbwIBFuUtenIB0YwjDqRqSkil1aYwqRK+FrvHP0jEc=;
        b=NzuJ0TRHVh4HIGaMa7oKh6rFBKlFTVBEaZe5aI3LpicjJz2OaQMS0Ht+H9JOIPV/yD
         6GTdcO2XJ6FqqUE+dU54sBL0GC5FTEoek9TB3JChkz7LL6uNlrdZRgWfwRezYJopH2cF
         09U9+qNEcaBu/Q9kWd4TwKYSGyEhx+t3dQ7H5U+q5arj1V/StSPnIMPk4xN0x48sh6cN
         pfzGEn+c7nEyqBc/8Sqpa2Cu9ovliHFodCiSGTqjqClCP0FCq7JmAHGwNsRQTE3E+DfK
         GbMtJmTzk3b2OgSxxGbzrwgG5ztml9TLw2jlZ2H3ryrJffjGBdqzEZ+MdQ3zcHu7jq21
         4vpw==
X-Gm-Message-State: AAQBX9dCDatDQFOZzpFFb4xJJdJgz7ntc1SjEcJJHpQTwOW5dznp82xs
	YVSemsVHidRS4BHDa5b6CQ==
X-Google-Smtp-Source: AKy350aio/rumQ7LetEI9AocwvSYx0GW8cwhrNzlriqg/1YEtY0JD4VmBm6rKqhSVvyc4ouniLa6kg==
X-Received: by 2002:a17:902:b78a:b0:1a6:4016:8974 with SMTP id e10-20020a170902b78a00b001a640168974mr2545317pls.31.1681474022232;
        Fri, 14 Apr 2023 05:07:02 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.90.106])
        by smtp.gmail.com with ESMTPSA id jl12-20020a170903134c00b0019fea4d61c9sm2950067plb.198.2023.04.14.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:07:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
References:
 <3ddbc897e2e5a766a2b4df591e747126288661ff.1681463340.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check userspace mptcp_info: Tests Results
Message-ID: <25025e15-e997-4884-2aa3-a119413d1c60@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 12:07:01 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6414330460110848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6414330460110848/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6132855483400192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6132855483400192/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5569905529978880
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5569905529978880/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5006955576557568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5006955576557568/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7239eac41312


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
