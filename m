Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291D362
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 05:02:57 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so9109330pjj.4
        for <mptcp@lists.linux.dev>; Sun, 27 Nov 2022 21:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvaADxEj/OM1cQg6u9ejF+eVfhH9KaZ6U/ioL+8QH/s=;
        b=gf/YxNvhsHi8blg9uDm5o6spBEXeikTaxQkjEj7paWcxoGYPw/A5Qwx9mENc5EJSnp
         AAynaoCB4UQUJSvm3Y+KS/UhSGKH6a1v60jeIX8MCQ1a5EFa7hOMr3SGY3dSJXL3MXVj
         UkLdabM/jnZWCgBVphy7SHMa5GsmTYCPURb1xRtLxCKtUdkxlL441hHNHC/hhZEpiCCY
         ylp5894PWJ0kHYAm9876xvEwAriZW8GKhlT+nOgJWhVsojCEQtwSZUqnWXxQJhS536/p
         fdbeQFH7O5DNaRG2QpQg7IXmzOCTRrIYLwL8pXdKF1zsdXq+QYs/F1M/BpeMBp3GnmnY
         j/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvaADxEj/OM1cQg6u9ejF+eVfhH9KaZ6U/ioL+8QH/s=;
        b=t62B9qf4LluQF81PcU0ZPNaO9/slahv0RdEVlS8c4wqbUAS/HTkRzqAI0SHE0uW2fJ
         usTvuPTp0C2/TadhfZnIbMApX7/74shffLKutEAPb09Ig2vs59L3Rh109zhBvOhZ8sKF
         pkcoWGcg19cAMcNbtlS3b0TPQ1oUa05JOUypQEbKS1B6bs/YGVY61LVMsCDiact1GyZK
         DNnh68lFQVeBnCYseWgFfVv5Yoc7xjTqC5sWBwC+3MNhQ+wTMZ8p1XK9hCn+zI8lDww+
         1yuTfW/zJCIBKa9v4A2RIGWUuFIloT60ZFA7hVXttR/BLDRNUFlURuiXmbYSQvMrOO8R
         2k3g==
X-Gm-Message-State: ANoB5pmZDUITanCkxE5X84BWMolPnfpwkM8qjbJiEVd4lZriMXpBoUzF
	VmxWHKNy2IYXG+bLs9ZweQlZhnclQQ==
X-Google-Smtp-Source: AA0mqf4AqKxlcqny7jsjwocyuLfi1Bw4nHkcqg/tIDLqAU+W9gW9fEAJ/f4bWWN4YOh1lsSd5E796g==
X-Received: by 2002:a17:90a:dc10:b0:20d:69a3:1fd9 with SMTP id i16-20020a17090adc1000b0020d69a31fd9mr59145584pjv.167.1669611777401;
        Sun, 27 Nov 2022 21:02:57 -0800 (PST)
Received: from [127.0.0.1] ([40.118.164.81])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090332cc00b00186b69157ecsm7695066plr.202.2022.11.27.21.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 21:02:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5ea0584d148efedf545cbd2a382c87d8155ad7e3.1669605531.git.geliang.tang@suse.com>
References:
 <5ea0584d148efedf545cbd2a382c87d8155ad7e3.1669605531.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <65bb6e77-2761-584d-0516-87914234f606@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Nov 2022 05:02:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6078049075068928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6078049075068928/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5515099121647616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5515099121647616/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f53d9d553d2e


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
