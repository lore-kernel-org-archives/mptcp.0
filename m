Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5017ED
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 17:24:25 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id t14so2588201plo.2
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 09:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc+qEzwG2+1z5OL43aZyz5IioXBqTvqEJrOo2AQSk2U=;
        b=K1ABOqBWCrKOtkzV28+LqsZKlb1NeKHTBJmwvoGTprTTn9Z1zutOF6lMrT2FXVL4tP
         xpFnzJefx32l6VUOTn5CegrkcbPhg7R0P92UIkLgZ2wWZnsSxniK9OVXyFTsDz2+RhS0
         pCyW2TenH2AC9GzHdzkOiQK+A1UUekxVWTl1uR4jiGiUqChxVDOWgbP5JqxEctN1LOYO
         /aX3b5YVQ/LofIaJATAH+glSJS++7JMwArUlvO0HnR+3k4Q+f6oXBAIwmYgV5GsdGTNW
         4FIy8hp8Di9MvqsPufVWUObx9vk0TJ7lG7JMkCwpHZBTM07J/WGKqnt1CeLVLSWIey/x
         6uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wc+qEzwG2+1z5OL43aZyz5IioXBqTvqEJrOo2AQSk2U=;
        b=gfzeHHeTjcd58DlMRZhJaTZAxYe6ouLKegW4iPY5EbwmyYJHZ4kriP4jgliylMoKEa
         t/X87j6mc/nL/bjII6bpBagDwbxcfg5n2riqU/ZSdIwnr1gmdyCfL6eoWnYj+gV12uxN
         B0P3SLFidP8BlXtwP0zXgUqjY4qg/YoZ6EGktfKuGwqL4mzBX2v1kN3Bm8ppWi2SjJ+k
         OJzMJDH3Q4LFL1pyBjClNCT/ChjkBhzDv/ecyhXQols0Py4OdjwRGDkYIN9IgURM612s
         XI1migC2VDEfYw7FiaCIkSOgMRw6lgO59Nr1J3EvFrxPr5b5p2+4WuKJjuN11bynM0fZ
         4o/Q==
X-Gm-Message-State: AO0yUKVqkiGyroXZEKypVzoZH3+heM6ckZE91XrFs3MEOgKKpwEMffq5
	utjilf+OuNcOnncFAH+9KA==
X-Google-Smtp-Source: AK7set+Gf0vWFEsNhpmCeG01cV46GVAu7BhmjskyyJJ9Jh71gyEYw8chKATQCS4OPwbGM91wLZLzBg==
X-Received: by 2002:a17:903:2289:b0:19a:9833:6f8 with SMTP id b9-20020a170903228900b0019a983306f8mr5534862plh.35.1676913865221;
        Mon, 20 Feb 2023 09:24:25 -0800 (PST)
Received: from [127.0.0.1] ([20.171.102.115])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902a51300b00198e7d97171sm2546710plq.128.2023.02.20.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:24:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com>
References:
 <1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Revert_=22mptcp=3A_fix_locking_for?=
 =?UTF-8?Q?_in-kernel_listener_creation=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <3a8331bb-676f-4112-0840-6141aaac52a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2023 17:24:23 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5846314349494272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5846314349494272/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5283364396072960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5283364396072960/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6409264302915584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6409264302915584/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5001889419362304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5001889419362304/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b8b8b32faad4


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
