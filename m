Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE935660
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 08:20:41 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7747df5b674so232349639f.3
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686039641; x=1688631641;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPRS3wLKuCADSZjN0G6/J2xxhkpkHEnS6bZPu+48IfY=;
        b=GWVAVNGGvbldagtV8Oe15eQuJZwW2z7bHEa3RO+Ppch8qK6iKwh6gbrKW0wR4lY/TJ
         4nJyY7CDcWwH/Kf9gsvNDkJT8V7IPLbG2eTRCH1DvcV1MRsyLw55P1NcjfBmlt+62Zrw
         7NiTHksmUzFCwIjME00bFjoattM/GrTBzewsO5ohC+sRJY3l2pPVzVXu4hjZYO2jkFi2
         NtBEx1W3kdvcE1uaSKNGOtq+S2FXYfAAXnUV1npENn+mTxzG9s/VliFoEb4FmSKlPzkd
         V7eEhwK6B+lmnXw3D8tfOVmK36Sn4MMirMGR38VE6meUbkrGBcUJu47uUeKUUIUZf619
         tY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039641; x=1688631641;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPRS3wLKuCADSZjN0G6/J2xxhkpkHEnS6bZPu+48IfY=;
        b=JbEWr0OqXsCJwwHF+3s3Mu0OvfNP+T8XTUD3gZJDLl5EHf9ZTYa2ayteZkrWzXSTRL
         zMBdJceghm901k75GlFRQrzRnWRy6e6IQMyA/QwPhkRuc/JBXltDtsX5tGZZIpIt3uYH
         1fAShNMLLH/x2umV7Bazy2lmQaGIPoI9qf0yQlPY/rACevcDBvLh21AoBZXrIGOgT72j
         LRpYYpbFnMEfHD7ql8RibRl9/Bj+IMs8R0NeX/hjYCf+JlQgL6QkuolVnPLCoKjqBIyb
         cP32klkq21/dqo1utINAn9K9RmkHIT/DdWGtdXjRYoZW0MDs3qjHTtwa0FrQiTE5vkOg
         LUbw==
X-Gm-Message-State: AC+VfDwkG4LJPFxVWCQIA8/QnLoFLKyfACPTWNagoLPJBBhbrCNi/FYb
	c2w0Pjz84fJHtZMWl95dLg==
X-Google-Smtp-Source: ACHHUZ6882GvL8jOzmdxaSIfGmTUZqvDgGLspvos0ivRDLtFXSdMx5DNlPuUHK0Qn3thslldkX+wAA==
X-Received: by 2002:a5e:dd09:0:b0:774:9c66:cbd6 with SMTP id t9-20020a5edd09000000b007749c66cbd6mr2600959iop.17.1686039640962;
        Tue, 06 Jun 2023 01:20:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.50.169])
        by smtp.gmail.com with ESMTPSA id t3-20020a02ab83000000b0041f5a0b7f9bsm1263103jan.108.2023.06.06.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:20:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f005b865aafc8870ca7f8a7c4cc99b7964562e3.1686033694.git.geliang.tang@suse.com>
References:
 <1f005b865aafc8870ca7f8a7c4cc99b7964562e3.1686033694.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <3acf9802-69e6-2711-ea08-ae418fceefb6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2023 08:20:39 +0000
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
com/task/6310770711986176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6310770711986176/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6029295735275520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6029295735275520/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5466345781854208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5466345781854208/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4903395828432896
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4903395828432896/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/08d4cef6dd8b


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
