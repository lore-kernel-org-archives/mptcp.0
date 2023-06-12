Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5410FB
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 16:43:48 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-543b17343baso2282996a12.0
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686588228; x=1689180228;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jFXi1MbBaOohNRLoAl4/HgU3WBqVRdGhdYwwnJjQGc=;
        b=PFuj6292v+dCJ+V6OsXX29+fGjM+fmgMeB0BrcmQz4mx/7E2Mo70o7EKiEc462Fxt8
         7rT19ULetr0kZ8/hUeRj4cr8YHmRooIwdHsuDenQtzehsbglrzztuPey8IWxbguK/BY8
         Hg5NKyXKmpg4lgO2gMyWEp+oLCHO4SkJ+kv+YcndcUAsz2BDfDxAhbFdK5lxUj4VP7iU
         se2TKYPAbgjFfT+1UqEhJsHH1PDEM4uCfS2z49V2luq14L5/oCkm4Xu3ydptDO/rAlQk
         qSYI/EYdK1EMs2ZYdnzMdxcE2eUiv9a+5eQvu51gVB2C4juki+WnJU0ozdoIHpn5OjaF
         aTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588228; x=1689180228;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jFXi1MbBaOohNRLoAl4/HgU3WBqVRdGhdYwwnJjQGc=;
        b=U1yGhm1RM1Qfas5UcCJ1Ns9I6ZWRjC3wJXR4qHRtjsDTR+5nDKRMr/Ag0Y3l/1gQ5X
         f1pzyLuXe+1fDRCeQnMmbanajjcCZQ2lxmD3txZIrAsOjJB9OzA+vlnedAJUmWMPU8kX
         DMwbpA+lNvIsfD8me4mwiCtRJDGaQV7pEvFsI8LxvoNmGQ7VfID0eUBbLNh9NcxqRMPt
         uKOPZe8aoxzxoz43TTKiGdIqgR5VCI/tnCMmttya0e5PEMLGcw0YcaEebpvXnhUGYvs5
         +8uXTqw88j6u1hrIQwKyx69QIbwokxXQVvZ/3+nRA2JOGr3KQtcv4H1Brs2S8BPdz+JK
         QDMQ==
X-Gm-Message-State: AC+VfDyoup4EohnqMHqrMuXt3T3GPgvEMrEAjXQJN9ginEc39M0f/mmB
	pESHL0MMa19QfKz2aqSGfds/asy3ekDT
X-Google-Smtp-Source: ACHHUZ4+uQ31ldlF22hUz/32y9ZRiwHgmJR6ELmH+JzTfcrDDBmjecQhAIT0P+RgjOMT+0l+zOHzpA==
X-Received: by 2002:a17:90a:738a:b0:256:831b:8f45 with SMTP id j10-20020a17090a738a00b00256831b8f45mr8487136pjg.16.1686588228072;
        Mon, 12 Jun 2023 09:43:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.133.132])
        by smtp.gmail.com with ESMTPSA id bk17-20020a17090b081100b00256b9d26a2bsm9356198pjb.44.2023.06.12.09.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:43:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <54a3b69d83dc1e965202eca7ccfdd4927b68de2d.1686554287.git.geliang.tang@suse.com>
References:
 <54a3b69d83dc1e965202eca7ccfdd4927b68de2d.1686554287.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add pm_nl_set_endpoint helper: Tests Results
Message-ID: <8049d046-c217-7757-be1b-fb1990533a9a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 16:43:46 +0000
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
com/task/6547545413910528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6547545413910528/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4619057182277632
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4619057182277632/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5843857972133888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5843857972133888/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4717958065291264
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4717958065291264/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d63870a84ebf


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
