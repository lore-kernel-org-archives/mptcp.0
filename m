Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F336B
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 10:55:02 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id o13so887594qvw.12
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=ukujmRZkiFqm0grlK3sAjtvVypqiyUOKY2AZ82h5sIA=;
        b=dxgjHPV1fcknoouLrBx7jBSNCzZrYI6J/2ls06b8YVZQYM0zQC0hOCX/lQ5pMgXa0z
         u2VLuXZk61ww343eqv721zkyf7M+0M51ohIh7a08cnikFzLyMYkKrxjxceRT5EstCygN
         DF63h6LX66O11Am6dlrywm30ROaAVBGfxyH+idu1J74A63D9A7OU0KyKytmi8M8lloaq
         JgR28yz3u0VxQRx6o9kh/V+5+o/4AV4gNRgrRpDnwsCiaAD4mofq1HDZa+lM86aorW6i
         pBhrE658Rb9rh7aEsduFokCVmJbg1Mg9qgt3MROI/i3jxcEOM50oZ1qZg3NhLgabDIYH
         KjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=ukujmRZkiFqm0grlK3sAjtvVypqiyUOKY2AZ82h5sIA=;
        b=ZCp8exCY8xAVVELFGuIhqJI5cdJfwPeqCZX2shnbbyHb7Ula883JMYVc6/wManNnfn
         GjEncDx8/nVTmDyWVXlnLlvoxbnL+kKvLONsxH04vW4G/QVV/Y8HHB+Cn1zs5NY46FSU
         8zvk0jc6MR+HV45uIbjqrZE+mtkycpJyR1YY+bWAylqEercCNlawcYHJA44QzLrFlr9D
         9hkUTReniuhV8+iySkZVA+sJJkQ7mq2ZoVJzwCmSV8qI+FfN10AYu4ogQ0/190EvJ/1A
         dTSj7UD2Vb0HHs09BkRBYPRwGQMQgamcrvRGKZRJIRwho5sbOpHNqMX65sw+HJ9EOkKG
         hb7Q==
X-Gm-Message-State: ACgBeo0WNFmVtWtjTCVOZHKNGCOBIq+1i3iYrIG2aFvuEBv2vpHbuHqT
	wIfjbc6e7ywap6zNpGMnpw==
X-Google-Smtp-Source: AA6agR5mOZ6strZ4cBR9+gWZ8ScfVgVMvSkSnCgEFLjftLPNkfMtm7p5sMZBfsU2CkhOiYToNQhLng==
X-Received: by 2002:a05:6214:da7:b0:4aa:a2ea:2483 with SMTP id h7-20020a0562140da700b004aaa2ea2483mr11186506qvh.8.1662720900975;
        Fri, 09 Sep 2022 03:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.10.177.129])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a13cd00b003435bb7fe9csm147215qtk.78.2022.09.09.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:55:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <03a6d8d7833e6b258ab4702291f01c8f2dd309cc.1662714028.git.geliang.tang@suse.com>
References:
 <03a6d8d7833e6b258ab4702291f01c8f2dd309cc.1662714028.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <abcaa8bd-9ad8-a723-0e9d-7ccb2a99cca7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Sep 2022 10:54:59 +0000
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
  - Unstable: 4 failed test(s): =
mptcp_connect_mmap selftest_mptcp_connect selftest_mptcp_join =
selftest_simult_flows - Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5145384333869056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5145384333869056/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 4 failed test(s):=
 mptcp_connect_mmap selftest_mptcp_connect selftest_mptcp_join =
selftest_simult_flows - Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4656858278395904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4656858278395904/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1f51144b7bf6


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
