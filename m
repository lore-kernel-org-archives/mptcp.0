Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A617B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 10:32:39 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so25144250fac.13
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 03:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=EqLNbGwf83hb8raXoV/W2s2cosHX3sHtlxCqlKhjeMY=;
        b=mpjdJv2H5m34h4i718KlNgCYq56fbREfCMLE8tS9uYI9VxHmZtj3fvAoWrCYG9Yoat
         sj5Gbc+Xk+DLW3tb8XrTOI1MBQKYCSJBjBweealbeFgVBUV4KU5iqILx9YEb+Irokb+d
         Nbq16LMy/TvfTjDchq/ZtkZz45/MtxvrtxvRfWrRXGt8z7Y730pZo+BqKpiCbbYH2VPE
         CGtLpQC3ZuDXAOzzv/f5EJFa5tC0iom5dLfcnpgXxYHbcWE7fcE0Cgn6+Tz//g+saCk/
         DCoKGlB+iqCwxpI9iTUPB3QG53M0HS7XF2gHHmD9Xf4rvn1qQQbGY9BjTpGyb6j//ZOB
         bvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=EqLNbGwf83hb8raXoV/W2s2cosHX3sHtlxCqlKhjeMY=;
        b=DkusgXA6GE1W72o3LOC5jdthASJX7UkEgI3zLVP0t9enJmTW18RBABLrhyRtHkdTYi
         0VFJpqels+cVuxqzd7xyghPXWEKXgosd6a1SOv3tISXksbF6xpz51JXJpk+kkhC5N9AE
         7xvAB2dscfgyUlrnD9w2XmftGUcfVgzKard8htBltz9nV52PKI3e2UuqD0jA/QAZUscM
         XyiRBKoJi3fu/tawSVukxnsywSGIS10s3wpnB5QwztlF9ETmNV0N253XnJLYAwuZ9/VU
         q47NOwZ2EOlYlYYifbr5cglZBBaQ6K9wR9VhVZYD5YW2+E20W3Dqrr5dvAk3M+fS5nqd
         pYlQ==
X-Gm-Message-State: AJIora/idhFj5GfDdRMhIvjEYsDYUY669Z555cIXNf70WgswlWhAB4Qx
	YNjC7ZGz2l0Nq4iFtaDkZw==
X-Google-Smtp-Source: AGRyM1vVgpbGd9/LLuncYir9sAzzUsPB+XOP8p+VT39KI3SeEKYeRy2ITizLJ7sSJ2bNIstHYyODEg==
X-Received: by 2002:a05:6870:5819:b0:101:f651:99a2 with SMTP id r25-20020a056870581900b00101f65199a2mr4634888oap.167.1656585158249;
        Thu, 30 Jun 2022 03:32:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.225.218.33])
        by smtp.gmail.com with ESMTPSA id y27-20020a544d9b000000b0032b99637366sm7093842oix.25.2022.06.30.03.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:32:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <22c84dbb74978d8062d453f6bc1857502078fc28.1656578856.git.geliang.tang@suse.com>
References:
 <22c84dbb74978d8062d453f6bc1857502078fc28.1656578856.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <076e8532-b07a-fb64-d5d1-2294226cfc49@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jun 2022 10:32:37 +0000
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
selftest_simult_flows - Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5934869556494336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5934869556494336/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_mptcp_join - Critical: 2 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5371919603073024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5371919603073024/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/012eddf81089


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
