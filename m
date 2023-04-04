Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174429A5
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 12:43:21 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id n14so31342737qta.10
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680612201;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUjI4k1OZjgsVoU/H9iveMiPm8T5WC0htVOa6swhNn0=;
        b=iMQVSuf0PZL8MZog6Nr2Si5rP+Rydv6x18v3Tz2QG8MzMu/Udp5WjMb8UfWzvba5Gc
         GFt2OCSrc3Qqfc6/6LE9GKbtJ4LTrDCFMDAihYk7K1WK4pY66L+bLQvXylU0RBh806WP
         jQSV4EEKbwlbaWeY6L45y7uGTxpjgBhLfVaR6bzJRs7LEgbsSi9mpVWXH4ayBlwlW0HZ
         OtF7vg61+SrhBATgv2zqqmamtIKDnhKKV9i/tHWBhCID+umdmYgADYI/ZMvHLRmLkHCH
         WIP0Q47s0X1tVvBCmOWR1cPIqLhWrfVQuc4duICc44CcKon6uz0Z6JArM/HDcfZSebwj
         6Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680612201;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUjI4k1OZjgsVoU/H9iveMiPm8T5WC0htVOa6swhNn0=;
        b=5QSvmpTFO7SujdWRyfIViVy/Ax7FY9ZhFFBXU9UnmjvUxIxF1vEQiAdizTga9DptPN
         PXRjRiNFxspNXzKABmImF38gmJ+cYn5AlHbOcrVPMQ5tNg0iSY2E10Q4KozpOYuP2PNF
         JWMCvKzmZ1tmcFfDw8vzsJV1OvlNmM/QdeMPlXVDFsbtO5d67CeK+Xd/VPHHfLj1ycvm
         65N6475RbZ3GpLxDhBuxFWAwvzlGkf3JvbnPqw9FdfUcV9JJhZ+SuStPZue64ioG4X4N
         iYFZJLB8E1qdVpFYyB1nMBA3odSki0tA8gTiOlorcXnjkrHfHTuBd1NlkJjUW9kEQ/ho
         49OQ==
X-Gm-Message-State: AAQBX9e0Onc1yf5Bj33IV7yYJLp+bPVwAphIwYSjF1M80dG6JhfMeoNr
	USPtuleGFAg3ge8r+4nLE76sZJCklbEv
X-Google-Smtp-Source: AKy350bc4d51B4lCO4GhTBLIx9K3boNk+i+d+zO89kM/KlZQ2PyUios8MhzHJ7Nol1YT1XQ6T6uMww==
X-Received: by 2002:a05:622a:100a:b0:3e4:dcb4:169 with SMTP id d10-20020a05622a100a00b003e4dcb40169mr3457564qte.16.1680612200917;
        Tue, 04 Apr 2023 05:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.255.84])
        by smtp.gmail.com with ESMTPSA id do43-20020a05620a2b2b00b007484bc04a63sm3569851qkb.99.2023.04.04.05.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:43:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <85d115f611a952405d294aad906b8163baeb3c84.1680544063.git.pabeni@redhat.com>
References:
 <85d115f611a952405d294aad906b8163baeb3c84.1680544063.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: centralize stats dumping: Tests Results
Message-ID: <b7524924-e243-2553-46f7-04517d748d41@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Apr 2023 12:43:19 +0000
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
com/task/5212034736848896
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5212034736848896/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6337934643691520
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6337934643691520/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4930559760138240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4930559760138240/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6056459666980864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6056459666980864/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7cf1e8f55f33


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
