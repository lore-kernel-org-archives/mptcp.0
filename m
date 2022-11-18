Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFC28E3
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 09:17:17 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so7761867pjt.0
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnSAg3lRxWFHgWiBIv6Wr1S6sPFRHhcAwWrxTUsxQOs=;
        b=UfxsSz1adtlHXXC4zBH3eLcLrZXqAN+CWi6+H0I2ZVulvddBEfKYUrT/DzdN967W2V
         xYDKhMt1RsF89dKbYgrQbKcBDJIni98ebzMKEiu0T9LM/WBkwJE9B9O23dfIo5sNOJnQ
         237JlhhxNJAMy2Q89JVgebZQPHKABR3MrG6FzC89D9YZNpbEhfqpdKWAB0jA6UwXCw2T
         hvfxeJh2qS2ew67C/YJqyCeZQdefXDlEVuV7pGv+y1FvMefmkhFmSAoRbJP9Q1bAR8Kk
         8oa4bCJ+fPyL70OA5ZXbYBFx7EOUSOQy2JPXEM3z41XrSqlBcwNAiyzh4bhf3DN7IIFb
         YGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnSAg3lRxWFHgWiBIv6Wr1S6sPFRHhcAwWrxTUsxQOs=;
        b=YoALhBG6n5I2mjAXrmwQaNpEuVr3zdO6ahgBK02J+ICqZc74L1Njv58Hh5T4WND/UG
         Z9Om+zdZ/Wa7xyNGfiZBza/rjvMDXe2PoVXTkm+SEjQmPoaH7+8Q1HMmNPJeSfO6VKzU
         KH0Qf/Q7ZO06ipzVxe8ffNiMNMvcJawHEhUT33M7UYW1AQAOLMYgBoL6Zg+w5LBAqfde
         qWASZnVCjswG8eUQiqMJOneGROu6bj57ExwxetJS+T3Ms+MLgyhwaNGUQcdp26/6pUSY
         bnDftu3voFhj9jrdoptnCu0OtatdvF4xTZ0yBlewPVDmKU6CEOG+Cyh5J0pCWjNKCpZr
         vIlA==
X-Gm-Message-State: ANoB5plo3FXqKniLdg7Kz4wpQD4TZggygXxZ1IkmD7q42Cs6omQ7fH3O
	vOQHAmbm7UCnsTfO9cMnV7Je0VkAWLIx
X-Google-Smtp-Source: AA0mqf4x7ueCuqjwCKYhaoxuwccl1niImeNX63L/cxhTRQvP/1pFPyvv0bWM1aWGK7vqoTjyiAs3iw==
X-Received: by 2002:a17:902:ef8f:b0:186:9890:97cd with SMTP id iz15-20020a170902ef8f00b00186989097cdmr6745125plb.104.1668763036837;
        Fri, 18 Nov 2022 01:17:16 -0800 (PST)
Received: from [127.0.0.1] ([40.83.251.185])
        by smtp.gmail.com with ESMTPSA id w10-20020a63160a000000b00473c36ea150sm2317525pgl.92.2022.11.18.01.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:17:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221118072030.3500578-1-imagedong@tencent.com>
References: <20221118072030.3500578-1-imagedong@tencent.com>
Subject: Re: mptcp: don't orphan ssk in mptcp_close(): Tests Results
Message-ID: <a9ef5e2a-cbf6-4d22-700a-614239bfc1c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 09:17:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4892156595273728
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4892156595273728/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6018056502116352
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6018056502116352/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0061c26274eb


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
