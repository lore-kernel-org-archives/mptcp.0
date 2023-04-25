Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF07B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 09:17:33 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-763ae18986cso95322039f.3
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682414253; x=1685006253;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCX90eNmukLKuIBOHY4l70vQcCGnfdxQ8bEUgAgxyCg=;
        b=rnpxgL5dwtWcNj6eBv3/bKXxJTngrbaHiUCofs+SIXurwmfeF+uG4djxErCzc8pcrS
         4zujAwWl+6Th0FnMKS0uEo/vgoSNSxiH5g2dFGKYZa7LXeWoWkqtX4gax/0FFhKfKlqp
         4KY1lsEf/UgB3CG3KBslQDxFwHY+gjeABQJDGHF89wxX+vYFQn2SGQovYoi7CMFYOTiZ
         yOYp7U9WlRqUYMPlAty43fblWuEAm7EqxaBnZDQRedm3G09SdAdmitbqRWL5IsFWfUrx
         QlpJxVkMiY3ioNnONQbjxmsNbdYF/MinVTFezjafefEtDRqMHWJ0PYJkidEg7g9O4j14
         RFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682414253; x=1685006253;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCX90eNmukLKuIBOHY4l70vQcCGnfdxQ8bEUgAgxyCg=;
        b=A5cUEVGfNGedRSxRMrTN++uojUkp5JqvMNBN+08WrVeA8lOebBLxnkR5V+BSiaYtR8
         oMbZvtn73xhvVE2Kzxv2GxceQyN1wz06q1NqaXDuSbFT+EZpHHCXOof2oRVHqLHZUtAw
         Np4vi9XKU8wHBOp0AnpcQkHdsXcMC07IZO/I+uBS9SH9qeJ5ayisR4zG4peZhWludS40
         t1MRR1x6Zqgl26Hjs/Yfe990FKLrBdm6MfWU8yOVawVbx14mJ4Dr6hd7VkCxM9Z6ILN9
         Q5hOiYwXWkH0sVGI11cdhGw4+/PmuPbPU/rUuWylrrwkqf0ZXLcgL6fPD1fUkTPdEiAj
         MGLA==
X-Gm-Message-State: AAQBX9cIiEhQfnYrhiE4zVOV90RfMNg+d//APTa/HK9YK2X4Njq/TkvB
	4PWauT8a6UAZ0Jz2GHWd0g==
X-Google-Smtp-Source: AKy350YS2k8pSOwicai/MApDCy9jRELlAvM9uooDmQajZaGAf8yEfJvPr6Dq/h5JZv5DAdvdbZ91cA==
X-Received: by 2002:a5d:9146:0:b0:763:538e:2316 with SMTP id y6-20020a5d9146000000b00763538e2316mr7909018ioq.9.1682414252919;
        Tue, 25 Apr 2023 02:17:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.158.58])
        by smtp.gmail.com with ESMTPSA id z73-20020a0293cf000000b00411a9b60c4bsm2529714jah.169.2023.04.25.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 02:17:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ca308feda45a2451d0297e2c5f21dd9b1aff6981.1682409247.git.geliang.tang@suse.com>
References:
 <ca308feda45a2451d0297e2c5f21dd9b1aff6981.1682409247.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update userspace pm subflow tests: Tests
 Results
Message-ID: <ecf6e7dd-1664-5d9d-d9cd-71c8c90f3e74@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Apr 2023 09:17:31 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6754937204375552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6754937204375552/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5629861931253760
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5629861931253760/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5066911977832448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5066911977832448/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4503962024411136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4503962024411136/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a3e928c47209


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
