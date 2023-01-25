Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A96FB1
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 20:03:50 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id jm10so18890134plb.13
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dISy9ad1EMs5MUXJ6eH7ODpWt6nwwUWrzo+C9Vtyk4=;
        b=CttvJmbNXhArnja2kD5OuhK5bUu/SYb5tJFJ8Upp2XXIN6x4phda4Jd17K8jO42WVq
         GcRhVH5K0/AzmuizGwTW9UtodoCddjlbcQl0WdsM3jmCvH14woO7pzgjyPyPHNOJeuDr
         XR8QN+QleYhyTNSVHf9EZE2ojMleMc1kb5RrGtkdpxiJ6Zt699ZPK1wMfEo1c2ctGL2x
         tpzE1H475XgthWLqULx1//fl9zHk5aqhbQbmyUGg+/0Woy+qXxcGOpRLSdlRCbBMQeNv
         tIx/XroP0xWge2tS7aka1rnMQP0m6kxWJ9JfDIGTApKkhkWYCbE/tVjEA7wZhPg9Lfh8
         9viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dISy9ad1EMs5MUXJ6eH7ODpWt6nwwUWrzo+C9Vtyk4=;
        b=QjA3Za+VO+Yld/bGB2/3CpGN2DLWyiD9Qg+Ic/GrPrSKd1pwNlztZojRJ6b0GNviLI
         4V7XfkEsaLtZOhflI5M0SkgqExVnaxH054GtbbzB0YAdCxHQspuUv3qsn81/MSv0pT9L
         MIU8Sa7Nncosuyrb85SCXKHkxmpvICWBYs0+ly5ncpA4jLvZG9ejUvw60VjdwaJqi38l
         CqyjY8QxKhL++sydQPRJfV5kFenL4WoixLRYb/Ky78Os45SuODvQ0cgoAHepjiyRJm1m
         JFYgJ9ErulKSIp+8varZrAbr5xS7uvf2imtD0eTbVX1YQcQAb6Zx4378NARaldSKQS8h
         FspA==
X-Gm-Message-State: AFqh2kpcNCzs4yj3D23CZOMmZwY56orI5u+mhM1TqQzmVtLUREI3lel7
	uk3uwZ5cl1iDw+jwXrQ4rA==
X-Google-Smtp-Source: AMrXdXsDHZjMg8UR6Ppkw6f5Ri/EIq+DyXEbQGHoNUA4613GXYecwDbErsejtIjEeTOiiFDgHXaL6w==
X-Received: by 2002:a17:902:e892:b0:194:d2c7:ea46 with SMTP id w18-20020a170902e89200b00194d2c7ea46mr29672223plg.68.1674677029652;
        Wed, 25 Jan 2023 12:03:49 -0800 (PST)
Received: from [127.0.0.1] ([138.91.87.51])
        by smtp.gmail.com with ESMTPSA id p20-20020a170903249400b001949b92f8a8sm3980469plw.279.2023.01.25.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:03:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <97f7deb4132d567132088d43f3e7f5ff0602a45b.1674668294.git.pabeni@redhat.com>
References:
 <97f7deb4132d567132088d43f3e7f5ff0602a45b.1674668294.git.pabeni@redhat.com>
Subject: Re: mptcp: do not propagate fallback subflow status on error:
 Tests Results
Message-ID: <d007c301-f185-bf39-4002-be1b55073562@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jan 2023 20:03:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4694040256446464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4694040256446464/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5256990209867776
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5256990209867776/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6382890116710400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6382890116710400/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5819940163289088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5819940163289088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/496b568c3bbe


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
