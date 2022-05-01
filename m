Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705028FA
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 15:37:53 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id l15so1351872ilh.3
        for <mptcp@lists.linux.dev>; Sun, 01 May 2022 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=9KyvwSmnGSOydS55mAh4gRqiMtuxrBLu4x6p19wwfs8=;
        b=d6iALJA2csIFbOdGUAZZbxb8P/VXjZlWnNMo79fDyoCerbTgGuYlIJKGmWv/3Jiw+4
         rbZCo+0cEPza4etFjTquNToOnC9QGffBW/0e4dk98kgxKX8pKdGPUckTfdl2OskUc5Fe
         gNC4psr2d4nbhEIn8DpZ45r5YywAF9wKE6G/kwxk6ojuNzT2FIm3yP7Rd8KxQx5G0H+w
         qIqAf0IxMoN7IGMDo+4rQjo9xzQrlDQfAZZeEbai3kzmoDfOjvvQJVMbUtMidlE3wLsj
         R0QYERxxS7AkdAyTaZc2D9dT04OZvmsLw/zJIdOU2Df5hslCj7Duymk9A98RZsYkyEjB
         0R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=9KyvwSmnGSOydS55mAh4gRqiMtuxrBLu4x6p19wwfs8=;
        b=ZGGAAjdsSa1VnGBWwQ2g2zI0ITev+dB96XIyWgB3/ON5P4LT9DsrYTcWGWIWppq1jh
         vaFprgzglSRU5LQvpxROXHBvwk4ZPYlQtGz9POyJDGsYliVD/PQAFiIRpOZ5P6ZoVJa+
         ZJ/8WZzXaCU+3q1Z8DzQpzMnCxYh0+X74ppokRGLmZ8z5/Bx4d7XRyF5JKUAzUZ3Nk5g
         PW0XQS630GLXIM32tZGvWAckVngeZpgZC6q3YlBBj4XOLFSw7c36bk1VV/KsuLBwfqRH
         ErfuMafwItQHPScfyVOWjOQARwY2sUAzDFBR9vrqOLSFWxF/rOcsgW7Ndxo0C6csGiLR
         cUEA==
X-Gm-Message-State: AOAM533cWjlfv4DViOaP/dzURGM3hotb0gXFkrmjvDrdmjaC11H3/A88
	Zt8URHPB6BA7+TL39NlbHg==
X-Google-Smtp-Source: ABdhPJz9yTpBN7k+l99wsxREuqOySr/XmU3rcl89pIT9zLNr/rwKx2t5pMuiRyrI8f23q6GPEUwf+Q==
X-Received: by 2002:a92:bf06:0:b0:2c9:b21d:6db7 with SMTP id z6-20020a92bf06000000b002c9b21d6db7mr3138156ilh.222.1651419472915;
        Sun, 01 May 2022 08:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([40.113.227.0])
        by smtp.gmail.com with ESMTPSA id y13-20020a056e02118d00b002cde6e352c4sm2051095ili.14.2022.05.01.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 08:37:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2c5bd5067e0d508dc5e677da3848d6aa6f610174.1651412613.git.geliang.tang@suse.com>
References:
 <2c5bd5067e0d508dc5e677da3848d6aa6f610174.1651412613.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <87d46bd5-fb58-8e4c-b494-613e4d9024ff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 May 2022 15:37:52 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5827059619463168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5827059619463168/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_diag - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5264109666041856
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5264109666041856/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cfcd857eaf69


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
