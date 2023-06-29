Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A80FBFD
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 20:32:47 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5704ddda6dfso11426717b3.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688070766; x=1690662766;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrLgzVnq9L5yHrIbPo9Z6mkp7xJNDuGIoe/Hpyk7s5U=;
        b=Xhh/UR0kO9P7maNlHiUBv151NJ6jmrQA1CdZzGm0DE44L4r1PItG/5Ab+BxAJkbTxY
         LjSD9LYwhx6AR2W67wtjnxjl+I5aK/jHqu/3+9k8WoLLdX7jYP5MrOQ+TwIMbX8nJNpF
         Ax0U5mvEXtdUQRnqoUoqJiZED9O5StnGB9xaeqkqYyQhSFZyo7jLEBn3jGCuZKku+Wzi
         vzMWXIzTZv3nN3XyIrODZCraCFF9GopbqIa0TSq2/1ryqKTaEeA0bQatxjqhqxl3mIwH
         8lnPU9TZ58clmDCv9T+ZbthB9pCdMKkreDUj7MyKaLjUem8Epa7J8KcoDPNi+7mztfJR
         rZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070766; x=1690662766;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrLgzVnq9L5yHrIbPo9Z6mkp7xJNDuGIoe/Hpyk7s5U=;
        b=jQLEnS//JWMiQ84NJTBgSEJdfG5/K+SseR1nhSkZhgyhUco9Zr+RTugyMFEVptOIhq
         l6VVNaIVwNmfxOrqxKRBDjwXkRc5qS1mUU1mOwa4U0N7/cnqgvdmgN6TmjZxMTOPeGvz
         ZcztunC+n1CPhxVSKYS92XryoxCL4ltxyPIG2UGR8y7C5VEsaWxNXtN+Ov8ne44BYQ2n
         Ao7n3HCTkDKhaxihwDnb5BxqubOCOZFTb3BXmh7tC/Xu08qPPmCzJCUtNZW+wwcR2P5E
         pQqohVLhuU0RUIhf2FU0eNvQFWlk588J1ecWGy4vo6vgwA8k5OGFQVljSfQ1bGch7ATM
         vqzQ==
X-Gm-Message-State: ABy/qLYRVaJb5Fpwhb5Jp1GQjcEpwQK9vs/X9MHMWuYjXnJ4d0ylWASE
	ceBNjxn/GC4inKAgQV/baw==
X-Google-Smtp-Source: APBJJlFUau2gwK8htiBHBZsveTT35LnbIy+H8Oz9kRtv36hr85aEx7dKoxRsIkVOpcUSMnEL2C+Pvg==
X-Received: by 2002:a0d:f086:0:b0:56f:fa68:2e34 with SMTP id z128-20020a0df086000000b0056ffa682e34mr470923ywe.35.1688070766292;
        Thu, 29 Jun 2023 13:32:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.137.187])
        by smtp.gmail.com with ESMTPSA id fz22-20020a05622a5a9600b00400a9edf297sm1166370qtb.26.2023.06.29.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:32:45 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5276902ce9c5492bd2029fc3b46bfcb927afb18f.1688004307.git.geliang.tang@suse.com>
References:
 <5276902ce9c5492bd2029fc3b46bfcb927afb18f.1688004307.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add mptcpify selftest: Tests Results
Message-ID: <78ec21d6-6f72-1709-5a0f-2e50b08b2142@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 20:32:45 +0000
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
com/task/6390325636235264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6390325636235264/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6576252639772672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6576252639772672/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4982950752681984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4982950752681984/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4831537535909888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4831537535909888/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b4e806c4ee0f


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
