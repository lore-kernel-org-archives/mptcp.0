Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE613C17
	for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 11:40:47 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id ey8so8500535qtb.3
        for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681904446; x=1684496446;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTZuwOMz4m+N4ZymgKo8PpOk19A1ouoqlazzf2eigbA=;
        b=iZfEwavK2PcgSDSptOAi3EGMPiRuiX28N5XA8e9t7r+87pDSZbRQVNErLv59pPV6Ft
         uzySUSrCoBci3akQ33FJf+lw/WnrSl+D3FO4yPAwvDNLndvl+H7693dbeI9376s5Tnoz
         1w+aPrs9k5FdQQIZwfP1EkVZWaTM1ltV4vkoA8fW7e84wGru8gV28fcdzuYONOl0QSUd
         XWkhfl9hGc9WsqQ0lI9SdCJsv9sDvUmHKRBwmDlkmUNZWaGPjugkitfgV1odWcME/dlU
         0ns2zumKih5y8c+qDrHHCF/IUbt0ShM8+dc6TYpl2oF2Jj5E/vhQqC9MonbZRMxvXQR9
         YzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681904446; x=1684496446;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTZuwOMz4m+N4ZymgKo8PpOk19A1ouoqlazzf2eigbA=;
        b=cVUsv8P8NU+32myzw44me8XSn9pxkMO0GbgwwYrWXQc8mkA3ATNrU4B5fp7whegbAi
         RMouvaPgWWTOp3iTurUE0b5KnR3gmrAHiHxTO+NhD6ISDFhvpcW4k5Ayg6K4pnXd1ITM
         d6H29+DOA8+ue1RHHe9NIyrnVGLIhdVO1t52a3GaL7Xp9R87WjNRW18XWKnTKcehn8Tz
         bcYX6tGyThsbfCKus5R27Yo62Uk+m8+U1bAEdKD5PL3EFgqmZETnqKOrG/8EA96M2yTl
         LsCxnh8dp4+ngRHGX5Dzr+F54iQY15S56iMuGslF/UDb60wMukgMQYDAsWlzONVdfGme
         aj+w==
X-Gm-Message-State: AAQBX9f66LfxeeTxpXvpHRrHTHBPahQENRLRXrGNqEgaORbPgnQlaB2A
	Q6Fsx16JCinBVbB/xCtjNSTBylRpRf3N
X-Google-Smtp-Source: AKy350Y+0DHZIc4cVyK4XBCyZwh4X7oC008sh6EuSOvRVX1wlX2m8ZYhkjMU4QDH6ncm5aC4rj8eiw==
X-Received: by 2002:ac8:5dd2:0:b0:3e3:93ca:42d9 with SMTP id e18-20020ac85dd2000000b003e393ca42d9mr5225315qtx.65.1681904446571;
        Wed, 19 Apr 2023 04:40:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.128.186])
        by smtp.gmail.com with ESMTPSA id d13-20020ac85acd000000b003edce7e34bfsm3018980qtd.81.2023.04.19.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:40:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230419101714.3347358-1-matthieu.baerts@tessares.net>
References: <20230419101714.3347358-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22security=2C_lsm=3A_In?=
 =?UTF-8?Q?troduce_security=5Fmptcp=5Fadd=5Fsubflow?=
 =?UTF-8?Q?=28=29=22=3A_Tests_Results?=
Message-ID: <45703b72-e36f-e68f-b5ad-2ba2fedda555@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Apr 2023 11:40:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6376102365495296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6376102365495296/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6094627388784640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6094627388784640/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4968727481942016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4968727481942016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5531677435363328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5531677435363328/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4a339f07d719


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
