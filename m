Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BB15495
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 16:33:05 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-78363cc070aso98454639f.1
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690561984; x=1691166784;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdLUHgu5z6KLjSrV8/0wU1P7Kt8sy2KhqLKqgilamQg=;
        b=ljMriM3Lad1/k4Uw77jDJAlCd6AeTxLxYdigk9nwImYnfEqsKBbaPZRhn1FRXyhrLW
         K3uv7I9PS/SY269dy8N98b5ysPBiwV1bKd205ZXY5jXDv7diqhIE4Oqq5V0rnwZpvA4/
         ZJv0s6X6TKX9+6S2KMgMFeMqTPKho4WWEO7xlDVenPbAtWIbmNgI90UpyauV0xx6uF63
         vzbS7tptXYP2foAH6PG+z9idyXEFyOrI7C+rXIM4yLEa6H9bvUn32vYTzkcs5XSdzvbw
         gTSiOImvyNoH9hX61eXRaFIoNSHbEpWfOVIEIbBHJdl9AifsG4CFQL8C0WjuW/xEKARP
         LoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690561984; x=1691166784;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YdLUHgu5z6KLjSrV8/0wU1P7Kt8sy2KhqLKqgilamQg=;
        b=T0/EXwqEapi/C43C5i/Lc6UsAihNHIgmPYrDIRCvWYq1jvPqJejJqSU/vfpaZ4zyev
         ZqkI937JO/q4xK9ACMR24R43kk6t7v0jwhmnvwhM5iBmzDZ36UqIswRG2htqR1T4K2Ox
         4WUPCj8LAxsiHpbKGaT3KnZLFWFfjduW6Uo59rBAkUqos5GoxjlaDDf7dbN74AB0aYZ9
         ohVsqIcshclv1p4LE5/ezcvR2hE4M+/pcWFeaRONodLCYbFP5QBcbUq3ilQGAEL2Kckq
         u0ioy+KgLZxbd9A466n18tXf7Kr6hp3B5uKyqrNH25aXnj+OSrmBKjT8rD72oDf2E0t6
         ZUVQ==
X-Gm-Message-State: ABy/qLbSfQPSmHEi8UoRUGeE3xWTUddW/FRHQ3OzP6DuPmSWYjKInQew
	cM95FA6WxQG0oMd9QjWMqohv+TUfbA==
X-Google-Smtp-Source: APBJJlER5fH2z+vn/vngT4PIn5w4njUF6/OzSs6UDw7SLUkVJAEli1hyy+U7eKgZogoSQDPItUaJug==
X-Received: by 2002:a6b:7d06:0:b0:786:f47b:c063 with SMTP id c6-20020a6b7d06000000b00786f47bc063mr49381ioq.21.1690561984527;
        Fri, 28 Jul 2023 09:33:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.2])
        by smtp.gmail.com with ESMTPSA id g6-20020a02cd06000000b00430209d0efesm1176557jaq.59.2023.07.28.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:33:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230728152845.1020528-1-matthieu.baerts@tessares.net>
References: <20230728152845.1020528-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_pm=5Fnl=5Fctl=3A_always_look_for_errors?=
 =?UTF-8?Q?=22=3A_Tests_Results?=
Message-ID: <ed9f3529-d905-caa4-8e52-3579c11f5acc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jul 2023 16:33:03 +0000
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
com/task/4850365917560832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4850365917560832/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6539215777824768
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6539215777824768/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5976265824403456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5976265824403456/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5413315870982144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5413315870982144/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b9e61469bac0


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
