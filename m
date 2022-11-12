Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB90EA4
	for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 11:08:58 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id h21so4351378qtu.2
        for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 03:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/PRnGAQPsO3a6J9TY7JSBBK+jXRBnMNmOKmiiNB5C4=;
        b=XCpma470173VNzZsFVY3lKeHhIGdLHaQhilztIjhdaaMvI5Qcw1cLxA1erqi5FPt9E
         wMtJ3FSzi5WX/+fZvcXyeNqy7HkUV3HMWGRBUVR+pRgRT6t80J0hJPeMxc8AvZI5WlXQ
         7ZV0qokReQrCODsPilg1qaGo0PFLq9HsTMR6WUZAcbuRhcRSYv6sL4CRv5EjjRJdfiuK
         Ee3Wl26hybOL3xm0EntOGGZPOysNvw2vf7NH4sqtUCJ0r0cChaIaH3ZJPzwSi5KxrE8j
         veoMFvCp0bLBULg/MS6F22Cwv+PhG325THn3nwEBetow4kfDHHTaUsAa4bvfrTi8N0Kk
         NP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/PRnGAQPsO3a6J9TY7JSBBK+jXRBnMNmOKmiiNB5C4=;
        b=XMQeFk79i3fdCAUolqWrcFKN2kVbkkGt6QoJ63gL46I/iZrYHZfKODECddKBIk4gH5
         5xKDlNZEtFhGlVR1n0dR3YXWY5POuiuxvtoAR3pqw55CcdcstK8ybCYMFi3hkSPNPbDJ
         IRUQ4Ml10xpGy/w6gmZOVpaULe3K+nJDcYb3OYYNN/C1/EJQr6Ca51Q7sBZlG5nz/XSq
         VK+DdUzbSRrs/mYbcKnsefyL2riCrE9OfSeIWz1GtXAJiEAjs6YleA1gnx1YnmCwo/lU
         Y77qfNOyhjgrOBdBtyuxSJVYOlEtspz0oT4FgS3Hy3ANHnJ5bmXO1sZWo2ug3S4sM0IG
         ajqg==
X-Gm-Message-State: ANoB5pnJIQbRofw4SILQiYOtall5lozMqMyiW3sWd9eTtRWICV+kNWnr
	WhW2P9JIaiFhKR+jyBRb2PcQ1ekhdaEz
X-Google-Smtp-Source: AA0mqf6G1GZ5MCKCdqdNimh09MThUC3/ZdRhYe0JUjCfbw9oqHB8iIB+rJDxaGnmII+j6tBVCzHLTQ==
X-Received: by 2002:a05:622a:4d0e:b0:3a5:4016:8387 with SMTP id fd14-20020a05622a4d0e00b003a540168387mr4844042qtb.440.1668251337129;
        Sat, 12 Nov 2022 03:08:57 -0800 (PST)
Received: from [127.0.0.1] ([172.174.82.109])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006cbe3be300esm3037544qkb.12.2022.11.12.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 03:08:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <29d4d7aae141c18b3c77873771e0812b6fd73471.1668245254.git.geliang.tang@suse.com>
References:
 <29d4d7aae141c18b3c77873771e0812b6fd73471.1668245254.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add pm_listener tests: Tests Results
Message-ID: <ca71b35c-85e1-f1fe-607e-c14c5a64748f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Nov 2022 11:08:56 +0000
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
https://cirrus-ci.com/task/6123235083812864
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6123235083812864/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5560285130391552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5560285130391552/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a10cffea84ee


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
