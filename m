Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CC515A1
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 01:42:03 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id z22-20020a056830129600b0063711f456ceso12969973otp.7
        for <mptcp@lists.linux.dev>; Wed, 24 Aug 2022 18:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc;
        bh=ZslcneDeKFcHTL502DnlO11l1a3W6gNCwHcX18X86Ec=;
        b=Vyi82MBKn+C4+aQ7w9DEKDuE5DKpPhDo4efzikCnhinZJodgcl3z+nWLLx/D/YtQg1
         U6RaSAVC7DxtdZs2A19fNmd+xdEyJ5tgJfn0LEBv05fn/Kr6aeCLAzz2dur8e2qgnJnd
         TW4g59KuteyIoNd9mQoh6Gd7LH/OVvxPb9RPcTend29roFU198ejDbfeX5ZWJEH098y0
         gTnv4oYNI1UQYtvz9qP5A4mkocAZSJxl3SYGjv/gXxJYN5jubf+oYmvuAxdpZqiS50MR
         u7FBl2KCfV2ftheboQUt6Oh6quIwDEFBFlznody4keMlmQ9E0vb8mdCxAaIpwvRMxnyJ
         QAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc;
        bh=ZslcneDeKFcHTL502DnlO11l1a3W6gNCwHcX18X86Ec=;
        b=diTvRB+hGPwTDw7elsoRWpMOHH6EU41dG7wZcQdRyqpg+R0nwro3fRMZgviepXBKtM
         jC2mAykxwbS3GsOzZyr9WnS8PJTe9ovFgJGoMp4di4VdDF96w0lGTNCGPSPRAffM0DOC
         ZFoYumwaqe5u1i6dCVpmlbdC8BkhfTvq4URplOk2M2GTK9XmLDUI6g66Cqvdok/5T04k
         vLXHPLonB7INuzeyrMEcfKVp1CQ3sr7dmVVO+xxrg0LYW+omMVzzkNrbArHNXyMVT41A
         JQvzafh/8weg/j9DY0CBc7wTePl6qTw4GkpOi6Uisp5zqNjQIxZZ5FrhJ72hSGnDnfFN
         HTdg==
X-Gm-Message-State: ACgBeo1QAJ48TJO9L/4riUJhfftIADV81GxEvESdcsX8Lrv9OjLCgghZ
	U9A1MfxLv+kI74t3a6m2Ig==
X-Google-Smtp-Source: AA6agR6CrajUDVKhZfw9a05ESJZCoIdOKXkeAt6/Tky2UmqL9COUYkpV5H1TKz9iSZAdhavKrvfV1Q==
X-Received: by 2002:a9d:6452:0:b0:638:8437:cbb3 with SMTP id m18-20020a9d6452000000b006388437cbb3mr561210otl.194.1661391722498;
        Wed, 24 Aug 2022 18:42:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.31.229])
        by smtp.gmail.com with ESMTPSA id k24-20020a05680808d800b0033a37114eb0sm4410844oij.19.2022.08.24.18.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 18:42:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220825001830.1911524-1-kuba@kernel.org>
References: <20220825001830.1911524-1-kuba@kernel.org>
Subject: Re: genetlink: start to validate reserved header bytes: Tests
 Results
Message-ID: <bd44128a-a428-696e-a258-0c52b21c147b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Aug 2022 01:42:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jakub,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5922836496777216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5922836496777216/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5359886543355904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5359886543355904/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3265c4de38f8


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
