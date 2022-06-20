Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58759A57
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 14:16:39 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id q4so3955088qvq.8
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=RuuwEnpIoV2CcRHK44d6oj97QzP1/I6uIejpgAtk/m4=;
        b=OCBrxIK6StvyzUYKizQMCOmGSdyutREjR3tnnqzy3hFZnDC25GHAJy+XIPUyasqURd
         EMWV2ILxyRKMWIUD3O/vkjbcD5ZQJ6ZJvokhRlEdzj20qKQBTQG4B+QlBN8c2DTDd5OP
         1g0TJ5xH9oNyLKKo670PWjIT9j+RMqMDC6d2MjW1kpcOX37GIDCHbuUx/jukeYbK/2hZ
         /yafXMwjS1ymeta2JJzGLZh1RdJE4ZjO/BhjS/2d7PWZasLZ93cs3fLcGD7iwodWBdn3
         wyha/VxgE1fdfRar23bbUO8pzCkXp6Q6elfUv8hAMRGxaWBma1gt0gEIDJ9oF53NaKar
         4P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=RuuwEnpIoV2CcRHK44d6oj97QzP1/I6uIejpgAtk/m4=;
        b=0M68G3RLpAASgXlx1sMLxVbwkLg8w5J7owiUXA822ZXMxOkuVogVTGmGiZxR8xoWzR
         4DaSxi5qXHY9CPLQhvLBUrEBHXc9oNeTvZz3B/R5Fwh195stdMScH7ANP2xo4X3YuPWB
         gKL811i9ZSbLoUF8dXgA5HcATqsqZ4/2syUVWsO/UP+rueYItw5kEZsCYlTBi2Zk2piZ
         46M9LTJ9bc6PL4nkr0ONpD+OkEcLcrgDw8fctqyQ8U21ZdlyjzVWnKDk61aOsZt6xOOm
         UACcA2UmgijZe4BWUzd4p1z05xKIoSG0TyrM2QEyIS9uS+y3tVg5SbmcT0WLMUV7aXjQ
         r8rw==
X-Gm-Message-State: AJIora+tyy3CA3OeS1VttMDxltfoqLofE1ux2F4Eq5O3g9wzcIA7ECrr
	6IMwO61X80u0Y4m5JRfIpHieYQ4zqPyXjOM=
X-Google-Smtp-Source: AGRyM1u4MSifPfcAnXB1rQA+y5Vu/fyE/W399CVTdQdvjV93BPnBEsK6XSK0l+NvGQ0bOo+ngRagUg==
X-Received: by 2002:ac8:5805:0:b0:305:0:7b3d with SMTP id g5-20020ac85805000000b0030500007b3dmr20208405qtg.46.1655734598065;
        Mon, 20 Jun 2022 07:16:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.246.29.140])
        by smtp.gmail.com with ESMTPSA id b24-20020ac84f18000000b00304de7561a8sm10538656qte.27.2022.06.20.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:16:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6d0c040baa09ca582d78a0a6afc7bba2308fcd98.1655723410.git.pabeni@redhat.com>
References:
 <6d0c040baa09ca582d78a0a6afc7bba2308fcd98.1655723410.git.pabeni@redhat.com>
Subject: Re: mptcp: fix race on unaccepted mptcp sockets: Tests Results
Message-ID: <6262bfb4-5334-1bb6-be60-dbcc1ef3c65b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jun 2022 14:16:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6227112922185728
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6227112922185728/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4819738038632448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4819738038632448/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2e56088a707d


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
