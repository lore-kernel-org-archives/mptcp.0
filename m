Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136B23A6
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 12:52:00 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1442977d77dso14805335fac.6
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CZ53jIXK/WYqJdYZkBFog5M2YD9No9GZO2cYQO6NnU=;
        b=eeM8EHjr6/vmxKjlcbwdcqMsicjIGnfDF2xiI4RVMVp2NzvtSz/oSmr2EiNq8QuZok
         dptjnTJOHfa7cIheJnQSwNJtDZldumJjwvHittxVz/rfMN/0DGMPFk1n/ol8J9mgIm9t
         vYEbyhZz2qWgmEG/Fe01QluPMTZnTsTZCsOnUte30o19uujkZKyaptBP+PE/wve++qYs
         M+WUYwXLk7xY1K2ai+B+Ra1WsbMa3olnJ6MEIEVqZvTAuPAGrOg/WmxjLqGpJ23UajtA
         uViUhxzN2+Tvc++QYq561xC0Nm15nRSaUVbDKPrpz3EXFcji+/H/3nzEVFnJGYY3RQQR
         +NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CZ53jIXK/WYqJdYZkBFog5M2YD9No9GZO2cYQO6NnU=;
        b=5OiyVDRJ9edIj8/dhq2Je+lkkTPnSYEmBgf2PApmurw81Mefw9ioXA2GVlKCSM5Gro
         IfkWWDRXrMoZogbcSNkj9dn2XpBUczAVy6VNdLRd7PR8ekM0g2a4tkqLlQK8ZcKd2SQI
         JTJBLOk7u75x4o4HRR80CCyQbOPRVve3GAtocUT32LoXh+PfRBXYy//BqoeTpSzvJTAS
         xgiRaEd3bjU9KP9+CNPQy3lPN1yDa1aoQlJ0NoY8wDm5p+Tk4Rsra8R/seI8eY7acgbC
         +WEw1/YFl4D10bcMLXV9QQuU9D1WpV2ZFLVsj1YD2MZlhKIpgO9sV9fE87lL07R3UJ78
         Fq3Q==
X-Gm-Message-State: AFqh2kpOkmU3D/WI3zyS4KmehaaxP6UYWXb4crj7rgTx/bdwR/8nt5Ci
	ZXde+eHq3+E+F6MEcYfuDA==
X-Google-Smtp-Source: AMrXdXsCKLj67cf9XkKj8XI17tXRLW6cdbr9CPW6TGN7GYRHMg2kufvPxAdXt+N1OJohv832bS2gPg==
X-Received: by 2002:a05:6871:29c:b0:160:328f:769a with SMTP id i28-20020a056871029c00b00160328f769amr13230882oae.44.1675083119232;
        Mon, 30 Jan 2023 04:51:59 -0800 (PST)
Received: from [127.0.0.1] ([104.210.132.177])
        by smtp.gmail.com with ESMTPSA id h18-20020a9d61d2000000b0068bd9a6d644sm312237otk.23.2023.01.30.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 04:51:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
References:
 <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
Subject: Re: mptcp: be careful on subflow status propagation on errors:
 Tests Results
Message-ID: <52ac9e65-7002-372e-8c1c-d07f5aa3d92c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jan 2023 12:51:57 +0000
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
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5015285221031936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5015285221031936/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6141185127874560
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6141185127874560/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5578235174453248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5578235174453248/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6704135081295872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6704135081295872/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e6d74fef56d


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
