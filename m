Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B3100B9
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 12:35:08 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-403b3213d8aso22644291cf.0
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689165307; x=1691757307;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M40ZbObrT41OkCrsi+uFuU/aAKIZOa4zt+nQpU6R2bg=;
        b=I2k9dih2EZ+2eEGhtyCfMy1X3rCmSzkx9WyJukanJHMXOyNqZPFyrfHqRzUhMjV/Lp
         KpUUBMB4e4A3liLK1AV5JkfMQ3nGK4xZe3qTg5JfNhGrvpeP7pBEoef3YsYTjIovx1gk
         uxuN4MoU1Esx8UH5J/K76NMkzoCsQbW0dc5rjOEAl9zzjEMroVuVNHBgKQZyK+Ynz/M4
         ZEyCd/EzjACjNY/HH3N+m14eBH+LgYEMkvRXFeADekmIu9dDTYuRgewU1nYeRRlM1XIx
         d+R/h3ViRQPL6bAM3mIM3790wPmhECZjUUrL2gJt4FYVibCQsPuS2Oq8lPHb2/Reo5bh
         Tyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165307; x=1691757307;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M40ZbObrT41OkCrsi+uFuU/aAKIZOa4zt+nQpU6R2bg=;
        b=eRaisHrMItWbW1DAkVU5FK/nK/Y27Fa+T0ZGoGBLSL61RML5qJDbwiV+ulMz0XMJUK
         Lp1DDJuwf1rwllPeIM3IgPjLCg/EkG3XBtLlUHPDmm/p3S+mrkP0RHENSXeQNh7UyIBF
         58hMhfHG/h/0XB4i7MheH7Zp3QcPCmj/vMWMmYkYypKNqEpl0QyR4rswrYx4Tz82B9B8
         yZ60tImsjkAM3l3VuA+BhrGtsInHbclG2+El7nSkKLj5HVb06UACOPYohZ8YEYhyDIDu
         B51KofLoc3KAkwi1mKPvvDrwJmXrEhZMcjwqGE23vNx4Vvpo+i5V7gZIJ5X6Cj/F+gUR
         kXbg==
X-Gm-Message-State: ABy/qLZcM2CMj3+Eut9bOjiD47i+87e4Vy6Yh8O3IkxYQ9slvUFkyGqB
	dxEN1GuEsrYvtetzQBH9rlfKASe/VQ==
X-Google-Smtp-Source: APBJJlFK30rkKJfdtT00wvxPcwn+kENPpmaXC2YXvHEs1LJrj8BTnCQZygUDjQmd4mS3PP+1xHjYug==
X-Received: by 2002:ac8:7fcc:0:b0:403:ad13:223a with SMTP id b12-20020ac87fcc000000b00403ad13223amr12944949qtk.8.1689165307203;
        Wed, 12 Jul 2023 05:35:07 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.203.202])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b003fdebf1a634sm2198052qtb.75.2023.07.12.05.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:35:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230712-mptcp-issue-368-selftests-subtests-v2-3-c8b174c18f93@tessares.net>
References:
 <20230712-mptcp-issue-368-selftests-subtests-v2-3-c8b174c18f93@tessares.net>
Subject: Re: selftests: mptcp: join: only check for ip6tables if needed:
 Tests Results
Message-ID: <86dbb8d2-cb3f-2889-0b8e-3d63027da54c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jul 2023 12:35:06 +0000
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
com/task/6483413096464384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6483413096464384/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5216775701266432
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5216775701266432/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5779725654687744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5779725654687744/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4653825747845120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4653825747845120/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e32f680f4533


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
