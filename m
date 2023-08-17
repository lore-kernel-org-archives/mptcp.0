Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC31549E
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 15:27:11 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6418cc115cdso41145146d6.0
        for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692286030; x=1692890830;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHZyEbMqmxwIT0tMu81e8jh066cpq2kw7KBVif+XDfY=;
        b=WLIKtq+P6E/pEpPvhVu15+bQ27PFRRJiD9NgGw0pcYoBLhmMAi25+5cKm/C9ogDUa6
         PdLHEYJJUZ5yQGro4/vLiLCyXnGT4zoc4b+iJtvSfZXfvQKXCDzxPCd3Lp513cn93x9d
         0P9HdmJfMF9GMSwJViWhyLFNqL8vYV9dVVqVEAoT5j+8IodQPEFDwuV58fWvpUct/iRs
         HuW9g0Y4CI98y03sOLMUFC0fh9hotZthw4bE523xxjDI8FNiwXTdmBucQHiadH6IbGGF
         iTbJo9z2Ph/cOXQhFj4qSNLV+OdB8xNvyVDLqmOPD1nHjNZPcJq4xtbG92av33kgDIeo
         +g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692286030; x=1692890830;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bHZyEbMqmxwIT0tMu81e8jh066cpq2kw7KBVif+XDfY=;
        b=fhB01fTo4weCAYr8TaJ6ACl1g4OIpVKEWL3AKj5o2oJ3aKPygPH/NiQuko+McgAJn4
         ag1fT/mwfil1JOiH3aHhcLx1XtcUTie4mQ8JY0QKfmMwDQgnCzMSuolzwIv7cAwRFJOG
         76VlEF4pmDFJjPrRDlSAV/+vLJF8Gy7Sh03IaxEtjQRLadBmQRYiImNSX+nPSMAvwdrN
         J1bvc/8l9Jm1exrA71MXOo7EQnIt/o2Uwxr9E+JBwitk3mhG3DWqrRqTeciEe82GE8x3
         FN79qNE9GZAMTN/HengfVUfxc2S5Pp9lybnREBn1ggOkDyFO68Sfi3I/NU7GCT7OI8t0
         Drsg==
X-Gm-Message-State: AOJu0YwDNTy3tzsNAsH8AEiK24BtmIr18YGPYauf/LQXCMJCqpZVvF4E
	B5VvG7UIm0ZB/jVn7cdGwNlG0MwaTg==
X-Google-Smtp-Source: AGHT+IG9EBt0wIwwGbI6SskcPXfgNVAajFmcTK5lXfhhF6qCEiVWLyH/8D6kdGf6qStuAn6VRu/krw==
X-Received: by 2002:a0c:e3c1:0:b0:63d:eef:c3f6 with SMTP id e1-20020a0ce3c1000000b0063d0eefc3f6mr5428604qvl.38.1692286029900;
        Thu, 17 Aug 2023 08:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.46.145])
        by smtp.gmail.com with ESMTPSA id n6-20020a0ce546000000b0064a6858fa09sm374527qvm.32.2023.08.17.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:27:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4d399e6564e6a4c2ea3fda6f6f4f7ca50dd6c0ac.1692281317.git.geliang.tang@suse.com>
References:
 <4d399e6564e6a4c2ea3fda6f6f4f7ca50dd6c0ac.1692281317.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: remove id 0 subflow & address: Tests Results
Message-ID: <e688e440-ea61-3dd2-87ef-fe4982f6907e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Aug 2023 15:27:08 +0000
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
com/task/5698108105949184
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5698108105949184/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4853683175817216
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4853683175817216/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5135158152527872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5135158152527872/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6261058059370496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6261058059370496/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/131df8187f2c


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
