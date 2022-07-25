Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EF7E
	for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 22:51:51 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id a9so9351298qtw.10
        for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=knYESjJ+nTmvE8Sk+EC8O8OylLn1Be0JX6+vqvzRRCI=;
        b=gKQNJS/ew8M78WYQxiYx25KaIjf8aFTU7XBnQGZeGGTx2swF1Zyth/TExyeE7S+vuu
         +/vHTfUnK/S23VhIni21PsF042VSzCAoOL+XbcG0yHBaC1RXVo2DBOB0Ff+fsxtXq9ie
         wfGKY+iOseCu/KWlIj1gXtKZi/B8n80JGd0wBlOt8GnO85hs2tA6ivhCtQO+TslORGkS
         dflPig48SdT8DNrI7SuDQovCTQtMSNg1NBDXEcCJsK5jgOESbmrT+yDnMT+0bf2I+mj0
         ZEnHnTaQOeIsHh7ZroeYzm5vFBd4GtqFDiEp/y9Zhw7h8ONFv+lJaNCR/e8Q1yqCX0pt
         +vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=knYESjJ+nTmvE8Sk+EC8O8OylLn1Be0JX6+vqvzRRCI=;
        b=C+csEbX/OFyaY5A+VlxVgWC6cJb+lrqBV3LGRWnoM8KutMj4+xmb1+XvaW1SF2hI+0
         4oWLCpkcM4YV44iBFH9ePbb+YSpfC/Y+7bN+F5mcYmYxjViVYNIWzoPo9IYY2QpTzZU+
         P9qumN5A8gKmDylG2H4mdhaE6g+FTiQqFbVfxs91vFbA7hGvQOsaJBZMAtKWw3S23bLV
         JvVqL5phXqh/vdYpxbqg2/arpl+EVfwaIh4dbU/XMSnAC1ANhPPV+ukvn/feJUpjiP27
         UnP9Lb9VXAbqx0Hv96zXI0GRSkCARPIQhUZBrUTlGSUExtylgOUhh6oSk5ygD83Q4nZN
         5lTA==
X-Gm-Message-State: AJIora+qi7Faj36pKaW7aGET6gXVDqgIsIpLsZlUZO3gF6hjkmphqzze
	g8xEYSMmpAS5SjXiNdEaNpPPL7UrqWAT
X-Google-Smtp-Source: AGRyM1tDmXQjHfagfJZOV4fY0JYDgZxg3VTWR8IlRyA+uYURQNx19QMKeERxdQ0xs5EY3LPqi1evwA==
X-Received: by 2002:a05:622a:13d0:b0:31e:f835:43ce with SMTP id p16-20020a05622a13d000b0031ef83543cemr12283379qtk.644.1658789510788;
        Mon, 25 Jul 2022 15:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.232.45.219])
        by smtp.gmail.com with ESMTPSA id t66-20020ae9df45000000b006a693e46d5csm9510531qkf.11.2022.07.25.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:51:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220725205231.87529-1-mathew.j.martineau@linux.intel.com>
References: <20220725205231.87529-1-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Do not return EINPROGRESS when subflow creation
 succeeds: Tests Results
Message-ID: <4ee65ca0-7d1f-7ca4-eba0-d3471bdf9b2b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Jul 2022 22:51:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5587014698401792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5587014698401792/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5503009298841600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5503009298841600/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/22f5cd0965a5


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
