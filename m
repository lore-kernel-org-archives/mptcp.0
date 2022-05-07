Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7977E
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 07:49:42 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d25so8067036pfo.10
        for <mptcp@lists.linux.dev>; Sat, 07 May 2022 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=V4xEYMOTxKJLvjYuQq7M+MTQBkS5K4Kh/DIG9GcDrlw=;
        b=EBd3mGkpcmF1xi92m8zMRftvdQ0ebzDtjCOMi/9+FGl4BkvmFW1xo7nGaI3r3V2UPF
         JFZVesg9Hwdznbrfl+4KaA2G4UkZ2+ksXG+GGYNzt++5VOyJdCDqdg2dzAKS6Dgvbo/t
         uNE2E/4KJ3Mc2n4FLeeGMh3uJb5lvwWA2jCS0NDSbJDbGperEXkabPjDzITiDsZIAKdM
         aT+v37AoTQKTyP8VfL2RhyKnJl0Ck1hpPTy78KN1MCTehElorR7D/br4U6AeTB6ayxxU
         l4HGZTbFNdNxx3Ubi/2/P0xudewINfagebrhEU1qQdPQ9yq/SUt3qywIfCF/t4okv8xk
         U8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=V4xEYMOTxKJLvjYuQq7M+MTQBkS5K4Kh/DIG9GcDrlw=;
        b=6Ig/Q4R/pgVSmvNW0ajVmyhMCl1KOxKDu32RMBwYu5BhlV+l9NzIZHOHjSM6HM9dVX
         ad26DeGFHSowwj2G0icjCN7U8HpzNT8eZRi2PJ2znwiBmqTa44PyUD+3uluXDQEAjzsT
         MMeiY2xuR7bNB4CBeLRbEDQkzgcjZTlOwsrzT0PR/FmOZbqvHRumC3PakSEkyj/5wZNH
         jRSmVpIB8mgV/8uF0FWEyBG1ct4wxbOIHI2HtbwS4hlKarXQQSrLzN6eNJBEUTz2IDD5
         pMoyQd0YHWZrjFe29wUWljjHk7YkxYl1OnoGGRdSHgbfVQT41lBTP9Q0/jarqP1fv3/6
         IiNw==
X-Gm-Message-State: AOAM533LkUBeOnFbCYxc/vWOMEZM5mh3L7Sk6n8Hzavg1Sjno5iUVup+
	h0SIfnA59SjBhhK5xH0bbg==
X-Google-Smtp-Source: ABdhPJxqeWsW/N9y37whdHwXIU8WksNlQstytu5uRQrI7HSOQOaY1tZW3xjk1z5eR8Ht9w6uWQFmxQ==
X-Received: by 2002:a05:6a00:8c2:b0:510:98ac:96c9 with SMTP id s2-20020a056a0008c200b0051098ac96c9mr222362pfu.18.1651909781545;
        Sat, 07 May 2022 00:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.228.78.95])
        by smtp.gmail.com with ESMTPSA id b62-20020a636741000000b003c14af50644sm4521112pgc.92.2022.05.07.00.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 00:49:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <76fb385e983811d40ebcac3602ff034b169e96a9.1651904166.git.geliang.tang@suse.com>
References:
 <76fb385e983811d40ebcac3602ff034b169e96a9.1651904166.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_v?=
 =?UTF-8?Q?erify_ca=5Fname_of_struct_mptcp=5Fsock?=
 =?UTF-8?Q?=22=3A_Tests_Results?=
Message-ID: <a81bca42-b45c-9fe6-3aad-259b5d72b5db@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 May 2022 07:49:40 +0000
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
com/task/5463628060033024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5463628060033024/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6589527966875648
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6589527966875648/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/06223e629d5e


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
