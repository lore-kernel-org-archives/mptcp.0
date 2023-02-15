Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BD7C
	for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 11:14:19 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id h4so12055812pll.9
        for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCF9iMk/fq13EltffpVKNkA1CWc5FS3xitsrUWXq2AA=;
        b=Gc6NLBUHBW81TYQkd56Pyk1Be4r+0WZEqZbUi1SUQ8t51tC7ImpDYFUIk8TU92rPAC
         5Nm9gq/mg6oE20cAOcHSbTbzisVLWaW5H0WUNINUpAz1COlJP+umjECOHhFG2Jo3z21b
         H4NCksyg3JPVP6BZojaenkEJP4farod7HAbU6c+tS84Q0pyFrxPVyhY1tZgV4HPUUX1C
         ecV1UPcQd7hnlJZ7dl7+mOcShdztDUUb4/o8Erxv4ZWAeGJ/m3WvXZKLYXukgPB207dH
         ucnN/xIvQI5qEW8ajc3YH6Dtpc8+6jx5fQydSsb5vKWilixot189al9v8V8Ao5XdIdKX
         JPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCF9iMk/fq13EltffpVKNkA1CWc5FS3xitsrUWXq2AA=;
        b=DYew9RHKUr6VmQ/9uzERMqZseIowsBT4hn6Cbj6gII1octz07JwQaSi3p4s2QlFDcn
         dencBYdSAO6wVuyc16rHRNECb+7MRpuEMVA9FF0a1x6X8FcgIvd3mgpfXbzBjpoiWYHv
         Ub7Jww+ZQwZEOOLP1xAyjtnQs4V8pf3IP0Ah4SGQp/siyZ5i71aT+9jz99ZBpa+InMyd
         3E6nUn+CFmbEtA3OMxDyAMQVDzcQ3ELlPwQMrgOkgmAwYkqzEw/eGcZEpZWZIVfp9Vf/
         8oI5rmpDPeeudSlvHqPqo/UUz4UJP2dU/QWmNVWwNhMeOM9InJ0Z4Ib7iayBQFepuw/e
         ua8A==
X-Gm-Message-State: AO0yUKVolFKgfViKhRZNF12PEIpZadGXZic4os8/HeqjIJmj2/cnw07D
	emewQHTOgw0PEj58Mrbxrw==
X-Google-Smtp-Source: AK7set/P4gjuhqobxWRSUt4p0DGfi5izpjVp/+hnyDWhnbhXxmOPBBf3EbPYxdp4jgBV1KKoS1tocg==
X-Received: by 2002:a17:90b:1bc1:b0:233:be7b:e70a with SMTP id oa1-20020a17090b1bc100b00233be7be70amr2381022pjb.39.1676459658787;
        Wed, 15 Feb 2023 03:14:18 -0800 (PST)
Received: from [127.0.0.1] ([13.91.160.242])
        by smtp.gmail.com with ESMTPSA id gd6-20020a17090b0fc600b0022bbad75af4sm1246956pjb.2.2023.02.15.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 03:14:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230214041410.6295-1-kerneljasonxing@gmail.com>
References: <20230214041410.6295-1-kerneljasonxing@gmail.com>
Subject: Re: net: no longer support SOCK_REFCNT_DEBUG feature: Tests
 Results
Message-ID: <e99206c1-eadd-2254-1e58-986981d66b0e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Feb 2023 11:14:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5794989825851392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5794989825851392/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6357939779272704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6357939779272704/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4950564895719424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4950564895719424/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5232039872430080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5232039872430080/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f52d07972da8


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
