Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F12C9E
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 11:35:55 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id y14so14219216qvs.10
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=CHjsGvgzOONFYI3Xq/UOuwvl+zuvAv3uyWu05FUwBAQ=;
        b=pn9nRM9jTK6c0mCs9BRTuLLqnmX8VUV95AuoW8d0u0rSHCmpufHX1NnCXmpukMonKw
         tJbVY/hxEf8O6gXskPbRZaE8IFr9oW72fYPgvIFBNBeoQ7xbg5bQcsC8kGZInwVjJNSf
         g6qbrtmIxKZNJlmprJgkIB6QCtRE9ozEXFqxtnkbZLncNb2ZXVC63csCU0pZoV45HBvk
         B/v1hfar79QA/kT4jaBVm+XZJ+5WRhPg7DMZANQmCV25+vGmUgGWxQZcpaTMyju7d3eq
         agwuVW9L4bSmI8YCt0vJHH4BBwtLCHIFSEQqVRkhKZ/rSiepsFMFWJdiPidTU0eupsiL
         ibtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=CHjsGvgzOONFYI3Xq/UOuwvl+zuvAv3uyWu05FUwBAQ=;
        b=7LQz+ox9D4/Ue6hoahLr3/yxJpILVr9EkcUY70a26cg/w3l+l0k/q5MkjBHkb8s8yr
         z12ymKUNg5Ah7T6jsrOVvZ1bNCLOVnG048gUwT/gYjbjt7K7LaPJVNH60zs1YNUwhBPL
         vNUZBO/x6gMeNqXi3Wd0vRRCwK+uPJli6LDd72Wpdy2rGlIisSEzeQYwVHxWtF5VeqUY
         95poIOG7fY6LzsgNTZIgIjQ1ERMrSL9FBniTO62bn+ruYiih935IrcCPN2M0CDXkkZQI
         dpInwAqPG125bjpOTbJ/C61QX6b+o+PvszYC+GqldHCxYQLs6fkP4rWeJ0zgsjTmdaKJ
         LIog==
X-Gm-Message-State: AJIora+74rwRc271sx6gF+tbbKs0Rfm2Skhu7YK+WVnyjxgMRVeXpNor
	D3IHO8elVvzzg5oZrtrf9g==
X-Google-Smtp-Source: AGRyM1uzq699iEgcySGZ9pf/teIOZUQPT/h/M9uOSxj8k38r7pnLV7A77mY3O3XE1kSsTTS0Z+wx4A==
X-Received: by 2002:a05:622a:14f:b0:31b:a118:8833 with SMTP id v15-20020a05622a014f00b0031ba1188833mr479000qtw.543.1656329754249;
        Mon, 27 Jun 2022 04:35:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.142.88])
        by smtp.gmail.com with ESMTPSA id d10-20020ac8544a000000b0031a90429480sm1809655qtq.38.2022.06.27.04.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:35:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
References:
 <886e059dc9096dcc9e1daa1eb1a07ec34d72aa74.1656323519.git.pabeni@redhat.com>
Subject: Re: mptcp: fix locking in mptcp_nl_cmd_sf_destroy(): Tests Results
Message-ID: <76887556-7d25-1060-ab5a-14a60b5c0377@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jun 2022 11:35:53 +0000
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
https://cirrus-ci.com/task/6101836691144704
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6101836691144704/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5538886737723392
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5538886737723392/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/31a3bb3c20ba


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
