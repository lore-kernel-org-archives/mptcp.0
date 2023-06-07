Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA12210A
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 12:48:53 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6563ccf5151so4824823b3a.0
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686142132; x=1688734132;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RimvKTYsX3EflnZT+AAT0zJwKBY5VtMIJHfMVr6APQ=;
        b=UA2/tKqkziHti7UlpKowtC1veHiB2htE2jB/bFSUCTRvfRRrHkSUR9XmtM5Yq8EaRw
         ptzSBVP55PdOvB+94VZenaO/ax/MqRcyiNnRDcM/p45gPDSsnQ6gMGtJaHI8QMO8a7bv
         eppGdJLEw2Kt2IAaXIE9QovcFO+e9gA6rsMkRAqTpT3mdzjbih8dfa4WYJzWH3POr15p
         SyUZ1ZYGt6vMoKTeHujpVwRPR4+omtSIJ3dYYzr9AKIiu07elEyPHya12GXakqTNkHVc
         HXT2CAo8c0jTMrgcMkT5pn3TXG4fseVcQHlkBfCCZt/Y1bfbizXCA4ZzY4lMh8SFH4yQ
         VM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142132; x=1688734132;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1RimvKTYsX3EflnZT+AAT0zJwKBY5VtMIJHfMVr6APQ=;
        b=b+nCMQICirgNwyC6afe2L+eNxwFTsuSUg5UWamiV7LDqc1tcpmJLEby2xDP2mgGNTw
         IrDH9gYQQM7TXDL4PFttTE2EAskdx7GONvuapkOnp9C8jW9Jqu4TpE2iKsmgZiv2vqYR
         Ep3S9YE/OnbCwfWKNYi/IEUE6VmtP9CtHNJYiVVwam+RduHcexnD+dFxRYfYumV0A6wP
         iDmYb7UZhwCTr8SVIlp9Z/ivSSlj0KSCP59ob4rOXD91xPKX5qWNPCZ2F8RUzbN+lHFL
         FfzVCw9DTdo8EP1gPvolORAEFcP0j/Jrk77+713dq7a8iOVoUqH1cVa0NBj8jxD80mFl
         ly1g==
X-Gm-Message-State: AC+VfDwv4UnoCUquh0pFJtVP+rowb1kTYG/XZsdbmCjdUvml6l8lfwXn
	ZSwknZeE56+CpyzmRms95Q==
X-Google-Smtp-Source: ACHHUZ7Zi2WgXEgInPJ+WPbNgKctOHfOa7nAlL8/P/fePerRH94hK8p9dvMsTDhMZ7hD05wM1HqbIw==
X-Received: by 2002:a05:6a21:7881:b0:111:26ee:8e5 with SMTP id bf1-20020a056a21788100b0011126ee08e5mr3444175pzc.62.1686142132450;
        Wed, 07 Jun 2023 05:48:52 -0700 (PDT)
Received: from [127.0.0.1] ([137.135.38.231])
        by smtp.gmail.com with ESMTPSA id h13-20020a63e14d000000b0053fed3131e6sm8986641pgk.65.2023.06.07.05.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:48:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2673d5e34566da219d6c5d31ac385ea778e32040.1686138130.git.geliang.tang@suse.com>
References:
 <2673d5e34566da219d6c5d31ac385ea778e32040.1686138130.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: set endpoint out of transfer: Tests Results
Message-ID: <bedb01c4-22e4-2aa7-4f47-40da84ecb9d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2023 12:48:51 +0000
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
com/task/4820643485581312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4820643485581312/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5383593439002624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5383593439002624/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5946543392423936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5946543392423936/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6509493345845248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6509493345845248/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/07e42421acf3


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
