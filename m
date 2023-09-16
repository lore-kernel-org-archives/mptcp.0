Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662411C8E
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 12:51:44 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-69042d398b1so1649490b3a.0
        for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694868704; x=1695473504; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCn+rMy3nO6mSoJhe64beMaKQ6mJQ01/SngjkX46KMU=;
        b=WJLSwqvvGSfhQAag5UoJZyorumYu6zdxJhb+AWCYNUdUy9oZKUSMs6AnxNdLez6dNf
         o8yVAhNbIhc6NUlnNK9aTvJ1JEg1xyiyZK95Cca4y9/VlJl0RW1cN+EU4kWRp2lB9QmM
         jH7gKOTKWN4kpdawaMK6zX0jBRVeEGb8UMqTpSIf2Uq2Dw64kGx5o5JxP6UcnXTAanT7
         iq2TcsT5dZRbVS/+janFqOidCk0Y0utP9jzGm45SQ6levpJmHkw8uVDQR1oXeCFv62ie
         j1KQrspx8N7foLpbWhDD3PTLuqZUGXqPVUxsEwdkkxNYbwYA7PJhusfc/mNdLi/d3uqE
         MVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694868704; x=1695473504;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCn+rMy3nO6mSoJhe64beMaKQ6mJQ01/SngjkX46KMU=;
        b=PX7l/BuzYN8H9afKWcoulmSVbzhbMi4OHhVFLyF3qkAgW00FzoT0MUnPOEqvdYHQSu
         eCEsXWFAR6/lwW+hAz9ZnhG80mOuM9dwjtX+zApGwezO8GswgnSCNmJDd255LPWw0kZy
         Wkrf//rDXAeA+5HJsg2OTqX64Mj2cmjItR46NgakbTC2TeZ2l1+ZoT6WOP3YKgDrINSV
         9IRu1ES6jaUx7Gyzni1867+PCnh37s6cDXi4NKz46n0PKDxCzfTTbSjtnQIr3JQ7opB2
         uLmalL0pkBDz6W/goGsr3BN3c+XkgSqRXtB1EP8thk1mUEjEnkuXC8qheWDcA1k5GMHr
         kkiA==
X-Gm-Message-State: AOJu0Yw/pSHMhocn1NIVdme/c+ZRL+TiPEJihO88cONxo1aShKmvO1UD
	fC6pJsZK9jjCRGJo5DFGFHMo8kD8Og==
X-Google-Smtp-Source: AGHT+IGFM0gXJBCq5xsyM/N2NiPz4ClhF46eeHmtDETDBvCwE7o5D8wZVl4psR9RmuUhwCFzX9f4Wg==
X-Received: by 2002:a05:6a00:987:b0:690:4088:95 with SMTP id u7-20020a056a00098700b0069040880095mr5345707pfg.17.1694868703605;
        Sat, 16 Sep 2023 05:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.173.44])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b0068fbad48817sm4458303pfn.123.2023.09.16.05.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:51:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <90054f25d522c7252a511eca430ebe326b22d346.1694864093.git.geliang.tang@suse.com>
References:
 <90054f25d522c7252a511eca430ebe326b22d346.1694864093.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: display simult in extra_msg: Tests Results
Message-ID: <21cb9465-f5f8-8a60-f361-7c2733c0c319@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Sep 2023 12:51:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6270259657703424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6270259657703424/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_dss packetdrill_mp_join =
packetdrill_regressions selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5988784680992768
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5988784680992768/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4862884774150144
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4862884774150144/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5425834727571456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5425834727571456/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0ca0531912ef


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
