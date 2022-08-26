Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68771441B
	for <mptcp@lists.linux.dev>; Fri, 26 Aug 2022 19:03:45 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id x19so2345011plc.5
        for <mptcp@lists.linux.dev>; Fri, 26 Aug 2022 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc;
        bh=sIX3o4MUXpX1ypjLKUqjBBdMDbza8Q8xDPf+E2q8lco=;
        b=I3GfJoMtMpBTfDqYMMI+OHlHlBCHRoKehT5HFwcaL3bGzxY9N5ZxXcILHe2KH79hJC
         iwy+98ilnvSsGYr9Eep4Kn62sQ5YqVsiR6BQ76QXmbnos7LetIK2euf1gAKFDwJc0t1Q
         zhDDTVJd0nVl2NMho70T4B7L67ngzdSkK1kESCxr9a3J/+V1GfyNqAWNSaK81m91xGLn
         7O7I51IExX84vwnbdxyM41Tas33JrwglICCUuMMjnJHCusC6LN6aAmo7Yt2y0KxdFa/Z
         k9xU0iIObYlqypYPKXEYSEIirKNnyhD2UgEv4XuUvjJJu99tNvyPIivnfLOrEkPXrXN8
         gtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc;
        bh=sIX3o4MUXpX1ypjLKUqjBBdMDbza8Q8xDPf+E2q8lco=;
        b=YZUCSQ5ohcpNQ5je2HY1kECGH5xAxnKy2Vb4j9HEUs/0NJorOKwdi5F6zQl5wh0er+
         ZRvrrabf6Kt4f9PzPdKi2YnK92sTlUTwhTAih2V35Uw65OXIp7DYEnPGdBF/Q1fuvFGF
         KCS9YmN2o23kzhRwRCtVK8HjGQtCTax7LbweNU/3ae+GLJIj50T+uVZTzjAUThi+0UWr
         DHDhu+0vgxzNT0qOgsG4qCtoK8Z1teBoXJkJwEfxIwijQQfAPiI5DYruRmeAkmQoFoH8
         wZ2gy4uw1+InRoqEs0qxhkxfC1fawf3/6E/ha43Qx7kL1RgLoqI9guzxKVsqxeDI/tsX
         ZIsQ==
X-Gm-Message-State: ACgBeo0cMBvNaDVgs0chCzoJFMX32ylkdrzG9VSzTjxglTH3FNnM1e6J
	pSKSfJAnGdEXLNUO1dK2F2QUetQWDo7B
X-Google-Smtp-Source: AA6agR5MYoUux7AzxnIyIXKxg3yNpBqjHUl70krqFG3pBCP3AXAT8p9qu10ZPWneZmS3YPdPEinyKQ==
X-Received: by 2002:a17:90b:514:b0:1f5:59b2:fceb with SMTP id r20-20020a17090b051400b001f559b2fcebmr5829433pjz.82.1661540624596;
        Fri, 26 Aug 2022 12:03:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.186.91])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902e84400b0017336c3a585sm1954554plg.233.2022.08.26.12.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 12:03:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fda2e5ce19891d50fc3b7cff19c81330b5b475b1.1661533333.git.pabeni@redhat.com>
References:
 <fda2e5ce19891d50fc3b7cff19c81330b5b475b1.1661533333.git.pabeni@redhat.com>
Subject: Re: mptcp: use fastclose on more edge scenarios.: Tests Results
Message-ID: <c8148166-47c7-ef2e-4d3c-b205ed3b4f04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Aug 2022 19:03:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_syscalls selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6532607029542912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6532607029542912/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4703019680923648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4703019680923648/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/19f1e4100f11


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
