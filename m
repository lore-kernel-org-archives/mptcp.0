Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2046BF
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 17:47:45 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id p133so2033993oig.8
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIl5+3L4vHCZ/qbgEwPXTq2s91My8g+JfPNfaXkYw9c=;
        b=ZWKwhau6qE2vD9Fe5XHRakxCsBNyNeuvo97sq4nRM9uyKm64qBEjl0r19ntVIhtPyc
         2Uia+7+rhxaGwBAX1fDxxdugv/r77e0eXmi4hRaZcvIuse0wdkPJNd7U/dAibX7Ds8LF
         e9WTiLzSb0S13oOZojtJhxPLrBB5Ku+pOmL3yT3s8NW0DchJZLj/qzBQS1IRn0kNzN04
         teCdF7Xwrw7ZtTRUJIqDTaGQTDbPjTpgdSLoyOQZREYDzns/maQ89vKYZ2fX4Nrs34CX
         MxgvtlfPR5JKXTdcyWXAJUVU719s+syVvkASGMql0D8km0UGB7ctw6W5IGs99bIWi/Nr
         cHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wIl5+3L4vHCZ/qbgEwPXTq2s91My8g+JfPNfaXkYw9c=;
        b=A3fscGg0uSC60pPoRWTUxrNJbO2pbIRe6qvE5VhfUHS/XylbNRPi8Wvra2vUoXHTV1
         wLuXDBK3fn4HgjpdgCWGFIfT1gvhScPVTVUdhYVWLrXPQrPQTuS0Qi1QPZxx2TwJx8nW
         E9tVzqZc5Uy/j25uQv1VR7ZBjW2HndQ5IeZ+9wZ27OpAZNC5V2PaRFbb2L0QaRTWXwJn
         X6JEu1R3Tw2o5cIT9io1T6UH/C+12ZXpNJDkV3DTMOiRubwe7wZWjaJdC3XDICv5LiJE
         5nWeTyl80g82LLlXKVIYPylyCK+7SZ9lckMEs9eMByEADF2ynXXPETNUJZn6/n3sSZCe
         jpSg==
X-Gm-Message-State: AFqh2kpwfq5JfXzYdWa15vv0pI61nguapRFRvhcncH+sWEPe0dQxRBKv
	Ny543ecf7FnV5xN0F02vng==
X-Google-Smtp-Source: AMrXdXs3HO6m4yohbY4ABGSeXHlEqCNCAMFzR1foaOAJMcbGcGGpWvRVBj/d4B4t6fcRNOfM8s6A+g==
X-Received: by 2002:a05:6808:59:b0:36c:a58f:a245 with SMTP id v25-20020a056808005900b0036ca58fa245mr15962009oic.8.1674755264318;
        Thu, 26 Jan 2023 09:47:44 -0800 (PST)
Received: from [127.0.0.1] ([104.210.132.81])
        by smtp.gmail.com with ESMTPSA id r131-20020acada89000000b0035aa617156bsm655529oig.17.2023.01.26.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:47:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
References:
 <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
Subject: Re: mptcp: do not wait for bare sockets' timeout: Tests Results
Message-ID: <29efd6f1-6476-7090-b16b-a3cf448591e5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2023 17:47:42 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6644295248117760
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6644295248117760/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4603601666965504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4603601666965504/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4871645106536448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4871645106536448/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5729501573808128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5729501573808128/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bb52e8434e1d


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
