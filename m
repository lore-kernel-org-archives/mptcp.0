Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1D5CA4
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 15:54:22 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id i12so2910108qvs.2
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLG+fidP6rCm5ca27gVL1BnO2OmEYJqdMhnNwaV/LQM=;
        b=dwhtA1kzOfo7QIGWyInICgzzC1mZG75D/UdOEFjy/0xIWymJ/onNGJTJztDN2Mihyn
         mR03uoiartpX13eZWCcjedC+lWGWYpt8OaFkbRAjK+7zP81fsJE5eVZaMwnEDNj4T0i+
         /u7ucvhLNC8hfYoypbNtZwnJgHFs2Audt6iHYxgwZoibaKf4vscE7SE/H6eYMveSYAzp
         7JnJb+HXHruggOfXw6T4kGc6HGzQ4TjspH95p7C0m1r26ObJPonKl2GQOP10Inq9Vi/Y
         aSWMNoarllPszpwaHP90ghoByQQfsXKXn/mRFXTMqIlO7ySHDt3sYwVO6eCjjHJRX07j
         yglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLG+fidP6rCm5ca27gVL1BnO2OmEYJqdMhnNwaV/LQM=;
        b=JuoVmG5K08cNRpDmTUVdkpc+YWyHka6iMM8PIKCTGyukWWoE+snzWbFCStNxXzl4C5
         rauQ9zjuW1ekTGxhvSh0sZESPIcIENx1LQzr47B4C/GYhvxNoDz0LfNvvERqVkBpRTPG
         2pgMUS/AuDk5L0E+0OxkWog75JzDNLa9oVHgnhRvhqZe8jIL/Adao17i795z2u2tUTEE
         XnAYsCj3y9JJ78QIam+3dcTGr3qYNuUbWW+UABsoAIg+3eTAD5yOZuU08TbA0O+O8pM5
         ijdVTZMJ+F/FP9RZAPWtpmK6SVIKkj8zQGDEZcNYnU3eB1t/mj253BOan8DXQHdFl2i2
         3q/Q==
X-Gm-Message-State: ANoB5pnuW9ePj7XCGiA/HNx8MXS67U4BElmrczyBrzDbFkxNiSpi9feX
	hC4c6nV7mW5fwNRirz+sWQ==
X-Google-Smtp-Source: AA0mqf6GPmWlghbMR0uWJKaKPmBeCogwXlMKusfk0wtZ0n5qI35tEgv5/4XeAYIKVjN7CWOqpnSS2g==
X-Received: by 2002:a0c:ea41:0:b0:4bc:26a6:b710 with SMTP id u1-20020a0cea41000000b004bc26a6b710mr18242605qvp.92.1669391661694;
        Fri, 25 Nov 2022 07:54:21 -0800 (PST)
Received: from [127.0.0.1] ([20.110.224.17])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006eeca296c00sm2912555qke.104.2022.11.25.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:54:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce000e27b0b132ca060b08db392c0ed5ddc39139.1669383374.git.geliang.tang@suse.com>
References:
 <ce000e27b0b132ca060b08db392c0ed5ddc39139.1669383374.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_listener_test_for_in-kernel_PM=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <8368acdc-2372-18dc-4e52-72a1a6f3d2b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Nov 2022 15:54:20 +0000
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
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5696994207858688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5696994207858688/su=
mmary/summary.txt

- KVM Validation: debug:
  - Critical: Global Timeout =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5134044254437376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5134044254437376/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5e713f4d81e0


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
