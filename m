Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259577C
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 07:18:06 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id r5so3919824qtp.4
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 23:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YIzcz3F+3H/gVfzIZEXXEwPTc1IDGuNZvDiouTg3RQ=;
        b=cQEJgQQPSJ9uXa4iOYKLilRhY439wY0hqRCvOgnhcUR3JyD6ZWHiCnj39HvbF+vMCu
         Pns30VGSCjHOXBZy6nWyQOhkjvflgshZ5MQNUj2SiZtgwjC3TxZB8ws10oh96hQKCwC7
         6T7bSYw58uHXzdQ63D+NmbCFfjSvYLo4mPh2/eTsf7THjYV4iLbFkxcQrn0Ccz/OzBYg
         5QmhzZJPIS6WnFomcxyuPeBlYCKIadRnIvENSZpVsamS7FNyTAJKkUoDj2WcgecTaqWb
         XdLqLX+4Mc+nPQ+G4Hpm2bfsxf+ru3+JQ/dGd/6ICsRzfjiKFcrBxfElRaN9Ad4XCQaG
         hxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5YIzcz3F+3H/gVfzIZEXXEwPTc1IDGuNZvDiouTg3RQ=;
        b=ZlcuHgBDeLdyFhaSelmAHXL8JTekiQAr2LdhUmQoxfgKpBTtRCUwidX2gDsJ9KBX/l
         hwuGnP3Axr9LbWwcP7Da6MPUUIlu9MJlL6KI416Kb2XGZl1uuwY1slkuJ2pE3yB+vitY
         ZtHk3Qdm2z2FvOg17R3v7u0JZFVAZQzTz701d0L55P7iRuhSKcsneYYe0kRZ76M5SsLZ
         HqKFMTw4OM3RinvKgjz7Y5RJLKOrI+XCXQSjQLisnHqeZTKFJ3Shu34ntIGYHj41neK1
         sZOnrPu5g74gQgJmn97iS46a2s6iTeSr4Oz+95zsuph5tgQyAMbBwX2LSJpVJmSQM0XK
         9eHw==
X-Gm-Message-State: AO0yUKXAm+c9dRFmATxBjOgZlw2Cj+3Va/aweIzTN1wPmQ78FJvgjbgk
	YStnPCdt7GFoxaTH9ejKU7G8H3mw1BbvbBw=
X-Google-Smtp-Source: AK7set9dKXLBRr8cDL60JS4MGPUCrEyPd988okn4+9G9Of+EhpBcAz53Pq885DfUeiXP7u9XtnKx/g==
X-Received: by 2002:a05:622a:1648:b0:3b9:e0b2:9a49 with SMTP id y8-20020a05622a164800b003b9e0b29a49mr25628991qtj.60.1677223084952;
        Thu, 23 Feb 2023 23:18:04 -0800 (PST)
Received: from [127.0.0.1] ([52.226.113.33])
        by smtp.gmail.com with ESMTPSA id d16-20020ae9ef10000000b0073ba942f3a6sm7351077qkg.70.2023.02.23.23.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 23:18:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230224061343.506571-3-liuhangbin@gmail.com>
References: <20230224061343.506571-3-liuhangbin@gmail.com>
Subject: Re: selftests/bpf: run mptcp in a dedicated netns: Tests Results
Message-ID: <ccfb116e-0f3d-5500-0caa-ec0a1433ac02@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Feb 2023 07:18:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5236367773401088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5236367773401088/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4954892796690432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4954892796690432/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6080792703533056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6080792703533056/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6362267680243712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6362267680243712/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/24c50511901a


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
