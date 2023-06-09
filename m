Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56891256D
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:18:45 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-64d18d772bdso1956616b3a.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686323924; x=1688915924;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/Aru7A/fwj857icYKx2DarUXXJVa5282u4b8K8w+Gk=;
        b=YtVgqGFwPIw8FKp8V4uj9+sxrsoTTokNQDWaPOwRs++GzcxGm+uXPbvL1Qd5Kap2AI
         yYOVEekkZLDRrOVHgEXrqrjBhaJaoxJ6/xWuRM3rT3hzH40j3sKOZG9RZ2edvFp6tGM1
         O0Ly3SIhfHukrAPt3tnK5F3zAwrSHYQmDqMUmyipuoTbs3qOiOym+ZIaE/6VRO+lcBzO
         OjS8rKaxNcd+r9vUvFtBIPI+gaI6l+JMA+hzG3T4SHhSos5WNigPIoVHQMxMRCttdJVf
         jp6SCsgo09hplxKgj2XgKhHpzkKRZc1QyAnn1wNL9y/ZUmPpb5EbuleyP5f2jfGaUQ20
         wfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686323924; x=1688915924;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/Aru7A/fwj857icYKx2DarUXXJVa5282u4b8K8w+Gk=;
        b=F4IZYEXf83dH9K70tr/erEud8Iw/VX+xOa6XMcpa5ZrkA9/biCSq0bBDN0Ldnanp7s
         TciKQuJ03vcfYPIq1UUuK/eJk7rgXCmkPFYV7Phwr8FriU13R2IcD3xCp85H+/3z63OQ
         UfUzXv7KEUJg3lmFE9MObmaxYtNE+raA+n42+nPKFnRwPyyNsLUQ7YtfjpnV9felJ94H
         6f1xQa3vskRbVojDYYl/VGGsir5pVO6T8n1troZWKQ2v4vBHBZEdrnFg8mJDey6kPxJ+
         pENzt5QRkYxRHqaF/tnYMA0B4ALcxzyb10PQ8Wm3xWbRs1qBzauKjcqL38hW7eCFiRpK
         gLiA==
X-Gm-Message-State: AC+VfDy1uBD2QURJ09YTjs90OjFJXpwtMIiatr29KRXQaxkonXpKq0Ig
	fDH7iDgCO7pzxWmzqDAMow==
X-Google-Smtp-Source: ACHHUZ7jT7P+Kzb1iL5//n9MNzechru42/grEoN8zL5nbpElXJau4l3HFcooYL5XX5AdAFWjWdyhoA==
X-Received: by 2002:a17:902:8648:b0:1b0:524b:e597 with SMTP id y8-20020a170902864800b001b0524be597mr1523912plt.2.1686323923657;
        Fri, 09 Jun 2023 08:18:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.59.110])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902b60900b001b03a7a40e7sm3420815pls.19.2023.06.09.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 08:18:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
References:
 <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
Subject: Re: mptcp: consolidate transition to TCP_CLOSE in
 mptcp_do_fastclose(): Tests Results
Message-ID: <2d275985-7e7b-b9e9-2708-5e796e08767b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Jun 2023 15:18:42 +0000
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
com/task/5242073528401920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5242073528401920/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6367973435244544
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6367973435244544/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6086498458533888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6086498458533888/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4960598551691264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4960598551691264/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4d0e5862922b


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
