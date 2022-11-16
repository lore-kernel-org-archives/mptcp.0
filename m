Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AB5CB7
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 13:33:39 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id p12so16432640plq.4
        for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+0y90f0H4lj8Z/bZZRKtuAPluhKFoeGhh2ym3/aVrs=;
        b=JA2J2aO9s+FkzhCWa+KeCZKEf87PuHzAeXpvuUwHsl6FspSM9lh0jKeimTYJUuADfR
         Z2wORQ8IQYBys8iDDAaweYToS7UpQjZmqWCIf+Kvus8wX4vLHmdobPcrElHXifWKA0Nc
         I+MoDKVeNqdYKzjdSkRhQ/kW5g+SN+5LA4zYpkU40JE9OopnNJsWlrhe4kTZThx+SZoK
         wBeHMkmWCUkSSYXj8lVBNqKvlmdc/qGRmUs58TjMEpH3a9V2VQi4tCWD6UQh3wQVn7gR
         oxGyXQp7BzX6gwmsFpbA5i8Ua7Ch56Ct3ZoS7aEsFBEPXcS0VG+0Wl5R2woot0DJ2fof
         MY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+0y90f0H4lj8Z/bZZRKtuAPluhKFoeGhh2ym3/aVrs=;
        b=tyzCzCqe4Z5F8UXGiN3cjEaeaI0F5PHm0cw43swBclLZpdiNRHfKDC1YOEEIMRTpsD
         W1d7HK9SzwHbgk1dvImbD0DVjAu0ZPDCMZ9sX4HeQlPlgWE9YzS8O4oOXcMGqSyzrIBi
         vA0neTI+PsQVCLSJD4Aq4RA0iP+6VugQVpcwyMDqt3syRSf5kpgroY38hdUt1UHl04GJ
         nDPF9H5RP+E2kkO8T5C/nlMjidJzFZ9gsLrK+i4AGYSQ0l9idn5QBOHtUAfo47dlcylS
         lEz2ye+ErrvM7BAQujIaFPdt25edw0u3aM2GGxAAJ+3RQLYE46NVrdYmFy01C8qHNPnL
         u+4Q==
X-Gm-Message-State: ANoB5pkpYmGnnD7+1kAz6swR8kixhgPqxZrAyRhtf6He5McRZjome+xp
	fKSO1vlioK6G0fZdp/hzwQdEGxdJpXjS
X-Google-Smtp-Source: AA0mqf4NMAbqPQWlSGtmQ9Z6hWmC0s/JfKtV2XtTXlzXCPwouEIFsMgkV5iOCgu1erqt4EIEHO2rfg==
X-Received: by 2002:a17:903:2444:b0:188:5681:4dc8 with SMTP id l4-20020a170903244400b0018856814dc8mr9038709pls.23.1668605618779;
        Wed, 16 Nov 2022 05:33:38 -0800 (PST)
Received: from [127.0.0.1] ([20.66.109.55])
        by smtp.gmail.com with ESMTPSA id y6-20020a62ce06000000b005625ef68eecsm10896924pfg.31.2022.11.16.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:33:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9962e346177f1f5b00f418a6b965a025050aa960.1668599064.git.geliang.tang@suse.com>
References:
 <9962e346177f1f5b00f418a6b965a025050aa960.1668599064.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: pm_listener tests for mptcp_join: Tests
 Results
Message-ID: <26bdcc14-b28d-dc4e-e53f-1f67ca251c3d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Nov 2022 13:33:37 +0000
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
https://cirrus-ci.com/task/5271409589485568
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5271409589485568/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6397309496328192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6397309496328192/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/45292ad643f3


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
