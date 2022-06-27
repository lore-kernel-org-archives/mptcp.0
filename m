Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9123229
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 23:11:46 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id q4so17617099qvq.8
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ynaLbt1u94NbXNogVqP37+StN/iuC+9GKCZaI7iLqgs=;
        b=GNrHU5ycT/RHufzLTqIhprBNhixEsN7ivi9Bzn+KliqR+QlbPFrI8/7aOfYX1hEOxC
         yBW0KTDE6hgAqUbJBwnbZCjTP3T+yXaWJCEgLeinyw+vkQROL5wnpaRDAnnSkFf0JfJo
         eMpbH/j9abPv9Uo0opa1jrGVGIjlJHeYV+UZk6qifR1+vpDuDOB6X5W2nNnC6NEgac+1
         xZta0wlPyXF+n11fbWMWiidUZnIsv8/dg1noxL3R8BcM5Saq8x67nbhWa2oFp84GjEaq
         iJJ/vvH0T95DP467ojkfvXPX1/x1CAS053pXUF1mMN6NCRXMY64SZPROI3qFP4wi2VMf
         R4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ynaLbt1u94NbXNogVqP37+StN/iuC+9GKCZaI7iLqgs=;
        b=cZ6iDd+bg+18S8siCQD5UDYMREEFIQ1ze7Kva1hhEWB6hdYJ+e/JOL79+DnHTuN+Xc
         qkqduza6Z2ofqe6ptfw9rcrrkmn485vl2Glrb+v1CvVqCRVqb8NWbQY27D0sLS1uav9G
         J7STBS68pFH0E09wIKOHIfJue5/iVsRIePTWHZ+duei+xCALXJvothiJFr90eLi6Ge4X
         4qGyQP+BqkjCl86VE2LZir/Szgyk84Icz0xSdwQGTY1wOIXjyq+T8w91JC3vD03HOScF
         iDfGVPRbx142SfrdrAcApa0SzPgdaHGsO4ESdw3VNq7o+B9o76M8RnYiPp/FR1c8Os0V
         YrmA==
X-Gm-Message-State: AJIora8JU/KpNeuPokTQIOixcOpaf8ul0fgfY0mjRXbODYII/mkeVk8O
	haX4LG/c/bECX53k4nWY7TwopSrrU2dv+9I=
X-Google-Smtp-Source: AGRyM1tkDEoC94kvBR9aBucn5/FIbJwlF0O1gPZInMdt6bZycKwFuhVZGN4ladjgbSzxnkIfwFDgsA==
X-Received: by 2002:a05:622a:90a:b0:31b:899:3070 with SMTP id bx10-20020a05622a090a00b0031b08993070mr4095585qtb.470.1656371505109;
        Mon, 27 Jun 2022 16:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.124.212.170])
        by smtp.gmail.com with ESMTPSA id v22-20020ac87496000000b003051f450049sm7986100qtq.8.2022.06.27.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:11:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com>
References: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22selftests=3A_mptcp?=
 =?UTF-8?Q?=3A_tweak_simult=5Fflows_for_debug_kerne?=
 =?UTF-8?Q?ls=22=3A_Tests_Results?=
Message-ID: <0c363905-87f1-d125-7aa5-bddbee0ef700@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jun 2022 23:11:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5662712175788032
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5662712175788032/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5099762222366720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5099762222366720/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4fa12bd9968b


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
