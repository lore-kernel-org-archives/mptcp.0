Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB00193
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 17:25:08 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so7747271pjo.3
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 09:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrGn/tGUZzjkOEPdabw5Y7dH2kQWyT1hjXHxEnyXSDc=;
        b=QE1dDRg+IHbWio2p+CbiWWk2BNJEsmX35uUM/w6Q/JjYrwS4+9rjMr/8Gq9ZpO74+Y
         fsUnIuzyEvCVrorFmwLohe8MJKLciVLUs7y0ojXZEDEsZuR0PaZBskQGu2kPZ/uqPVBn
         /boYwaipu2evul7z3tQU6SXNMu0j3kn+zcd4C8A/iqe5DPV2qFd4x1o0hzZntxzJoi7y
         xH9fZbg4sUUQEANGuJgzY9NEsCzZVUqNv++naRNK0qn5M7zMMHwvrKaGX6KKtfY6UdpK
         1rTPgMC7qzGvbqRLBkAsdwlPRbmtDQoU7IskjKLu/GElU9jk3jD5oPi+1XtI+o0FYwcy
         Nf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrGn/tGUZzjkOEPdabw5Y7dH2kQWyT1hjXHxEnyXSDc=;
        b=SuJDpD7f+bMN6sxfJ4878XHg1vXXqPOfpvzS6raQ776wa8PvAylCiTQ8IX92Jlguge
         twC73SN72Dg/8b+MMr9pwmoK3pbS7bKH7l5TJyqXiFdqvJMKR9rnL6esYGEYFICsIHk2
         tu61dq1r144eW/bAxAtqNRuLLcnSItuYlpOJseN6enc2dkW0YU7VOIMFafHhMB3hB8IN
         fi4odY9Ch/s1FZq481qhp2zoj6h5RTL6TprXCy8OOtdgnXGbiU+QI7V+QQ5hxDfD8C2x
         Ttp0NacKaDGO89WrmRkvFtjGMY+8xwQejpUmG7WZ10BPyWnHppcPdZ0d6VVfaCT0LSu3
         mhDw==
X-Gm-Message-State: ANoB5pnA6hC5J67Gmmq6N+jqojTsHxC1FzbGwGizJr+DcvrlcOXPUOsm
	RmnsmlD6TS2MOOiWXk4+YQ==
X-Google-Smtp-Source: AA0mqf6e/jtQweMm5IjFt2wyLqwB6G3xGq4Z42Ps0TH+QOoV7dSaHw+F4h86hF+SejZ7n6Ep9SHt5A==
X-Received: by 2002:a17:903:410b:b0:189:911a:6b5a with SMTP id r11-20020a170903410b00b00189911a6b5amr23103358pld.31.1671038707919;
        Wed, 14 Dec 2022 09:25:07 -0800 (PST)
Received: from [127.0.0.1] ([40.78.25.171])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001871acf245csm2162241plg.37.2022.12.14.09.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:25:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com>
References:
 <1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com>
Subject: Re: mptcp: fix lockdep false positive: Tests Results
Message-ID: <4ece7d78-2e1c-2402-3c66-be29f2c41f3b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Dec 2022 17:25:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5554305462173696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5554305462173696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4639511787864064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4639511787864064/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5765411694706688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5765411694706688/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6680205369016320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6680205369016320/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6fb2e2062f7d


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
