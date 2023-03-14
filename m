Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A828E8
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 08:23:07 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id z10so8396109pgr.8
        for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678782187;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh3I1ucX4XyF+SuS1f3zfhtM2Z+eyK6HqBeSGOfICVI=;
        b=RHmUOW3rXqN5Iyc9bY3XM/+zxSfH9Fsn9EdYKW6ZHlGFGMY7Hnmu4Y7YcdZbCTkX19
         sue+caE8NGJa0kjwyAO6b0Q4QCQrQfmCZlUL+zCLdM2xQmMmTqaNkaRdSK1+clqfd4qV
         N+HRJL37u+gp51dPC52wCeNPjluqA/N6GSbMiqUUMBf9sOsZm4aI6ukdQ7l8WvP6cygu
         DdSPSLaJLkd72K25vvxv9OyfKNXGEt8nJRCr99noLl/65xNLsIi607Q/dq7gkChqKBlV
         MUGbqOMnsHiu/AfaCwcuKtUNbaKB8i6+CoY8vsNhQOvbbqGVPFft3G8hcCPyyhACf2QU
         rPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678782187;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nh3I1ucX4XyF+SuS1f3zfhtM2Z+eyK6HqBeSGOfICVI=;
        b=rZ4H4nYlfjNem9o0gyS4rORRBOKphxvlsLZUFGzkeToE474qtj98pw/qxkqSoU8MKu
         pRzdTvixlp/yM+ugmYU57yilI63o8ggzybtcmJOTDP8+qpCFE0r/5VpppkPPuTy+CPa/
         NwRcrQL7SBIQDGi30/V5BcEXbJN8/G1LvptDBBL2mmWFVLM26CsC+sfG/fSc6cgVETO3
         x/13lsOLFEQqY01eNvFumTiAzDLQ91ywu8w5tDerbGcZPIoYAC5/0xpG+T7yQrHtKwHp
         IAsUknAPRmjGTinP+5g+/9XDTAk0uH2i6aWFZegtkFveBxZCCceLHMuBrwjEPG9Hxe1/
         BKPA==
X-Gm-Message-State: AO0yUKXN3NdbArjNaOexRUKL/1v0Q17NThKOjWw9a0xfeZK5lbXq6+gE
	LnjGNHp2tH+S5NKOVB8dF5vCYEmnf+ta
X-Google-Smtp-Source: AK7set9J5SfuU3WeafGo7/SBKD6IO2ig63QGg6PYPmOSSnrEuAIVGTaJc9pcYgNGEECMsWuG/Q4/2w==
X-Received: by 2002:a62:1bc7:0:b0:623:55c9:bcd3 with SMTP id b190-20020a621bc7000000b0062355c9bcd3mr6094831pfb.14.1678782187034;
        Tue, 14 Mar 2023 01:23:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.61.217])
        by smtp.gmail.com with ESMTPSA id f11-20020aa78b0b000000b005d4e89b69e5sm1003704pfd.127.2023.03.14.01.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:23:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
References:
 <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check userspace mptcp_info: Tests Results
Message-ID: <727e7111-585b-8734-c09b-3fec788f498f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Mar 2023 08:23:05 +0000
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
  - Task: https://cirrus-ci.com/task/5885673681453056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5885673681453056/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5322723728031744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5322723728031744/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6448623634874368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6448623634874368/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5041248751321088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5041248751321088/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f55ea4c9374f


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
