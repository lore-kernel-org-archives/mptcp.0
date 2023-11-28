Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E175B5C2
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8TxcE14"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-423a459d616so17857451cf.1
        for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701181990; x=1701786790; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaH9TeUW3n7CkH9XNykKu5WCyejWpkN/TxySFgAZETs=;
        b=Y8TxcE14EPoy3zAnjhqE4YxOUfw5wFkIajZ1z5f9pT1k7C6TLZp3TnK8HIAuvQM2It
         33FWzK4QUar0PxqYovVWpG71Njo6FAvhbRTPQkqY8xIDlTbfaLJvAb4rqLk60sN0J/FQ
         zeWCSeM9nC3p1LzF6/xPmShKunq05b8Mi/WzmTP1pRzEhhNXMm07AuDZJ8jKA8Www6UH
         5p7La+ATfKPd8XA/sTtD1ZWothYU+qXJ1huE9KQxXB2y2cg93xVLsuMweSZXvEcvfPmq
         uSbDJ+TOrjtXwO+8tATGWeDCw7MsfMSfBShsTjPtvdOlPjWoUW3AHHO4cTWqzG+8bscx
         ZpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181990; x=1701786790;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iaH9TeUW3n7CkH9XNykKu5WCyejWpkN/TxySFgAZETs=;
        b=gttLek4gUBROxME0EnpiVulAGy3K6DObenNY0Zr5CcL1y301M2j00QQqZHz4OzwAIp
         YYgEB9SDgho41s4M7bf9OT2Cjsfmr5wqSYJW/e9yyLle4IBy8URu+b7kB3xblYgT/ap9
         vJkyJJa5To7xbZpEGZxftmX1ezqafIYYvglRmJ1DmaAcLGEq6DAas9Ooesffj9lR6adr
         LL0H7pI0yxBgpp+tWcAked2jQEwqvwJ/odGqgQBh2eUfAR5P3uBMpqywqQaqqvhFgza4
         WipcCZyOLwf19GnhMR4a2yN1cuNsRAZAsT9wx1rtGwEs/DhhWfPGSyG8EhjpQ0giPUgE
         2UTg==
X-Gm-Message-State: AOJu0Yz0A+pJaMLK+cHDvnN38s2uELV1jtx2JB+ealMRmsHrbBJ9TnOP
	5nX0iQiKqOszPt3GgMHQ/A==
X-Google-Smtp-Source: AGHT+IFsNgsaFU1OfdFD1TwsxOQesa8JFd21RUwjmMDniybuj7sXkRegrsFdk7+D6rXAdRCuRFYz2Q==
X-Received: by 2002:ac8:5dd2:0:b0:41e:3e21:a1b3 with SMTP id e18-20020ac85dd2000000b0041e3e21a1b3mr19221645qtx.56.1701181990403;
        Tue, 28 Nov 2023 06:33:10 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.97])
        by smtp.gmail.com with ESMTPSA id x25-20020ac87a99000000b004182037f655sm4586070qtr.14.2023.11.28.06.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:33:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0b59f639265bcd844b1d51597ffd5e172127732a.1701180777.git.geliang.tang@suse.com>
References:
 <0b59f639265bcd844b1d51597ffd5e172127732a.1701180777.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: join: check CURRESTAB counters: Tests
 Results
Message-ID: <378e8062-a8c6-0fd4-58ac-6d7fc4fa7781@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Nov 2023 14:33:09 +0000
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
  - Task: https://cirrus-ci.com/task/6003812935139328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6003812935139328/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6566762888560640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6566762888560640/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4737175539941376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4737175539941376/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5440862981718016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5440862981718016/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9fc088de6572


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
