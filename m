Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3992F39
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 10:57:59 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id g186so9670909pgc.1
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Yk3ImqZzDDzoxoMy2AHjPzyEvHLhHrFdrA2EWfRzi4s=;
        b=mot1hHt5UQYoeshj9z91gLwiRvXawrPVNtTvxTb9FRAstl/6NnQaKy8Qk1g78mmiRl
         sHHKVfv6zqK24TmNNAEUmgSDPixYWppfztqmMJaAXLJooaggV/6J+f4veXgrHoOtDJId
         rf3HlqOgbS31KB8BXRW486HvuTD8JCzmyCzMsqbs3UbjNiGiOPZ8VPcwpb60jj9wlfe7
         7RQ0/6UBRZxY8XLiRPPqSViTpo0KOP2wzGLf2vOwb4dIzIijSyo7ja0aAwjS2IyIgMUT
         p86hY+d0catKnr5VVGAmmeqZNe91MSdsoHkz07bUslL7hRe1f+sGtfGWHRgAQQjh0b4W
         UEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Yk3ImqZzDDzoxoMy2AHjPzyEvHLhHrFdrA2EWfRzi4s=;
        b=7+d/z4EN3cwmzD6QiUw2wkTS92uwb5iaifjaBmh8VfbiSJPuLq0KBThUJ4DPKZ94rd
         TiaAJU8twaiXNL4Drv633ErTY9Xx5zQ33/iveimyuHt1wb2msW66B/YuLdSn/qEu69M/
         94FDCFHzAOwYdHLen7Gh0OlmGp5thDs8CKbw0oK6sqbv6AtyoyRA7iswheORCh1htRRA
         ZYM2rjap5ybPEqbMd692jSknToSwyNLYP2eUayXXBf0QAARwpNqHcfQp/vM1lsHrQ5bE
         MWKH1nytdv2wUqBkMoiIgu7uMyo8O8J1nDAC9LsJ9ywyGOvO49PCr5cm+N1Ki3BZKpAf
         GeXQ==
X-Gm-Message-State: AOAM530PVqEaeSFKnxPRLS3KhcfQJq798lDS5tOnEYCvU7odPz3I9EE5
	hB+36XDp76pb3HYhspOhKwBYUKbcnBy9
X-Google-Smtp-Source: ABdhPJw72TmKQadwxd507BuSpT0r6Q7jLUyZ8UvPz51UiLTstrv60BPvwoTrSVkwWfCvd/5NdHOgXw==
X-Received: by 2002:a05:6a00:c92:b0:51c:1030:5eef with SMTP id a18-20020a056a000c9200b0051c10305eefmr16772853pfv.76.1654685879168;
        Wed, 08 Jun 2022 03:57:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.125.141.169])
        by smtp.gmail.com with ESMTPSA id bt19-20020a056a00439300b0050dc76281f8sm4211919pfb.210.2022.06.08.03.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:57:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <8c8d4ab88bfb43cda2ffa0b5e43595cad8c83512.1654680717.git.geliang.tang@suse.com>
References:
 <8c8d4ab88bfb43cda2ffa0b5e43595cad8c83512.1654680717.git.geliang.tang@suse.com>
Subject: Re: mptcp: call mp_fail_no_response only when needed: Tests
 Results
Message-ID: <36b2e5df-dee9-bfa9-1bb2-d811fa7a3991@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jun 2022 10:57:57 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5546032812523520
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5546032812523520/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6671932719366144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6671932719366144/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c4865fd329ad


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
