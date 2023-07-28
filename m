Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EE13FFD
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 15:31:08 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-486639bdd77so754038e0c.2
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690558267; x=1691163067;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvjeH49VcLEw/jjwqCDK53n+kWjKT9z3qG2S8x3ffu8=;
        b=jMBAqT2Yya5sLcuBjFtNaxNotMXQOA5UbCEVcTQP/Vnab4Gxce7hvRX8HhM8eJ3Znz
         0DclnUSgHfzJBCOey1NE135iZNWd6lzq4GcU2OhRZkEkQq35UTbj9qf9emvfqCmvJIoU
         yLNMLD3XNLFG/uya+wXYdm7aMu0OtQ0xTPp1wK3LjTb5PTakPL5Wt2jNewE0Rhb2LJqO
         fqd18y2egyDuVh/Ve8l1Mdfwk/DtSJCw0RcRFK6O2X9lceBhPw7biKl7Gpy7AwReT5aH
         VlELSQHx4VkLXwEUgInyvP3Lx6bW1OLZRQMzSBu8Ht6CGKxdlBHgplZ+6Cr6TsrkFiGz
         qThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558267; x=1691163067;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wvjeH49VcLEw/jjwqCDK53n+kWjKT9z3qG2S8x3ffu8=;
        b=ikvHw5bJoM9H5E7iFvB2IbVcDBnuL8sUOTHEOfae/4RQxENImdfX/cotZD9+4IuQ2S
         fsYUVmqlH9YPtKdCmxDrEFaCiZI0CkXiktK9RHumUbLTJTWQG6KOijik5EcEoIgqpM+u
         eNKPUMnxRry/3BPKFa2hxdSzbOJT32lS2ZPSBmRwq01weHSKHIEW3gA1esYnxrLXxwqe
         XG0KJvCqrOoPD4R+WoxJJZ5gxImFpi7qvvRC00CcSIey0pGa10279LT07YkT3yV7/vVk
         Hv28yxSsqsBmvpzylNFsZbLzUSCoRxui/cIHsx+RquM39EPBaV/acDRj+itMTk5TACkl
         R78w==
X-Gm-Message-State: ABy/qLY9GBdhm2slbpHowd0ZhY4ojcDfwBrj6s3Ph0Qwz3hZwxcziOmw
	OIE9wGsaDVnHNdgzDfJaWedvt6cMtXyS
X-Google-Smtp-Source: APBJJlHDM/5OG5Bb9t8akXOawAP2Jk4mauSGNl6HxdUexbhu0zisRhPEBitfUlQfOiwxZlH+YaztDA==
X-Received: by 2002:a67:cd8a:0:b0:443:f072:4eea with SMTP id r10-20020a67cd8a000000b00443f0724eeamr2308805vsl.25.1690558267560;
        Fri, 28 Jul 2023 08:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.65.126])
        by smtp.gmail.com with ESMTPSA id p6-20020a0cf546000000b0063cf49c35f1sm1330683qvm.35.2023.07.28.08.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:31:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230728141833.916787-1-matthieu.baerts@tessares.net>
References: <20230728141833.916787-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_join=3A_colored_results=22=3A_Tests_Res?= =?UTF-8?Q?ults?=
Message-ID: <a4ffb1ea-8fdb-2b96-117b-ed527f501ba6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jul 2023 15:31:06 +0000
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
com/task/5430554259095552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5430554259095552/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4726866817318912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4726866817318912/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5852766724161536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5852766724161536/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6556454165938176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6556454165938176/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2db7493f2845


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
