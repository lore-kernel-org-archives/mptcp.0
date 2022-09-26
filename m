Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FA3D6B
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 15:05:22 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id s9so4256179qkg.4
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=mvQemMHtqY1q4G2bzYdAKPy83YXq1x54fXBoQWJ96no=;
        b=IfFlKplRtyjYP2pm/7BkWFsny8O5IilBaf+v5uLYf8sFyGORd0JZwtORkCKXSDMc9a
         g0Q5sw5HoGkEHHZJguepZOqEcECYOd9gEb4yqHlA2ZTec4q/H8jxc+66NhbCqPeoHyFp
         95vxSjQNEdjOOJ1UDegiIKgELbE94LeV41EYsN/3YrRNNQYDVWHbI5ThYh4MCtZZydTS
         +QcYuf/IuOkdeuj0le6Mj0YIqDcnR1Ku1B1WLm1GPlOEr0YqbSynajwgsKP7Bi6Ibv9k
         tGLcF30gfX4uwQwam7jSANSz3KazlAwRQmQHvC/HLKtXpmv09xbHocsXs8kdr+wcX752
         4veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=mvQemMHtqY1q4G2bzYdAKPy83YXq1x54fXBoQWJ96no=;
        b=U2QYgBSKAsVKDccdVaSr8C3nYF9LugR+ata/3KnlzQySc5aj7y4mR4ujc3mmDJxW5J
         Ja48U2mUThuFYxLxlGXPYgSiDOatJDQjVHa7MgA+C9ntFXYnUvoqaBsInh/+c99QgU/Q
         e4qaLRX+DCaBbRnf4mIbSCVUz0Wzd7+W6p7e80wcBkgcRsLPJzLGQBgbFSJGQEX6UdOa
         wx8W2zj6jtqYZERw7EVs2Jd08xEFsBBM+k+K3IpMV8oJDaiY7WtZDiFjeK2tUveX19qp
         7Q6o2y/2EYPNqCXogWKjBGJiqyXq7r8u1lXaT+zOeAqA9YKhH4auQsl4FHD9FAG9v51I
         y2Hw==
X-Gm-Message-State: ACrzQf0QT+98eRRKWl4jwq1HgOJTpJcLzvFhcE1+jIDlpFiu4Ta5O77X
	02wIjDwUDg9FBbpo+a9xRA==
X-Google-Smtp-Source: AMsMyM7apbayedSMW0d4snBkzw+M3KMT6kQfgZHiZWaO1h8tadbtGtAtxbCcQUyAkb3F9aeepzg0Vg==
X-Received: by 2002:a37:38d:0:b0:6cd:fd39:10e5 with SMTP id 135-20020a37038d000000b006cdfd3910e5mr14471684qkd.784.1664204718687;
        Mon, 26 Sep 2022 08:05:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.230.68.208])
        by smtp.gmail.com with ESMTPSA id h28-20020a05620a13fc00b006cec8001bf4sm11713723qkl.26.2022.09.26.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:05:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0a7720e1aebc9ae8babf8b4881b7ad2acf672352.1664198754.git.pabeni@redhat.com>
References:
 <0a7720e1aebc9ae8babf8b4881b7ad2acf672352.1664198754.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_use_fastc?=
 =?UTF-8?Q?lose_on_more_edge_scenarios=22=3A_Tests_?= =?UTF-8?Q?Results?=
Message-ID: <30def6e7-a331-25cc-3eb2-6e53031c04dc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Sep 2022 15:05:17 +0000
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
  - Unstable: 4 failed test(s): packetdrill_dss =
packetdrill_fastopen packetdrill_syscalls selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4988002983215104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4988002983215104/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s):=
 packetdrill_dss packetdrill_fastopen packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6113902890057728
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6113902890057728/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9ff9f4f21e18


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
