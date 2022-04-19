Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0F1385
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 19:30:16 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id x20so13911627qvl.10
        for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=3e1/O8lL9Ht8QHWzvvs1W5AiYIuoix1sxzvKBMvqqdI=;
        b=fgXrETPNm0BbifNF/bHOIhjIqyPRIu+G8aNjxr3+grCq3qXkOGMTLEn6cic1cFQAPm
         ZyNp9dAK9YWGxNtXnfYog0yCx9JjuZAg6JdS/6x9T+tSjRitBttn8sDLXZLUao0ofds+
         JiAOnQfDRk8z202CcThLflPv3bQjTTU4XD4jRYsadDLNnlasCDndPh6f2F32q532XPVN
         YeQ3t7DdzQPNGUAFxYbjeXhXPjUEBdq4pow2r1IKCmjUK/rDxOaUXXrMOy411zcozl5v
         t/PiZTg874iF9NrBZkPhmuOrYuot3grKqR9lyVcP+W+QTPN+Rv7EL5IMlxsUdLKGj9Sl
         DOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=3e1/O8lL9Ht8QHWzvvs1W5AiYIuoix1sxzvKBMvqqdI=;
        b=1l+0dTmfvsxgppx2qOsVRmbmL0Y2PUqS6KiDn8dVHpW97kbQlVpSBRJP7ISd8eCknf
         i5F7mTtsmU9EPPYJ2l06pkuZA09IPDOhvkzPuSLzvtY4atvRB+VVK8XeXvHJOssw6Zmp
         gkf9H3MmjkR28GlRoJXNVh5iGgYv/0jUi390qZm2d/UtMIC7rVfrM9IYpghn+1MEDlb+
         mAj0yrMDe+vYTfyLlIncp5ISgKbcCGlP5sYV0/6+rQvVYtNReVHIvF76wre1bmactrgF
         Hq9+7ZM9eHMOZ6r9rU3hzz4HzLbTZHDrL+hrkdxLi95jmf+wFtI+/mzWbdLtaFvDpCCm
         gCWw==
X-Gm-Message-State: AOAM530ZK7URHS3HX9PCdk1Z/c66LWkFtIF0vAju/yFRSotnrV9GfHRB
	zG5tk2T61S5x9hsEJmPsC5rLkd7nvA==
X-Google-Smtp-Source: ABdhPJwbilfLewsHAh1nqMutNURG/JKv7yWHVQ1Or/yiJ/gpUXTr8VJz5jlMQIu0ynRWe/CnAIK6Yw==
X-Received: by 2002:ad4:5d69:0:b0:446:3d44:2fbe with SMTP id fn9-20020ad45d69000000b004463d442fbemr13158776qvb.16.1650396615791;
        Tue, 19 Apr 2022 12:30:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.88.131.216])
        by smtp.gmail.com with ESMTPSA id f16-20020a05622a105000b002ed4688f116sm523403qte.86.2022.04.19.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:30:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4742d835a4550db1a6f6f8ac6eea3433f819c36a.1650386197.git.pabeni@redhat.com>
References:
 <4742d835a4550db1a6f6f8ac6eea3433f819c36a.1650386197.git.pabeni@redhat.com>
Subject: Re: mptcp: never shrink offered window: Tests Results
Message-ID: <039d139e-9459-e581-3303-e7a8da10ced5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Apr 2022 19:30:14 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5584135128350720
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5584135128350720/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_simult_flows - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5822711300620288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5822711300620288/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fecffc194d28


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
