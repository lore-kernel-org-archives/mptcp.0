Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2B1A601
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 23:52:29 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id x21so2446020qkj.0
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFfTNZsNbChds1JouhzLKeflYl/uanrID/eeU9FLK98=;
        b=CA6JmzuEYx99v5qoPOp7yBLq+WHHyCU8lVjBEwSoKvH3jCKi1+OQCcwpuv6J4HTEJJ
         hkKIgFyIP6cRVMhtk/4VbjE+H0qvizO9uhN0McV5WlHR5XYMoAC/jnrZH0H2F0ko8sQ4
         wcfe5O8VAjGoNe4YlwUx4Qdo6AW2KtknaQt6iPIp9w34H/fI2+ZQh29PagV0zmVQMeYy
         jDaJd/7tA0ZY74/2zAeI0oCV3naz6fIEaWVIG9t7qm3AJYAy160dtawdjRLCDbqjuTdd
         Sayak2AA0Ix5r/BsKIysG9f7O+lgDI6UHx0rwYLFGVptWxygrzrn4AIgbSFmPl7Njgi9
         T1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFfTNZsNbChds1JouhzLKeflYl/uanrID/eeU9FLK98=;
        b=MHy0w+o5bJRNUXmBHOLbY9aFlLYquNw36HsyNhWzbracVhkblTM5nfdHS1SnBmlaub
         HIHdBEPa7bO3dEo46t/ZWREEks8kuKNatj99Np/9lnyh0Df3y2eIzW6FRnM1aDb/1MUN
         BxHz3yhb71VsYvQlNTxiMxiVN1gQYLrbJ03dZp93PzXDqMZPjnWXIxL4Ymq4AdwGro4E
         /iKTQZm+oxtt4ao+ePkGH4Aw0b4IeV/NXkicmF60Gwayt2JALERdICNVoNhLixCgpSM6
         28yewNdy31JQsgKWL6s3TcdNK3LOpX3s9Fwwu6hgCZfQ4ExEQRPeb4qaJmvUHpzhinjV
         vrtA==
X-Gm-Message-State: ACrzQf2pdTDcOvfq4et6Jrqybug5MxB+CJ9ttuiXnfgU9vvg1ea7wfQg
	EdupKszoh1+73qSmTrVub8EIUI/vAQ==
X-Google-Smtp-Source: AMsMyM75/NOHxDelJugSToGX+FUcKxI8G7cpcf/Y2VYlWSUxFiHxSVfBxJnY6M17l5IGMYjKksZGEA==
X-Received: by 2002:a37:ef05:0:b0:6fa:630:2b4f with SMTP id j5-20020a37ef05000000b006fa06302b4fmr11314103qkk.41.1667260347986;
        Mon, 31 Oct 2022 16:52:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.22.247.155])
        by smtp.gmail.com with ESMTPSA id r16-20020ac87ef0000000b0039cc7ebf46bsm4286331qtc.93.2022.10.31.16.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:52:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221019161940.3178393-5-matthieu.baerts@tessares.net>
References: <20221019161940.3178393-5-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: uniform 'rndh' variable: Tests Results
Message-ID: <0521a353-85c3-eb07-0c10-e2d52521577a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Oct 2022 23:52:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4978928891723776
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4978928891723776/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6104828798566400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6104828798566400/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/097d5592cae0


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
