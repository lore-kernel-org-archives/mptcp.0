Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023A63CF
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 06:56:34 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-75d13719304so19390485a.3
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686207393; x=1688799393;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jrj2u7TSTuxY74hOsRJHxFQgixv3TlNZhY+0tLhc4g=;
        b=ZkkyVXbTRQnXApur9VedoZhH+sc1ExrOgIBKPrBy8j29MWhPPNxtSBZc9dNhUsjJps
         ochUMsQaS/8CtnJ3hhvFY7c9VMaFQH8l6E/LjmWCrndFiyAN7tjkuoKLLNOx9sT6gF+y
         ek6GQYOXo/Q03W5A4sH2Krspz0zvlkZ4VrnnIHw6fy/vpp6euyjCfA6UQXqQY1LHNNvx
         imnBFZZl5oyqa7fvH8EzaL51UNcjl/N285R4J8/iz/4iNVXkz5PiZRhhFHtL18GByOX/
         E9Yw4kJye57DNxvUfoTl4Yz6lKZw6hgk5L+p56Th0/YgEtVnNiJ/CmRyqBD0QhlilPrs
         03QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207393; x=1688799393;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8jrj2u7TSTuxY74hOsRJHxFQgixv3TlNZhY+0tLhc4g=;
        b=Xj3d9+pVZ1xm5Uya4q6NWUCdl4UVPdfZdGI54idsps6w7FDnBq7qcDengCY13igaio
         EnvG9EKX0BU0dHblEuVDJyFG5jX4ocibwP7PjRBc+eotrixj88NYp8D8KTmZZpAymvEF
         z8L45l1E+aWSaKHI5kzrwxoB11PXl8BIskAEui3+/GzO65YIpwi9rAaP5CPQT24vXR+V
         Zx0FHLz+2Zh1BhortMdRUC++HXxygn1l3D+pJbMRGpmE9BW5SgSEBrvdHWFdZy639Q2f
         WSk5ol45UA6TGsEQ11NG3/AuLP81SKq+ZsmTXtofGOfPEMifvPm4tcRHG3jbCm5PVZZg
         oPkQ==
X-Gm-Message-State: AC+VfDyk8erZpId4YrbfV6uUnR2i6eDruLHyordfGhWsLazmWniTmzFt
	PgPVWre9XEjjjEQjGCi92A==
X-Google-Smtp-Source: ACHHUZ6tT+ikv1poJyLhQ58pkWTDRUqMh2iTTHyHYTTPPAVUKMJ3opWuNNg3LMFJz8VUQHSz8c2juA==
X-Received: by 2002:a05:620a:1b9c:b0:75d:50ce:ef09 with SMTP id dv28-20020a05620a1b9c00b0075d50ceef09mr4555101qkb.10.1686207393313;
        Wed, 07 Jun 2023 23:56:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.122.113])
        by smtp.gmail.com with ESMTPSA id c22-20020ae9e216000000b0075cd3d61715sm145956qkc.47.2023.06.07.23.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 23:56:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
References:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <685aad9e-d006-ee6d-04a0-3b7dcdfaa432@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Jun 2023 06:56:32 +0000
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
com/task/5546798673035264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5546798673035264/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6672698579877888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6672698579877888/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4632004998725632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4632004998725632/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5757904905568256
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5757904905568256/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7c8401a57874


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
