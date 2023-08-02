Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701455230
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 13:03:51 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-267fc04ec74so4940557a91.0
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690981430; x=1691586230;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWXwAvByQG5eTUgg2qfil1HvrFP87dSMKzrrKhf3Zbw=;
        b=Y1n880QZx6aM2UC1lc4R/j3lAmuCfNU4Bnq6fAqyWXExWTG3U/Hj759+SR9RrmKpD0
         Nu1fTox9NeZl9fzJWntnXQ2+UxFQtxkf8Ej3ldZV87tQXH+7L4ucqAWQZSP9J77qiNRr
         gTr1TnVig5Xtz33yjp8CyI+olo7E0FcrK54gnrt8MYHI5ZtEyTutyr2NaM6f1SA8OvHv
         M/OqygEJ+qzO5xEzWotq1OOzTqoORG+LOECmTaVTPZhPymh2u38OFkBtGpjDmDip/j2M
         Di9y9ho4opHRMUxTBMu7Su4kYsNBqF2ZUc5rd7ZASgMfjRCCAQ1XjM1s5qX+kXpU2Xtd
         dSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981430; x=1691586230;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWXwAvByQG5eTUgg2qfil1HvrFP87dSMKzrrKhf3Zbw=;
        b=b1YQwgqyeXZeoWZICyGBHhbMkgVquygJcH7+WojA+M0OEY5RlELa/lgsw9T1WjWd3l
         005IbENuu8GkWn/7tPFb3aGJRJK8hb59bEMBptpSrqB40O0tOvZEiPjVzJL5oQBMI0Ys
         UXZPZNqL3OvdD2r4hVlIm+MV+F4HK9VPEv1ALiGeODwvHQIde4ffJOIqH9/QqIbQHuOP
         xWTntuyaNb4gGQ3fj4p+kVmOKTUpTvnVI7NeTaiw2cnOD724QP727n2PTK8C2giksYFJ
         LXdKIxoOOsVPr0sG2vDYqV9xc2HDd4g+RUvKEF5HF1gHdQs2zOWsCvzdua3MXgux6sH1
         wZAA==
X-Gm-Message-State: ABy/qLYJQ7SRVnxbwJ5YWp9aS65FZoP/zrZW6mwc+XNNhlNnFxMLUIR2
	NsvZVb7TPEMz5qDRAk/New==
X-Google-Smtp-Source: APBJJlGRWQekG2oMi1LvMy8mvkrfCom5K5uU4WLMkxrbOLH9/9DSIB8trGgkseXu68JGX+aIol7wkA==
X-Received: by 2002:a17:90a:4046:b0:268:5ebc:34a with SMTP id k6-20020a17090a404600b002685ebc034amr15008340pjg.16.1690981430405;
        Wed, 02 Aug 2023 06:03:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.87.101])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a64c400b0026307fa0442sm1084481pjm.49.2023.08.02.06.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:03:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7cc369ef8c192ca7ef18b8d31a4673ea1b13261c.1690976940.git.geliang.tang@suse.com>
References:
 <7cc369ef8c192ca7ef18b8d31a4673ea1b13261c.1690976940.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Tests_Result?= =?UTF-8?Q?s?=
Message-ID: <40e55e5e-108a-1bdb-0f37-26ef8ab7364e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Aug 2023 13:03:49 +0000
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
com/task/4780248831623168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4780248831623168/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5343198785044480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5343198785044480/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5906148738465792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5906148738465792/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6469098691887104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6469098691887104/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/19006ba8d449


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
