Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FB184F
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 05:13:54 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id i4so3152993ils.1
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 21:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EhImjAw2zBVgri5hoW0Ue8xrscfJrDmEugbD24R0Io=;
        b=e/HXz1TIOEGvhgBm07mNgC+Fnxw68hmg/1VE5TZSsuqy6njk3CPUPJJofziNiCnyGd
         lwDIkhqf6k17HP+gP3pqLis8cF+D0oUXWLsNrdLETcO7DnDPWCUHD2UlBVB4LWHVQBHy
         07LK202jxb5QxlP9Tu5wcizxkHPC8uzakBNFX7bI2MTC3t3d2Q6VZeCu6xT0OUorXb3i
         IEJdg3rVLDE2pULqZaogLP6ei6jmYqlB+vsMBAlD+/3dKACiTLzYqTXlqDFjAPvW5r9R
         ddOMp2uvKY1kHaie9ujwzcqqs0omGlpuT6iuDgJoHmCUJWM6QX4DtRHz+qxLwafRA+z/
         DEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EhImjAw2zBVgri5hoW0Ue8xrscfJrDmEugbD24R0Io=;
        b=A22kIq3wJtkiUJwUkFkiUGy6orvWKSU5DFJyp90l5xq+GLKou0CE8XIdD7iqADqEJO
         q8M3Zul7QYZiBdHUQP09z3ZzjZWFQDpVKdrt2BJVwBHeGMox8nbjcBhs1mU0yKCVSxD+
         YPSbqpCxuLAgXLv+Zl01RXSefEwe/3E8YWcVrgij2f8W/cEieKqIaIA4lSN2wQOQD6dJ
         jxy76JQY9g+kwM/toLFAKiS++bpwFGDR8D0Ldgia1DV7FKN0I3vNiAgLhidD1chc9d+e
         YQ8XQDPvWRgKe2S8XJwsEUsUTKCnTG9GnVaL1WvN5K4giLVR1dvn3c2rCnO+0erO+RWM
         gQHg==
X-Gm-Message-State: AO0yUKUBvOnPcSt7XJK0G5eGIysP3NeTIY0MCTx+07W+xfgF5Afrryll
	6k5AeByaVVant1FzkoNJCg==
X-Google-Smtp-Source: AK7set/LO+V6/lB3hN/SuU5xuOHstSMUh5GrZXUxRkQ2kxW6pNL3012obExN3PlZHCtGmZShXWPNmg==
X-Received: by 2002:a92:7602:0:b0:315:3d99:bbd3 with SMTP id r2-20020a927602000000b003153d99bbd3mr8132838ilc.8.1677129234055;
        Wed, 22 Feb 2023 21:13:54 -0800 (PST)
Received: from [127.0.0.1] ([13.89.2.161])
        by smtp.gmail.com with ESMTPSA id b15-20020a92db0f000000b00316ecbf5c30sm1022297iln.45.2023.02.22.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 21:13:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
References:
 <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
Subject: Re: mptcp: add ro_after_init for tcp{,v6}_prot_override: Tests
 Results
Message-ID: <2bb08380-8f51-e274-5aeb-d87669c93c7d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Feb 2023 05:13:52 +0000
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
com/task/6402467986931712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6402467986931712/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6077964417236992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6077964417236992/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6067056542482432
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6067056542482432/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4587090856378368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4587090856378368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/493e3c7b7981


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
