Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10051FC2
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 09:10:01 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso36539387pjt.0
        for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTfsgUxC4+IYxuodBYWtf0gMCbGsbuX5v+YRIHN3z6U=;
        b=HS0/Xw3cZKdlCSik2Oe9nq6yink99A/+JIhhfZD003lon4S8R+wpt6pofRldJsBOVj
         COLvg7LTUzKjt2KzH6YzNP4OYi9S7qpIsLt6/P9maHBo3kAtodmvGu/wopcVtSz1tiFI
         WROlxMAF9aZX2OJJmqGQWa7gCfK2R5wwMWduONORH7TIk7m+MTOe/+oC/j7LLttGFRvY
         eWxUWQq2ru+6f6oycg97HwDHhdXinFhz8y6QCKKLWUVI7GHUK5SKuDxkkHWfbh1OXdqg
         ViPqLYU8O9UkP+iuGFtKvZIx0ITepNakxGlRjjEzGX+xeBWMUQsS8yFZXSe6rJOYL3cc
         +ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTfsgUxC4+IYxuodBYWtf0gMCbGsbuX5v+YRIHN3z6U=;
        b=ADvVlmaMxQ4yBAALJo91sMBPb6o+1C8znFRzvtxH1Y3YVFI1CdZJjyPu66TOjQu9MA
         INzVDFO5G9U7y2VfR0oUmmOYpU47en2XgVkJRRK9uKhbZ7BChFTQBftw43a1KugK+xGd
         FvEI1lLM7OUuWt30q8Vig7mt4qn6u1w8Pz/i0nmBkG+6xnpjSNIWoywlBWj07GlDHhJ+
         35KA1J7rs4pQ0ZH3jZbcklle11VWmus3pQ8k7nae2LYypbPbWrVBp7A72Wua3hG5m07J
         BtuipjZYiqZuPNjYLcibNL5khmejPiRb3kx01UKr7ipBzgvFXN3JnFwBCBuXv/wg7NSX
         WBlQ==
X-Gm-Message-State: AFqh2kr8Ux43jnv/7reQag8tFZ98+2gwHlAIljZwcA70K4C1ihANGBnw
	Ihdb/tvUGEw9D+Pd02nHWrzA/Q6rgw==
X-Google-Smtp-Source: AMrXdXv55DbzMzNUlEXxL4cjG26PthwX1V7y1kfjLM3Cyoo5GtyODyTvanD8YPsbxwa+b6jn3xPd8Q==
X-Received: by 2002:a17:902:e5d2:b0:194:52ed:7a16 with SMTP id u18-20020a170902e5d200b0019452ed7a16mr3206695plf.24.1673946601311;
        Tue, 17 Jan 2023 01:10:01 -0800 (PST)
Received: from [127.0.0.1] ([4.227.0.192])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b00186a437f4d7sm20691373plb.147.2023.01.17.01.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:10:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ef05d6be7333148d39b579e9b4b4ca7edbb8472c.1673940640.git.pabeni@redhat.com>
References:
 <ef05d6be7333148d39b579e9b4b4ca7edbb8472c.1673940640.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Message-ID: <3def7f4f-7fc7-b4c2-28a4-5d501b1d4c91@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2023 09:09:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_syscalls selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4799310072643584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4799310072643584/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5925209979486208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5925209979486208/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_syscalls selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5362260026064896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5362260026064896/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6488159932907520
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6488159932907520/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ee85063baf78


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
