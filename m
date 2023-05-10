Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1762F
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 06:05:28 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1924ec320c5so5321326fac.1
        for <mptcp@lists.linux.dev>; Tue, 09 May 2023 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683698727; x=1686290727;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeA7Fsn64OxkA4WxxY5KyOcMXkSuM3xVb50A6aqQeMk=;
        b=Mrt5RjpA3VXAHjQIdV8f/ouiPodY9Ksb29oMMl+pJsSE3n8spFetI8JnPnP7h9aP2J
         N70m8A9opbe+0Yw3bWBPFkDGlmMPwLoePCufeuxIR3mDV3ihnILu2auKPZz0H1kf/02e
         IBKUSu+26ex6c76YsFh2iWMKMM1YsZalUUCVUmP0z1udYyeunIwjxux8ZnPs2oCLOZnm
         2USO4sJK5uij1y7Md31yMDeinoJde+BeunZBU+I94ENfJqaqsKYg9Uf6W1l6/l0+9fp/
         LPaTYNVz+eaLtSsVLz+WLmhd+iewAvfVC49g2WNcyjazNuPLouMv1XOatc2k1bbeiAp9
         0G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683698727; x=1686290727;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JeA7Fsn64OxkA4WxxY5KyOcMXkSuM3xVb50A6aqQeMk=;
        b=VOP06RU3+0CUHmyUrP7sJuxKpg/JLgMQO8RRCgQAtUyYzVhx8FmInGZTv9hSvQ3c/q
         E+DYqcH7QaPJLo1LOQcw/LNDpLiywoCRGp0xyzguZUfINhcsr164Ehu9aLNC54sNj8W5
         PCvm7nB5TuYMGZHi61B5wUZl/VotKVyk11Ce8O/ZwmZAWbM/gR7GiRJxKnmBzzLpdF+3
         8EFSVhGD4HgVV2ASpmAO2GP3rmA68ElvuMXYtSHoAYDVNls59hUmL1sV2ogSwXphTdNw
         KF+RbJ8o0MYnnK4YDwMJXgZI30YWeskGbJA48xDwpd/tNe8lfOJYTlQ7mxHXyVlzkFyb
         C4pw==
X-Gm-Message-State: AC+VfDwwOJesvMEGtwBHINO0fEebQqMDj58qxajZLIS7cazg+BNV+Vke
	Z32amyFONU7dw3jOkOXpdz9vuy6F3O5yP2k=
X-Google-Smtp-Source: ACHHUZ5LJJS/UBD5n8xIVDadEVglsdYMigDehcssy3wrcdhWE5dsfl8N3yuMvUTgFeJjPGrmgV01/w==
X-Received: by 2002:a05:6870:52d6:b0:172:6d02:7d74 with SMTP id p22-20020a05687052d600b001726d027d74mr8905170oak.21.1683698727255;
        Tue, 09 May 2023 23:05:27 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.167.56])
        by smtp.gmail.com with ESMTPSA id t12-20020a9d774c000000b006ab1ea1af9esm1119950otl.68.2023.05.09.23.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 23:05:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6350d66fcc037183977d7dd6cae5de14c14f770b.1683692137.git.geliang.tang@suse.com>
References:
 <6350d66fcc037183977d7dd6cae5de14c14f770b.1683692137.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update userspace pm subflow tests: Tests
 Results
Message-ID: <f10382de-65c9-f34d-ba0e-beeb1b496cb0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 May 2023 06:05:26 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4765607338442752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4765607338442752/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5891507245285376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5891507245285376/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_syscalls =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5328557291864064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5328557291864064/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6454457198706688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6454457198706688/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/af9bc2609d3c


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
