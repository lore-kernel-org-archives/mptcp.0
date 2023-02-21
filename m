Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61908C0B
	for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 19:04:33 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id w23so5402873qtn.6
        for <mptcp@lists.linux.dev>; Tue, 21 Feb 2023 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj+UuQQK+bgDv+O1geecd8hY4aVmsKazb2QAfzzGo2U=;
        b=Hd965yzvVJara9+2rt+/a47IAt2gEJdsjO/gshdmVRrzcIsj3bvRb2tkaPsLFTZowf
         w/0XO3sLCNsXTspBWTEXAlw6/uKaxW7xWmscxJpkO3Wb+tjZ+qkGtD5atOtA8O0YU7i7
         SJJCswBegwhqVmmW0obIGUX1G3ppdXqHI64hrJO8ZYyJPYaH4/cWnrAWCMA5X4nk3lJQ
         fJwlbbUKO1z7dGPGJ6oPmhrN15c+xRnNfDnHrS0UiUgcXv5qBeGcZ3VcEZgUfCDB4R2k
         vxC3fzd+iniMuN797W1s8TJa8ZqVCxhgegAg6+ia52CTBI8bMaTjPXzQibNTla0AmNYG
         NkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pj+UuQQK+bgDv+O1geecd8hY4aVmsKazb2QAfzzGo2U=;
        b=avd470RgyCuZK3hNyIOZBcQkEZ8wiUDtjjwZtcOBIyf+pdGJtAE2PezFQYbJ4FKDIV
         Mvw0d/OZDlOmTg1UZ/cseA8BYmE4kjbcT3h3JqaQwmYSwgX0o1nzYzLaHil8uE8974Hz
         PkUj+7hcFqVFSTmm901Ld+87L+jImTchmUL4QNhB2UV3YY9rSrnVctgUE80do53e336g
         MSM2VKiJU+C2i3R6+OpXir6Cfb36E1ijeaxBs+S+HX+zUYirSDHKVUo1HnLMhZ4d88Hn
         tayql+5CC2tXDmrdKHZ87JreNNLEpFlHll5msKZS5sGvXXN4SVABRAurfj8pvyg3bqc5
         qizQ==
X-Gm-Message-State: AO0yUKWbebA2ApGsqmXMzTj1pjup6FnfjBLzkRTeWLfPQJgsuUaQ6G7j
	nqS1b0M8UrDtbnNC3ohnsUQokMDV26qG
X-Google-Smtp-Source: AK7set9O84l0XsfvFQBD9loMOEi6AOc0ebkQP4Nu/OsITafbJZvA/BPZ6AaS6yGjDRRPHV4eRW0mjQ==
X-Received: by 2002:ac8:7c4b:0:b0:3bd:7a6:67c1 with SMTP id o11-20020ac87c4b000000b003bd07a667c1mr6274319qtv.43.1677006272705;
        Tue, 21 Feb 2023 11:04:32 -0800 (PST)
Received: from [127.0.0.1] ([172.176.137.180])
        by smtp.gmail.com with ESMTPSA id 72-20020a37054b000000b0073b7f28e52bsm11463315qkf.7.2023.02.21.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:04:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
References:
 <20230221-mptcp-warn-tcp-done-close-v1-2-d248242b29b6@tessares.net>
Subject: Re: Squash-to: DO-NOT-MERGE: mptcp: use kmalloc on kasan build:
 Tests Results
Message-ID: <c04b8028-a833-8bb5-db43-f6595644e8ab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Feb 2023 19:04:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6730426857816064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6730426857816064/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4531403602264064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4531403602264064/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5094353555685376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5094353555685376/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5657303509106688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5657303509106688/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f5aae4847e68


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
