Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409C381AD
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKAO3X5C"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57b811a6ce8so2780734eaf.3
        for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 13:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697488805; x=1698093605; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TlSVL5UnLgOBOOhuGyJSt5cKVo3HylachMke/DXmqE=;
        b=YKAO3X5C3PlkYHla/S9WPXEXZMGbXtoH5OtoSZb6FCyCSGEXWg4vsGrZVr6HYVtfml
         Q4od4PDnSreOyASVc7byg5eSEDL3tk8+nZWwgMTrsW6wRmlYwOk6F7D4pdQJBa0Af+x1
         oVOpJYPDxOxtAs4NGX9+YU+RnB0m9Wz69ofAc/hFNIf7qFhZBTfB/cSB2pER9jOV8T2X
         xlQ60G9jHcvrrpCpI9L+ta2mbIFTkOR+HfMDcMpparCtZXBPmLWFqiOvufNmYCRo4cRh
         fMOsyBrTyIGCxbQ2y+WvyffEUHJmTfo3UkNjwBq5y6X58qfddAiADaGsVjgl/MEGKcr7
         JTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488805; x=1698093605;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3TlSVL5UnLgOBOOhuGyJSt5cKVo3HylachMke/DXmqE=;
        b=k3hAeLnbuxreBGTvs2kl4JXzfnAt75An/XKXtZJJzFNpb/7jSQ/fyoJ3hdfHFFXdXt
         OdNb4f6DAls1hnla93+GEOr8EIsBb1AS6P1HtfxgBHi28vn9F5yjT7wdKlA91AyyWNFA
         BOmmJzqmzRWs16d0Bm5sEgoMPrCYAK8HnZ70mI3PAEzSxAMT0N9vnMvNZlFpvSnXEini
         o9zDr4L7rRmTXv6o7xbzvpKd3bw7WwuKCHHsbpbULRAhehyWEPwZ5WwfdsEmg/JBz19N
         pD+35gjEOFffrDRdc6OI4CTZ16sLsSuwPG5/2kqtjq8cz0IdCkgVsO0d6jWSfTu7Aq3p
         Ie8Q==
X-Gm-Message-State: AOJu0Yzx+F8ejt4HXWbAharsAjNbho5w4Oubo4P25DfLuZnjoyjHXgF4
	vfy6j8uPkfeI/g3BVMD/DA==
X-Google-Smtp-Source: AGHT+IFUVR6NJONoGqVGmJh8/aTNW4e/xoKJN9rxbNdLyLBVkN4IxTtPoeRufyklGpBjVKcrVhwJqg==
X-Received: by 2002:a05:6359:5e02:b0:142:dfc2:a441 with SMTP id pw2-20020a0563595e0200b00142dfc2a441mr543246rwb.8.1697488804784;
        Mon, 16 Oct 2023 13:40:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.182.156])
        by smtp.gmail.com with ESMTPSA id c9-20020aa781c9000000b0069266a66a6esm326345pfn.139.2023.10.16.13.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:40:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dd36724a428132078fc63edf48af1a14eb095299.1697463031.git.dcaratti@redhat.com>
References:
 <dd36724a428132078fc63edf48af1a14eb095299.1697463031.git.dcaratti@redhat.com>
Subject: Re: tools: ynl-gen: add support for exact-len validation: Tests
 Results
Message-ID: <c4fc9ddf-7231-c040-6587-12bd49dd583f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Oct 2023 20:40:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5917958434717696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5917958434717696/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5309085919215616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5309085919215616/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5109073318772736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5109073318772736/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5027610942504960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5027610942504960/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/da604a436c74


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
