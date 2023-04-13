Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735133CC
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 10:22:12 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id bl15so12684326qtb.10
        for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681381331; x=1683973331;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPjaj6XKRQy03v9aa5B7DmzNbuPWngmwfxxMTbaRLew=;
        b=EjV8y1Mr2PF1neAXhPnPY2ZneMp/Os3q41KEz0IF1pV4OXDnn2JZ64iPTmSG/jXQmL
         0eltdbCVDLFpd5xE327PdPhavnQ/vjkN1Cn9laVVHTq9pdORRiaqU2Q/hW1/++djLKHy
         iocrZ0QaJNcUuQ0C15g3UqFgDfT+UdAerB0qEe05er3kWw4MZ8WJPLCRvjJAghR6J00T
         h0ibYDyHaGW4ftXFuWyGbjKOW+hmqwS+Lvk3Cb8x7T0XiTZNFneRgLRkNLdVtbRzKFFl
         RGWRto25Wl5PqDfnjCRRuZqL93cpfE0ecp09LnmhmEgZHqATJ87GGgJ8dhtExU5xCUZK
         jnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681381331; x=1683973331;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPjaj6XKRQy03v9aa5B7DmzNbuPWngmwfxxMTbaRLew=;
        b=QM+wlNPgQoOH4FSJ5FWpwqepO58BYIKRMs2sOt/5t/Zqk+VGAshv6ZM+fOlMRJ7udL
         4WQFnQ3Sj9duxfvbDd3p75n/Q8zHj3Z/vzNNYFULBufiK8KbYhYKbJAx0/9q5KDU62oh
         YbwgjQaXM5SL5Ei1jbfi99RrurVrzO+KI9jBytIejhigj+HpDl4ILKFYhlYKIG+wMc8o
         EaVVxRjCrlhSKANI8sIRTNYt+BC9FhiDlyz0g8kS+VFH6tr0+x2hX4LLjqG8CqAD3HcJ
         1F5qiPcg18c/NKE0hMvK7UawHNnhctyQmSlD974BNl/q2Jf13M/gw8GetUbykbxA6g+M
         GtKg==
X-Gm-Message-State: AAQBX9dKcXwqYAykiLkyorsZSHMEc5boPZEoubIAGBr7GfBHrZPOIGfl
	/wZ1aSy6ZSA61OQv3pIhlpFs7PJs+w==
X-Google-Smtp-Source: AKy350YVAtQ/E/aRvBipUYvmhobzSV8NhWuQZYmWVO/iIaif1XxyJAP/+1cyNSoQmzkM7vrXrjNvow==
X-Received: by 2002:a05:622a:4c7:b0:3e6:365c:2bf8 with SMTP id q7-20020a05622a04c700b003e6365c2bf8mr2440654qtx.47.1681381331544;
        Thu, 13 Apr 2023 03:22:11 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.200.52])
        by smtp.gmail.com with ESMTPSA id x24-20020ac87ed8000000b003e4d5d4d623sm389530qtj.11.2023.04.13.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:22:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f22b1dcee050479ba19ea7b8e95a04da2c30acee.1681376983.git.geliang.tang@suse.com>
References:
 <f22b1dcee050479ba19ea7b8e95a04da2c30acee.1681376983.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check userspace mptcp_info: Tests Results
Message-ID: <ceed029d-29b2-e075-eb12-5e3b63521f78@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Apr 2023 10:22:10 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4911013565300736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4911013565300736/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6036913472143360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6036913472143360/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6599863425564672
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6599863425564672/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_add_addr selftest_userspace_pm =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5473963518722048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5473963518722048/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/23944b8cb3c1


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
