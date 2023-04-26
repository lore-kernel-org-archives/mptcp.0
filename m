Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AAC2F2
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 09:59:03 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-760ed95b9e6so152089839f.1
        for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682503143; x=1685095143;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSB5shidPGlfTLaH9ABkyv+CH/bQYv/6DqTRoQ+CD2g=;
        b=pLUAq05kOW2XrXg5Sfp5F5OpZQUPa1nn2scAgGBMbrdUe5iz5ro5AlY5SplCVxVJus
         /rRDF1CtWUVhHUjJ+80dvrSb72LHoH+3jbTr6W6PYW+I/X6HNKM7Qw7aYENQQ8EB43vV
         c0S9bJwh0AYXbk+6tLoceMw1H2Ck20fqJKaSWbXBiJ2+dZ6rnOd+395lLCCN9sL/Yzw2
         2F+2xhz+VFhf8TE+KlV5JprnjPINhZewrco2qsEUVmLVaC7oGjVvPrbembhBlaSWLl0w
         25ATeG+Sqgt9U8c277c/cPZgBWyumC61x3zhVfYhJbMOe7PoeuctmxOvlg/whLrHPm43
         YriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682503143; x=1685095143;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSB5shidPGlfTLaH9ABkyv+CH/bQYv/6DqTRoQ+CD2g=;
        b=DFfaD+tFCXHPbzJWjpobjhSZdaxAmncPV+FTapXFcXDE/rbf2uG27K3s3wRGmf8Opm
         caHUL9OfxtgdSuEIzWpCCiHmE6RcPrsxJS+PnG7iibWdEx3RTyV8EgZiatoNDqAsDlng
         43DStiUnagQ+pIqKJ/Dj4eJvMWGtdCR3wpZblSIKjiXnUUhfiDEK+1TiadlLVxXVVGi/
         igtAv0/NfB5RPx1Y/zWOesN+tFQBbXbR/ReIL+GeklOqIBat0Tfm+BdJeNcjOqpZnDeb
         9WJyXc8wvnMbmvsP9UApRSmc3WOIi39NiGDol1V7rjvos/CnvonUI09Xwrwtqso6vlkX
         iSNA==
X-Gm-Message-State: AAQBX9c/VtMTNU52wGt5iQYIVfjBJe6I2vPldqA/pynmDSRzT/0gnKLw
	SlWC8ZHDaMOV9x/bL08wpA==
X-Google-Smtp-Source: AKy350Y+E5X65eDhCA1g9K9Wgrt+dvhBfWJt+jE/YBdcUFkGAMOMo/KX9PhJ2C2yxWf7uxfqgBW/Bw==
X-Received: by 2002:a5e:8803:0:b0:760:d52a:c1a8 with SMTP id l3-20020a5e8803000000b00760d52ac1a8mr9109972ioj.3.1682503142999;
        Wed, 26 Apr 2023 02:59:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.123.121])
        by smtp.gmail.com with ESMTPSA id f23-20020a6b6217000000b00753206f01e5sm4342457iog.19.2023.04.26.02.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:59:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6d3687d33b1a7f6b40e75047ab09a625ff79d923.1682499136.git.geliang.tang@suse.com>
References:
 <6d3687d33b1a7f6b40e75047ab09a625ff79d923.1682499136.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update userspace pm subflow tests: Tests
 Results
Message-ID: <db0bd120-bcf7-4b6e-622b-abe905331e4d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Apr 2023 09:59:01 +0000
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
com/task/6494550181543936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6494550181543936/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4664962832924672
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4664962832924672/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5790862739767296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5790862739767296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5227912786345984
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5227912786345984/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ae45c96e08fe


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
