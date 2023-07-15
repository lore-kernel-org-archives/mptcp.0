Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998F7EC
	for <mptcp@lists.linux.dev>; Sat, 15 Jul 2023 02:13:25 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-76728ae3162so231770885a.3
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 19:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689387204; x=1691979204;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4KboL/kIYREHEGlS+7WmiP5cjMaSUG83FR7r90CKic=;
        b=Goi2sMkuD97gCAfeH8WWUL2aCl7wnzqW76K9OKHZsBXpFc/dr31jyj2/ySPCKlGalG
         cV0rWLuO8s0iV/X+YScy3np9TgYoJPhcGcFdC47hbHSMCDXlo6ti67JK1hkD5E83074+
         IbGJ6236060wA6uwXivJSiVEhnUuPSwtGaxow2lJwr+Nkr9lPpFCZjJbre6JrOWD9oWD
         dCqkLRkfWOX3JlcGf/n5censU4aZ4zdR3GbLSTylZIFCIS8dLcVlnFtwABqMMXrfy0pr
         6ECMtMxJJlClsigaSrkqFc1htMR0J916CogaMS5H6q+wC7bMVMJ56ud+toUbWajigz6a
         a8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689387204; x=1691979204;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F4KboL/kIYREHEGlS+7WmiP5cjMaSUG83FR7r90CKic=;
        b=MrskfZqQ2Uk6j7JVcyjJESska2uMf52Cf1CE43cpeHhNMAnrjnsLQRG1MyzX9hRbNz
         lFCGn8cR4f7FeQSSsIpVmwPeXFztaQ2a1fuf20V56KI0+8w+qudsD6Epy02ls9BfeV0i
         ZoZdmLHI7y9wYnyyLpYJI4V0xaiu3LpVAY9+1ojVyqVggRwMaIJ+qf9wTd00UHJ3gl3q
         BOjK3+fTTifZIfR+s+99t8n2XpAHD89CWQb5xZSwZenni8sdZB0nv/2evcdacrAuM6A7
         HZ7dGZLgfF4AUzGkgSyD79q2qyYIhH6J266JDsOmm+FdqLIZglDwtmi12+eV0JkqQNPO
         pnaQ==
X-Gm-Message-State: ABy/qLZuhHJ8JY8sZrWmRzdGXAG5EijgGbeMuzhVBiX8PmCEZpFglEwP
	Cq9WzG+xf+/fpYv3AXQ6b8ZCsM/so8JoN2Y=
X-Google-Smtp-Source: APBJJlE18mc92bhw+LiibtW/988s6QTl0mRbiowCSV0BTyZ6f/vswDrlunXzJbfbW5B9pzWM5Dxixg==
X-Received: by 2002:ac8:5e11:0:b0:403:b130:80b2 with SMTP id h17-20020ac85e11000000b00403b13080b2mr7685738qtx.12.1689387203812;
        Fri, 14 Jul 2023 19:13:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.44.102.39])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b003fdebf1a634sm4434227qtb.75.2023.07.14.19.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 19:13:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
References:
 <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-2-eb9582b8e24b@tessares.net>
Subject: Re: selftests: mptcp: userspace_pm: unmute unexpected errors:
 Tests Results
Message-ID: <dea2bc4b-5371-6cd2-b616-a2fc69c6a5a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Jul 2023 02:13:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6672417561509888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6672417561509888/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4631723980357632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4631723980357632/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5194673933778944
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5194673933778944/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5757623887200256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5757623887200256/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d18919e68283


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
