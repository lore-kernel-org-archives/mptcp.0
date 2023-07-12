Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C921F199
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 14:52:33 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-767582c6c72so683391385a.2
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 07:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689173552; x=1691765552;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCs3HnLPQTkwk3YhGUU3xbHi4ed1n854OPWgkE3f1GY=;
        b=LKkvtZ2Ha7BoadsCtiVHGxEznVDVt/F7BGYUy0o/4rTBD7CF6qTyf4QwwaSfsdLs2k
         sqof38vbQ+d4qFG6L5t1tqaJWCpB7/AmeJAqJw4Igeud9R7TETeyxCAv1fHfTI2pDxlR
         s2lJDlEpjWufuJBf0oil7VIEydxNRZmhZJ2jpuJ4oTgYIgT6qMrGz7jVNTMdWBafy66k
         KO4Ht4sfl/5apWd3ptefmiUq1FTzsgFK4lGMsz7Y9ObCiJ9YOMLJi7o4nBr9hUaPysvt
         BdNGc1CCdiEHeYWerXLpVmL7eTcji9GdKpgQ+omxe8KoDSBPsI4M+cwv2I7XF2zo5oMK
         QgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173552; x=1691765552;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCs3HnLPQTkwk3YhGUU3xbHi4ed1n854OPWgkE3f1GY=;
        b=RpC2JpBrUV4MOK/KhcRswA6EsIRXhsjcRrYX9uqTWJrTvyKwPMb/MpOXgINn0jtD9s
         iF9P8gb3Y9V6Xw4wiWtgrgBOFCt1u10xKwPevYSWbyMLj3In8tJPpsk7iejxP3mgyynV
         XK144qHkg/EIOUKAgwQnVWkImzvVERmqP2u7H21usfrtOY2bJOm/xgowibCLtHE4SzQw
         anFKD2uAzfZ0MFHV6cgNixa7sKVQfWk5h16GHFLYLSlbVwUo//dr2h9ilHyjL2k3vFBY
         OpXs298KJoxkkadQ6LaJ7XoJeYuU9mKq/B3729E2AZba9tT5WIjRe+AcyLL6mDvwqY9C
         b8IQ==
X-Gm-Message-State: ABy/qLaYbwra93+85FchJqWQw4RR6q00jpW+xvabLtJtIetL89z6gnSw
	M75oIrgz7l5aQ6xaypifdWmdQveV6w==
X-Google-Smtp-Source: APBJJlGRZCf4A0Brzjk/baVq0GFv9Hiu/uRUc8bDkQPy1JpE7SLSwfw4WMpIV3sK84AzvuR4H+swBw==
X-Received: by 2002:a05:622a:34f:b0:403:b645:7c21 with SMTP id r15-20020a05622a034f00b00403b6457c21mr8902471qtw.46.1689173552410;
        Wed, 12 Jul 2023 07:52:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.188.80])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85607000000b00401b060b264sm2316750qtr.9.2023.07.12.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:52:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230712-mptcp-issue-368-selftests-subtests-v2-3-c8b174c18f93@tessares.net>
References:
 <20230712-mptcp-issue-368-selftests-subtests-v2-3-c8b174c18f93@tessares.net>
Subject: Re: selftests: mptcp: join: only check for ip6tables if needed:
 Tests Results
Message-ID: <3caebb5b-17f2-5658-efc0-5add1752e19d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jul 2023 14:52:31 +0000
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
com/task/5378197752119296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5378197752119296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5800410217185280
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5800410217185280/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4674510310342656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4674510310342656/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6504097658961920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6504097658961920/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ff0b68960e05


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
