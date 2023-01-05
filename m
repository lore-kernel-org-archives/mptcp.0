Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421E630
	for <mptcp@lists.linux.dev>; Thu,  5 Jan 2023 08:32:45 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id s9so29417428qtx.6
        for <mptcp@lists.linux.dev>; Thu, 05 Jan 2023 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFBiTFmj7Vu2vymqta6d5RtL1q0zIimJ6jOS6+arByk=;
        b=PkkgG6bkT92aPh5wFFckS2OMB49FgDSD594qzLIWcBn9+jHJ/imsXnolaR9jmLFEC8
         fPiIt+nT7HzOsDU+44OsGqiCSUdA5IidSc/oND/ydDzWeDn+yzmDUZBY2Mx9IpCMLaGG
         p6JodO0pXZK3oXrl6I7kxQA+7QBGMBKeNMlgKTI4UG6rxFMasDwIAq6XWWn2lIc0/0tb
         IQZpRU8mbvLonoerqBOqUsV0nMVER1RNFQ03TDV0TyzOtUtUr5cNAAxVzYl4/Fqr4jie
         coM13m8sgdeUW0qky/nuYPBRGXBnb1OSnzEd2gf3tFOH+/myL/FLzwBvjkHnmDkywSKU
         XmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFBiTFmj7Vu2vymqta6d5RtL1q0zIimJ6jOS6+arByk=;
        b=lDGnDVVarIhlIuQH5QluijRYf/PingJMqS26bJUkznp1M/1yUandTmifEB4NQ6DThK
         7NCBmSgVe1iC/PasTvWVcFfv3JmcWOjGWZ5RJjWtUt+kPBV9XELLa9vQiRsyHaMBbyvJ
         BjUv2qWS3sAxuJJxoIs2sM31EmDSheJsVYf/0aXRyrpXb7ys2bKkhthbg2YxmuCPAB47
         5MGyAstKotRitvlQTKD8WoZEVGp+mj+VPU9LGhdyS9pN2bwXvw27f7zhXX9TjKBXqosZ
         Tf+pbd1glSC6FTZ7F5YCXV8bwHdGBIbHv98e9acVWLfzD89vSRquWZuO+XXhc/QpjoFv
         Q/VA==
X-Gm-Message-State: AFqh2kpLRe2g/sA8E+gNL+/pLBKPhCoEvcvMpmGrPqRlEiYqftBAmmda
	ligFRPr0SrDAp2Xya8Eoz+SN2kGepeRjwdo=
X-Google-Smtp-Source: AMrXdXuTr0NXzAX1TtXCTLG1rdhUd6VwHSyPUL7lwsWhaPgPoOFvEU19iN7exwiMzkveEWU82VqXLA==
X-Received: by 2002:a05:622a:4007:b0:3a8:3039:a702 with SMTP id cf7-20020a05622a400700b003a83039a702mr65662544qtb.43.1672907564890;
        Thu, 05 Jan 2023 00:32:44 -0800 (PST)
Received: from [127.0.0.1] ([172.177.129.241])
        by smtp.gmail.com with ESMTPSA id q29-20020a37f71d000000b006fb9bbb071fsm24714044qkj.29.2023.01.05.00.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 00:32:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-13-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: userspace: avoid read errors: Tests Results
Message-ID: <8a778ab4-18dd-e342-bbe3-5154cf82ee72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Jan 2023 08:32:43 +0000
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
com/task/6007793140891648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6007793140891648/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5444843187470336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5444843187470336/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6570743094312960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6570743094312960/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4741155745693696
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4741155745693696/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b224e1e9ab22


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
