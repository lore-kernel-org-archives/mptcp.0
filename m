Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE9AD5C
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 21:37:13 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id i25so7252018ila.8
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq06alvrptiNnND2Cvb5lzdaSMIO8dBIW3YQlKB3pcs=;
        b=iLLolhC/lAGWhMFjXX+Qr6F9w+JWqh7n8c9lPOvUBZ1AseXcb9h6uwh0EyZDrDoffa
         dewnDSO+OCIKxT4Ctej6kL7QFeIvncrGK/f36bhOKuAFgMA39HxM6pwJ+9D6KEeqLFPt
         0m4/tGJA5mS4z3uk9f0K0pXvXirKgtobOa17TO4sDMG35y75911NIvNQH23MN6FTbcWx
         yq9fRjro0Yld0Z5wjnK051GMKG3fwXR70wsRRnj7U2MlKsOWBaWXkyiR4Ft/jqmG51EI
         wcZ4dl9DwLH/SWGD8i60951E/s8LgmPwgGYyuUzm6iystOZggOdqFV1CrWsstc0uSFhp
         SK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rq06alvrptiNnND2Cvb5lzdaSMIO8dBIW3YQlKB3pcs=;
        b=vkSolq0ehTqswsJGMqVbNDUye5hzQTgK6Jty7XdsRHscCGvJQvzlzZvrIR5bYLqzAW
         8BQE5QqEX3IUA/ULZ8AZ+FUQnxs1GmvfbCDbdtXNb03V5tz4ePX70AdwdInL/9FKWgGx
         dD2BQqInLYaGJYVvIeqVLRnq6NrzVaHDG5xO2/5o3OZX9+sf8qL5XtSbrrPY4iVO1DdD
         e/mOroHm7qeJvWE+Qq1PF5kgc5MueHe9vAN/Ah/EyOR90qZ8DqhpDjWi9D6vaMcUrhsX
         F2VXed+/6W6u0T6/CnWbpF0aV3qrOSBDb+buia2H0TV/Db6xFdnK08humyPcWqO5RmDZ
         ASPQ==
X-Gm-Message-State: ANoB5pmB/zCSdRcOsfcKtQv+uzIwgTsgGLThj4XEJ+LWGhXlfne1JwV2
	HKMC7Vj8vZ0kJ9msBiliVA==
X-Google-Smtp-Source: AA0mqf7pYmYp3bwU2tGE54H2OBfTqVcAC5ihnbn4IhmTihR02U/Hl2DjjoPSnMHL9iKcdlvISkn/fg==
X-Received: by 2002:a92:d644:0:b0:302:3883:e567 with SMTP id x4-20020a92d644000000b003023883e567mr13112584ilp.29.1671053832509;
        Wed, 14 Dec 2022 13:37:12 -0800 (PST)
Received: from [127.0.0.1] ([13.89.60.108])
        by smtp.gmail.com with ESMTPSA id f19-20020a02a813000000b0038a2f576b54sm2063276jaj.54.2022.12.14.13.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:37:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com>
References:
 <1f27ea6ff3b76035685ec372cc9e2753b9f9d90e.1671032651.git.pabeni@redhat.com>
Subject: Re: mptcp: fix lockdep false positive: Tests Results
Message-ID: <4627921e-45c8-3466-7d27-6062aa126772@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Dec 2022 21:37:11 +0000
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
com/task/5817967330459648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5817967330459648/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5255017377038336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5255017377038336/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6380917283880960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6380917283880960/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5150554645594112
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5150554645594112/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7f5351cf5abc


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
