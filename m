Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226919515
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 15:57:56 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5577004e21bso1569039a12.2
        for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687881476; x=1690473476;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBcsAVWUvE2i1q9hvmp+seuR6Jiq2FcQy/cf1zMV07I=;
        b=mbtffUxj1ElChAHtYH5tYATdpItQdPmJ502zGcLqgAkAXeFCNZqJx8UeqC0r9RJQRd
         SrKQkdKOoAfOrB1u2ifH6nUrokuUy+YUicOy3Qbxae8SaOybHhWfKhKTE/1sbGqzlUY9
         omXY5OQjYjLVNTuw7/Zr0I/S9Ye/OvBKvv2X+0j9R64+1tG1ATyCPGnDyKKfJz/xwwRg
         ubpOOmb9ThNL7vxE3eD85QivxVxOI5kXyKeQzHZwk0nUnPQOmiaBnUIU5XBHnBp3jtaN
         jqxQi3FrHUKfIkUyI8uGwAgY+yZ+ghqxuOk+DMj4Bjp/Pqrq5uE1d/vxz2wEOpaad9oe
         s3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687881476; x=1690473476;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YBcsAVWUvE2i1q9hvmp+seuR6Jiq2FcQy/cf1zMV07I=;
        b=B0H1RBcOumJ+QRSmZpa/DmfV41VBQM32QsuUpMG6Wm6F74jgituwnWT+mR6gKTOqSr
         s9UNea4bencoiwcj3nZKnq1fck6//EIoDMjJIybqC390XbYCJR2Xv/0CvqW2OSBhOpG7
         hidTCp0k5z/Buor7ORnKgr+nZoB3bJV92hKyhSGoyfPZiX2oXsDFOz7qcfD1+AWdwVMt
         UVAg6TMUK7OmH5C9PcP/z3glZG5Mb+CkkiUUxlRWgAnrjZ69mLgZ8oa1wXhjaVaTj1oS
         oGtdvGRQ6WxWuSnFIpx4sj4c2SKVYreyzyCGzqW5CBjOCTUz2tA6cIXPFV7yxG8E7uzS
         Ct9A==
X-Gm-Message-State: AC+VfDywRrQ60wx2lEUuJEv9MwR8OG9dv6SGkC/kuKYzv86gluiaJWRD
	c5g+fRY0v2xExWJmkwjgJQ==
X-Google-Smtp-Source: ACHHUZ71u7EPly+1KsBgdBJWrCQGEtsnvywTYVb85OnnVhfs1aE7GyvTlXm4tiLzOdPQaxm581VbrA==
X-Received: by 2002:a17:90a:fe0e:b0:262:fba5:2a8e with SMTP id ck14-20020a17090afe0e00b00262fba52a8emr4187944pjb.47.1687881476386;
        Tue, 27 Jun 2023 08:57:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.177.200])
        by smtp.gmail.com with ESMTPSA id 91-20020a17090a0fe400b00259b53dccddsm6799528pjz.34.2023.06.27.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:57:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com>
References:
 <ed9c7f0320bb94a4a147d11c447cefa59f128ee1.1687877390.git.dcaratti@redhat.com>
Subject: Re: mptcp: convert netlink from small_ops to ops: Tests Results
Message-ID: <f7b328dc-5fbf-67f9-4843-3f7a8c0ecc1c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jun 2023 15:57:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5189759551668224
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5189759551668224/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6315659458510848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6315659458510848/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6034184481800192
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6034184481800192/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4908284574957568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4908284574957568/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/58968013f2f1


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
