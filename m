Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9247163
	for <mptcp@lists.linux.dev>; Sat, 15 Jul 2023 00:25:56 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-666e64e97e2so1788731b3a.1
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689380756; x=1691972756;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADBCr1U3MgCRPbkHsU7/gwgJUbpiAc/cwJHwrpHyC6w=;
        b=CRMPMBLQrPaTt7xhjH1ms7QrLlObKzHS49jjyJS3RjAkecke/OHREBXc9PildCfcRW
         0tZuwbqehqBCvdZbSAnvPmhhp6GerA/GLuYvPEhM8zTGpnmCpavwfeZY/wTJH/EUntHu
         /rdIxX5f0eLv95v2YxSTahoNPtfa1vHRfqNJ/aQphbnd1psN544mINPlV/ksbX2pmA3S
         kKTJ7E8wqZVCzB0zSzKUU+zMEswth9RvZEJ+j8Lg/rI/kmE+aCgSWvq5O0hhgOtuWapx
         ok52cmaRw7gjFDWAu2z26mQSm99hyn0yYGzf2X01fpzQDCgj4rktC3+Gl5uILemxDqd2
         J6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689380756; x=1691972756;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADBCr1U3MgCRPbkHsU7/gwgJUbpiAc/cwJHwrpHyC6w=;
        b=DQgJaFCI03QkJNZjgcXDCO/3YAc9TwZ4dR13qUufwEGpWFJbtKJdP91TdAYXudtwZo
         oW/uce8saxzGagkUjW1BwhEagxyXrGd96ORZ5AfmthXL/d8e9F54KTKBF201oKjBAQBz
         ITVgPoxXGCdkTzOOJH3gWWdvMJ6F8BONp8jKRbpEqhbtHCKJWzaKKRlm5P4k3ms3qbvS
         QAW4v56ykka7FEpgSzyg3gkdZnBYINkBsUidJrqPlcx2f5wc9+giSuZN1EFP8hQi12zR
         ZVjSEHV04F/L9B3hUPMdSL1GJ4fVWKz4IRIgnuNeK847GWW3erDgakjdaVMHhXWVkjvI
         yckA==
X-Gm-Message-State: ABy/qLaAGWMe8aMJpocN2R32QyDdZXG4HgoQmFzKOBigjAIOALLvV4nl
	8bjh+3Q7fL+S01MfWemeTA==
X-Google-Smtp-Source: APBJJlGHr/rgYxuCB6gLnEQjBcHjMvzdWuse1bBs21W8iuBovBSDrslGdShDVYvAB0xD0lhcYCnc5Q==
X-Received: by 2002:a05:6a00:1886:b0:677:bdc:cd6b with SMTP id x6-20020a056a00188600b006770bdccd6bmr6940473pfh.19.1689380756026;
        Fri, 14 Jul 2023 17:25:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.161.31])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78392000000b006827c26f147sm7644917pfm.138.2023.07.14.17.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 17:25:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e0870b3de6c2d87f4b831ea5193d2c2bc5156b5a.1689334116.git.pabeni@redhat.com>
References:
 <e0870b3de6c2d87f4b831ea5193d2c2bc5156b5a.1689334116.git.pabeni@redhat.com>
Subject: Re: mptcp: get rid of msk->subflow: Tests Results
Message-ID: <275107f3-f277-c02a-44c3-e4734f8d81f5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Jul 2023 00:25:54 +0000
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
com/task/4562317090750464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4562317090750464/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5688216997593088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5688216997593088/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6251166951014400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6251166951014400/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5125267044171776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5125267044171776/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3653a7a07506


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
