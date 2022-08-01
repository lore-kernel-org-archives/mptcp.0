Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4E7F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 02:59:55 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id r21so7148104qtn.11
        for <mptcp@lists.linux.dev>; Sun, 31 Jul 2022 19:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=hyiCwVj6+VHzkUkoIr1R11v8ZPQj08VUuT5tx4xhKPs=;
        b=lxNQthlJcR3SB3bsOoUxSXTLqz+k1ZmTwNv5v8TQjDvrTvY5X7qFedGsoGp7jnQQSE
         3kIelwEeKsFMUxi+/N0HbEuFo56bBebjvslhHYV2lK1NnTum4ZpymDR+YtfsWw7/3HfT
         iBsZbi5OtfbijvGCPS8R+A6spBjpIfu0AAxN+8ANzTN/Tq0JNbZvBVPs87eZc/Gp7gRR
         dD3Tcn5apSiJYD7bqKgJiXtLBFfCkzF5BJBWl+n2jC553A+YhZhzjSsUzt3Cw3+7+Ud6
         u4M+KH34Ff7skc1SeZX4CovCayJZPEX1xgHAZMc9Q/CS4DXGZ6TdyuQgPpG7lshbtp0e
         VeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=hyiCwVj6+VHzkUkoIr1R11v8ZPQj08VUuT5tx4xhKPs=;
        b=PthuhX3rfvrbJEqZZ4lMIYyTqkqn6bHVOc1B/GNYIVuseVKJ2yQuPNDXiabkZGyLwH
         eQ93qYaAdjK0W1T8pyvxLhHDyuJ4NZHQtvfeCv8XMSaeeKCwvTlV1Io2ohIKH/7UWG8u
         huKmzkl5nM0a6NpOvg8RDajVy07FC1T8UpCPR62o/hPjS/+DrS6lUepulOkxvVvinTRS
         LkWc5wDp4zHGy02tA133YvnOYwnVCyHO+FIGbvnhhD2eTclsyfNmuCXYdhmG2ZV3qBGM
         hjvEc1vq/KP3IdHI4o/Gy1/9LZOAhmWrLMiF3/q6jTBZp2nSempvUoRx9tbWvxpsccZ6
         oKpg==
X-Gm-Message-State: AJIora+modilQmtyV0rcDMPceS6iecumTEN05ozCB8ZYMJS0Jdbwpl4C
	AqnC5TTjZ35Wrw4jZCczn5YpJ91yly0W
X-Google-Smtp-Source: AGRyM1sRTZl7QDkOOZLODeJmi4Mdy7o8jjcOyh+2O/DgBuIptcmMMV1k3VQld6rNE5RPtZcsm26XUw==
X-Received: by 2002:ac8:5bc8:0:b0:31e:e5bd:ef3b with SMTP id b8-20020ac85bc8000000b0031ee5bdef3bmr12768039qtb.94.1659322794990;
        Sun, 31 Jul 2022 19:59:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.141.75])
        by smtp.gmail.com with ESMTPSA id y194-20020a3764cb000000b006b61b34d2c2sm7460053qkb.42.2022.07.31.19.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:59:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220801024656.397714-1-dmytro@shytyi.net>
References: <20220801024656.397714-1-dmytro@shytyi.net>
Subject: Re: mptcp: Fast Open Mechanism: Tests Results
Message-ID: <6ba054ad-6f2f-a921-c4e8-a979bea2fb15@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Aug 2022 02:59:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5864799425789952
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5864799425789952/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5301849472368640
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5301849472368640/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/552c6ba5a6a7


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
