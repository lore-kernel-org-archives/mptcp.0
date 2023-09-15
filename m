Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78B125B6
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 16:25:34 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-770ef903e80so150281285a.3
        for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694795133; x=1695399933; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6KUn8cTvcfrkrnNQcSpO9H0Knajpwfx3hAxeZryIss=;
        b=SXN8UxILIBdF7ozdJFXCFbT7LuJR10KPxzsBxb2cSW5AoapORARjxw16Hn/iPgT9GB
         jDQ6CMLHVDBEe+Z9+2vLJxRP3VoHQYStFh5EwvX6YAciz4EXaj2yezm5fpWPHziA6ap2
         q1E9E6YEx0Z6x0gzVOxqqMHfukxJrGIB8G9NtabuXrHLN1t6CQ4aHALZSTvKAnDWJ8it
         bkA5N6yUA7mwr31rXHb3h6IVECZEFqZAgHneQwgjEDHrZEbOkZTNjnMkes9JdffUrogr
         cQJNyOo4AVNycoQ67M1f8JBM3gZrmRBFWweuSbBBC7R7XN66WCchikbDEmOfRfnQkqIS
         BUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795133; x=1695399933;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6KUn8cTvcfrkrnNQcSpO9H0Knajpwfx3hAxeZryIss=;
        b=VbGpEz8A0NdJhmzQvgb2bKPsrKFwQjL/XUIRgdntg0fafv87OTT1lZrbGzZUdQDkgA
         tDgfkkb8EjB5BLiL4Jp9rZ31vY0pPZoRUIWC4SJ4H0Vvq7AT5qdS86Ha/GN3eWKTeieF
         2Cg0zlvYq03ZY/+zFclWZXBHjmiKtSURfKfh+w7MWJqciXqPFfrs8T1ejgJkA9VdgQfY
         +o6HgO9Nhtvrwy5bXp4RSXvy+jEN10Ns9Nl9/LWC8wPpj3ZEobCDzJH07fqOodDtsVLe
         2asiI526QmyAXSKmO4xpu0g6z2hEoyobWOGkLkCm7LzscSoWltG/je/wgUhWyBK6F/vK
         Jr2Q==
X-Gm-Message-State: AOJu0YwIotaYnV0PueyMueESKc3xLTheLIriahokmSpCC91DOku8OPHV
	UtQIqiS9oDH8dqkpHnFCKA==
X-Google-Smtp-Source: AGHT+IGZ1gWhHX9GhcZUCg4SmPgyt3G3OkDeEj1ILU0vvLhGOyZKYFy4U+Y5x5Lu6D6+8khGUA8a+g==
X-Received: by 2002:a05:620a:3953:b0:773:a484:8779 with SMTP id qs19-20020a05620a395300b00773a4848779mr2266941qkn.12.1694795133297;
        Fri, 15 Sep 2023 09:25:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.39.63.98])
        by smtp.gmail.com with ESMTPSA id o11-20020a05620a130b00b0076ef2816ff0sm1332761qkj.16.2023.09.15.09.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:25:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <03a5cef7b0980cfb6f35f5880ff38c6d15c39531.1694787366.git.pabeni@redhat.com>
References:
 <03a5cef7b0980cfb6f35f5880ff38c6d15c39531.1694787366.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Tests Results
Message-ID: <064777fc-f432-482f-fc7a-72df65cb20d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Sep 2023 16:25:32 +0000
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
com/task/6285088502054912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6285088502054912/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5132277739421696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5132277739421696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_mp_join packetdrill_regressions=
 =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6680702066884608
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6680702066884608/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4850802762711040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4850802762711040/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f3784307e90e


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
