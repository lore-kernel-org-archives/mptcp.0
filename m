Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40405747D
	for <mptcp@lists.linux.dev>; Mon,  3 Apr 2023 18:04:36 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id l184so8939402pgd.11
        for <mptcp@lists.linux.dev>; Mon, 03 Apr 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680545075;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7MKsNqlcSbEFpcbHwwheox2ryqdmoWVTUOhPE+Boxk=;
        b=VF4gqWUeaNCYVrzxTVqx8Ym4hIssHkH5wWkLP/pyL489V20Ajfb/phXfsEckvPIJhF
         NwAuXY+q3TsDyycq5Rd2yWiZJ8X2zNPqVrYmG/bwRumwr3ADqnMb/TdSXuihHfHy3ha5
         nFz5t2ykm8NVEb1FjNbp2pSq3Arw3beRadlVNaLIHKkPwsXEtYzm/7D7qXBssJrBTwqP
         67vV0kwweTWSlKZxBPgN9mC2FGtX717nGfnNNrsimqKQWGoW8t3tfJ2wyUlVxVpKZ3jJ
         XaVg3fdJFk06AW7N82NM9svUV5JJWMGvsocgWUtEBrKF0sP0roNXp0tX33uRpzsbG314
         KNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545075;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7MKsNqlcSbEFpcbHwwheox2ryqdmoWVTUOhPE+Boxk=;
        b=gN9Ql8Smi4C/9CBhRaw1SEVdEpFYA/w8kCdQp02h6Ix/G8L4Wp0xYYBoNDaKG52Lea
         wPT/bfM7OT1chQdJPsxzDkVuqJr5M4DFMteIy2JFgNNJO2lqDadMOaPe4VJQ7zdD2mzc
         YX/hg06sGklHogXkJc/2qjlwOCDZhqgDuHpmSvoxrv01Y+g2JJJdfZSLeQGx5U3/9Egk
         l7qLVLn4fKZLaQWbedrbrg8f6H/ksXZuJ7UwJVJhnT51GnS+t9BMcyPyk3NLteCdt4LL
         PkBTY2DYOJf6Yw0OQlJwcl4iaIBwyLiXd2QP/mO/Ng2jzwitW1cCUXoUgXo8joPwD7Nb
         DmMg==
X-Gm-Message-State: AAQBX9dxm8rOFIwF5JKWLqy2EQgW2wqxv4X7fQalpxjJUgpO4NRWIqBh
	LYyDOtnaMoeaf/Y02B4j2wy8vFhh9w==
X-Google-Smtp-Source: AKy350bZV3aobjP5dtulgn63nEu/bI3jm9k3eria5jyCHAvSuq2Ic8F3PFfkXuruQ54RmQAb7YXUMg==
X-Received: by 2002:a62:4e10:0:b0:5a8:aca5:817d with SMTP id c16-20020a624e10000000b005a8aca5817dmr33688442pfb.5.1680545075478;
        Mon, 03 Apr 2023 11:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.87.21])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b005a8a5be96b2sm6380424pfo.104.2023.04.03.11.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 11:04:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230314-doc-checkpatch-closes-tag-v4-5-d26d1fa66f9f@tessares.net>
References:
 <20230314-doc-checkpatch-closes-tag-v4-5-d26d1fa66f9f@tessares.net>
Subject: Re: checkpatch: check for misuse of the link tags: Tests Results
Message-ID: <8cdab9f7-a97c-55cf-f39b-92ece32bbe29@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Apr 2023 18:04:34 +0000
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
com/task/6018756900552704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6018756900552704/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5455806947131392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5455806947131392/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6581706853974016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6581706853974016/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4752119505354752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4752119505354752/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5055c32bd437


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
