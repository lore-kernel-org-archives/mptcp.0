Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17871426A
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 18:16:07 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-635d9e0aa6dso7680246d6.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688062566; x=1690654566;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC2NRPOd4ogvEdgvw9ZlI6fAFE9n3GkGOGebcENEMeo=;
        b=oRHinIv45UEQgWRdR8J20hcsRxV7QNvG2OIfgbu+URQ82vz7LpViIjlJOACYofhyOD
         CdNbfkQAY+wZnT/X2cmd0LXBvGIpsnASd1dcDrAgF9HlS3HcqvPRmu1UAf7II2F8yIM1
         K1lEkM9OGsVicZ7/3OR98+4s+CJ4ky798hHzxSmLTeOVeg0piX6w7eLBYYxe7NCzqUhF
         4HGz0I+q8rqSsWgvmoy2v8xTi7dstCVnfZoVZALqBn5N48yn9cMSyQ+xztgnkd5c1pcY
         2wstdYKNhrNI67hDDS7b1NkipgrGR/6ItpPoWa9jxmlpyRpfyMzmKIQL6y6dA/S///ak
         ICnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688062566; x=1690654566;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zC2NRPOd4ogvEdgvw9ZlI6fAFE9n3GkGOGebcENEMeo=;
        b=ElMa9yvdHMuGCihfWwo+wkSgBXBBLxXkoTyaoKyy8OtmozAp1xHHrjBlC9f2BTYyrV
         W5IwQD1mjdAzLFFCoCGpJd5jAJXnZvok/hUFc5sGhzOauO1nVLa1zGrtfCPfDL81EwuD
         QsNNvur0LV0KS1XPycsMcvLxqWxOYAR2Pw7ycSArwFkk2cTpgRFfUIsqFlsMIavciuUn
         k/HAozVjZmRXtCfiMCJmpEf9/u0gMQWhVsOxsMXJ2C4X27tQVfkw+1VVwKle8m2x+UtH
         zva1a5XYLwwnjGPmHT2omhObma74tbNezQxwpKEEY7QxGaoS2AJEirAgQjGJl60R5xo9
         pcgQ==
X-Gm-Message-State: ABy/qLY4UQW4tUN4LCOPKSrzKoZDm1/IgMvzaj5R4B8BgK4myTzcWKdH
	XGhyPeGBeNxnWwLnwOcpx8WNHWNLTw==
X-Google-Smtp-Source: APBJJlGJRzyeBkDEOr9WROVydIjI0zQ6hdSwzuAjIOoNmApXtX433RT/s7/Oj/Z4IJJ59jzP73GhJA==
X-Received: by 2002:a05:6214:27c4:b0:62d:f515:9320 with SMTP id ge4-20020a05621427c400b0062df5159320mr432417qvb.28.1688062566228;
        Thu, 29 Jun 2023 11:16:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.69.196])
        by smtp.gmail.com with ESMTPSA id z15-20020a0ce98f000000b006300ff90e71sm7240903qvn.122.2023.06.29.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:16:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230628144927.828117-3-matthieu.baerts@tessares.net>
References: <20230628144927.828117-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: join: colored results: Tests Results
Message-ID: <361182f2-0f10-1739-28d8-1cc5caa0e849@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 18:16:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6585027727720448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6585027727720448/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5368007371784192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5368007371784192/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5917564174336000
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5917564174336000/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5842187364073472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5842187364073472/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/07c93e69ca2a


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
