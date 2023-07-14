Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9D1371E
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 12:57:15 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1271746b3a.2
        for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689339435; x=1691931435;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBiwoSu8Cl9C5jbLcfaeHKUj1m5A+73IzwsWwAar89s=;
        b=LvENzvb8LE+7k7CNNMobT365JBQLnPrdF/OZNf7iTgUvyD/7arOZnKF+ooKSpByP2L
         sY5ANNHQWekhfpQmD6fTEZhXLQ9dtwQF2bHV4Lc/otGlEtUSpvhG+z8kQ7VSXLFY5jgI
         2NlBGKz9LVGKJKQcu4u/D8PK+UJ6YK2q112THiKoZ3oF7yPB/jPblRe8U4VuamzgyzJK
         4w6jBz4/84WVpHlViiztzYamvtDQvbT6q7GhpI3wmAq6HFHL06ghydlAz7eIO81o3hKO
         uzND+xvD5Qjkm0AKKxqmXJqf58O0wj/V9bQv71BPACj68Kh6TqxUv5CozBVb3Q09DakI
         bqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689339435; x=1691931435;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBiwoSu8Cl9C5jbLcfaeHKUj1m5A+73IzwsWwAar89s=;
        b=UdfhUa5AE+H0wSfFxbuFbLDL11EgkGxMogliEIlRNgltGa5J7EoQ9UPk/hUp+ItdeV
         fONFrtABV4SnUKQeOxOwJ070s1j0AKaRDjEMQjIMTtD2L7HvjWPoO5nchhBP8B8lHLx2
         VaUYwal37j0NlqqKk9qq0kh84zy6YMmNdFUESPmbjqjvnwjkd8Sj69+jQNMFrSN1bXt/
         64LjQPGJIy+N6UYT+/1rKhqg+R2+dfbxs9HeIYSc9d/Bgt1KW1oRmlDhpBTlsVRqZhTQ
         IL9X1a+lia/VlC8R0/PKJzoAV3jwLLYbDnsENhUcHWXlx7MCbUvAiXLSfstXU1DXQ3Ij
         4IJw==
X-Gm-Message-State: ABy/qLYVgCGqFlcSR0J4CPKR4iMubwyUfLvNuKMob8t5PZ7w+O7Li/ZF
	y/6AOhrGSsiUMUR0EBOkPQ==
X-Google-Smtp-Source: APBJJlF1j0z307MlURd6evZBDraBIBY7wo2khdNETTkLDohOJ97fqgxbuM5UHYsj92ltjFO6xvbEIw==
X-Received: by 2002:a05:6a20:406:b0:132:a85f:b2e7 with SMTP id a6-20020a056a20040600b00132a85fb2e7mr3280729pza.53.1689339434631;
        Fri, 14 Jul 2023 05:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.46.51])
        by smtp.gmail.com with ESMTPSA id r27-20020a638f5b000000b005307501cfe4sm7407167pgn.44.2023.07.14.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:57:14 -0700 (PDT)
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
Message-ID: <84ba76d0-33da-fc53-2b61-92871ec37ef2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Jul 2023 12:57:13 +0000
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
com/task/5305177201180672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5305177201180672/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6149602131312640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6149602131312640/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5023702224470016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5023702224470016/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6431077108023296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6431077108023296/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/10e01667fb4d


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
