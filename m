Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5F9455
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 19:20:43 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id q27so14265997oiw.0
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680204043;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmbKdVjrVyqHeEPO4nuO8FBuJhAFYW2wOuuQO2Msx48=;
        b=L+9RxmvdbQZl8mPv6G7DBmhIZH0yin/bTP0x+ojv0MDwO27U37rK6vBpRF+9LAV+Yg
         6Gc9USnwNL8L9yb59wE/ZetRNyammIJVoGKaxtBO/Q823WvJIEYiP1B+HLUbg3jCkO89
         Gp3I2Q3peIK9jbUiVHEcPgR+6AwUEezkRbmac49g50VYYyVU/FlgbjXK1kmMW2QLyYHs
         coPbI6WP1ftCff+szoDiANrL1gmGMZP2KDx1S0XcPgUhJXj0gMir+daHCxMXfUeH92cI
         rDBdj+MYVtuXtRYqb/DbJk9CaE5eajdIIxfISg1UYJFRL4MZhn1OfrcAcPLrai95TVk9
         G0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204043;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cmbKdVjrVyqHeEPO4nuO8FBuJhAFYW2wOuuQO2Msx48=;
        b=YaNqHSqQ4f1mn8QWjTS9XOfcUuXXbE+wyarXqQkihO0IftSWyZZTrSAERS77huVY2J
         SITWOBM9UiEUxzIF1bQbm8ArinLWMVsL92Oa1+N7krzb9S01qCIIRbsGcg3Sk6NizLil
         eFFmA+yThtS64/O1ErI4A9kEBU0W18T6hegdic1vWR0dJC5wQqkjKsS4owe+9vXB/ls0
         HJdnJ3qxLUMrZPaEE7dQNWOBPbTUduJ7nNrr3cR9lWLXImhcXv/Sdvr9VPKb7FYNVEri
         KCtMh+raW5au0EqSexG2xuF2gz7dAqmeSOX9Fr9pkgVE/AE5x8+yTIdAEAuantLE4YL3
         Ca8A==
X-Gm-Message-State: AO0yUKU7DCTaPptyl4Ln/tCay0ZI1VMMndkO61OIaL/MGbNKE3GfWRIq
	Nkyth476IywFdJCPh1KzE7mSwa2txt1r
X-Google-Smtp-Source: AK7set8iXnX0N6fNlxYuHHbF/381GYewOminuqq2R/tMnYOjzkjKJC9IjX8yIUn+TdybuL/Mv5KbZQ==
X-Received: by 2002:a05:6808:a0c:b0:386:ee34:afb9 with SMTP id n12-20020a0568080a0c00b00386ee34afb9mr10369439oij.11.1680204042946;
        Thu, 30 Mar 2023 12:20:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.84.8.144])
        by smtp.gmail.com with ESMTPSA id h4-20020aca1804000000b003896fc34eddsm191375oih.52.2023.03.30.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:20:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
Subject: Re: checkpatch: check for misuse of the link tags: Tests Results
Message-ID: <296a4239-8e05-1216-5dc0-3e7fc295495f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2023 19:20:41 +0000
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
com/task/6470058105372672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6470058105372672/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5062683221819392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5062683221819392/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6188583128662016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6188583128662016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5625633175240704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5625633175240704/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d6036791407e


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
