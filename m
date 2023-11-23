Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E3250ED
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcl6K73N"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77891f362cfso73650185a.1
        for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700749227; x=1701354027; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4sXO2mxWNwSmvZMzcd1lLxBpde92MIW/1cG+viEuyg=;
        b=kcl6K73NNXOT5rKanACHHlsPJj9ORzoyoaveGjLD4Sr0c1T+/0lj7qSBbIxL2k7pwe
         i9ymKELIliXWHrunnB+R+xFLk5vsib6kdZkbKkBCRPe7K0jskPkVCc+f0tV31rZ4AGO8
         7OG5Y9uWOMZ0XNZGYFoEfZgF4cRFcyJuf5kSMNEaM+Bh6RvM/WBzjmd5pc3ScHAEjcR8
         ej5p6XUW4xb93aLJAaBpZ5basXiiBCaTuG4uQX/ozf8Wz0m/WdxRhLMXnQEs6KbYbBbe
         Tt2RRf/uyEYvMwWNFHg9XIaeFQJdACxfU2iFZ8cUu3x7u0YizSnAYb1ncxNJILN/JMyh
         7SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749227; x=1701354027;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g4sXO2mxWNwSmvZMzcd1lLxBpde92MIW/1cG+viEuyg=;
        b=TfCZFcce5Imklf4OrlFrQX9O9Frnq7XxpDv0qzlUKc440QZAmB4HL4Usq1iBdDz1GF
         kC95dPKbp2rJJfaXCkiiI3i260DgRYPLGt8dV6co3kjuk5S6/sDszLzmNq7UdFN0v51D
         vF7keCQpfXj4oCMB3EPMlBy4wE9LE+7EONd9DsLp3I9V5K2N43Fg75AaNC/7sd9xVTeW
         kOqrOr2I/uxcAxTk77RAu8IX3GHbRbByjO2mc28+dpzT4TCyQVdszOwGOwgZ06ONIZ/+
         kCb9x7xi9EJKUiYrNF+3SGdXc2sTr1YkDNT9xG2TbpVftq4uhMmQUNBMsK0TPWKQ8OHc
         DErQ==
X-Gm-Message-State: AOJu0YzMCDDm2a1F+i24jrArfwSgJIV+vr+tMEc677ufslajuFAQVZGY
	9ItCWyvn1L29DkhBkxC7WAADiRomNw==
X-Google-Smtp-Source: AGHT+IGKyNDSeRyr55bvSIGKE22tL6561A0CwrEQTT5/dp0cAEpaQcjogJHxIlyyUyoWTCT47sUyvg==
X-Received: by 2002:a05:620a:1918:b0:778:9813:6cad with SMTP id bj24-20020a05620a191800b0077898136cadmr4473714qkb.4.1700749226765;
        Thu, 23 Nov 2023 06:20:26 -0800 (PST)
Received: from [127.0.0.1] ([172.183.77.199])
        by smtp.gmail.com with ESMTPSA id i10-20020a0cf38a000000b00677fb735738sm540433qvk.34.2023.11.23.06.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:20:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bf8c6d2142b5362dd9d6eab1c32ad573d3558657.1700652422.git.geliang.tang@suse.com>
References:
 <bf8c6d2142b5362dd9d6eab1c32ad573d3558657.1700652422.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: netlink: fix positions of newline: Tests
 Results
Message-ID: <c0055626-192b-cba2-2678-087379a0bd72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2023 14:20:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6454533111414784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6454533111414784/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6173058134704128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6173058134704128/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5610108181282816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5610108181282816/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5047158227861504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5047158227861504/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0cae163093e3


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
