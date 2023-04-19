Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE9179
	for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 00:12:43 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id u37so6724898qtc.10
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 17:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681863162; x=1684455162;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Yu1K74KMOBsJHGNP7AWoY6M5/zqlAeM0WGNwZXXNDo=;
        b=E2+J4MNqqWD31/R627InHLpWWPRC2N2VsVysZpuk3trDFGxBtJomLigB4deinfze6A
         /YswW7NwRTxGUGBC71At/Sy0USUvwzwnCOZJ6FdgHVYaP42WydIHqCm3TJyHeNQCNJcl
         5tHo/xXUPEHSM2NQntqPXZVGXMMlFm3YEvAM/8aCs8ClRQZkgxuLn4hwZ777/nQBkln1
         n/d9V8QnIZouVvq3BCka3s5d26LKz/b5MC8O2q16yz96eqcv2AlL60aYhiJZwbF7Tc4a
         nhfUXANY2ysJnnpGZjHrPqrBuxnNXEbRyf+cA6+sHDu4wYobplu41r7RLioT1gfc5OZa
         Pj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681863162; x=1684455162;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Yu1K74KMOBsJHGNP7AWoY6M5/zqlAeM0WGNwZXXNDo=;
        b=FOnVXvuVFyExW57ybO8883rGLu1UTSgGglBwewz7b/6pbKi9JT0iDqlRb7vXu4/nza
         TiMScFoZW++8/DKAwfTFRO/MrvOYkf3DVjdjNOOCza0fUqPMZUCnHNB7hZA/bC7HeSkN
         rLzOAi0FgdcNlnXm7jA+CIIafl4XsjrsaNZooI8pUHXyf1YketikgAdL1ScNUf7mvv3y
         xbYpVh8pmgKQRHNeODi0tznRNlXGP8IMyJVzPaePfzCra4j5/aWXDp21c1Ppbj24etsI
         kXYua8AU2tKuD269Wh+Nl3D0UNRFxxkWI/8ToJqDuw8AR14EjuJHrGKmwAi7CFL2RWcj
         9VAw==
X-Gm-Message-State: AAQBX9flHoy0f4LwXM4CqLweLyaIgHObU5DqvThQ3Bz3vUrOYn2xM1U9
	2DGv4tYUfguktqvBU1eCpOcIelk17sswtlI=
X-Google-Smtp-Source: AKy350ZT7DKyE3vlpF/RN7y4jE47/NCc4sT8nJRvPuDIQNnHAA5kVCXCuu1LrKLHMidyehsHKJvJtw==
X-Received: by 2002:ac8:5f0f:0:b0:3ef:3cdf:c29d with SMTP id x15-20020ac85f0f000000b003ef3cdfc29dmr2175950qta.52.1681863162695;
        Tue, 18 Apr 2023 17:12:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.188.93])
        by smtp.gmail.com with ESMTPSA id bq16-20020a05620a469000b007484d284cdasm4291760qkb.93.2023.04.18.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 17:12:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230418231318.115331-1-martineau@kernel.org>
References: <20230418231318.115331-1-martineau@kernel.org>
Subject: Re: MAINTAINERS: Resume MPTCP co-maintainer role: Tests Results
Message-ID: <b064a162-61bf-7d1f-df38-bd3c4fe88511@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Apr 2023 00:12:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5548554148642816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5548554148642816/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6674454055485440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6674454055485440/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5759660381175808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5759660381175808/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4633760474333184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4633760474333184/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7d96499f0ff6


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
