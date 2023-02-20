Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555963DB
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 15:32:53 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id bt6so1047937qtb.4
        for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLcDm6L5Aew3IEBGHFZSGBOl79aGXB1egCNup8tCxcA=;
        b=WvLLa0pNrVvBKj/26iIGVh93IoywSJl7jmKC9Ejy8Fg3ZRLM9asE2DzSok6r7WZaFg
         u3epBa5NEyQHL4u2J5bckUDg9hhfn2ofWff9ZCTvSRrTlwKVEssoBZrB96OcL1UdXUNV
         54tQa7frpL6JzIBrVorMhnDYLhPXIhJkznEK2wpRLfPz6SSar5uvC0PgeTzbaos/ZwgA
         3sckXNTYLmNMND72Ic3Zq+i9cwiKtBzZf/8yPXq7b6RpZAb+y1G/hCl+px/X7EyWOF/w
         0/N2jRjDPEQr6AjGqzVDEhG5M4YlbQaHp8pflvYl1P53X39eFIUf7D1HHStykGHkmymc
         +pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLcDm6L5Aew3IEBGHFZSGBOl79aGXB1egCNup8tCxcA=;
        b=4npt/Q7SnGFXHeX4YDjkiviPwnQStydmzlr8B3hPdrKnXemxq82ypHr9Nlhh7k5qcg
         +VubUpqhPtDoquN5J3Hia0gfkw4UYrd9qR1z/ia3YPOMutnO9I/ptcrgOdGI2NOrOHA2
         QxNcO9iHeSjlbPlvS6FcXm7H/LQMUDozjjWkwB5NQlng1EeL1A4+WzB5mS9ARXLGNfN/
         bBzCx00QZjwuYic+11xgFaTbhtii2wRjw61CkNYaV64kZOwb1fqGnTSWNE2ecLK6Ls7I
         VnxznVCL/2BL2geFo9fUs82aEEvFEWRWt2NdASFf9vr+B5rpu/aHBotdSgxMlzTc73/0
         HWpQ==
X-Gm-Message-State: AO0yUKVcgewXNjzDITy/osl2rkitj5zlXyiLKVKUc0scafwxgGbEVXfX
	13SYEZx/t+mcSDDdFpHICQ==
X-Google-Smtp-Source: AK7set/MMaIvAohKLbMVNVYsYcsEL59RcmyQ+Y1wwlx+Q2BvVAD5tiZnnIlQ/g/fZ1tqkjLrgNQkpQ==
X-Received: by 2002:a05:622a:180a:b0:3b8:5bfc:57be with SMTP id t10-20020a05622a180a00b003b85bfc57bemr867405qtc.65.1676907172710;
        Mon, 20 Feb 2023 07:32:52 -0800 (PST)
Received: from [127.0.0.1] ([172.177.27.177])
        by smtp.gmail.com with ESMTPSA id 13-20020a05620a040d00b0073b575f3603sm972034qkp.101.2023.02.20.07.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:32:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c2265383cb2190247f7dec66fb67182e558bf5a1.1676889543.git.pabeni@redhat.com>
References:
 <c2265383cb2190247f7dec66fb67182e558bf5a1.1676889543.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible deadlock in subflow_error_report: Tests
 Results
Message-ID: <0b0445d4-e2b9-793f-5eba-6f807d7bb002@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Feb 2023 15:32:51 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5587182899953664
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5587182899953664/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6713082806796288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6713082806796288/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4566836109377536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4566836109377536/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5692736016220160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5692736016220160/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/38e4dd7859de


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
