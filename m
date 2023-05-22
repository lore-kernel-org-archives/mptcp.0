Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE1171A9
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 19:27:52 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-528cdc9576cso4485812a12.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783672; x=1687375672;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29ideY57y1+CgiQTqMnKz/PPfHvJ7TmNAzhlK/a41FU=;
        b=kUZss/rEMO2LtqVf44gKOO+3Zolv1LM9mT2Ap40iK4KdSTYnJ14DaHqrABCuAGASUU
         lLvbXXkbr0TQf3/aw3Z7ZZ1Sch4ZPLcmzWBSdZ5X5hAGdCbR7gAOH9pVcgcfv70EQ6BQ
         sS4D1woN/+w7JS+KBcCrYS5m+ovSiC6XSIZHsQhMnLWCsYYAVFxgq1pV7Qi60EB2ebSi
         4V6iF4LuAuN2OcmlDzQlYv5crDdolMjbqEyPeIOX/mOZvYIatlIkrX3DGC0QWeX6fh03
         PMLWx2aTqiWa3WBm3WMv6PIFq0JXqMyfUR8L+FZiSn7JJFbEIlWFcIMkVqM5nd9JVn6C
         rxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783672; x=1687375672;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29ideY57y1+CgiQTqMnKz/PPfHvJ7TmNAzhlK/a41FU=;
        b=FEOTgn98RV6LDXscm/j9yZXYoojL0NVPqZA9oqonjr3CBUe6JShMF5bxjwqGmEkSSt
         TysTYIPE4UMJAWdYFBQuUqd6A8qkS6luQ9PgOgcelS4zAKU2MB1y50/TRiz0YKe0Im1J
         pWwDx/oNNVYyk/OCsYlgu7EFWOcia4wXx2PPU1m0LrApLYc63EiurRecRQn+yICRCQrC
         dQSFrOTio5xed5OjoscG3PIkfzAdqmZzKw9cEBnIyL2lctvFm92wVd5Rf1bx+pLe/+1R
         TpZ+9REUa+bAKpNYFfW0eUku6RG60bxWUm4EIEFgrSLC8l0RFlSg9mMzOtejSPQmP3fe
         CS+A==
X-Gm-Message-State: AC+VfDwtRoIs3H78th+ZBCXm6ejpDOEw0bopjQfQFz5QM9lWdXY/CZax
	qwpfKmmhEqJbzNG2ag9PVdKClFjyvQLI
X-Google-Smtp-Source: ACHHUZ4yrMR51FlgQW/dNaHsEuWXKJ1phDisVifkuSIBCxnoYzaRxi15cQGjsECucS9clf7PhjR8QQ==
X-Received: by 2002:a17:903:1208:b0:1ae:b38:b6a with SMTP id l8-20020a170903120800b001ae0b380b6amr11949745plh.58.1684783671606;
        Mon, 22 May 2023 12:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.227.50])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b0019ef86c2574sm5199151plg.270.2023.05.22.12.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:27:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-37-50313e4f83ab@tessares.net>
References:
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-37-50313e4f83ab@tessares.net>
Subject: Re: selftests: mptcp: join: skip mixed tests if not supported:
 Tests Results
Message-ID: <8a459941-cc7f-1f1e-6568-61f75a3bfc8b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2023 19:27:50 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4875564574572544
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4875564574572544/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5438514527993856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5438514527993856/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6564414434836480
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6564414434836480/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6001464481415168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6001464481415168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7220c4c22b88


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
