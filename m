Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA3107B5
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 18:16:41 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1b0606bee45so2135898fac.3
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688753801; x=1691345801;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqgxnAGW3UimZuedXN3zYjWee675YU04G0QacWFVCc0=;
        b=oMCKbszXYD0tF07biWu1NWTIHV8ZlkwaWNaXKjelLRTPPc0xF1wY2fvOtFHNOfJYCF
         AvOsO2YAQ6qMaw2y7PY6hniNCZKVIQ/j4UDT6oXhGutMIcLgsBABYv67S4sFbCNTNkCT
         iDSJ/nwwPHLCkZQbBtcK0G0VCa+kEWh5rjUTbX7ebb42NEjpyKoKSrFmi91KKA35bvxn
         3nyixkuzUkzE+DGX2ykZhyUBJTXJiXx7jSy++xs+lh5aNutfUn6s6EobPPXPOhX624Nu
         y5QQxM4OdzvGNOzf30RNvi4sEnUMTrXaTb0/o3CFcb25f+3MKmlPd1C/0Scvagk5jTLp
         eZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688753801; x=1691345801;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqgxnAGW3UimZuedXN3zYjWee675YU04G0QacWFVCc0=;
        b=SuGkoajFrMyNuZeRbiYGM1VxUGK/OtV418ny3N2sRC1opAk3nloBuUtce/zIKSJ7ay
         Qh1ksV+IPArRkz7uaOxJbJa1/jtr1Iq46KnCrotDAiip4A8qon5JskrrKmsj1nuFyABX
         Qx/M78zljNCvjWO1t+ZSpp4sWMkSOj0NwlkCGtzELTPUpitB0RJFbpruA0xAi+8lfPR1
         0yyJeSHE0UzMCsqVHoIBXvHVnFYjhiYlOxpq7mL5bLV6X74oTVW/cHyMGHLq3vObaQIv
         jTJUA9ABR4fnOSKBIXDkjn7zne/yEffcAam3tGXoCqYArYUK4H8jXInFIL0NtEBZJPe1
         uPuA==
X-Gm-Message-State: ABy/qLaEFZt8AQuSz/vxcBLWDG/xM1uC+YmITCy/AW6TNl9T2F/KEeab
	FyZNz3m9ChJhc0IMqgs4CbsnqonQKFJa
X-Google-Smtp-Source: APBJJlGhSa5Uglm3m7h8jNfKnJKkj3snR8Zgy2bC91zwKo/pQugcxstHzIGUryy6hR9Vpb4aZqzHFA==
X-Received: by 2002:a05:6870:171d:b0:19f:202:4fb9 with SMTP id h29-20020a056870171d00b0019f02024fb9mr8392522oae.38.1688753800779;
        Fri, 07 Jul 2023 11:16:40 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.167.32])
        by smtp.gmail.com with ESMTPSA id z5-20020a056870738500b001a697e75260sm1994092oam.58.2023.07.07.11.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 11:16:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
References:
 <20230707-mptcp-unify-sockopt-issue-353-v1-6-693e15c06646@tessares.net>
Subject: Re: mptcp: sockopt: support IP_TTL & IPV6_UNICAST_HOPS: Tests
 Results
Message-ID: <76613979-c9bd-0531-c455-ce1ca0b94518@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Jul 2023 18:16:39 +0000
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
com/task/6207458729787392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6207458729787392/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5363033799655424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5363033799655424/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5925983753076736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5925983753076736/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4800083846234112
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4800083846234112/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/25067ce9c170


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
