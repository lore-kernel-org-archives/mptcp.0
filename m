Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B37B
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 16:54:48 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id bb38so6282259qtb.3
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=DclaBIjG1cMcUT/xouCQOfIH89Gg66fGaIu2NBM3B04=;
        b=TxaQrkaf+XL9ktpi7FzI4Ip1kSs7ADU33mYtkWpF22N+zZ9KwZ70P9hofCjEXKNUjo
         kApEbPOrBJMytoZCjfFKVuWmgttCBQRTh5Wg6E7r6gTtlZfFvweVRHMtzEFflqGOp7g+
         vbGkIYC1PazXqxrptwvKhNqg9HlLLj++kY6JjR24AdAu96vQ1dNpLaoZZIkQ+ERKzHcn
         cwyBmRcYA/vMDq+QppFPG/VTA+RyRmo/kH7q9wHpr1cuOxlRcCNnbcYafqZ3ZsjgmsJE
         0XtZmiArxOK3cnnAK6PUhcYbvBuFs5hoTfDVen0FoRCuP51A5+hpudaGAFme8vysg7G0
         hISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=DclaBIjG1cMcUT/xouCQOfIH89Gg66fGaIu2NBM3B04=;
        b=jjN1B6x05av67C/+U9CzEdnxwl/zwtItr7r+qMLCTfDNYs43WQAGqRzwZb6YbBphHd
         UJ1u3YoKQsOKHhg2hms8m5GZvJIZRKxA02BdXG1UltMgU+rUflK/VTlYAbKG+2y8dj0l
         ZMDug5cUEncpRCj5tfrm3ZyC+Po5FJ+Jouhiid8xH0mRGUxFN2d0tSCVBm7I7C2G+KKZ
         iGBId/Uty42Bpg5pNejqcnRe6DzV2CB+xGi+38gQs+mEme93s6AJok+yNnePcHSRlxw3
         rnXYXn62WPRNqhsNwXPedicdDwwTsVtjN57rBIhol32AbbnNjyMbY1rVQJfhB1wi7m5w
         PFxg==
X-Gm-Message-State: AOAM531sR5HUu+lDsU4YvPjQzaA7iYu+tpMDi/PJNwAtcSm5RJe+Psij
	VeJMA4QnmS0zWVNPDH/ULw==
X-Google-Smtp-Source: ABdhPJwfWiu5GCp0DEa5fu3qLqgkl3G14NDVTUOHEx+nx/djFJKGOdNZ35ue8Hs73CmxeKpL0mOPCw==
X-Received: by 2002:ac8:71d2:0:b0:2f0:a7f2:946a with SMTP id i18-20020ac871d2000000b002f0a7f2946amr120694qtp.78.1650041687079;
        Fri, 15 Apr 2022 09:54:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.77.193])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a099700b0069e5cd89332sm768142qkx.77.2022.04.15.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:54:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <43cbe1db36c118468bc6e88ced16079d05f30643.1650034062.git.pabeni@redhat.com>
References:
 <43cbe1db36c118468bc6e88ced16079d05f30643.1650034062.git.pabeni@redhat.com>
Subject: Re: mptcp: add more offered MIBs counter.: Tests Results
Message-ID: <9b39aaaf-2ae3-246b-c8b4-8bd70eb4060d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Apr 2022 16:54:46 +0000
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
https://cirrus-ci.com/task/4509118336598016
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4509118336598016/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5635018243440640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5635018243440640/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/40eef4f35b96


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
