Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C1139F
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 13:25:11 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6af81142b6dso6596089a34.2
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686144310; x=1688736310;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QdCwvjgfq3Ymm6napdXTnpmYffpTsDBB6xgcUmex9s=;
        b=FbH5imlCggsCkusvMpxOKcVUfL+PUN7Qt6EyseOT00d0criNoL/aFLZph9C328mkG5
         0+51Hex6kEs7BVDPjPdQnwGZxNXTcA6knqQPiNivOZlqBGMAEyh9d+P05NQeGRF81fyR
         FASeD1K8XOcygdmUwYR0Wm2GBQKY45Rfrz2uDXDdGklLTgPVY8phXnNGfPASK78hBEJo
         5mRBplYSNLos86S9McYLd/i3b0rnhd7t5GFXGGLzxf7KQf7MCIvhFttlh27RY0hNJf71
         1s9fPYwUlr+nzBLBO8N/jTl4LVHWDSkFV9mibst1alEIomtJftv7p/D0XPDrdLJtM6VM
         p//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144310; x=1688736310;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+QdCwvjgfq3Ymm6napdXTnpmYffpTsDBB6xgcUmex9s=;
        b=aua+1M3ltZzMUaOMbe4irSp3pUQl9nx6/xOfrVJZfAmE1x56XD73w06lftlr7Z34lB
         4CGb/HyaM+sGJPjp8fqNWdpui6Tr1vsg++qcNZ1S2u/m35vRaXWlYY7XfuHgNjFNCDev
         uChCTgJIEgIYJaZPqhj7iftz3RYsyfaYiAp6kDPBrQdUlx4vi5VnMbYVPkIJI7J2kdbQ
         B8nzKII8AAdymcVBSNx17LGEDu+9ZMFFokK7bYw4xGE2mPXi2Ur5mjmunrTUPb1FyJCO
         sAcWbJPZDYRljkFykyQ23KKKOa+TS7cekIdxarFK6oACAy66u1ycsV5uurrcgYJtVcI3
         bVLw==
X-Gm-Message-State: AC+VfDzwOFQRC+VFXRfPw4uOcLWFruwtaXh9eDYyI4wOuBo0lu4obMy6
	ZnmCwohe7TcBxWNk8ZCJ+A==
X-Google-Smtp-Source: ACHHUZ6YtGrx+vQu3qzV9Raud6Wn4dRpw52UyoSvdC50XOl74wyj8iv+4U4xLEvP9LqPUf/mvVu4uw==
X-Received: by 2002:a9d:7849:0:b0:6b2:a879:406a with SMTP id c9-20020a9d7849000000b006b2a879406amr1531307otm.18.1686144310121;
        Wed, 07 Jun 2023 06:25:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.11.150])
        by smtp.gmail.com with ESMTPSA id z5-20020a9d7a45000000b006a62aac5736sm5421582otm.28.2023.06.07.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:25:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230606180045.827659-1-leitao@debian.org>
References: <20230606180045.827659-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <e97d521e-10be-5f11-9f63-2275f2f6b23e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2023 13:25:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5622611925794816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5622611925794816/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4509906158485504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4509906158485504/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6748511832637440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6748511832637440/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5635806065328128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5635806065328128/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3a948e44bf4f


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
