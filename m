Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE9BE61
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 14:02:35 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so1444316b3a.0
        for <mptcp@lists.linux.dev>; Sat, 01 Jul 2023 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688220155; x=1690812155;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEzkC3e79Aa5HfLr8pY+ri8HMs3NJhV8Sgs8m6RponI=;
        b=pdQ84gvbWutJTb2ru6ciqcF9+ZBD4ybNW+h4dTsql7FG5+nwxe7FrKvP1OnoO1/IKS
         pLlBIfXIc+ffsrkXBW5wnXzRSDGWEb5eIRJYpfugWtmFx2bycTe728GODP66Q3mozOIh
         YCoF6/4jsww3a21YHhSQcnO19E7vgxfjIZwu4KHk4OVsLA+T2ywQocZGFh3SkGTiCsfq
         XFsYnZJO5XujWk1IA4zPh9FRysaCF5m+PAeoGMdQ0b7cMUeoKbKi5V4/0t6KBa27T7LI
         Ao9oNtlkYcwZ4W/sDDU7/WB6WVG6UUR4c7SN8hiQdniByzE2h7MvbtCqMjdLCZGcUQmY
         LaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688220155; x=1690812155;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEzkC3e79Aa5HfLr8pY+ri8HMs3NJhV8Sgs8m6RponI=;
        b=M4LxfDFwkDDCGkCFonhJ9zWJzJS0yyWoBSpIakY8cgeRdePOCM02kK7GBEBSy0ykR0
         XiOOt3KwmLjbBuC5BpLapUHCMEPzyFNmy9Zs3YGS5y7KYP560H6G2qEY3HvtUmbvuoYo
         BlW0KLMRI0x7tbvdz4Jp3j0+lfN58CLsJnNqN9db1p//TMLZdnUmVwBU+7EdWEFokicB
         YJAFecqcBCYU7o2jYQBWAtMUB2kS5xbhDNQfH7CtcdaFwL29uZrYfc4Tr/Gypg2217s6
         e36IVurDqAgeRnrwfifZIi9C1ikDdRlTYD++1m8+3OTwOJXufXB4vpCbWD/a9D3hjZrU
         QUxg==
X-Gm-Message-State: AC+VfDwqixJqTjKtQzvksEgWhoc3fo1d2uQDQb2dcwB4uzfEcFoxOmOc
	6Lumss0iH9H3L8ghbcL1ngkvvxWv9A==
X-Google-Smtp-Source: ACHHUZ5kGOjPo9w1XgJLVsqLLtyEsvu7Yteay+eVo8r+7UFiKN/ocOkROo+BvJA1Fug0or/Cx9/ePw==
X-Received: by 2002:a05:6a20:1446:b0:123:828f:68c with SMTP id a6-20020a056a20144600b00123828f068cmr4318829pzi.50.1688220155081;
        Sat, 01 Jul 2023 07:02:35 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.87.31])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78e1a000000b0063f2a5a59d1sm11631393pfr.190.2023.07.01.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 07:02:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56db1c21d35a76ebc9cc6017da64b30add33304e.1688215769.git.geliang.tang@suse.com>
References:
 <56db1c21d35a76ebc9cc6017da64b30add33304e.1688215769.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add mptcpify selftest: Tests Results
Message-ID: <01906f98-2d8c-8115-7c68-e486e77669a9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Jul 2023 14:02:33 +0000
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
com/task/6011347134054400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6011347134054400/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6574297087475712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6574297087475712/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4744709738856448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4744709738856448/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5448397180633088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5448397180633088/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c3be2bbd7a11


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
