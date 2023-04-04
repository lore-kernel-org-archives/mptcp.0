Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CEBBA3E
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 15:47:32 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id k12so4901808qvo.13
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680623251;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6Df+PgBXGqkxpF8OoxSH8bbT8wODUZP7MR9/X3PCbk=;
        b=HDjgL3SDII+QG96L9OBoT7XWpmA9nlHpxawlvM0eQ4aKYTQO8jh2SFNp1GtoGJ+9Hw
         VrsXQsQDLjuebu1hrEFyya3B/8Hdkbgh1c5zQvVZkqbDlSbzqO3DEKK45m489/2gBhZc
         wUk/S2I6+2zlA+PXlTVgbxaOuaWliHZvhkO8qHe4NEygXDefs7Q5A5Gz8FaTTGP7gTy8
         bC53ohMgpGbnTnJMdWUjkCeYWGyLgOtu7PaCDJ4RIcsp6OJjpueco4ayqfFp5f5ZRmN3
         YqfgM/11pZtKW1ymcJncHakKSKnpQFMRc11iNBkPCE+pcvVd/ZIzgNCDxQjWxgqwByTb
         HxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680623251;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U6Df+PgBXGqkxpF8OoxSH8bbT8wODUZP7MR9/X3PCbk=;
        b=FFGZW2yFkmcyk55WIapfXtSFO5/7T35kxlty7Ai0n6hExTp074oK5i34rZTt9t2EtV
         ufp7GbEwAGuPuUVA6B0kn8JxzRhK1yl2yzwtKWX3N8JKgm8T+5+dxkYKfhSnrMGwdMgZ
         nTEJqE10DlWyS8OoPo9P5mO/+3MjO41I1zdyFsoAkSWQmTr24jBPZxGEVZK6jer2sLBe
         ZyA1G5v9LW/5usXyIp+P184lFRMxnKgbhhuKYSbSsrhYX1Yoq15sxkj7XJFP0wT1jj4j
         N16yK4GVXd6C30DZfdScbKOhm0HVJVZZyagvkaWkg53N09GdmL6ucm2XiaWXhseNsixl
         5oRQ==
X-Gm-Message-State: AAQBX9dg+5pJdr/u+/jPN0noeHcuRzMHreGqX69jXG3za8gJnQRE0rg5
	renZxB1ZDvquChO8015IUw==
X-Google-Smtp-Source: AKy350Y+yGyp69DELawaUL8FuaOnMf/HFahr6+6dyvecCsw72wrPtBjDsD4ekPbIt3I7H6N+RWQgBg==
X-Received: by 2002:a05:6214:29ce:b0:5e0:ad80:6846 with SMTP id gh14-20020a05621429ce00b005e0ad806846mr4090648qvb.0.1680623250835;
        Tue, 04 Apr 2023 08:47:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.226.113.35])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84a8e000000b003e393c9feb7sm3346549qtq.58.2023.04.04.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:47:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230404-mptcp-selftests-join-busybox-shellcheck-v1-2-65892428a951@tessares.net>
References:
 <20230404-mptcp-selftests-join-busybox-shellcheck-v1-2-65892428a951@tessares.net>
Subject: Re: selftests: mptcp: join: fix ShellCheck warnings: Tests Results
Message-ID: <892c8d4b-4224-4d9b-3208-4189bcc197c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Apr 2023 15:47:29 +0000
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
com/task/6207163090075648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6207163090075648/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4799788206522368
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4799788206522368/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5362738159943680
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5362738159943680/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5925688113364992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5925688113364992/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a9e891b9e4a3


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
