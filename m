Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291097F
	for <mptcp@lists.linux.dev>; Sat, 25 Mar 2023 07:27:27 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso7153881pjb.0
        for <mptcp@lists.linux.dev>; Sat, 25 Mar 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679729246;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gfAcY8N8mJNbjNS9Nv+dKKetDKc3yRlvqQkRrR5p/I=;
        b=Tv/q+kHORa5v1awJkmaZ84jMJXfZbU1qfT022O5pX9fY0nChF/WsTqRlAAwpa/yD5h
         UDfSkUmjPshnq48CfHdBtbKCv6OHKdhBfSk0tvWC6//zYyeK/VlgIFFRVVCbNCwOxkjR
         U+DBWRnvXYM7VoocBWKOPxprVcJTkKmWdv2poqRAgrSvrgjKe8vau3Qz/nGGpUOTCq7O
         y49yVbOAgZJsODiF3IFSmLiOOZD3bxOEdr7ipkhWQLYEzKoRoXLBUyO1kHAWkAhXlYyd
         t3j2qlmdxBafQ1vLaPWxZydc/A97YidUYbprY5qi2hmNOFZfYh+x1SelgZ9UjpCXGGQV
         WSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679729246;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gfAcY8N8mJNbjNS9Nv+dKKetDKc3yRlvqQkRrR5p/I=;
        b=PCRllmifcvRfdC80QrjnfFL9OWBQkWsAup5+FFlQOvh2JlV5VKiuh72wJw8fw7/0Xe
         uTxONf535gNIAos0VckBFiAaQvDjoONgUJZ44jZB8o8FaGFKoD1RG8GvfUohP4WGX/tJ
         ce78ju7/BOlKPnvevqbuJFsup+OnGnXyJPSVUoKgFCWPCrNj/gxaS93vWlaEpndVZryf
         dUgBAoyMVjUnA9r5hlFIFkBGTW6F2bIFRAy8KvsgB0QjUY7cN2uEiEJXOc48jR4Cqfok
         DkpJnDLvFa2+TTHjdpmL1x0VznICFmjOtcZrfx8XHaaf4KeNNZVq1RMviEKlJ0yf4ic3
         YgEg==
X-Gm-Message-State: AAQBX9flgp1yK6PkXVnPtcrP2/AL9jaFz1ye32/kk7ibnUMP3hIXye/v
	oq3rjEWqRrUB/etpsh9fvLLm3O/pIk7D
X-Google-Smtp-Source: AKy350aA8LhqtytsWYSYzntCp3AyfBjxsa3CLbuGckyoIRUt5xCnVi8H/0Ck7EScKYSMaMjw7Rq3BQ==
X-Received: by 2002:a17:903:20d4:b0:1a1:c746:7d6f with SMTP id i20-20020a17090320d400b001a1c7467d6fmr3858136plb.53.1679729246460;
        Sat, 25 Mar 2023 00:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.244.144])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b0019a91895cdfsm15316617plz.50.2023.03.25.00.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:27:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v2-2-f4a417861f6d@tessares.net>
Subject: Re: checkpatch: allow Closes tags with links: Tests Results
Message-ID: <7decd0f8-3786-c4a9-a728-f7e5e8eda661@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Mar 2023 07:27:25 +0000
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
com/task/5262323972046848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5262323972046848/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6388223878889472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6388223878889472/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6106748902178816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6106748902178816/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4980848995336192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4980848995336192/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ca6d67801b4c


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
