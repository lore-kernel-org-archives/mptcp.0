Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD515A9
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 02:22:32 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-19a156dd5d2so246644fac.0
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684894952; x=1687486952;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/zyFWub5Ns4GRER9qeTJeb7VkS5U8/VDmjlHfhOsAc=;
        b=eTVmquk+obLGugKmLmam9Neof5nBirkHnnBhyDoO3BciShILcXYFvjv2doIVz+Hpja
         ZA3nXSEl+SfDY3SIQk+Zxjld9djhjaVpWk5lCI6kgZ9enOtX3CQFX5utjvNjbRySPqy5
         FSvjO9N70hIzUs+Yp7+xvxTmn9mSgpbDqLBqT88r/aXFzySX/93Ikn3QhQKQ79zwZ6Mj
         eyAtbWLQlwdV3vMcUc2BpVbGp1x8eqZ0znxR9S5aMcIrE89pP1g8bPFOEv/k4YScU7vy
         r+PzIul4LRTUHBZcS/RsQMI2DwzP2WsI6uzg0jauJDrRralv7AueuPKiQwzENS1kG468
         sJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684894952; x=1687486952;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/zyFWub5Ns4GRER9qeTJeb7VkS5U8/VDmjlHfhOsAc=;
        b=iKRwmTSR4DTQCLCpE5IaXgf6iiIGkaC7Xy/dJwOKLyUfLsdbuUmgtzLt1Vv3bZ771L
         NBZDSfB3QF9NvZe9amX+KxNkQ7jPDOONLBBPyL/JkuQ7f1UW9Z4I3982cUhfFddZzYZT
         /f3xFM46Xpi/WSteSwy/H7hF0ahE9GN7n3hNgXX7H8EiSkqpGwi8+8phUVK49XMLJtWp
         JbDmAnntRrox89UvhdyAVsj0/2vyYHldPEFJgZGjj3wsqKJybXHs7djhASygplVUrEdQ
         GhVcfaa+NCblHaSwBpg6kGYJJ1i0pZo4zgXd9EkDHzro3sVGBhhqCFAHZ5BT7xOcW6jP
         Nmuw==
X-Gm-Message-State: AC+VfDw+V1TP5O78cSi2D0mP839ohXl9URiW6tvwN9b0HcGr8HEmRnDl
	0M8jTvX1Ut8haQcMBojRSA==
X-Google-Smtp-Source: ACHHUZ4/ep+onlbBMLSzqvtIV//PXo1p6bFuObuZTPZxN9q5DIBul1YDCGSX4MXLNf0qTnQCgBGkTA==
X-Received: by 2002:a05:6870:6248:b0:196:46f6:4ef2 with SMTP id r8-20020a056870624800b0019646f64ef2mr6736754oak.51.1684894951940;
        Tue, 23 May 2023 19:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.132.178])
        by smtp.gmail.com with ESMTPSA id d3-20020a056870540300b0019e6b96f909sm2502792oan.22.2023.05.23.19.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:22:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
References:
 <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
Subject: Re: mptcp: fix active subflow finalization.: Tests Results
Message-ID: <f9779268-0d76-401a-6e5f-749684b7f091@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 02:22:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6045200401825792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6045200401825792/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4778563006627840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4778563006627840/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6608150355247104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6608150355247104/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5482250448404480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5482250448404480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6e2e302b0b8c


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
