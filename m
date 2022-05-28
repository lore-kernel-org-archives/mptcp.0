Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9E7B
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 17:05:24 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id i68so7877523qke.11
        for <mptcp@lists.linux.dev>; Sat, 28 May 2022 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=q0GnzrSUc+ecmI7YiQBCOsHols7t9YGqilPSj1QBpOc=;
        b=QbHq0/14cFutgmhLIuctlUNddIbVkb1D9NY7xyuu+z8QJBx/6YbXEFCFxx8mmnXHU3
         vUeDN6mThSxqyVxTIGFpxGDj6ak1m63vfqrUIzWYdcDp7/Agyhl+DAaO1E3Cg01+SADp
         TgqYxBfSRYG41TLlE/Sa1afDEqymWNJ34dwzNwD4tmiu3dDLUqI3jzg3CwM0oxs1ROdu
         jLJc8CpITHwW+eGTVe+t8AfSd+/iLmuV4WAAOSXtRybKSkZrgy15FSYRtNNfEECvactT
         x+HY+Qu2WqkkhL6umZGVZELR664Zdbz4YXO3cHDRlJKdlTjLA/M10x0bYAhYubuu6vUm
         dOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=q0GnzrSUc+ecmI7YiQBCOsHols7t9YGqilPSj1QBpOc=;
        b=tcsRDYNB1KspicSM6dGEULP1gx6V+pcFmlgz6kkypup4xEDgP8n7dmsxSne3wR8tv6
         sPkdWzHJGl647xntya64plGzz/XxYi+zQZeKGKTivCyv68bKJXJO6DeSLMpKWRkn3lmo
         HK1i9atMJAfJhDoNKWzlvWYD39F2Spcngbh/KAzPD4No/Yd7QMYf9KL0ceUEz4A2VkZV
         9ChKmopO1alpq0/2T3vIlUYRSWnk92gIJOie98aOteL8fDbbhn0+KoG3mxfNXYsegX3j
         hizb6uQ3USUmqkUZFeijvwRD9FyNEZI/klgsmab5MR4jyCVAeKx11GjntsUXuqWCkgI7
         B0sw==
X-Gm-Message-State: AOAM532e2L9T7UP0OFTrF0gBtfjX/Dgq8qLL+dKWnKe+Ki8dLDLYU8as
	k2DcQsKC95zUni1YDhnR9A==
X-Google-Smtp-Source: ABdhPJxnnwgUvofxwB1tMWlIYL+foB9evNe09zN25vTZWeJ+NIDVeHlMWw4au3bN0hJF59baaEm6TA==
X-Received: by 2002:a05:620a:4545:b0:6a0:74de:c70e with SMTP id u5-20020a05620a454500b006a074dec70emr31670027qkp.73.1653757523463;
        Sat, 28 May 2022 10:05:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.67.20])
        by smtp.gmail.com with ESMTPSA id o7-20020a37a507000000b0069fc13ce225sm4722388qke.86.2022.05.28.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 10:05:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1e2b27869e72af5e2928450ff6216f0d78d609da.1653750351.git.geliang.tang@suse.com>
References:
 <1e2b27869e72af5e2928450ff6216f0d78d609da.1653750351.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Tests Results
Message-ID: <38032cfb-4c3f-673a-76f2-be7950987f32@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 May 2022 17:05:22 +0000
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
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5604026279526400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5604026279526400/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6729926186369024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6729926186369024/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/982d66320a49


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
