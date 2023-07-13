Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51161F173
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 17:59:45 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-76714caf466so91655185a.1
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689271184; x=1691863184;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOOEGDM7/Lljtb19J0zxLU8koiOYrCdTyOIJP6+Au2A=;
        b=cthwub4EZb0uVgL/4x/j6NgNTyJBZHl95ae0f4mrwnRqRW9FnHDEXkCQPuNnusK1/h
         Kho1653YNOfFFcZg9fOrpkyc5KsJW28SfsBya9TcI6I7zyV+bUmYE6B+bFT5vfJkgfBq
         AFgocrsLqD15DdoFYZYDtPufv6vXcreOfIRvPpx6ckcRYIWjdyiB9HWzhjtePTjRiU1j
         osacUWnj6qHzXRPyiWJxs4/WGwFv0Cqqev9EaPuv0ZKgJXokINRvPei491QgQakFBeSs
         Sn1fRyN60DwlqH6ueI4onuzwg8QLvD60jQVNFwNmtoOhw9KonuOyjB9eZ4U48nPO/wLz
         0xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271184; x=1691863184;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qOOEGDM7/Lljtb19J0zxLU8koiOYrCdTyOIJP6+Au2A=;
        b=AC69+raikAZWFL8GibKwxq68G84DqS4YGb3Hr/CtepSsXJeoj0WmSziORVYM00eqvv
         A4pJeQ9EcXqxGzhlaVqjkNT83NrRhil+Mkn1zkkpKNsOaNF4oB64utHs65vJ2AV07fDN
         JS9hqJ+eAb0PxiyZp1dXNHU1JhNZsfRuR8xVl6plV8a4KVOowd2zzd4pR4N24p17iWdg
         FxXHXXIKTgVUm5oO4sEYqZgq67lgxy1/Zd2zkVBUAFrDc28OHbvRYj8Go+U0m7wAqCY4
         FWxEQIAKUjM1GmuEa+pTiTG/4z1EBrS1bzR6iNFdvDBRaGxSw+yAOBNMBJMcyWHczTlS
         5Y6Q==
X-Gm-Message-State: ABy/qLZwKdzv9t9PixYnqxOMX2m9ydnTXMaTWlyM/8LFZjJUvEPIXXD4
	rdgDueyn9iaCILrbrKLzlA==
X-Google-Smtp-Source: APBJJlHCaj8eH+AeAH2F/qldmSe96ca3z5pYfCCyU+AqMDlMcoL7ZW5BJagSmjNXeFKNMAt96Q+SQA==
X-Received: by 2002:a05:620a:4405:b0:765:50cd:9728 with SMTP id v5-20020a05620a440500b0076550cd9728mr2739440qkp.34.1689271184341;
        Thu, 13 Jul 2023 10:59:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.134.82])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a142500b00767cb046e40sm3070548qkj.94.2023.07.13.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:59:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
References:
 <f994b6d9cf322414f649676bf283326658fc428d.1688993570.git.pabeni@redhat.com>
Subject: Re: mptcp: get rid of msk->subflow: Tests Results
Message-ID: <c3159a1f-b670-5883-d07b-04070f1e5114@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jul 2023 17:59:43 +0000
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
com/task/6122328535334912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6122328535334912/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4589019657404416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4589019657404416/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6685278488756224
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6685278488756224/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6048767019843584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6048767019843584/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6f392039115d


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
