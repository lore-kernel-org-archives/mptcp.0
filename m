Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E320845E
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 14:43:00 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id q11so6269607qkc.12
        for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=vkzufB44sruxq4HhzI1ue0NUIdCmtEYvr31xWB/Mtr8=;
        b=RQQppQQAiucsbcYx89tq03PaoBfONvFrFenMaK2UaZRwpS4tM/SvnmS1bxcgSKW7CN
         K42RkhmbsEEBmu8bqFLjx89jyaNvL65ejlgzx4ieh+gPTiV5+HxBavE+V7cuvGWSIBax
         m8mWr9vUt5lnJXqruB2Jqa5zE9NWo6gqtJVR/KWpUK8DbSdS+aWHnfOpRfHYd5INTO5n
         fTceopZPbgq8Brnono5Z3tohq97Oef4Q2e8v89Hg18GnkpPFq0OtKflfsCHv3Jq6Fb3j
         P7qJ7WP6on41psKQJdhigSO69ppOwQJ/LzBLSLSdXwCGO7Bz0qGbkCPcSPoAtgFW9Vrf
         lXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=vkzufB44sruxq4HhzI1ue0NUIdCmtEYvr31xWB/Mtr8=;
        b=Vf44B7oNKafJhp8kTgLTNVCrspMqcjXVGbEbdQ8EUPdPBIcjyeFP2X3ZkG87ZTgtav
         a0qDOHdDHQuD0XU+EOM6QzZ2GzBOlMYEk8rRbLR6P0pnkOXXELMctzGXLa8cBX2EcNiG
         V7maaHPSo4nep7emz56ewdJ2Lb7rVA6eEb+d+EjyJDYo20f+2K7aAYfNQW3lh7qehMmA
         F7sJzCDweLrB9G+7Ulu19Yzp+3e+kJakbq333xXWxXY8MKa4BILaegZqyiNyJpwEQagO
         coGSTH45Mj4ca/vRgIjgSljIjysa873jaqx8bJqlaVvY2aCcrFTd/OPTXbjUOZ2FvSHx
         u1eQ==
X-Gm-Message-State: ACrzQf0a4iHzyrmJvg/7z0CDWh40vRo+7qhOHopLxVQHfUfHUTjNgmpY
	ulvpManh/fEt4wjVo7MeVJJ/KYUW7BAZC38=
X-Google-Smtp-Source: AMsMyM7q6oJsTPyf+LLal+Gl9QDixBcr33HykzuZJgTSRdtVFqCmUYEKf1NNVCfEwgc/QTfZ0PKL8w==
X-Received: by 2002:a05:620a:bc5:b0:6ce:bc87:9253 with SMTP id s5-20020a05620a0bc500b006cebc879253mr2425057qki.486.1663857778968;
        Thu, 22 Sep 2022 07:42:58 -0700 (PDT)
Received: from [127.0.0.1] ([20.7.69.119])
        by smtp.gmail.com with ESMTPSA id n10-20020a05620a294a00b006b8f4ade2c9sm4265572qkp.19.2022.09.22.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:42:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220922135627.2019807-5-benjamin.hesmans@tessares.net>
References: <20220922135627.2019807-5-benjamin.hesmans@tessares.net>
Subject: Re: mptcp: poll allow write call before actual connect: Tests
 Results
Message-ID: <55c78e1d-6b72-db89-ee2d-ea7535c9754d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Sep 2022 14:42:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Benjamin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4636649643573248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4636649643573248/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5762549550415872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5762549550415872/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2d7f1133320


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
