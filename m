Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EE2904
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 17:17:16 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id c1so5193320qkf.13
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=aK435ug46ds21nPSHA3sCJMPVYoXtWhIhKUKx0t2DBU=;
        b=YbFMXUDcYaLVUxXNJH+4VvcKOXqpbAIW3rB7jdB0jVoprCq0uJ6k8xpiHCK9ljCJXS
         c20q89x0G3aUFI8AYEYkzGc+/KhNYDf60CI1D2ktXXcUyzSXoLvc4ktswPJqBEprad+w
         Cd/psvlMPnwlHyxww8ZdU0pR8vvtaGtV7V93riqsAzVXw07QJ/9NWQ7/odJ+IOqq4RkW
         Vg92WNJIM8Rfqic0I/2VtRGIlZmj8Re7nTT+gGkHX0IoLBdRsWi7pIv+BBHpfqzqlp/U
         ugzVZn9ZhYhoIbegLzqWDkmBLD+ZO+LYaq7TOLdWT5kMntypvRzCsGqgYn1CuyMok0MX
         AIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=aK435ug46ds21nPSHA3sCJMPVYoXtWhIhKUKx0t2DBU=;
        b=yb1O7jcDGwKsrKTgJ6HcBNvy4tHV6jBjtz38/EdKGCbiAUG8MyUAXqTiNTju/iqzy5
         lHI2JK0SAnfcbiYrtjxn1aHvarXDOQd+bA9PNix0QvyQyPfbOn/IhjdxVPnmCuG1dLRt
         16xP9nQFO40vV2S0dk9dre+cxo7fS+A111mfw0iIkf4naS1LGHIllxep4Z0S4FlchXOg
         abXGE9KEJ1nb1M5Io/lnZWR4XOTdDS51OMmce+733hX64BcJZ5YRB//jWSVK6yCASpfR
         5UBX2Nfvu/yWvz7YTU4YQfFEjcce+cIqNepzlOAnnSjJ/frtAmGqCJE4RCUyzY66+OTw
         q1Nw==
X-Gm-Message-State: AOAM530Rg1V6KiUJRgDLq63esBf8/khZakWD/5rddKU9dtPFivilMALE
	6qkItrA0TbaWuxrxXjd1Ig==
X-Google-Smtp-Source: ABdhPJygPH8Ilje2OA7FVZp9fbjU8YSElcAFbPqlYcKzAoXzD/0QvBsNhwE9gq22Gkljx87q67JvYA==
X-Received: by 2002:a05:620a:4101:b0:6a0:533d:4545 with SMTP id j1-20020a05620a410100b006a0533d4545mr3691062qko.475.1652980635877;
        Thu, 19 May 2022 10:17:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.8.165])
        by smtp.gmail.com with ESMTPSA id i13-20020a05622a08cd00b002f39b99f6adsm1542021qte.71.2022.05.19.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:17:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ossama Othman <ossama.othman@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220519153929.214331-1-ossama.othman@intel.com>
References: <20220519153929.214331-1-ossama.othman@intel.com>
Subject: Re: mptcp: fix conflict with <netinet/in.h>: Tests Results
Message-ID: <fdddce3e-776f-2cf2-facd-775ef10691b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 May 2022 17:17:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Ossama,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6207370031267840
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6207370031267840/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4799995147714560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4799995147714560/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9ca5881aed64


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
