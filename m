Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF91A73B
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lar8QmF3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1cf8c462766so48676085ad.1
        for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 03:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257032; x=1701861832; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdc47aQVPlHYy2ESeXWMA/qDND5trhDEUxFKlSqxgnc=;
        b=Lar8QmF3quvtfj0bpsjOT8tFSrehmoxzfo0W8g7wJ2oh1xemRgJ9AX4Tejoscacgh2
         EhyLdeIY15n0rJu61MN+oAs+C/TjomOHD531khPk9qOHZBqO8SfvxSyk1X80JGj2qk6s
         ayLVMtc5xg0hRmGsrYQP3M4bOYwbBVHQfj4pTNhrS8C1ExYUpqX6IvCIZvrd/14EOOej
         F8hS+diD4+M9hDuYlDLSoc6VymolZlZx2WkXvjnvgJfFo9+QVDwSRg6jVzZ82IXPQXdv
         f/j5htBqWoOqGyPRT/YDh81II4LYyQ2Xe69zcjABdaUm0lWzeuwIlELLQx5l2XYJ80Yy
         kRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257032; x=1701861832;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zdc47aQVPlHYy2ESeXWMA/qDND5trhDEUxFKlSqxgnc=;
        b=U0sCbQzS2WOOpOzcWba/5OKa4nQ3DJJrKLIIeS5WnQAtvM2JXwO4NdQ26iN8chI4up
         qpygdlsfKpmq7IJrAIb0ydt/V0fVkj9IthZIVQxQXX5AWo+QfUbbaOVTZc1pgBO3Hdog
         259epMav6AER9AlHLDS1yn9q9yI5LUXe11QpyFnKK01IZaizWm1Yzp2DpBpTY0rRfTSg
         XJoXdyyAGygKgTrpDUPTolJZ0mIIHEFurtSurbCjAfNlqVRBJHYHRYndOBpbIFYU37DX
         yXTPD51JonO43BTI6+SAJkq8p8suBHHDXNI3Uufxma4cjkspSfApGlnbQufLKid4HAFE
         SHHA==
X-Gm-Message-State: AOJu0YxNDBScP4zOhyX1gAVV/QvdvAg+0iQS/XQYnMT0x0nWRcCf3Xv8
	dPmL7grQzVOved9eP1N+xhqYXuVBrQ==
X-Google-Smtp-Source: AGHT+IErMNLEbwBhmFms0mUODqXVETkpOM+QuMWkotNp1noOxxi38widhUBlzAX7cCboqpWXFXFQMw==
X-Received: by 2002:a17:903:4d2:b0:1cf:aca3:186c with SMTP id jm18-20020a17090304d200b001cfaca3186cmr14440432plb.30.1701257031952;
        Wed, 29 Nov 2023 03:23:51 -0800 (PST)
Received: from [127.0.0.1] ([20.172.28.131])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902789400b001cf511aa772sm11905227pll.145.2023.11.29.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 03:23:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ec671764e010ca002224c611aae89d829f205166.1701256112.git.geliang.tang@suse.com>
References:
 <ec671764e010ca002224c611aae89d829f205166.1701256112.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Tests
 Results
Message-ID: <12aece5b-70cd-70a5-e28b-26a24b0203f8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2023 11:23:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5843851173167104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5843851173167104/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6406801126588416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6406801126588416/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4999426243035136
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4999426243035136/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5280901219745792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5280901219745792/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a2f9b2d4aae5


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
Bot operated by Matthieu Baerts (NGI0 Core)
