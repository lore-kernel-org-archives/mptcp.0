Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E38BF1
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 19:05:18 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id cg5so16918778qtb.12
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsTu9h35SAfggqLW2e8hYkY1PO+afipNTsG/juol+4Q=;
        b=j4jibzkpJyMYZXlSp8RxR+MAPhKqwVeoMGZOUDmuHWBC89spmJTrSx3+1UPallvY0D
         BoALukI1+krzYq1AxGb9GU06s0Mlo2s2oRKOTVVFG/v4rS1sT8609wdRcx9QDh2RHRX/
         kH3imMN2u0lENtyOPq6WuFsnOo8sqqetJVxIiPzmTJZPXbnOdW0vGGN9v6+8+ACEBfdp
         zP31AsHh1ii9w+piZTrQ2zD1r+/SPfNWDlcuZehf/iM4LbnqWkLYzfPBZxCZ2xTf4wVD
         hDVlKDpwuwNWDlJPwpKtOEcoLzT+pICrjUh56wGdniMln04zXcmLokS+Koz9vUm6iUxC
         wyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsTu9h35SAfggqLW2e8hYkY1PO+afipNTsG/juol+4Q=;
        b=D5qX3ZC54TBSPkacFpueiVMW5s0fbWXawcf39qBTphkgndm1ElX647Ufzn0aMtEoyt
         oG9CQFj+M6VpVhJKwqvRqSfc7GsYkR6bJKL7h1YUvsG2iqz0eEIgNlfOsG1pqIMvmiJl
         1QhsLTmQWOHud4aZ3lBxhHvL09A3rv7StbOLNj/rX1LHvN/Nuo0im0qRgVd7D7bSMYUy
         HFfxCrJhX5anr82rdaV96HsudQ19EttTLMG7pxU+Vx46ZzGGfUhogKPGr0cBJ8BTvbde
         hVS7CQITuV+ElWnj/r0L2fOu/i7SM8GHU75wUWWCyp/L/tJ8f7O8wCw3Mky2MO5yq2q5
         Wo/g==
X-Gm-Message-State: ANoB5plicHcaJzkffMXCyeT+OPZhJA7x0VdOAKQFce9VLGlN2GWXsFVz
	16gg1z9KAuO1WQULcCbtsw==
X-Google-Smtp-Source: AA0mqf4NwEpOUdg3LvA4TVZYbT+6Gqnb6W0tLZSZ+ALyffFikXOMppwvC8EP1xFuIJ3jEhehNP3qmA==
X-Received: by 2002:ac8:48cc:0:b0:3a5:3c62:5395 with SMTP id l12-20020ac848cc000000b003a53c625395mr1367983qtr.35.1670439917538;
        Wed, 07 Dec 2022 11:05:17 -0800 (PST)
Received: from [127.0.0.1] ([40.87.82.49])
        by smtp.gmail.com with ESMTPSA id bs42-20020a05620a472a00b006b61b2cb1d2sm17854392qkb.46.2022.12.07.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:05:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
References:
 <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
Subject: Re: mptcp: fix LSM labeling for passive msk: Tests Results
Message-ID: <6f859695-ec19-7d08-80f5-2f490c4251bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Dec 2022 19:05:16 +0000
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
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6227756669730816
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6227756669730816/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5946281693020160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5946281693020160/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4820381786177536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4820381786177536/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5383331739598848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5383331739598848/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9a2e646aec14


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
