Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD929FC02
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 20:33:09 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b80b3431d2so6904955ad.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688070789; x=1690662789;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov47ntZ7S0XZtDaXKEdDvfjjiGo/ulodCBFk3viYqoM=;
        b=h4EhhUMcsz0MTbbhYpefI6PXbHmKc0EmKPBJ8fqSxMdZ3AWswY7Umudd8MZBAu4S50
         pkwvmX9BnzQ/tYpQwJB1VjOPzxXzlMgCyinqzZ8Aw6jhdWkuj9QAe68ph0ITDWQhaPAc
         4SAI400r7TMtBpgDIHRXCpE9UYakZwnJo1FkMc8caD31dufpz0PtwdJANnhI43IP1PEK
         O80F52Pz62JnqDa2pxKgTCPmqKbQdRKtNwnTF/nLDs3qnngtZv6+aHP1VzBWorEqdKjS
         XwrunMyr11YQae4LHe+0wC0eVEV9Z0Yl1v4ANCiLllJqx3a/K/clXEjFL/fKS+M72gWP
         teqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070789; x=1690662789;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ov47ntZ7S0XZtDaXKEdDvfjjiGo/ulodCBFk3viYqoM=;
        b=jbkvG4kx+GQh0R8ZKIACrI0ucaVNhlHltmQW5BZctd93z5flfamNe1lv2I23+QRAJ5
         JTaW/2zKDm12r8J0vivZdPBNVqjNIbWymFQ8KXEfS0A1OhiP0nIxQNFwVKL0VEtE8zn5
         sRHgA7IHbavDt74UyjhHCKIWr8hNFip/wKpY1COuJYdk6qOcUBujL+62GXmxhLddYHWk
         XUyxIeINF1o6V8ZhT87g7OirQdukFw6JWPjWBpm6cOr+wJJOH/mQnZ0s1YVtaIzBgZ+3
         Te9nN3EJ3Iko3XGPsrOXXIvLOrBU3r9nbnae6F0iE01zlyL14ge9vYfzCK0DxPzGzZnz
         EEqw==
X-Gm-Message-State: ABy/qLYwLc1csvxl1uY07pjeUyuvgoCjHP1ElTNI5OlL8mandV+hBa0t
	VTY/9MmCY2EQzarmfYqivEmLnaAcci9J
X-Google-Smtp-Source: APBJJlGMB181tOp/4inBOOzXImQ0of0oGfIs75XwCGHfc0A//tw+AirlzEdNtJiF6LvDAjlikPe17Q==
X-Received: by 2002:a17:902:d4c7:b0:1ac:8be5:8787 with SMTP id o7-20020a170902d4c700b001ac8be58787mr333603plg.21.1688070788950;
        Thu, 29 Jun 2023 13:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.51.32])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b001b4f77d4e7csm2966359pll.115.2023.06.29.13.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:33:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <05fb1934b9654b965f62f54be06579cdc97c864a.1688045383.git.geliang.tang@suse.com>
References:
 <05fb1934b9654b965f62f54be06579cdc97c864a.1688045383.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add speed env var: Tests Results
Message-ID: <2d5a1c7c-e999-83ce-1e70-b68a671714b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 20:33:07 +0000
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
  - Task: https://cirrus-ci.com/task/4797490306744320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4797490306744320/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4993086875500544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4993086875500544/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5916780074369024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5916780074369024/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4790880167526400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4790880167526400/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f3fddd565b40


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
