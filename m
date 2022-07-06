Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6EF7C
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 10:17:10 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id o26so3556471qkl.6
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=jQQQ3SICsdHIE6BfLBapUvQoHXUKGmQfnSP7KtLNqI4=;
        b=qKiFna17bJRJzvcpBne69nYJ+fE+ig6W0YsXEWfrCLEMmEiLZxM+UCglKa9MabbJ/z
         0diQvawyxesPMdQ7Tp/I6Qebz2WgkiiczFPQrdmjJcnEZpZDnp3kq36FEFRqlxS5n/dT
         2QPwtUCIOQfAXrkF/uyde9y++y9Fk4d8mxZSTCMlt5JjnYX7NFppdKt74DhuJBOsrLkW
         NWxxo+fHlLfcyjZ9i767JwZVmgHzfso2NHGZpezcKXNGvTr0tPoRjp0xh5FxvcoBjZsw
         nloebiaHagUudQG4D+pIEuiFwcaVkcNuhCHYsrlpjby8aYdZLnLqqGLV/2/ZX1LHzl6B
         llQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=jQQQ3SICsdHIE6BfLBapUvQoHXUKGmQfnSP7KtLNqI4=;
        b=AfeQ50UkIdSuz5lnaada4KcAT3+irbR70bqqmCYI6jHW8XPlTji+fOuq0OxkrG7/eC
         TIRRyXiTUydcM4hYJsQ1Y5/gwmqZ7gNO8Ojsn/1BbF2jfvjMcAsmKpCtQFKTX8ostPtj
         K1AYmB75XSSDQ6biJMVYS22VDLezQ67f7VugD/D1/QTJpckPkLMEAoPGANMUkpDKRotr
         v7fb8Gws8lLXZOlBA4aGtMadNhPWZiNP7E/tndxJE98ge/AYmD+BrdP1sj4H2VSDYhrI
         5oJRvoR8E/w8culj245cH+f2YYMmwcLx29uva8UKQk6HQciK2t1LM7z7BbFzhkvYjK6k
         UxKw==
X-Gm-Message-State: AJIora+HpPugYvxNcgttJBQ6iFBxZlHzwKCkmbs8l8P0RFy+IjDhH85A
	IkAvfcWns9ZfuZXjFAgth0B3ZOXUZAXl
X-Google-Smtp-Source: AGRyM1u570tQedatWxzJK3uKHASTl/feyy0TRKidf1+pA3XgGSaKSe4JohzLA5EaNmwJMWc1y1Y0BQ==
X-Received: by 2002:a05:620a:4384:b0:6af:59ce:a5c0 with SMTP id a4-20020a05620a438400b006af59cea5c0mr26756290qkp.492.1657102629115;
        Wed, 06 Jul 2022 03:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.114.221.186])
        by smtp.gmail.com with ESMTPSA id v12-20020a05620a0f0c00b006a73654c19bsm31998358qkl.23.2022.07.06.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:17:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
References: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: validate userspace PM tests by default:
 Tests Results
Message-ID: <709d6d2a-0e12-76ce-c029-c429c9f22763@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jul 2022 10:17:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5669279193366528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5669279193366528/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6597218206482432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6597218206482432/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/795982e1ec62


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
