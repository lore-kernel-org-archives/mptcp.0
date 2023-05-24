Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA360862
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 19:56:58 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-397f0bb41a2so294956b6e.0
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684958217; x=1687550217;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oec24N17XaqzentL+3A83O9Xs1wHmr6V8Euq2pVSm4g=;
        b=Ir0S8kqva+X4czmiD08RrT6by215BMCnZty6+8Y8uGC8jF1b3iMsCAUxmpdzdZhncl
         jd5gEGpjJ+DeDSjJ7fXEhAo6J2cRIuzawWjIvO+wJeE8z7U+uYyVcdlGXQa6JNLib6zY
         +qgQ+ZajWjsHWzBCZkfnDirZdGEbuyVc/zlGwnMfcRJ0SFJzAKjtRjW1EsekX+S7C1Qu
         sem3ajvxLw65lBlnfXEvEhMz+V32rsbj5Bj7fn0XUBgWdfpSvoWfhxG1gcTkvOSxaEW6
         Q5zrrf/d9A6uQ13ksympgrw2hvTiz8TXziofRktf7t/FXxhOdGngq7wBs9yibUPnlTS0
         BEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684958217; x=1687550217;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oec24N17XaqzentL+3A83O9Xs1wHmr6V8Euq2pVSm4g=;
        b=Y84HsM8SEPdFI/GrTT9E+A29IjjKRRPCoalxud0K9Pda6CvQ33cEmDajap4/q3PkmZ
         3sGh+OYR2RQSU/VPTOHNkDJozDUnxixjp63zSMT731sTaYBYLG76gt23l8RCeQI4MNh1
         rrdfa6XtAaRj8FnI64PtCLF22+IFFfuGy2NWVDKgavJCmlJSmjkY4YJ2I4oT88ciXogr
         qN2D5j6UKVnrcyQ7Aeq65q2+BIRw5ZoAHLze0JZAymhYD/ESsDzNHjok52TtVTxpS5oy
         T1jV2468PLyGIeXuXPl7ooRoDw1G8Kaa6naGumaVPkdfVcJ5cbMBfgEhd2a6QznvBWWs
         mKeA==
X-Gm-Message-State: AC+VfDxCUjtThJ+g+MxeMgFgl6bz6RFo4DOMOeXCnr9ferea5/5Q0DpS
	COYTqcQdrqfdHjrpAuj86A==
X-Google-Smtp-Source: ACHHUZ66vs2YAwxXr5ZG0lP5EPUGVYJ7l2ve1KQu2O3yxSjgMDl4BpEX7muJ6v0kfulrPDnjTePrdw==
X-Received: by 2002:a05:6808:8dc:b0:396:20ca:e68a with SMTP id k28-20020a05680808dc00b0039620cae68amr9069916oij.34.1684958217243;
        Wed, 24 May 2023 12:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.166.242])
        by smtp.gmail.com with ESMTPSA id u21-20020a056808001500b003923ef75a3dsm2280658oic.4.2023.05.24.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:56:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
References:
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Tests Results
Message-ID: <95bef5f9-5d73-ee9a-d53e-b9c91f03b114@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 19:56:55 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4503925617852416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4503925617852416/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5629825524695040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5629825524695040/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_add_addr packetdrill_dss =
packetdrill_syscalls selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5066875571273728
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5066875571273728/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6036925308469248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6036925308469248/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/63022ec27b06


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
