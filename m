Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7F1DA30
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 23:25:49 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7658752ce2fso27067885a.1
        for <mptcp@lists.linux.dev>; Wed, 09 Aug 2023 16:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623549; x=1692228349;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiiYYxLduIFBllkAlroar8cu09nfdDmO/zbKWTD+1w8=;
        b=Tnd8VHFFnVAWZWkYR/cKOAWRe9m6hPTcF5j3cW/Uw4QtDAdreOn/RizWDJgulk1cfx
         LNqH23RmLQg+zQWlEMO/NSfrD7VMFt57AhYMKTDRqTZ1hVhkQ3KuRftqjYeQhwT3Z7CN
         ymFu3XFXxgauJ/a5oVu2kODOfPNYLWjTPq6lLyYtrxMbVHhGVooRklwMERbRpw0ycSrE
         GrN+vKB6hMKG7iVYc1MYvOmygEaNXvCEiCVEVmTlRpUy1pCZ+WfvGzcxKtjO7swqH68i
         izFNtLCjNcm3RnTlE7KStjvx627eGBQqXjWxnJtbUhCvbMlBXQiqUGE/1tVV0jpiWx+k
         fgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623549; x=1692228349;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TiiYYxLduIFBllkAlroar8cu09nfdDmO/zbKWTD+1w8=;
        b=IEj7fHDJDjurr0qXqjT4vaOlDOGfBeUoYuLZJ2s+FlZjuZwt+2uMZDiBSoibj6bSiF
         4mWR4VJaJJMIjT3lFs4xMnusnx8QCyVfVotvdzrpZ4+CWLaBQQFm+Ba1WdW4QpC9H8Yb
         EKePEkW1RKkS0PhAqQ4eXSklfCneJtibQG5Co/kG3lC2dSQFNo5IWkOG2EOCbEjOgGYP
         1ckJCXHZKY9TbxIJ/wI+6TFkS3LLRFYfaqG3uB+j1WGv7STeQBbnNOG9BR2FTPdwqhgn
         yuvDT9E6jk0EwYr2O8zKysMUP4moQhWho5YxNQFbXRwZU0Ev+SBQHrfwZOiuhTPmuXcO
         vr2A==
X-Gm-Message-State: AOJu0YyV3LO0P8kku0O0d+OPODAvp4e2WXdQu0JqNm263ILzYL6rMuHr
	DFX0AZAjshb51fKuKIQVGKSPSUUVCmgX
X-Google-Smtp-Source: AGHT+IHYKFZKXvIYFa6TDJBQCWWyNOJtw92G+/nKO9KO1bJeeYjSWCO9TqzUW13h4b7iLi9Re4anpQ==
X-Received: by 2002:a0c:e351:0:b0:63c:f964:dd67 with SMTP id a17-20020a0ce351000000b0063cf964dd67mr564761qvm.49.1691623548816;
        Wed, 09 Aug 2023 16:25:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.65.125])
        by smtp.gmail.com with ESMTPSA id n7-20020a0ce487000000b0063d60fac482sm31954qvl.97.2023.08.09.16.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:25:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230809225918.21523-1-kuniyu@amazon.com>
References: <20230809225918.21523-1-kuniyu@amazon.com>
Subject: Re: mptcp: Remove unnecessary test for __mptcp_init_sock().: Tests
 Results
Message-ID: <81cffda2-cd41-5188-3e15-ee96c4fd7647@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Aug 2023 23:25:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5907693383188480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5907693383188480/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6470643336609792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6470643336609792/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5063268453056512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5063268453056512/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5344743429767168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5344743429767168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e7b0047cdbb4


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
