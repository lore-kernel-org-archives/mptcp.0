Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800E258F
	for <mptcp@lists.linux.dev>; Fri,  2 Jun 2023 14:43:30 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-75b0b2d0341so235875485a.3
        for <mptcp@lists.linux.dev>; Fri, 02 Jun 2023 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685717009; x=1688309009;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QDzIkYly73Tp9FSFoyWv5CzKlHQMDs08kueyMr2OgE=;
        b=qdweEvG9RAtDrwZUwxLPF0IA0l6ZinMb01IgGQVG4JK+SKn0YNTnm27400lCxsJvwz
         cUvtnILVwj3l6fsHHKgEtMrvpng1dx+uZpHLtAvwncxT2sFVrK29YeCsTlD+AjIpCsEQ
         O+Q2qqcCtmJOKwliYHpnpGLCKB35GXtDtPsz3OOvsUuBoMzJpPlmPDGReUqPixjz8rPB
         ih6JOa8vHSvpOmeUc6R8wgTvMTh0NB8S5m98JBCjMjLiZT2dTZngJ1doqoo5dtMSyQUt
         SJfhMnh9eJmTx1eZyEGJwqRj+7sCH1a2cMN2oeI9SkG+FUgaJyhVpMWwxIKdrJiifpaD
         fqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717009; x=1688309009;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QDzIkYly73Tp9FSFoyWv5CzKlHQMDs08kueyMr2OgE=;
        b=YmcMzuLDUw6J2WCN40PbTvSrOvg039uMCA/uMoyXmAbK78MFD7Hh9DOMGZ5lpc/C+4
         ZphquRcxirvBw6R+Hp3xyYpRqgBQR/PwPT7YFD/wb6/nVxXsfV9K9mIVJjWytchoEdMf
         m6MpV/0mhb3giyq0P9yxMPJBwjsa45BKJsPHX57MxawiFtpGBlipFBWUAQt4+VM1/osO
         5+zkvBlaKk5bLfD9NffeSs2mO4MbLVz+bnr+lWEaY5Ku8FNsj6iIraHn9Sh4uRc52quY
         o3kBaDRIIXp+FraJUqm9n6ErOU4qeyCNVdHLq+A5CPx9QbdrN3OGfEL7J1zaA3eyBmrN
         gftw==
X-Gm-Message-State: AC+VfDwxtP3VWw9gu6Wex3YocYMmHk9Qk70xsMUsB0/XfSh13xLtaoy4
	d+AMeLV0E5Op2kVcKxnFgdR1L18tGQ==
X-Google-Smtp-Source: ACHHUZ5EN9nwq1r3obfsCCcUNy0fQem5qFemZmkwYbD1mLMicmEpRgOoObctSwlVLrsAzSYrfF8x/A==
X-Received: by 2002:a05:6214:c4c:b0:625:7c0b:4640 with SMTP id r12-20020a0562140c4c00b006257c0b4640mr14604977qvj.22.1685717007940;
        Fri, 02 Jun 2023 07:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.188.86])
        by smtp.gmail.com with ESMTPSA id t3-20020a0cef03000000b006255bcfca88sm913189qvr.7.2023.06.02.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:43:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
References:
 <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
Subject: =?UTF-8?Q?Re=3A_ipv6=3A_lower_=22link_become_ready?=
 =?UTF-8?Q?=22=27s_level_message=3A_Tests_Results?=
Message-ID: <2f021ef7-4321-5af3-0813-6822eb163a2a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jun 2023 14:43:26 +0000
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
com/task/5975182569897984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5975182569897984/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6538132523319296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6538132523319296/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5412232616476672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5412232616476672/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5941386143334400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5941386143334400/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7662725df26d


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
