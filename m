Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091AAD22
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 19:43:35 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-17786581fe1so46633555fac.10
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680896615; x=1683488615;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmGoFZWC9PDnvE+sTjJQzyudUY5A0ZmHnd4ikyyFi6Q=;
        b=dsL3w0zn9H8ut4dezZTBHPXEZqxaZAeDsJVQ8Eu7Uj+qNZsTuCBK73dZiETONf6IB3
         zShHsZ9nRyj03DrFkLHj6VCjrNog5UZcWb53ESXye9fSK6EpaYCh5riXw5NCs6/qyAbP
         MjwSf1gBh/VqTZAA3/dvks8LJ2Ng7oOkOoO829EujghYnEU+zYJKRQGAqIRt/mYFtuy4
         RdINmFqsASoJfutviA/FG8RtdzbbR+YOrtuTQbzsfr2CY9gZbMT7bVnW1ddqmNZBsaNi
         mxnNDIB+/DLACpJAux0NBInzQDtvYMK0qsp0qc/+9O+dO7EOObRIpRBtU7oGDJQr+se4
         4RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680896615; x=1683488615;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VmGoFZWC9PDnvE+sTjJQzyudUY5A0ZmHnd4ikyyFi6Q=;
        b=J2PVLSobvqmpMn/PITmOXm7vo3Y2JkrWfb+mH14qMGpew7C/4ABSRCaHEU7r4vtavw
         Eknnv2trOy+CmmDUhpxUJM34Vw4QLkU/8W8E4UnfF1P40trmX8pJXP/WRTFHWOjGI/6T
         CNpW0kkduUHKUMJjA2wbKQbRfe9q0565b9O4erz7IRSywtFXMDuDHZSX0wS/4fF1qhMe
         E3leO8mU4Xafbg06ezr/zyA58nKAiqidSIAE3zUmQjVGcXOnKNoTzNpYvuC9yU3PeBzN
         T2mtHisnS9Ie4xepjxZpUpZu/tDynKDJdS4yjDFb74W982egD8DsbxPI3223VGfYI3V6
         ziNA==
X-Gm-Message-State: AAQBX9c13++Kt2qYfT9pVdZ/ISPxpnxzSVtku6n9jV3Ji0mK5nvHwywG
	6opeWEDHKcGgjtCR5saJNQ==
X-Google-Smtp-Source: AKy350ZxlaeURyqnUbXuFsftIw+82E5Vt3HuRHEiSucQWWLg4nHD+odMcPzcG8xQKeSO8u7XNReRHw==
X-Received: by 2002:a05:6870:700d:b0:17a:aea2:cd0e with SMTP id u13-20020a056870700d00b0017aaea2cd0emr1423736oae.1.1680896614719;
        Fri, 07 Apr 2023 12:43:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.170.104])
        by smtp.gmail.com with ESMTPSA id sz11-20020a056871860b00b0016e49af5815sm1830896oab.51.2023.04.07.12.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:43:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230406165705.3161734-1-leitao@debian.org>
References: <20230406165705.3161734-1-leitao@debian.org>
Subject: Re: io_uring: Pass whole sqe to commands: Tests Results
Message-ID: <6558e001-bcd5-327d-3fd9-b4ea4897b64f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2023 19:43:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6539795959119872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6539795959119872/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5273158563921920
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5273158563921920/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4710208610500608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4710208610500608/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5836108517343232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5836108517343232/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9999e6372112


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
