Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361284A24
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 16:06:55 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 206so859958pgb.0
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=gRVIfIarOIz/W/hTlMFyUQHLprzq/fJVp+Ylv2WaNzs=;
        b=imMCWsL3XqqI5rb7ZPu9FTd8xsLU4oFGr12IjwGeMXMUUe2Gfii//jMyw6NhBvfEuR
         0N8mt4u6gdXRk+5gT/kvr+9TVqReG9GuXSHNS83RIey6RQvG7wb93/C7S7VFXw5oZEns
         jREEHtuuZMn78cWpdmXGOE1ssPDR3hIupe1guME9c6rjuMz5HzPnFpm65O/8m7o+n4dB
         lO/VzXcZEayJaWNQ1GINKokBSL4pCQqdFXZDRGSv/pce63Ekry3Bp/xD0AuOC3UcuiVY
         c5m6w7rVnq/k5AIlXx3EPxcHLdkBI3sY4KeNPYpLDdsF/3PGxH+SNmn2pQGCrjVihoTi
         WRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=gRVIfIarOIz/W/hTlMFyUQHLprzq/fJVp+Ylv2WaNzs=;
        b=L6ro7SQtvIwIM0ZXGNqhUECh9oV2+AWdi2NJKnsqDa9Nu4YeUYxohuAGAVpvS3Nh2i
         6c5vxf1DFLRdOcwKJObM0x3/PAjrb7/uelVror/C9yN/07ZO3stoTfkyddxgYi5ZnSfd
         8Z30lTaxj5YOGfes03yrEkDwPCZQVeBHPTP+KMKpzKtAitY1oC/QsAzNqdXbRiep8rXD
         L8GbqSmCn1BM1PTDxSKByDG4QD6d37mViIVOTCle7OEE+vLuGuO3HRS0hy0t6gtQ3S0+
         p2al/yosPud46ORvARlG1C17k0onobfyJvMdDxzPDmfI5Ia3Uq91PyJMSzhg4nGib8hR
         GQaw==
X-Gm-Message-State: AJIora88kdOrwmu/prQF70dTtheFFjCAOmUlNuQ1okZMYA6gRCcOhEu1
	/euK5e8z59d6RNZY9N5esAb+RaQdDwQF
X-Google-Smtp-Source: AGRyM1s965VDgHCLZ0ykw/r3poeTCXCw9Z3fbzrqpni7NTvbCulDpvuKvEgrDjavQnN6h0mTCfGTbA==
X-Received: by 2002:aa7:8889:0:b0:52a:f05b:31f5 with SMTP id z9-20020aa78889000000b0052af05b31f5mr4185533pfe.69.1659110814600;
        Fri, 29 Jul 2022 09:06:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.14.97.158])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902c95000b0016d692ff95esm3797439pla.133.2022.07.29.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:06:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f253e24227ce660aae19714c2cca1726ee087184.1659107989.git.pabeni@redhat.com>
References:
 <f253e24227ce660aae19714c2cca1726ee087184.1659107989.git.pabeni@redhat.com>
Subject: Re: mptcp: use common helper for rmem memory accounting: Tests
 Results
Message-ID: <06b4dceb-92c9-0b4e-426e-173a1e2dc85e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Jul 2022 16:06:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5166180951392256
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5166180951392256/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6292080858234880
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6292080858234880/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1f45050af065


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
