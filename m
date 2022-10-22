Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1433C05
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 15:42:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id 10so4937643pli.0
        for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t39IwUaYLutGBakXF3rTUijaR6dmeqtn5h6V+T0K+s=;
        b=Y6KkpsrQbMWxCEIgw57os+3LTk3ts2prDsSaxOR/PT/ZVWEk/8xC4lJA1VeecZzDIY
         yEvQRlPUEGgEs3tpUUSa9Q3BKWj5aL4/nznnMGC/U95Eeoc6n8WA/uyMTBOjA55Ia9qy
         TntUcohTypXtpm0qQyKVEbAj/piIOl7sLvmZEJKxFv9sUM4dio5BaqjQu4KyFYw2cvtU
         IvIJft5tPTeTJ5WjFl7KG/4RvL8Rxv4C60qDi7Lddp+rXTi5aqh9w1ntpkjjAIy3b4qx
         5BQKtDHrmhmTdRXlCVK2t49N/IYho/g341J4IYnYKRYLELzMCDA49snLXtbOFuTsEyQA
         O/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2t39IwUaYLutGBakXF3rTUijaR6dmeqtn5h6V+T0K+s=;
        b=laBgZ8rNxG7SMZZ9wjrsuQIRBv6sz1dOrPyHRTkBIeqc91ezA4sTpOlgZxt7+aMHQ0
         ggTjjYiquXeJYGUcqnq2ZgiqDNKIwA8RyLsQ1/fwN2S6djhOfyZwohPBESwC2Okjs60D
         ZGWTLZztIhXFrOjllLJXXxRpIl0FT3pR3aJWdbnri4cM8C3EPscDscbtKFEmUOjFiXpf
         oE/dtiDEjq0MZBvkYdMRLIcTw0KYEC9uBiU9TpRQcn/1mAMXUouttx/1e2Jx+bRcVwcc
         EoxQ3yRQ2d9gdREZMVv8GVH02e5eJPxC97C3IwRJjRMOlFliIj2rmReSMnNJxN2tC4Rm
         FT0g==
X-Gm-Message-State: ACrzQf3XCVjSHHuf+1jBc7cPgCxNBWATmbDSICltEINqpSpZON8y14LR
	zyY0a6IstxZB91gl3dnwEw==
X-Google-Smtp-Source: AMsMyM7X0XnlCfncojwxT3gwdFmUHwnE2wtDRgEF7qQ85yKsOGl5QrACrsf3Xa1PPxhz+9l6wBqK2w==
X-Received: by 2002:a17:90b:314a:b0:20d:904b:18a8 with SMTP id ip10-20020a17090b314a00b0020d904b18a8mr63136011pjb.96.1666453333172;
        Sat, 22 Oct 2022 08:42:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.66.25.103])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b0016eef326febsm3415287plh.1.2022.10.22.08.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 08:42:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221022133528.31996-1-geliang.tang@suse.com>
References: <20221022133528.31996-1-geliang.tang@suse.com>
Subject: Re: selftests: mptcp: use max_time instead of time: Tests Results
Message-ID: <37b4b3a9-23ca-63ac-8ee9-4bd6359ac0b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Oct 2022 15:42:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5890198042050560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5890198042050560/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5327248088629248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5327248088629248/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/93625b5e6a48


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
