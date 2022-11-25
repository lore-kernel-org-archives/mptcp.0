Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2C3C38
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 16:55:56 +0000 (UTC)
Received: by mail-il1-f176.google.com with SMTP id m15so2211676ilq.2
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 08:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyDi+gXCueJeYWzstgVvXyQWlN8hXAGeSneOo1Y1gn0=;
        b=hcHbqrDUhlripfesiidDFzm0ZnkjZIVnDqC2gTVIYYYneRJL2OeWhvuwOPNsruw8zP
         l//8qqRxqm1b2hQFnL9bwYdc+rXqrAe6J2+s65EJE3Tv65a101HXma9JQaUcIFCpXg8L
         5lTQlT2BjQr9AVW98qEqWyEEH4LHneptVDOGuOfkcQcLPVOgU3XsM3X+D6hsyO3kCbN/
         TYl9iHSaPagBdKyH9SNkYYaQ4rB677hUMPIOx/7t4Xa/q6VaypC5le8x5qonVGsABkQ6
         2kRfxYYNXIKUqVfGo0QMpgw2XYF6ZVptvFzOFerh8tUs2fujzD4+QggNc23Adi3rGcH3
         THBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HyDi+gXCueJeYWzstgVvXyQWlN8hXAGeSneOo1Y1gn0=;
        b=yurxj+YJs7rEW4aQcEkxRjeTu1E9LZF2VkZ1IjOq+0FxyKbnbrgaDBHM0gTyY5Xgs8
         sPcUh6bm+/EXSs8OjsyfhF6JDEzDEF/NinT98u6l9imc/o77XfSg0ul0Fy7jy5E0PaPa
         A7ub7ghdveor9WKtRvceBa7VvBgj2gYqiN4z2XcwLPIihkBnRJsj1sWhfb5rKA7wTInA
         PFAgBX9g1FUZ002YxTZxbKDCR6huXXWKCAkRLtI7L7qm9LTp3i1Pk9mP8fDpA7OkLs7G
         UAY5ryP3aKQcYFPIDB6siJ6MUSHWv1u4mnqkKYXSnjzIl+zMegLPoS2av1z4seddGpOf
         ppmw==
X-Gm-Message-State: ANoB5pmOdDJaXJVn6YClVHsJk+mCdaePmYrUdTF1xVLnj/dotRSHrdJO
	iIgY8pXv5yuOnvOJNAGCQ7sf+JbnwOPu
X-Google-Smtp-Source: AA0mqf6gkI++AFlcxQu8NNngOmeB1voS0k4n0wD4w+ddhb3GZayNK/eQLZ/IwO/zwTu69bqQR9dKeQ==
X-Received: by 2002:a92:c5af:0:b0:302:d1e4:40b3 with SMTP id r15-20020a92c5af000000b00302d1e440b3mr9296825ilt.22.1669395355972;
        Fri, 25 Nov 2022 08:55:55 -0800 (PST)
Received: from [127.0.0.1] ([40.113.217.173])
        by smtp.gmail.com with ESMTPSA id b24-20020a5d8918000000b006bb5af55ddfsm1555223ion.19.2022.11.25.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:55:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221125145257.123844-1-matthieu.baerts@tessares.net>
References: <20221125145257.123844-1-matthieu.baerts@tessares.net>
Subject: Re: mptcp: add support for TCP_FASTOPEN_KEY sockopt: Tests Results
Message-ID: <f0b54acc-ed57-50e6-d5c9-ae1b86a878c7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Nov 2022 16:55:54 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4970530218967040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4970530218967040/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6096430125809664
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6096430125809664/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6cbb089592e8


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
