Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B292F41
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 23:02:00 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so8843013pjk.1
        for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ziRraKkfu6wkiVusDayHjNfuKCb07+408/ZaErHZ28=;
        b=CXA1Q3DZdjzp5uWMJ+Ph1jo+HGNMSaY4TzlhDUd4JtpqzZTHZPMrC+K50w8uGbKoAH
         6yvG5hTycMpngpkjNHDMweSal3yQPCJUHthXHhqgJ6sXELYglef5TkA6a9vCAj3h2Z6F
         sq5LT8ZEbrPgnHKWHsW05vqyZeoAyd+yds354vow8jbFHVNaXkW/aQKQ6gz0YNk+OVEc
         JVXj8Byw/tCB1mvA2rFyQzPF8idaYuu6ctntJZn3RVmGd9a8Fkjt8m85PYEZW9FgSy25
         aRf20Xe0wTcOUy2BLAbK+65gLox3QOc8p7oF/zFXOsvTOn6Ltqi7d+56LVVOsd2alFo4
         68dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ziRraKkfu6wkiVusDayHjNfuKCb07+408/ZaErHZ28=;
        b=QBRjgE9zj6uDhzBdbaVY3QWIeqOiLvMLtW/VhMyV68qrROSVat0LbNOlRCR10mM13d
         QDT+ZHcq9JhALOq/FTCJyp4iPySkrgPhTGNKVrkw8+Lqs0jYIG63qdtY/sR7bpiRKOxs
         Ucgr+Sm1bI+dBhug0N/DjUEVptxueGZtzIrYizEHK7JGBBvYDHbhvq3SJ2m5DZ2seXoM
         axHQZkgC/kqGxGlZJoWv9+vtn6qyLwNC85YipDYOhp9RYTJ02PuSbILm3OJ1GuHbGINv
         5XdYORYPWaLbXNwQheLPn6chpDIEYHyfK6VURKadW3DBkqNAwmiQ18tyBv220bhHlFGv
         O4Bw==
X-Gm-Message-State: ANoB5pkFe+AWuEoKeJia9fp6RJntj6tpvWJrbSMd7BJ7UldX/vgDyQtU
	qv0NhHPQ3REbYDO62FCFAjpeXOs1A3x3
X-Google-Smtp-Source: AA0mqf5TAXJK5GmuMSM+ogf3sd/wHLxxPlo+bgpwQ8+NzucEXC3Gkda/FidUJ1uLfhOm0ohu6tpZPQ==
X-Received: by 2002:a17:903:22d0:b0:188:b840:deec with SMTP id y16-20020a17090322d000b00188b840deecmr33706094plg.15.1669417319554;
        Fri, 25 Nov 2022 15:01:59 -0800 (PST)
Received: from [127.0.0.1] ([20.253.128.215])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b00186b55e3cd6sm3969117ple.133.2022.11.25.15.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 15:01:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221125212028.702058-1-matthieu.baerts@tessares.net>
References: <20221125212028.702058-1-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_add_subflow?=
 =?UTF-8?Q?=5Fv=284=2C6=29=5Fsend=5Fsynack=28=29=22?=
 =?UTF-8?Q?=3A_Tests_Results?=
Message-ID: <73769675-6b6b-2b32-5b41-3f09827c5f6e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Nov 2022 23:01:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6342328210685952
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6342328210685952/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4934953327132672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4934953327132672/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bfd8d2dba6d0


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
