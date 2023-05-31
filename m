Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046513AE1
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 10:28:30 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-75b0df7b225so360240685a.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685528909; x=1688120909;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/OkAlec4aAok0LQHGQn3afmNGuRvXisCgfyLtI2tYk=;
        b=bPT9bdZTWAAUJCZqHSCh0iFcc8kv5SwK5gJX67xy8LF6prevgwLUd3sTztESNjW0Eq
         qYvIiPHRtcFZIqYLb9+i5J2g3UPsB6MrOVNjiMZATpZwd8Chd03RPx56rpCWaT2/MAdA
         dw0RjM3yJ8WJjjKaZdFAsGsFrazgAdbNXQOV1flZAsHxm8hLlnJ96w4eHGAXNixdxbvL
         l2hycoqq65hbd999nUBywK9WnuFpzhQ7SQtmS3wKX8pUTiOpya4onU8cLEzzqK09Y176
         uEYxxsaT6yKmgVt1RYhHNCsfk/+OIqOw2RtUYZv5+MrLdJX0MMdxwzeXofFhFMhSQk4M
         pweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528909; x=1688120909;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/OkAlec4aAok0LQHGQn3afmNGuRvXisCgfyLtI2tYk=;
        b=ZTS9h7wYVd6g3aLwaNZY6g3lN3UBVg+3cetA4Z00ErX97uRIb4FrxPWPpUZwqnSOVA
         8uqgAVKZKFfxQDMfof1URfVG1WAztoxfqBKQHLn2TJjQQ7YY8B5VRWuoT//HqnoVMZ4C
         T10GHSM6FQZLK+qdxDCf0WJFrKFEgFDusecCVhF3hh+BZYei3tuh8zfsAE1jsmJErH9p
         4zzTV2o88fF22axm1yYy3QEOsOQgXYjowByaY8oRrn87Qz+5/MZyIxXfyY18OUnUcSia
         0QGMpPrkZbk1sYRS99KGlestH0Nqbb5X9MHXFOx9Ha6YkmxzVXuXHhaOAn+ztz1fT63k
         2pow==
X-Gm-Message-State: AC+VfDwtARlUb4EwWY/OALnQ2UAFuaXudh55i3/jCyt8udOv1ZcPNeVc
	DreqxEUxv4ugcvIAsVkol+/Wcw6jMxvQ
X-Google-Smtp-Source: ACHHUZ5fQkrxkB6WXZ65rmalfTjRWinHiNwBt/wR0Z+G9dgSykBk6cZcftidB/V/N2otJypXucYAFg==
X-Received: by 2002:a05:620a:438b:b0:75b:23a0:d9e3 with SMTP id a11-20020a05620a438b00b0075b23a0d9e3mr5120209qkp.57.1685528909477;
        Wed, 31 May 2023 03:28:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.255.3])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b0075cc804ee88sm3663916qkj.30.2023.05.31.03.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:28:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <46e0ef22b358efde64e3783c4cce79dbcc45f417.1685523463.git.geliang.tang@suse.com>
References:
 <46e0ef22b358efde64e3783c4cce79dbcc45f417.1685523463.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: set endpoint out of transfer: Tests Results
Message-ID: <ac196698-466a-ab58-a6aa-329e4e725c6b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 May 2023 10:28:28 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5215260047572992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5215260047572992/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6341159954415616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6341159954415616/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6059684977704960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6059684977704960/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4933785070862336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4933785070862336/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/df17924f37a2


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
