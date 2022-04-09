Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914B621
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 03:19:50 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id x16so10009945pfa.10
        for <mptcp@lists.linux.dev>; Fri, 08 Apr 2022 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=+FDB8heTspOGw0+fFBpAmPBYAkpuuo+Hr1kpqypt9Hs=;
        b=bkptKEIJVhiXmPAwdm2MNOIxtakdzldRmCoaBaPXuyZ0fuj7ZnXepNqU80AJdEmGUF
         GWCXOLsk+pO+LSKrsifkx0qaLj0CDfT8s69leIGqiP9M1vBRO1/Nj/wZz0eIvC1Hk6Tl
         copbigasw9dHNq7W877/slYN87WoQMOWyYgX2i3VLr5ReX3EUNykO/9cNsL6X5sPQbnA
         bTaHXKYVGLmh/s0TBEs++m9btaRjp+Vr2cQqPROYT5p55KwoPv7VOKn6y/bhd1TakQBR
         4CQzBIVkcL3pMJgQP1hFxe8Wy9Vx4FpiO4YA3PnKE366fxkKAD9hrvf1orxQ0F+1mSEq
         2BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=+FDB8heTspOGw0+fFBpAmPBYAkpuuo+Hr1kpqypt9Hs=;
        b=uq+WhpTTQmTBncaswGA7cRQOBoXzRXaSBXqcl0in1U0vyME7+2u8AsYhRf7xZYxqgP
         NYMFBkcTpNoql9aQJ31YORSAVsORC+6UeU/SG9m0HNBiOqY9MIcuR0dIU/X8npTHAXkD
         tIu+z4GjZof71r0pUOrKKVWBXiqwNDGprBQ42GGiP+crAs6wDFJCoKeCLdfCbooAXzf/
         ahcZfFWXnMppYRV5DsLgOPN0e9qUlbnGnhAK5mqdAI3mwG89q2cQ5keM+cA+TT8aAhLl
         pWmFw6cuh3t/erR7y3i1D8uA24Zr+aZIgxHRUXQN+qcfg96u7FJ3CHQqb0RvFoSUBiwd
         QK0A==
X-Gm-Message-State: AOAM5324jvlNdy59+F+UczRcr8+PnLM5Am7e6dA62FAUkBqtCVbme9T5
	9IXcLRBgjCXOBpLkl6tDtQ==
X-Google-Smtp-Source: ABdhPJyic1NC5zxlS7opwQvz4FnT8V8IL2GoKxBZNfAZ+rQiki/8sHGaQxfol9gprvD2t0ISCi1RvQ==
X-Received: by 2002:aa7:88d4:0:b0:4fd:ad26:c52f with SMTP id k20-20020aa788d4000000b004fdad26c52fmr22360237pff.25.1649474390426;
        Fri, 08 Apr 2022 20:19:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.5.198])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090a02d700b001bf6ef9daafsm13493814pjd.38.2022.04.08.20.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 20:19:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220409013825.1877395-15-kishen.maloor@intel.com>
References: <20220409013825.1877395-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Tests Results
Message-ID: <2ba496bc-8f71-5499-1d9a-f7dfce8771d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Apr 2022 03:19:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5254733618216960
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5254733618216960/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6380633525059584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6380633525059584/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a726917f504f


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
