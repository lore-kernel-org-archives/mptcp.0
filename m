Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571048788
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn3rWzop"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1cf6af8588fso9067115ad.0
        for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 03:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700566346; x=1701171146; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG/Clr5naY8/+bx2kDbt8ESR05ilFvT9T9kOj29Yj8c=;
        b=Pn3rWzopNc4PL75ol22duwb3hAJkN1Le7ruYcsxJYsAGO9PrmWj8tHjc40n8LM/0HK
         FdFrwFGcoBdSrX16doTZbQaSIQgOGr3YB/nQ7xeTstmcoNv11ygWDs8gSUHNuz0NU4vt
         YhFppl76IJws3+jiU+TwxeQdldaG+gCl1tlEfOAmxNVZ/bT3RhVHkq2IF4h683xwTNtw
         V1HEucD5i7sBCGtBR9gHm9gau/9AdKceLzY3ID6KGJWMtp8GptMeXrsBGCeH/v9xG6kR
         b03NJALjCWnmuArxwX5iX7/pfLZSXiY40cuom9YxS2sdr6CSVpzEEQYM+QjlUj1dLuzk
         QhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700566346; x=1701171146;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wG/Clr5naY8/+bx2kDbt8ESR05ilFvT9T9kOj29Yj8c=;
        b=L7u8/+vxjI4UqOx4X8zw593h8Yf5sQX230RBecDS/BMMFrZaeQ2Awiu/03wjzLSD4a
         0rV1OdozkIL4nnNuMIoIReEO5BP4563EZcQsVkTNmQ8+kj3QtyTqcR81LlMPI9qEDQbA
         GSBWHtqlzMrOgdVHE/RPHUH9eMBxsaFevO5G9pNbf6mOD5iwBR36sMpExJM5rRhc+5sy
         K+NcNvi6hwIgV7RChnwHbPwP7oEBDRlzTC53F5Lu9OQlGiBXO0DLLZXqrAJh4DByha/Y
         mQBaETMYEMURi7ywVVtqdk3I5sL9V6QrWcO1HL3a9bgW6Irr/pAWw92gLunzJ4NqkPzD
         ykcg==
X-Gm-Message-State: AOJu0YxIoR8Ne0UGImtLAn+UtlDt4ApA9eE7hgRgsxE0PPsjArS0BcKl
	DFA8/LGgbK6vTbbHwjRLOg==
X-Google-Smtp-Source: AGHT+IEp2w9vXuWDFXrULuirHjg5hb7QwPeXf/gyFOSXMDr2N1bT67IfDNJLmzyLCC4sVdWdx13F1Q==
X-Received: by 2002:a17:902:850c:b0:1cf:665a:926 with SMTP id bj12-20020a170902850c00b001cf665a0926mr3435867plb.49.1700566345959;
        Tue, 21 Nov 2023 03:32:25 -0800 (PST)
Received: from [127.0.0.1] ([52.159.137.232])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902854a00b001ca82a4a9c8sm7715064plo.269.2023.11.21.03.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:32:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <52ad9a426bb36948608535adbcd6b1074bf5c94d.1700560046.git.geliang.tang@suse.com>
References:
 <52ad9a426bb36948608535adbcd6b1074bf5c94d.1700560046.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <0441f3e6-7ddd-cf19-79f9-f45f09e8feb9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Nov 2023 11:32:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4965466960035840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4965466960035840/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5528416913457152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5528416913457152/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6654316820299776
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6654316820299776/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6091366866878464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6091366866878464/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3c038d5dda62


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
