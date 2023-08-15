Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C77185D
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 07:44:33 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56e0bd33797so1802803eaf.0
        for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692085472; x=1692690272;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++wPvuFWLBUdW3lkM6ZiZ4yjmZS+Ku1zUG7AHWeceEQ=;
        b=GY9oeHRVKtJdJE3iAKcCUGMG6EUU+Cgnlx56YAqcFhAv3qk/aNfXuQXeuirtwHj48n
         oX8B5+04mfX+DnaXNcKWJtw7GRf/Tszi/UTyJ/Hp0Q+zxdxqezzcoXhDV+dzf24cNzFS
         oZ40McWLS+nS7Uafq+IRqrvNMcNFCOkGljTm2t68claJoCr/TWSZuLs/EC3wYZBM8kXO
         Zmu94BMS18xouL3iLuuFv3sUgJon0Zgvv02mpvos24+ugul9QkqYejupYXkkezxxP1tj
         VaJGbqaVJAHG8tj856QpmV3zn4LHUzcukSsOWI/Hm1Ytrh1awKrR9cUvv7tJ50kRSDR8
         PcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692085472; x=1692690272;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++wPvuFWLBUdW3lkM6ZiZ4yjmZS+Ku1zUG7AHWeceEQ=;
        b=S1NlHmZ4+WoC7MvOg2/9tZBB30p0KLqD2vvZmjc7QvKbhvHbsHSHUjbCSi+bxioWAn
         +opFVKecwMHL4ANnKaZQeNLb2/Buns+LmPTsiXrZ3z3gaXhfjObrk5yEmWAKu3qdrMFl
         lij72f16aTiPwAhiiFpnYxm4Bj07EFuAvGsE6v9S9sVRjGKnX73LK3KuPsRp+1h3N1AW
         ODcU+QbCPiYYKvoYsGtp3HOb54Q6Yg4C5vgjBtsy3kpL+BVWrHRQccuoaef7nekMj94I
         JN6yQ3WGux6mY7y5APfI8EHgttg5YzPwNjtXRfIu2voNptpX5AvmDnMz6gl5HjEg6vQx
         F+xA==
X-Gm-Message-State: AOJu0YwKEHOiM2YcAE4JSQyu6N4qrZ2/HPJq3mPQBDbV8wUvIsHbJjaN
	sw+i6XIGVO0SigTTgbhJug==
X-Google-Smtp-Source: AGHT+IGz5Ky4ftfe1gcX03oxHwVyIxDBVd8DPND+6nef3cMwbaTLyOlt58qw3OaOJKbORbJF4x+Wsw==
X-Received: by 2002:a05:6871:821:b0:1b3:caa2:eedb with SMTP id q33-20020a056871082100b001b3caa2eedbmr12930061oap.44.1692085472533;
        Tue, 15 Aug 2023 00:44:32 -0700 (PDT)
Received: from [127.0.0.1] ([23.102.139.111])
        by smtp.gmail.com with ESMTPSA id x192-20020a4a41c9000000b0056d2dde4cb7sm5552329ooa.0.2023.08.15.00.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 00:44:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6608f9d9fea9d2bc57ec8378a7afa4fd52c66d17.1692080803.git.geliang.tang@suse.com>
References:
 <6608f9d9fea9d2bc57ec8378a7afa4fd52c66d17.1692080803.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Tests_Result?= =?UTF-8?Q?s?=
Message-ID: <f8bd6c69-5862-ee69-de25-da21e1746dea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Aug 2023 07:44:31 +0000
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
com/task/5091565979303936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5091565979303936/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_mp_join packetdrill_sockopts =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4810091002593280
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4810091002593280/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6217465886146560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6217465886146560/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5935990909435904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5935990909435904/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/538d21adcc61


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
