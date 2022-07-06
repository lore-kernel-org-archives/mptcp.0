Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D417E8
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 01:40:36 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id c13so8679743pla.6
        for <mptcp@lists.linux.dev>; Tue, 05 Jul 2022 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=uUaxhEXuO1ag8g+UCSpVJxIiFIegelZ3H9S9P1OUImk=;
        b=eWu9c6mgmNucpGi9ztjPTPOWrpjGA/YQwazrR1m32hspL0LEPOWrDtJK4Ut60/QQVL
         SNIzaHXp63UAYXGkzqFHwmHghGX3ofNPoaazVDzGO6qEsbA/Cl53qVMjbuZHO7mldIDZ
         DEJ84SqkXOcbiHzl95e96nw8BqBlbhOwAqGVzpAO5pMpbj2NAatgSM1MefTnt1OWHo7d
         6xeMZbv5zCdAr1oIcdPLdziHqVUSW0PWKpqEfQLJnv455zJ+SHDGWX9fK0c1lg4DiMoM
         YUo0LI4VPKLCPiQ77NdmcckvN52NME4pphSgU8MPlNzLBLAwRtnBVUS/UoKhG2nqySpp
         70sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=uUaxhEXuO1ag8g+UCSpVJxIiFIegelZ3H9S9P1OUImk=;
        b=T0if1kd0JnsEmUXQExxE2EcozmjtY1Yxjd+QXZZLX1oKh2B6rtw6lRrjQij5Jmsltc
         OQ+Y94IO0EvcQ+cDCqnicCJ4JAoY2BAeEoyRBrNKK0IXUnxXc52IjKdnSWgAwvVC/Mfs
         W+I5wq7IBtR+zgQtJ5TYVPF6/DoqNqFRqF8MfibIJLgHVZfSKh53awr5+P8kDW1hBTgb
         c0I2RelcUhNYvoiWeYv7HdaD71yfgrw+1ND2lN7O6DH+KSipkd2hNc9l9UQzKobC0PHI
         1+CoJtre/yDtJYW9xVWlSrhPpOdwNnO5RLk1S9HXTFpsie0zkyIn/rKOTvXeP/cT9Wvk
         fikA==
X-Gm-Message-State: AJIora+REQ8S1mYR8p1gdVOyraj4dcyaL0jL/S11EiwRNdVu7gfuXF+i
	UcYBDINDVpCrDEZDQ22/l9o8Ta6vsU4k
X-Google-Smtp-Source: AGRyM1uU6MaExzrb+L0Cr1brczZ0jq77QKb5V33JH1k+A3QMUcT+O/pJ+SbeLZOecYF5dYr3px8pcw==
X-Received: by 2002:a17:902:6a88:b0:16a:901:3c7c with SMTP id n8-20020a1709026a8800b0016a09013c7cmr45661328plk.100.1657071636476;
        Tue, 05 Jul 2022 18:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.186.214])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902c2cf00b0016a268563ecsm24206932pla.23.2022.07.05.18.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 18:40:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220705235144.221591-1-mathew.j.martineau@linux.intel.com>
References: <20220705235144.221591-1-mathew.j.martineau@linux.intel.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22selftests=3A_mptcp?=
 =?UTF-8?Q?=3A_tweak_simult=5Fflows_for_debug_kerne?=
 =?UTF-8?Q?ls=22=3A_Tests_Results?=
Message-ID: <06f301e7-4b44-c71c-d3ea-8230b8416ae3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Jul 2022 01:40:35 +0000
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
https://cirrus-ci.com/task/5834940309831680
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5834940309831680/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5271990356410368
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5271990356410368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/153529610b41


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
