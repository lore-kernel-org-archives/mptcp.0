Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB861FA8
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 04:24:00 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-17683b570b8so15981948fac.13
        for <mptcp@lists.linux.dev>; Mon, 13 Mar 2023 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678767839;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lwj9h4rhu4gG99//adBoqGmpedPej4N/5oyF8LlIdU=;
        b=dJc8IXxuisEsl8aiUQ0fXZesDS6i/JrUCkOvSAUJT6sZE9q/tOmGPyAqfJ9IRDyMaK
         55aCptTTqt4EiAOwINaXE2aL2BlqHPXdIK9Qx9sVoxyE44BRf5gPYE4doHacpvpRV69Z
         qM8F5eFjHS/HfcPCpd3sH1m2nDM+4xGhsZ1NsVBGFGY9cRAnOhL2ZTdAlFiIiElsMnin
         fdB1/ZZ68jbO8zuhEIUclz22c3QAtFlewCjkfhhyJp/t8qrnXlf1rpTIdGr31McjqMFs
         a1ioYaKJZw2OrMjMQX7CrGDHbTACpilr/hf3cnMZhJVzx4D8IwK+wjQGvm/YW3gZ6Skv
         RSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678767839;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Lwj9h4rhu4gG99//adBoqGmpedPej4N/5oyF8LlIdU=;
        b=zo6BtUtRt5ciNLIpwBirXq975F6QTJ9RRImU3ESaCf1uykgs7EAFFgRUzkjOttioyP
         v6Sv8FfR9as4+1kmEQE83MotxS4Jw5Zv9sDebq4F4CW5AJPCaOstOZDFVnKq6ZbQh1Au
         vgKNx/U3G0rsX/6peVih81wizP5gBRyEofzTGz7xXL4W1kxktig0kwPia012C3cKFdKI
         QG0zt+iDlF9ODKG41SvoMXnSYVSjmnHIqFwIAmbBFBqD6UFxNalZr6OochJ3pAc2T6Qy
         QL7NFXfenC5AinH315HkgJPnoMmcFp5jIufPVk3XnXr6PYGg2teFApjt2RfJwxsjVhN8
         QUkA==
X-Gm-Message-State: AO0yUKU4530W8zF5gHOgJ2w6h66j+jH6MxFupqkFivPnvnJp0rwzrBez
	Gwz6uHZLa5OAjeAEJyHaug==
X-Google-Smtp-Source: AK7set8lB+VBvoUFqwT/xy2exCTPRfypLcduIO/Uo8dJE8jcrdGjBCx55gZCFkw1sMbCHuZISHWWHg==
X-Received: by 2002:a05:6870:9a12:b0:177:c303:b49b with SMTP id fo18-20020a0568709a1200b00177c303b49bmr3758444oab.32.1678767839334;
        Mon, 13 Mar 2023 21:23:59 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.174.130])
        by smtp.gmail.com with ESMTPSA id c1-20020a056870b28100b001765b2f6c53sm727043oao.9.2023.03.13.21.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 21:23:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35fc5e7f22966c370c932f134170b0ec5f8aceae.1678762832.git.geliang.tang@suse.com>
References:
 <35fc5e7f22966c370c932f134170b0ec5f8aceae.1678762832.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check userspace mptcp_info: Tests Results
Message-ID: <3d9a0774-e367-5259-0446-f721322fb071@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Mar 2023 04:23:58 +0000
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
com/task/4876870689226752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4876870689226752/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6565720549490688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6565720549490688/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5439820642648064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5439820642648064/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6002770596069376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6002770596069376/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3c5779e08e74


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
