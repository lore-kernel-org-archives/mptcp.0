Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C407F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 01:53:05 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id fu47so12473284qtb.5
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=VNzqFrz7OJEyEk0WWsvSVSm6Yy27ezToQBX8Y/Fv1aY=;
        b=PY4eOOv+3iPJy9NCp4snn3mMn5GLA0w5bTFhoICFhp0gmbVdKjUBK0UaNFDz81Gn0J
         srcxO7G2lcH3WBEtRGftZhS/EHY2Ozqt17Ds7ju8uROEogALwj3PoqmVDu/1Q9dS5ij3
         IdrR1GB21wPuVqgeZYPpNArafgh1Ni+sd0Nt9wdp/iqEHFeYpp9zJ5gjHYGfilnCtO+8
         5Hzf6KFCsjNUDpvjCTktV5TI1C7964IhDuNadwhAxyfKGMhwKhTP4fuyOxTN2bl2koeg
         kfRNz3GTS3K4iAy0JsfJ0fSXB1AAOyx9iCaF9N5/84xprY8B2NOvOfUrac6gLS24AgZo
         Z4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=VNzqFrz7OJEyEk0WWsvSVSm6Yy27ezToQBX8Y/Fv1aY=;
        b=C7eks+iGJSXEks5VJ1SoL/7OWN15kv7RzSZXRyps1R4td8gOn4geu3JZDKSjzL1u4d
         2lQFemLnXshPA4EkmrUN4hh1jaYTbQxI4OPeK+466tgMNcPihSnmVYcO8gkFmEMvGpC4
         zcEOOAM6I6WIfeuGukuBsFvcLwrEEOdoQ3mxdeysAEpCo4DtMP3cvN34J9e9W3Mz9pbw
         v6FdjKkhVoToMjBu/+M4xHk49QT7Bvyzf+YjGFzNIdp+WS7hVk+Lg7DdT1z4ZV20gdjX
         Kk6THgcQkJfInVPNxdhdgZVGAVGEh28F4DdgLntxMC2NBMfOp8LSvelekir2m4VzD98l
         N4VQ==
X-Gm-Message-State: AOAM531KmhIDLcdprQSVfy3ybz4/NWfLTnZv6Loy9UFZN0fVakmhNrHy
	ko643CY8bJzeHpOPfYsdaA==
X-Google-Smtp-Source: ABdhPJzevP50Uy6iuJZQmLrAaFYpQPiWn/F3bfkEWJxzzq1TlaE5Ha7lHhqMIn1nxFbAINNyibYmNQ==
X-Received: by 2002:a05:622a:491:b0:2f3:9228:d544 with SMTP id p17-20020a05622a049100b002f39228d544mr13014052qtx.142.1651542784501;
        Mon, 02 May 2022 18:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.43.102])
        by smtp.gmail.com with ESMTPSA id x123-20020a379581000000b0069fc13ce23dsm5285642qkd.110.2022.05.02.18.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 18:53:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
References:
 <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: fix a mp_fail test warning: Tests Results
Message-ID: <6c12a5df-0b2e-f9d5-870e-5bc0b00734df@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 May 2022 01:53:03 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5758627486105600
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5758627486105600/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5195677532684288
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5195677532684288/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f3c6e91019a5


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
