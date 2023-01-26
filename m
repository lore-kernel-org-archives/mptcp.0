Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23411538D
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 22:24:23 +0000 (UTC)
Received: by mail-il1-f175.google.com with SMTP id g15so1415639ild.3
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 14:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdnlrTLb1cSpzDA8MU/yIoKI9nzkw/UDJDUHeudOVLo=;
        b=OUpG82NWOpJqYYQ/AyTk4Gi+ClVFkinJJ/bhymZarfRlDX335BI5kmLvKRoyifDk4q
         ew7Kbj46kgyWxMs21bNw4cMU2r1397l0fWSED7Yb8f1mSu4geidHjRIU+bZRbvTTpHKv
         pj94WNQcPSxVFm8+EcK/LZYyxGxUbFFCBpzCvlK+82K91JGAu8zog3HVVUaR0zNzvQQ+
         yETLZ83gPK7Sv6D75PEmYqxMc1DORmk54v9o45BmDBmYnroSurEJjzLXfdhLXcLcBwL0
         4lFiLkqslto/p0R1LKfZsSpPV07sghw/c4f6Zl+TClqSGk1nl4x0r1OtOXDhG4bnvY1i
         eBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdnlrTLb1cSpzDA8MU/yIoKI9nzkw/UDJDUHeudOVLo=;
        b=HkIKUPGORBJ0YNi6fwOZsseG/Z9s/EgvltfJaFGZ8VP4VNXz7Mah2Ieh5lhV5lC5QO
         cQLh/be03UonsaFUNUI9JZZb0NGmLB+qBARAEUOpAQjk1RX+x1b5umj4/nnfGp554tSE
         KprIPBRtFM5yjpm6NSINL3CanzVGgKkAc2TSp1JPLum2hMP7QgKeor7P2JmOFbgk2GVi
         3edJR0b3JFhfQj6khNrV08OGDL6x2jnwpPPPoBKzz9JdD5DHk2kSoN13yntvPPB8rLBG
         xj54KJeTUXeDJshXAJJR3zd0eWAhSmXijvWUFRpYgdT6hLC0a8C++XR2tP8UXLB+ibhD
         cX4w==
X-Gm-Message-State: AO0yUKU5L4Ygf0YmiLK9yiHAF6rehCkLV2mBZQlY4pfkftJF78zbnmmq
	UPewbo+H6bqJaK3e7vIhGSPe9UOGqx3X
X-Google-Smtp-Source: AK7set93jg3AsT7mjGBglu/3j83+CTCtgaojpQXUpjprGEPoHpJQuL46KJdEkdL4nJpRZhXBc6gO6w==
X-Received: by 2002:a05:6e02:19cb:b0:310:9f7c:2e1 with SMTP id r11-20020a056e0219cb00b003109f7c02e1mr7701345ill.5.1674771862181;
        Thu, 26 Jan 2023 14:24:22 -0800 (PST)
Received: from [127.0.0.1] ([13.89.2.162])
        by smtp.gmail.com with ESMTPSA id a16-20020a92d590000000b0031093e9c7fasm650772iln.85.2023.01.26.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:24:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4d5c94f133002e76ecb74c3303ab350df9175e90.1674767058.git.pabeni@redhat.com>
References:
 <4d5c94f133002e76ecb74c3303ab350df9175e90.1674767058.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Message-ID: <9462c399-1aa3-083e-c253-2adce228a105@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Jan 2023 22:24:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5066988909756416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5066988909756416/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4785513933045760
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4785513933045760/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6192888816599040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6192888816599040/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5911413839888384
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5911413839888384/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7edc0a62d5ee


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
