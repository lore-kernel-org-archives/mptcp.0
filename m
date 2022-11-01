Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2521D75
	for <mptcp@lists.linux.dev>; Tue,  1 Nov 2022 22:43:42 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id c24so14901281pls.9
        for <mptcp@lists.linux.dev>; Tue, 01 Nov 2022 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEsqZ6VpbgVwrqhNiuXh+wMBlmE86rfK4j6YA2biVRg=;
        b=mqCbwVdYLOVPWi9VLaKMODeAzMCGJBcJOtSgR4qiNyWyWLHVUrdcGDSmucvRD6FDel
         xu21JTrwo/oBhJDGWcY5y60dSHMqjzea2kK6p19fg0RIK/Iptlze70NGYMpgRAG1/vTT
         H+iStwHGe4yncmeND3YVaEXvDWHUt25SqhFYlLYS2ralHO4tQV8Ak6gRwJm5WeKrD+Oz
         tEAAuEAjbJ8v57Bj6g445idSyDXqJjaINvfbdkxgkafHtViW8QNomPAHt5ODnWCXYwWo
         MRvFbzhbPhNHMGFpKllnm6DTFaV8TP/IZMaJavsBxvdjqRrQiUSIyhG+ph8/bdH83mFC
         Tcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jEsqZ6VpbgVwrqhNiuXh+wMBlmE86rfK4j6YA2biVRg=;
        b=OUsYC0T4XQDTSVy1nLSAk3u40kcQIYXVe7rk2LiICfmA8cDXFtEb9J3hSNG1immRel
         r7+xvXRVeuH0M0yvGYY3TiYBL/jVaefR9M80P8Q2r8PanxpivTZt0nc1IfcVosBYu4+h
         V3Yj9CRgSz0XpMA76177j8ymuY08yYFPUEZYEvtaHRMHjiOllNUG99J3wYyvFBtAXTnJ
         pNs60aOnJylBoBw4bEhs2tM2Ib+fMKhxcEh3ifi0fXtKxl+VrntShTmuWz/qp/OgM+pb
         KhKRDzuVNrRIbX2dMLdNX+M73rW+gUO7u6XljqxBiSBM1KSc7D/ssjrBjjomnbVg1v2J
         B4Cw==
X-Gm-Message-State: ACrzQf0msbipxztRw8oILs88hEMNkmeP45K0t5IYPuYoUQ3WDkkIRMfu
	pWAqaL6JV5XhAo8Md629LA==
X-Google-Smtp-Source: AMsMyM61UYwxICayzkXR7aywoLNXAmgSUr9Ya1kxpzYdSIwvBgZkY7mstJx6KrANjKlfzeJDjSu/kA==
X-Received: by 2002:a17:903:268c:b0:186:f81d:3358 with SMTP id jf12-20020a170903268c00b00186f81d3358mr21817667plb.129.1667342621943;
        Tue, 01 Nov 2022 15:43:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.178.35])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b0020d3662cc77sm18826pjb.48.2022.11.01.15.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:43:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
References: <20221101205538.13892-1-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Fix grammar in a comment: Tests Results
Message-ID: <9ede0b81-2643-a2f1-a726-2f22c868399c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Nov 2022 22:43:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6510945403928576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6510945403928576/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4681358055309312
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4681358055309312/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5f6b7ec4cbf2


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
