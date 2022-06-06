Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CBC23CB
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 11:25:19 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id 187so12464397pfu.9
        for <mptcp@lists.linux.dev>; Mon, 06 Jun 2022 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=bFqR/nek5Bac7xx8w3Yc8bidihkJFJhfngNMQ8Em+uc=;
        b=lVkLsjWGZewipZDwda+H6jk7VVals2c2greZtms1K1bJ8e2XN2sfv3Ke05M7jJc97c
         /K0YQDaDNIu6K28uyMPp+vFdJMkPCo81hSB0opv4e3TWwzdC5drAyP/cehRDAHFyB52o
         51bhsFx5ddkMTU5W8Rbv0R55A69kbpSZ8Tvcmf+pT2OAjecHyPLmQZQa3YmZaFbxjh+V
         zl422ITCe8z/jZauormXFHBF6N2AXkeY85C2dn2W5nF/2zFv3lpgHabNDMotr+wuvTrE
         eILLQD/f8v+6JDkdZndK/xeVNVRixX4VeQqBoULydU93PFJQQ8c9ffbZxhRw8z0YWled
         upnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=bFqR/nek5Bac7xx8w3Yc8bidihkJFJhfngNMQ8Em+uc=;
        b=5nl0rZVwEYPyK+TMvSE1fiyknv1u/D+/osQBy7SrFh+EfDGxee+0Vp2FUqZ33OZsCT
         kWd9rKHWwRBfQVa33zUXqZSlVwcbrskrbiYRPYYd23yWIL1YjmYCpe6sQ0y3kAVSDGe+
         eXFtASIGScpRHaeQRGbUHI06pRrIUParfqacQ4IB3AP9DF8L3jS/kYKyvzkVPgqrROTn
         +ItCOIIIQIN+kvn8tY2q83gg2IcS3DlTom2cPSjC7mvdZWOf+THlFmhxkUbrlidVvnHW
         NKD0MUx8cLiUELxmCP0+jpzmo7IUius1enCP15jO/j3eb3i4GoLWG73M0sY059U1+6SL
         0pBQ==
X-Gm-Message-State: AOAM531KJzk6v6awWMNYA/DaGlDsP3VertuYxvJka9KKWJo+lUOVbyUW
	tNYuIqgaMISejL9gxnT58A==
X-Google-Smtp-Source: ABdhPJye2r2uFk3gwIJBeQn6LSSHpmOaUEnfo23qdMqnHSJWD/Cr6GmZPnKsLaLY76F++mrFCEdBUw==
X-Received: by 2002:a63:e348:0:b0:3db:7729:c0fe with SMTP id o8-20020a63e348000000b003db7729c0femr20402703pgj.482.1654514719150;
        Mon, 06 Jun 2022 04:25:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.125.138.166])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902710d00b0015e8d4eb1d2sm10298979pll.28.2022.06.06.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:25:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9c943b559892de4d8c76e38f3fd2622a59cb6f0e.1654507832.git.geliang.tang@suse.com>
References:
 <9c943b559892de4d8c76e38f3fd2622a59cb6f0e.1654507832.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_test=22=3A_Tests_Results?=
Message-ID: <d2cd165a-098c-953d-15c5-43b4e4c6b894@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jun 2022 11:25:17 +0000
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
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5696523970281472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5696523970281472/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5133574016860160
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5133574016860160/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/eabbbe1c8c5e


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
