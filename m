Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB97483
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 18:58:58 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-101d2e81bceso10739843fac.0
        for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Q62KSwWqJaQTFGb/q/LRn1L9h2TpUgT98tmZjsaSP0c=;
        b=YK+rpzLu8qxjEub1Ac7rLw1SoVe81x905m1wZ1PJDo6nY0s5In6BRMsEmZBL4d3+yy
         /X9wbTv/gnZp765Xe1hWRJdtFOFxbOoVHx+KnZqbIyjLHLvZTPlgC3WG5OXZVkdz9zp9
         eL0NpVpUSAqzhflswVfput3EcbJW/oYk7RktaRQvkHOgJ8MRJabqOgHJ19ENUa07JC+M
         zy/vQpLZLi+Q2s7HDebh1r3Ij3HqKaNB7qArwKA6ZVHW6dDrDktuWy4qzIbSN5HOST0g
         L+dz1OPXRThx0j00O9BRSVEP42t0bnztHTAK3hoUgMwjQ43Ex12xBMgjJa9QIPP9S5BW
         CKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Q62KSwWqJaQTFGb/q/LRn1L9h2TpUgT98tmZjsaSP0c=;
        b=dYUgZi5VuS9b6pDZSJbK6hUXlUBydmo2bCZe8oO36sjcikc6RDTDqROo0snCPJZ5j8
         3y8pCayYlR7mxehM7MDgpxp8p0PnN3jysCoiE9iyr5+kFBhUyz/yz5/H6sNG9xY+ZrS3
         3nrv4mIVj4b88HZ9dur8d8YGhi54O189ZoOu8nZHsd71DT9yhSsJOnkfLwJi7qLHUMpH
         S8pwumAheKD51ujqbQ0tHJaP7lpq1ItqEL+wRV1r+XKNXaOP/9nvIZ/KciAlOkKgqIPS
         HC9RfEy9qCAt7bTC48c8etacgsT71XhPRatXv4bHfmDCiRhb04/eEIvb4O+o4BTMeA2k
         HrjQ==
X-Gm-Message-State: AJIora/J3UVeCRyUghPU1ISLXaW68uStgS9Q4VxzBPLejCUMKr/ElIww
	KZVRmPn40NIdxX+n30/kfg==
X-Google-Smtp-Source: AGRyM1vdXIPtB//tEbl9m341HE8XQ5pXVg+5StpbM0qBx4dvJdmZ3/FqeXBvIRGXlHswZrV1ZJWhkw==
X-Received: by 2002:a05:6870:5706:b0:101:135:fa4f with SMTP id k6-20020a056870570600b001010135fa4fmr16554520oap.158.1655837937268;
        Tue, 21 Jun 2022 11:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([104.210.134.190])
        by smtp.gmail.com with ESMTPSA id k25-20020a9d7019000000b0060c5e0afa8dsm9876892otj.34.2022.06.21.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:58:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b8019c0a12841c5e90be24e1dbfdc515d30fa5bc.1655829222.git.pabeni@redhat.com>
References:
 <b8019c0a12841c5e90be24e1dbfdc515d30fa5bc.1655829222.git.pabeni@redhat.com>
Subject: Re: mptcp: fix race on unaccepted mptcp sockets: Tests Results
Message-ID: <e16f7b0b-fe3e-c653-39f5-ba0c5eb9494e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jun 2022 18:58:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6006741941878784
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6006741941878784/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4976523449991168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4976523449991168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3532197ad7f6


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
