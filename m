Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B0D1945A
	for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN4g13E6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1cc58219376so18676165ad.1
        for <mptcp@lists.linux.dev>; Tue, 31 Oct 2023 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698773215; x=1699378015; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWPozMW6VbrbhbV9uQPckRGzkjpiTXHHLkPpY/IDx+U=;
        b=lN4g13E6B7ahHcYLyzwIc3y9gygm+V4bGXZqTemh++urNayvAUbk0mMRLlIzrXeEnq
         0m8a42/2ozJtkb8+9iJM/nmmqGxlcJ1ifGZWEpfVacZmJdqtOahOya9lnU6MHZ6lqT8V
         80dImF46I4H4nwGD71jQ3JUUhNdoEIf8XgmSy7vlMJ1Z9LxL/Jfjfo9kgTfJd8WW9FYM
         71saUT7M55GdPGVRYf9bA0LdYl4HXCrgzo6COeCeki995XiqUOXGtQvTMcKGxFF3s/HC
         +LaqXZdSgnjJnNYajJxMw3yCvg+EE8wgZ21v8A+jnBhogjsu4eU2LsTyt7RALlLQwdNv
         JkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698773215; x=1699378015;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWPozMW6VbrbhbV9uQPckRGzkjpiTXHHLkPpY/IDx+U=;
        b=ZllapmmcrPz7GwffaI+x6vqGGhjTQ9VZ5m7eHR1+KjknCIWCUhkyz8BW05M4/awvv7
         2xXaXxQxqum2am6+uPxai7YZdrrGFzv2J9MsoKvavOWFr60CZtzbh97PFjKGIsm14vY1
         Oz+BkJScvDrwHvjLd/At6RrcknGwe0wDX2OKO+meol01DBhM5xBRoUOKUuXnAQ6HJYYa
         LRH4pIbYQx//Y5GT/vkWbWI3XSCqLq1hGfKQPWTAzH3XdiQo4BVLG/i8z3lWxRPDPwwo
         tsae5cF0kKT6CuWAGSEYPqySO3mUOrMmKdjh/HKiW3VcVuNdIhT6ZDeg5U8sByCBgbzU
         Vntg==
X-Gm-Message-State: AOJu0YzP3RJhS5KGYpMsUjDiMUqadxRSMfbWwwQOY78Pyt/7nibdL0n4
	8iE1X+rYJnlko1rXY6CQ6g==
X-Google-Smtp-Source: AGHT+IHl7yKlhJtwUNCbdhgCoGv7q3u8bolwMsQmGekMMV+DQDBcDd0PZULyiZy9QbF4xCWyg96N1g==
X-Received: by 2002:a17:902:ec86:b0:1cc:e66:372e with SMTP id x6-20020a170902ec8600b001cc0e66372emr16895486plg.20.1698773214721;
        Tue, 31 Oct 2023 10:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.243.23])
        by smtp.gmail.com with ESMTPSA id z17-20020a637e11000000b0059d219cb359sm1307838pgc.9.2023.10.31.10.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:26:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
References:
 <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
Subject: Re: mptcp: deal with large GSO size.: Tests Results
Message-ID: <13369786-7bc9-d44f-bcb4-519a5b432d06@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Oct 2023 17:26:53 +0000
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
com/task/4778133740584960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4778133740584960/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5341083694006272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5341083694006272/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6466983600848896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6466983600848896/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5904033647427584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5904033647427584/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1c8a63f49894


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
