Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9C6ADE
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 13:00:24 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so1903745oty.7
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 05:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XywFlZsNJWnqrq1hyUTHHMhcYV5SJOBOmGTSe3S+ucM=;
        b=NgrdpnOmjU3gUaQKl+OmcDobuIkJkOZxwpUUO6ea4sDIHasJkqJdIoZIPFY3qlhRep
         OUqQWPfIIYG73YQYQ5ptMuTvzVS/JbQKyjGYc0BVgqDfLQH2YoGjHp5R8yS1gpP8yV4P
         nQW7PCIKGIxc4vAXFeVPfgIZi0EsvANBzceOm1tKS6rcjnBWpo7tfN16N+XsJrxk3WVD
         xfnTIgo2hnPZb6FWVRNMRNG3f/QpyvTmnzpdb8vvO9MXlZwdLaTkuOg4QIHjbRlgA3Rl
         7Iex45onfFDjHuwEPjXEK2XK6rUcWcRge09/lDsBS/uA+BLCmy7msQ+toTpoBl8BM2xf
         sTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XywFlZsNJWnqrq1hyUTHHMhcYV5SJOBOmGTSe3S+ucM=;
        b=Rl/jPUj/IldrDYuJyExL5szhR6yAiJanD/qBFmmsxmimaU/Pepf3+SUVnrzXYZN899
         0rz5rDvMghpabSkkAXBRDeUWtiQIhwl7qAZaRMc+GvOu8HUEMMJfvwsD7N6vh7HIyVyz
         UH6c1s0bWYBok1dXzDEMGNysvUqfTvE5TwuTEXE/3H3BglycEsv7lMusv7zAmiGxyqcX
         F2yBldOoaET2pYl9kD7JYdtoQOC0zsaKHEgdS4ge2MfdxVW8/3pLI6oyHfWiJio1zLdp
         Hw9Jfcwb2YrrKG93vgzQH4LxP7Y8kOYt009uLQjwGtpkKpY3ujlY2OdEESga0lB223Js
         e6PQ==
X-Gm-Message-State: AO0yUKX6lXwh8ylHLOp1lm0Xwz4pOA+5TBl1v6ByNIgZ/sO1blASFsNn
	Ax8tcQll3Ls4JENNa0emiWgneZFQnQ==
X-Google-Smtp-Source: AK7set9akFZ7Qfrj2PomHIJeI580uF5MhtDhv1CmtBsnd4HUvkVJXLXwJIUs2be2REmYXZof/XNiyQ==
X-Received: by 2002:a9d:51ce:0:b0:68b:d7d3:491 with SMTP id d14-20020a9d51ce000000b0068bd7d30491mr2708914oth.21.1675170023573;
        Tue, 31 Jan 2023 05:00:23 -0800 (PST)
Received: from [127.0.0.1] ([40.84.170.0])
        by smtp.gmail.com with ESMTPSA id f64-20020a9d2c46000000b0068bcd2b0bfasm2969289otb.65.2023.01.31.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:00:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
References:
 <20230131-mptcp-issue-323-join-delete-re-add-v2-2-8de2421163c9@tessares.net>
Subject: Re: selftests: mptcp: stop tests earlier: Tests Results
Message-ID: <fca55354-f401-4cb0-12f9-5d2d8c4843aa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2023 13:00:22 +0000
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
com/task/5272704723451904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5272704723451904/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6398604630294528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6398604630294528/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4991229746741248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4991229746741248/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6117129653583872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6117129653583872/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b2e272868708


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
