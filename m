Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAC20F7
	for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 14:54:57 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id b5so6678674pgb.6
        for <mptcp@lists.linux.dev>; Sun, 23 Oct 2022 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+VnWXyRNudKkpaNxqJoE4fXY04IdHVeQn+KYmPxFG8=;
        b=MtpVw//TbMW5/IXQ+z6/or7ekPXeeVMrMNhOiVkL1GJoRmMj/mlBF8FiSaRaeMG77e
         Aw3Jo0dbS6owTeZy4sxYrd555XqGVNpClh02quon1VGQcGp2K/0w4fe18+RDlWrUYmF1
         Pe2y7YMOEqMkm4roSidpjcj7uAamkv+Gv4ywvLN3wcRiM211Smdg/uhth1GArR+jed30
         T1sL35CMpJE0FCvS0Y1tTOYGXcW4UbQVprRj/CtuzVxAAK2uV707R8bRo3uZv1LAWswI
         nkRg7VOp/SpTDyEhyhJJyfztATJahZZrn8DzkOUcyCVpMmyyKHyZao7FWQ6P+SrjT+ZX
         Ptqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+VnWXyRNudKkpaNxqJoE4fXY04IdHVeQn+KYmPxFG8=;
        b=od+9b9rwWsBbRxALGi9juwTCOsStC5P/ZeytXa69bi7SZFSIfd//eJ58WS5HOKnEiM
         573/WIB9UJzL5YbU+FfyqG66lKmNTJ4ilBFNZGKCL8y1WAxLBX7/5Ove47/0eySOC6ZF
         ntmmUBOwlOHBgz9owGW60qkY6qaMuyR/QZEzDj39uD0j4mHpjmgPAh+7Z3hXpP3u6A1Z
         mTfKbLQeCmYNIRk3vQitckshRzI5k/o4w3fhW8OC68P59PBCT3KdRafhxZ+PHwEt6+Fr
         NB5KVpRlqUwFAiTXM1hCI9FO+Uc0GOVeuJ1Aunuhhve+7MYg1cE4F97If/hT1+IBm83/
         USQg==
X-Gm-Message-State: ACrzQf3JBv4X5eNuR973LgHrYcJbgttCsEmP/nlOdry2489D7LkTI0vo
	wwQNqEyMNUxzyEu/EO4x3Q==
X-Google-Smtp-Source: AMsMyM5YhcOf4ID+z9TUMSEai4x6AqGLMDkt5WCYxEyiHeFMYMx+Fg0rgzgKq9+YKNw7CyUZcMqoxQ==
X-Received: by 2002:a63:dc4e:0:b0:46e:acf4:7589 with SMTP id f14-20020a63dc4e000000b0046eacf47589mr13771429pgj.170.1666536897136;
        Sun, 23 Oct 2022 07:54:57 -0700 (PDT)
Received: from [127.0.0.1] ([168.61.0.179])
        by smtp.gmail.com with ESMTPSA id 1-20020a620601000000b005626a1c77c8sm18304548pfg.80.2022.10.23.07.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:54:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221023124831.8959-1-geliang.tang@suse.com>
References: <20221023124831.8959-1-geliang.tang@suse.com>
Subject: Re: mptcp: get sk from msk directly: Tests Results
Message-ID: <0818ecad-641a-f981-e1d1-31d2f760c488@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Oct 2022 14:54:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5530777696862208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5530777696862208/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6656677603704832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6656677603704832/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/38acef14684b


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
