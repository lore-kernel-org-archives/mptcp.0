Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70929A0
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 15:27:26 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id r14so2561950qvh.1
        for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=4BVgkWQ+7lGYhkR5mnNgC5QDycdI7zcJieDui0jb7eI=;
        b=JB08BDoUPLd7/3lcalaRyYxpWYNlV7XYmdv8FSPIdfYY0DjPLjiu9gi2g3rr1NdxxJ
         Ov4gh1iCqDBSiUQJq4YovY0S02w9+rL7Mfo3vePNkcLT1bBTaqa9zMym7lHvyStAR5Z5
         g13t7jCLYSXSse5y86DWQphZQG0Rnv1i4kv9LPBqfEHt4pzyD2YZ8ZHaAVGBoS9rd01y
         kTsOxl+BKmqx+yJfp+6SsZf32mMd5YCo6CrojHehpba+vtGz11OlE/U0nHyFHXCpZIm+
         QNxgLbMJJ+pODAI8NaAPNj2+0SuUCtYSwLm2uO4mJOhDyfZlZPHZy5FqaxphmhRjRgTW
         rDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=4BVgkWQ+7lGYhkR5mnNgC5QDycdI7zcJieDui0jb7eI=;
        b=34GuApPwJoStvZ8KbDJ51pfgo0IL32A7KIwigYDWFEwWVz3ZCq41efxCWTyV2XnbUv
         uq9lFGuQsCzMjHPcWzAtPi0LKons2ZnsX/bnyJ0sKu8wsxvhcxpBZaFYOreovvvIYAn1
         hgK35rQQoKf+5CoO4wcrxby4lZw37SaVNOyBS4IPVmxT4Dq7bX5hp3I0/zizDcnqGUzc
         oJnNtiX3rJ+GejGy2UVGaRSYnGmHGAA6wLdykleRQTy2/IzF3nkdwFitii+qHlRXcGCV
         kuFTHR4P4eUIJZP6jbZIrOHNnW6erpMQqabbC7hgtGLAfgk7Ep79k8A0KF96A/OmAhyj
         gyFg==
X-Gm-Message-State: AJIora90nLSZlltHZ++1vXTqgYKgpDCTSacvR7SCjM5DirGoofAlGRnL
	Np2SYOkxWLEzZL7RdAOPCg==
X-Google-Smtp-Source: AGRyM1t5WF4F1G23mFCrmQc3bg5IbodaZQ7YSwhX4NiLkyUacJxQNmekm3iP9bEPMuEXEWatqCwYUg==
X-Received: by 2002:ac8:5949:0:b0:305:1445:f413 with SMTP id 9-20020ac85949000000b003051445f413mr4420857qtz.27.1655393245245;
        Thu, 16 Jun 2022 08:27:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.0.10])
        by smtp.gmail.com with ESMTPSA id t20-20020ac86a14000000b00304b5eef8aasm1895017qtr.32.2022.06.16.08.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 08:27:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d1745c1e08937164e34f0010369e8be5f4c2afb0.1655387728.git.pabeni@redhat.com>
References:
 <d1745c1e08937164e34f0010369e8be5f4c2afb0.1655387728.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: tweak simult_flows for debug kernels.: Tests
 Results
Message-ID: <1d640fd1-9779-91a4-e86f-9fc7acee1709@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jun 2022 15:27:24 +0000
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
https://cirrus-ci.com/task/5708948505362432
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5708948505362432/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5145998551941120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5145998551941120/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/727243b29682


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
