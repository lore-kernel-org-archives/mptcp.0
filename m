Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C1D301
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:38:15 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-75ca95c4272so7648485a.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685007494; x=1687599494;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIxKtW7WnP0jsD2Er2tJ1vZhqHWZG1Waq5O/sSV1Kno=;
        b=Ek5VQmzTzAVk8Jr6xYTujUwaWNPSQA/TGJGpVeW2z35MOj5/0tf4PFSYht3ZvQdZNg
         054GWJxZd3K1q4bNCqtigys8ZMD+6DdQ49N6NUblpF7l4z8rhvRajvC+1o+J9UxoJNTp
         MrXaqL/+cbSuTtzghxfoWXZ8kmi25ud7kRqEOgqSV8daOj5YAmSg+ZNjzCrow8vlkPuM
         QyvGI0m3jMOPqKd2E/zaSwJykZxeycQ7nMcCECQkoDsLm8tZW2AO0KlTv2vie+I57WuO
         WpCBNg+v9osA0pByO+Ne1n2chOAtgqpHjhrNG4LnXFiHLtZLSuYK5Wj+9W6Q65DU4Jsq
         ZzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685007494; x=1687599494;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uIxKtW7WnP0jsD2Er2tJ1vZhqHWZG1Waq5O/sSV1Kno=;
        b=QKgvZJVrN8hNmpecNIxaydHj/UBuoJLU8ZEqttXdksHZL/aH+mZEJAwMN98ijxO3hU
         J9/PCGxyROyJAladrWTIEWEKcHuUvG/8fqjXPDegSxbzudzcKlQjrtPlIjF/kum3MZvc
         WQScpk/jnJPFeog3KlsJvJd35icykwUYMsF//hc7sHntmuIo0rDTjhuCNP9a5DuQCZeY
         OIEWAMekciUV8Lm2BSlgj7llzbhm3izr9ZJvLs81K5FGcLlPobY9vy/DKxATl5piGET0
         dbInu/91IMqCYhHEgY43N15YhRak61pSfDvnuWOHO7uiGZhgFKw9W9hHKVV7T9UycPc0
         2+SQ==
X-Gm-Message-State: AC+VfDywr1BtqlksqL9/BqqJ014dDTiw3yDz+XY6t8j+aQ+K/U2Vyx6D
	uks7JYeBzHxOvkMY1O6gfg==
X-Google-Smtp-Source: ACHHUZ4OFMqtJ0YaMiu6TlyTHH5iWNGLDPp3b/1cCdKb/jz8DdtbW99SryowmOIdq5IvcOp72wQABA==
X-Received: by 2002:a37:a914:0:b0:75b:23a1:8e3d with SMTP id s20-20020a37a914000000b0075b23a18e3dmr9096804qke.14.1685007494630;
        Thu, 25 May 2023 02:38:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.22.48])
        by smtp.gmail.com with ESMTPSA id pi27-20020a05620a379b00b0074ced3e0004sm261180qkn.63.2023.05.25.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:38:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <05ba1107fa5edf988fa07856ba359d73bf51f54b.1685001897.git.geliang.tang@suse.com>
References:
 <05ba1107fa5edf988fa07856ba359d73bf51f54b.1685001897.git.geliang.tang@suse.com>
Subject: Re: mptcp: unify pm set_flags interfaces: Tests Results
Message-ID: <d95dab44-351a-157e-a122-23f1c12f1151@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 May 2023 09:38:13 +0000
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
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6347681895809024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6347681895809024/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4940307012255744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4940307012255744/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5503256965677056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5503256965677056/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6066206919098368
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6066206919098368/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/34a2a3d2695e


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
