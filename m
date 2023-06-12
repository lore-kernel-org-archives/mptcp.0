Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DE1F194
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 17:25:23 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7606e639083so7891985a.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686590722; x=1689182722;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMXCAwdXZ2FDmicwRqhB/MSUahnBuKCyH5OjFXzDzcI=;
        b=LNAC2dYo3/7t0xdDVpJuPcAx3qB8KiIz+VpVQf90btSE4h6FK5kOPLEuStTvRFv2O/
         Y0TPaoAQUjfTAV59fZbOMtTLTv6hF04drJFSaKWB4+fCowSv8i9v7TFTSHYdGp/+1+nK
         3eMQzmSNWQvIB39XZTA4wUGwrF3YDy2g2lZmhjMuzBQEFBIRq1ODhYVF4LmymbHDPz87
         bln0FeqLGvW2YwvsVILIlDBBEmULLYSk0eTh700HFQ2wvWilcr2SwNcVdq+Id3gGV6tX
         fe0xUnUvMZ7pFInXGWlTvpNTL2DE5DJN9hDCTg3dr8er7u7r37Mu/nV8Vx01W82n7xk8
         8M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590722; x=1689182722;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMXCAwdXZ2FDmicwRqhB/MSUahnBuKCyH5OjFXzDzcI=;
        b=j5wHv8eKFEkWheUECz5Y773HvuWy1M97kuPsetoZ5dg5VcJtPjptnH6HXnXFprk5aT
         VZOFlSULXqVinJBdh4b0IAyc66kxuiW47MfU8nO0+Wx85JuCk68OUwmU4deFEwNVg1a+
         kDxVMIIl8lhMbduMDGKZLsjv/KHD1vYoeAv5AYxO5plMfCmPlatqeo9iCcJDVpbx/D0A
         NsvLuOytf2RaELyRjk7dPbWtDPZ7ZYlOUOCfA7ln/9bDLrLDum7Zn1t+2an3X0oWoxpn
         PCcSxOvK5LzPCLlrzsW0S0y/prDKLCSR5kPm4+n0uDKkbn2mTdUvv0RD+2s75U11iPEH
         6Zww==
X-Gm-Message-State: AC+VfDzssqCorqmHyr9PmT/JCcaPk5dGVRoQvPuznXIyGPbS0d6JpGry
	7KHwRU/JJrBpwZmJ6UTWAg==
X-Google-Smtp-Source: ACHHUZ5Yo0YfjgwpBHwDZ0Nqz/ZIVVkQ/sIS+YyNN8+SE7Q0rDUg7eBev05UsKEASf6XlxiskjpPTQ==
X-Received: by 2002:a05:620a:800e:b0:760:4d89:caa0 with SMTP id ee14-20020a05620a800e00b007604d89caa0mr8618038qkb.37.1686590722524;
        Mon, 12 Jun 2023 10:25:22 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.203.194])
        by smtp.gmail.com with ESMTPSA id h24-20020a05620a10b800b0075772c756e0sm826722qkk.101.2023.06.12.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:25:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com>
References:
 <f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com>
Subject: Re: mptcp: consolidate fallback and non fallback state machine:
 Tests Results
Message-ID: <b796ac05-2fa9-487f-8ccd-134a2463e26a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jun 2023 17:25:21 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4788605378363392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4788605378363392/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6477455238627328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6477455238627328/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5914505285206016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5914505285206016/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5351555331784704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5351555331784704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/68be28d432c3


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
