Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1522638
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 18:38:28 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f6915ca22eso307201cf.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685039907; x=1687631907;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moWbeoN4q7X1C/4317YF+qcbXnHSLyjOhPCWHC9/c7k=;
        b=YG+D2PgYovAJsvxrdOJe3XrgF5PLEgk3oivMcYicSw5sQ3VkWkG3BJpQacX3e2dxiy
         mIqOTOTCJiD0Aj98uJvRywvZqY+4m3CV91wcUf3/dRW9KVYdO6Oq84uotDl6i0zawmIR
         EXIBBRF5gZx763S3lxJ2mI22caNqir5JXVxDvnxkXixbGrpdAySWZ/ivPHtZ0U8TnmpW
         +8mN9KsC9p/FR3JkphMBskNDv9st9Dai5M4BsHJX1JXweAcNR6Uk09eBhCdmHnjHn/Mo
         yzglhSoMDKV/oIXGMOc4Ssz0JtP+WwBie7i7rqeZi8PR5J9nGJhF689AbNYiHPTjIsi9
         pFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685039907; x=1687631907;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=moWbeoN4q7X1C/4317YF+qcbXnHSLyjOhPCWHC9/c7k=;
        b=c6Vb5FhcFhisuHLv9/SVzGrphiRxwtUSv5zCLce+XA8545VQSQ4sKSKJ4ngO90Nxof
         hMcopOTQNUqlR17KqHKJtmvpvuu5UQJfEfWto7l7wbDoUTkKT++/lJdKvR7Z8oooezpb
         SEWlB6VRjUWbjj6Vt0I8G9eK4CUqgHXrkMcMEtFnOUKiPJ6vtm7ORHfpFHB2g0l+D8R+
         GG0CykpwOXznwmfVuwHSwan9VWmvJU7OcshhDMtgvJGzI1nSjSU79xDQuFNogPSrRsaW
         4TMmG5xs0HSuwHP1YXqI6bzN0qPbK1DhYIVqKoDAJBAfGYJisfwqJfStX7nrqYg9OVxB
         e3Eg==
X-Gm-Message-State: AC+VfDxJk64nBMFBr4TFsbDD/DiUsvuuCmiRK/aXNcoMO4xm9r3KkwQP
	Cx/dFE/kzAXn37OmcwELw4ORnBvBls4N
X-Google-Smtp-Source: ACHHUZ4IOpl856tvybxduyzKlyIhnXxn8Y7zvYDTsF3+2Lp0Km7BwEvegmAm1m4gmsRn6lMVIREkqg==
X-Received: by 2002:a05:622a:342:b0:3f4:f522:dd8c with SMTP id r2-20020a05622a034200b003f4f522dd8cmr575898qtw.18.1685039907511;
        Thu, 25 May 2023 11:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.158.51])
        by smtp.gmail.com with ESMTPSA id a3-20020ac87203000000b003f6be5256d5sm616169qtp.19.2023.05.25.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:38:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <48d92dad7566fffb4bbd10c4cc9ee60414fbb4a0.1685034996.git.pabeni@redhat.com>
References:
 <48d92dad7566fffb4bbd10c4cc9ee60414fbb4a0.1685034996.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible divide by zero in recvmsg(): Tests Results
Message-ID: <27718324-ec05-b584-4757-9e7eabcb4805@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 May 2023 18:38:26 +0000
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
  - Task: https://cirrus-ci.com/task/6241504767770624
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6241504767770624/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5960029791059968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5960029791059968/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4834129884217344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4834129884217344/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5397079837638656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5397079837638656/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e34825081a2


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
