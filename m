Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC717E8
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 03:52:42 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso2356898otq.11
        for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 19:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUo5wYeayAN46U0X2y51c5wIQe/lwheLdMeLlocamhk=;
        b=kfDOog3SddPWhjFNMB6O3xpVtR5C+vo0XUbCDz/Lh66tmqJU6qyKVz3P8OoU1soD2M
         vxDz3I8ywgzqAbUMyNCItg5o8bBklN68RWYLG5Y1vKOHW9Xj81+G6VT9gw8k2eB35BJN
         HvpuaFJggwJjlDduFPzGSyBUwScNhTNUxN1Shmnqce5MPQJgzofsKuqpoxApPaQNnWNW
         WRk2NWisjAPv+UbjpXSIpN1JxFs0NPEdV1PtCJpgqsO5uz87YZEia2cQxOtJHZpiuGsq
         R7XTSbaUdjieHfy0/xD1f8TddOCwt99NEZGNvXW8fPwXykxyaoQbP9oX9wOqkM4xTgGN
         Al6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUo5wYeayAN46U0X2y51c5wIQe/lwheLdMeLlocamhk=;
        b=0m+FpAZI597fo6TALQ1oq98XRSV0Y1r4MvBN5jmw2j5cFTh6Wsj4CwFf6FIhmyawfX
         H5WVLSvww15CuGkXuUvwjb7koO93shTQBj9seFF19tLqCoVLXr7a2Y2o7vOeeGmTokTW
         oN+0BrF+qP8VvWT813O8Zqbg+nsJEnk+GQVkA8aSipwJAtSUJFhai5Z9eUoeikPysYBV
         R/44H6tiMkV+m/gpFY/KXXGhKSCS14C+lAw5/CcihtEHtT/aiGjwMIcw2ybr4QUHq2bg
         HceutuLHoShjvbC7AaeokU61SLMt07Lo48b2CFBrekKjYS1ma7B08+jiGPFOgoqkvgJD
         A09Q==
X-Gm-Message-State: ANoB5pmhK8m5oTDoRqDlOMWo+ngTfGFsCZkhLgsHan+zXUCONhtZQUW2
	vRf1UEBUFCxXWoczqzpXOg==
X-Google-Smtp-Source: AA0mqf4kzSVhNHSLoNdDf1ZJzkAWIohnDFMcP+xRHMRYalc+ZNr8RjHufIw/QfqhIfYPyliIUSUdJw==
X-Received: by 2002:a9d:2f62:0:b0:66d:afa0:aa38 with SMTP id h89-20020a9d2f62000000b0066dafa0aa38mr2946997otb.218.1668743561253;
        Thu, 17 Nov 2022 19:52:41 -0800 (PST)
Received: from [127.0.0.1] ([13.65.187.100])
        by smtp.gmail.com with ESMTPSA id y18-20020a4a6252000000b0049b17794d19sm1031825oog.20.2022.11.17.19.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:52:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
References:
 <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: listener test for in-kernel PM: Tests
 Results
Message-ID: <3a26c64e-1eec-01dc-210b-d8945f0ce299@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Nov 2022 03:52:40 +0000
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
com/task/6178938796376064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6178938796376064/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5924801957593088
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5924801957593088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9b92ff8007de


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
