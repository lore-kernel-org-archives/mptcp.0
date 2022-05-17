Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB47F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 08:07:12 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id bs17so14077728qkb.0
        for <mptcp@lists.linux.dev>; Tue, 17 May 2022 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=gr81NE7KTeDFwU7Q8y6ljI/3jv5UZQzFODDQEhBy8pk=;
        b=NDTk/Zq1FNDVb1AwJa/ow92Q9KmC3ziG2aJ0VRn4anBABqn8acFVyyBakRjDB0mMJe
         DcS2KQVfn85qIVEbSkfXOCbhgsMOOoE/ZKmuWqeJ6NIB48zIqOfnYPjrznlYOEzxAx/f
         rfoDIsUOveUTWLqWnpdzhdcAQkvCkFqnhMlCLBu0x0itH1PB6QqRy2Xl53Aobw6cDWV4
         I7Ey0j8DWIOLNGTw8/fAyNHhGKeBl2WeST4LgWaxv7VkRUBtL1xOayGO4cPH6S09kPKo
         c0vKpJQCh5juYb7oUVGiPJkWoGiOyMeF/OfWU/qr1UrgkoemVkItqjdcWjYAdtYlYdTB
         0klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=gr81NE7KTeDFwU7Q8y6ljI/3jv5UZQzFODDQEhBy8pk=;
        b=VA4Hz/S+ebmil87kN5vNOSwW/rS9hOtapbcZ6T1KkCe/haFySTjRpSTG3MZlBKVd5B
         GoQ15hxE8SZUJM2NONkgtRjTy/ybQhLUeeH50I9WswKmA/ruemRBb+hG+gfjdsFmh4wH
         DDfydSbaQZDk5n5fSfzgdnh87egSMK5cQg5ytRNjMed05/Fy94pG0OXZSu+xQ5LCB7rE
         hDFDBrZ48hYAXOVLAso49zcW+9A4sZUMgbftfg4aErVdTlEceC0diaz6j95owSKbLQnY
         BJiEEC55PFvPNM9sfsTADOHOxKHhXpMO7uoHL6jxF6NzCoK+GOm6UpSqB0PbfZKz975Y
         3Q2Q==
X-Gm-Message-State: AOAM533IgFRd3yflRWw+5sd1qAA9GT8IphoR69rUNlb9QOFyUNT822j5
	tOzNlNV/pnDX5ZnvygBqjg==
X-Google-Smtp-Source: ABdhPJzX0gXi8/sJvPgcjVLRV74dh0xR3JkgwWXGi8Yi3jekQngVURF1GoK224snknqchSMxUy5viw==
X-Received: by 2002:a37:de12:0:b0:69b:f132:c606 with SMTP id h18-20020a37de12000000b0069bf132c606mr14799402qkj.695.1652774831901;
        Tue, 17 May 2022 01:07:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.251.49.15])
        by smtp.gmail.com with ESMTPSA id n188-20020a37bdc5000000b0069fc13ce1desm7341795qkf.15.2022.05.17.01.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:07:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References:
 <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_add_bpf=5Fskc?=
 =?UTF-8?Q?=5Fto=5Fmptcp=5Fsock=5Fproto=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <1f0003b9-359f-c92f-ceab-559cb1b52f43@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 May 2022 08:07:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6492176627531776
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6492176627531776/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/4662589278912512
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4662589278912512/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9260fa883442


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
