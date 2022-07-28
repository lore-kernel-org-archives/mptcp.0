Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424A7A
	for <mptcp@lists.linux.dev>; Thu, 28 Jul 2022 20:49:43 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id u7-20020a4a8c07000000b00435ac1584a6so492248ooj.1
        for <mptcp@lists.linux.dev>; Thu, 28 Jul 2022 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=oy9Psx+1dhzNy2ZY2lDcrYio8LxZRNNpulpgxDCAHBQ=;
        b=Ps7lh6nMp5Lvkl1Eo6i6eeKXzAiFItbzIqZOaTL0Ity67cFQwuhl5BkXcss4bMd7Of
         1VY+NScOZKVZzLph3CocZg+eIF+pYBTBBcp+vPfmjoWha2VLPDBmMpoc8xS+i4qtoVOl
         cqzdoLpSdnscOX0BT/UxIjtwg481Z2dn+P1DJhIOxl1a1E7zak/nns+Wp7qJ4gtdFV98
         W+evulTuG6pAPCHNp9Md2IaDeFR06U0EPR06OuTlqM7b3dPnT/4lDyTKpekX2RkJKGH8
         M6BFUCNrPMBPFOOUdDzTPtiQOY9yqP7yYdb6TE+0GLjS2imgE63Flhtiz1s2CVukEq0h
         BByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=oy9Psx+1dhzNy2ZY2lDcrYio8LxZRNNpulpgxDCAHBQ=;
        b=7RNl3eugL2zhL3InXcN7VZH2FgQqCv2SVDVWh+0evnBIKtl6ubljgD4vqUcezJ5MCt
         kkMSZuc7DvBMS31ZMj64d6x+cZJuSGvr5T7yDdZfCW65DgxXmXCBY5IcGmPqHx0mINKX
         mEDSjass5wkFQ4CoqoxDxKWDXBLwkVplh53In/hxsH/qJRQ8qwi06s0lj/5A7rfPclXV
         ryZ3CCMFjOrJigSkEHOx0BspqPD3yAiP1OPSYQ4kXySfMgfPHVB2p1Xi3a+IECarsWV7
         Vbj7xJeRvLIQexyjD0schfPJCxxp8kg+bHHnYXM4DmzrNC2u7CE1SILZpUGPKEteEQ1l
         VIQA==
X-Gm-Message-State: AJIora8xqiaRQtve+o+xqDd3nkDU4nhQ2Vdkl6rX3W6mVcg66OpDcuwo
	A3QHjRH8OgDs4jbPRKjBRq5aLip+ZLSI
X-Google-Smtp-Source: AGRyM1uZxHcC6IOsfF+lIlAJ99QAIf9rMEO81RytBVLIFML37UlwGWSnFk6/tu+B2TPaVoOPR8UzGw==
X-Received: by 2002:a4a:b306:0:b0:425:8afc:a3d8 with SMTP id m6-20020a4ab306000000b004258afca3d8mr199241ooo.47.1659041382772;
        Thu, 28 Jul 2022 13:49:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.84.43.47])
        by smtp.gmail.com with ESMTPSA id 65-20020aca0644000000b0032f63c4638esm678826oig.2.2022.07.28.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:49:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220728182544.4128-1-fw@strlen.de>
References: <20220728182544.4128-1-fw@strlen.de>
Subject: Re: selftests: mptcp: make sendfile selftest work: Tests Results
Message-ID: <f330403d-0a27-464e-0d18-d203dbefb703@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Jul 2022 20:49:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5906818701459456
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5906818701459456/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5343868748038144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5343868748038144/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d7be8baa6225


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
