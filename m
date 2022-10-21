Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E61617FA
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 13:09:00 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id c23so1553806qtw.8
        for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elslI0MpbxAB/jXjTrdBpK7nhrqYKnZuf9D3eHTbJ5Y=;
        b=H9tWi0mXJUprIf74DfzvaiqEoD2UIjZgQera7Zij6EU+HzzUpGk+U+90Gv3jHvf+gt
         6hoyCgwyyr6/uV/O5VSM6Yfp6cU88e20ailUnXk+iH2T8iS3Zny7DkuTOq/Apchj2IHH
         E+WrB4rCAMsn6tvtzzfZMmq2D7b8tOQIOHumyHVbzY94Q5ldADVxoywNbBee9tteT8Fq
         b0BFE+XpIXDmCX7Q21rPF4o3eXX6tQx/3KiztgpkPWljd31qT93zvfyhXXMDspdCDhkc
         KLAXqAgHf+K+zDELSH3ckfGGYattBciENd4NJNeKIiW89Ayu01WQBzSv0VIKgp0vLkN8
         9nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elslI0MpbxAB/jXjTrdBpK7nhrqYKnZuf9D3eHTbJ5Y=;
        b=fF1F7kehgD9dS3tctS/e0xI6DroG0qnafNHUALUbMeNj+glX2NqQdwEUJyOYfoL3ft
         eL7rmJ4iNGXGE5xAvRoYjEQ6mM06yDHMhc2ArBJ1/gqQ/frxuKtMkf70DLE1Q/BNEju0
         CYULKI4eCyaYlxMqmwaUGIOwWWRUIdiSsM0um3Egxp8ljrPzvB3cHW4nskqstp4zfYy1
         A5iIuPw5xX/b1U6AGMEIn3YNI5uCCeuuIcn0rPTIGv1XznUFFALzNDk+JAKEVwepg4yZ
         axs1jZge9u8D6q6o4YDrg6PsRmpkBh0jz6TakauDxty492ytOEevFcw9b1RTW1e3CjJ9
         kDCA==
X-Gm-Message-State: ACrzQf25DsXwit1I4E9Slf8nSds3KSZjwXyHXDXKmN6MPr4hRnddVlNK
	+F/G/KGui07oewyFAOIqcQ==
X-Google-Smtp-Source: AMsMyM64W4Oefj3UKNEtwp005mXGESh/YzzOxkdFlTyUAb1dBTVoN3mheVboITy35slFz3cey3Q+PQ==
X-Received: by 2002:ac8:5848:0:b0:39c:e974:1c2c with SMTP id h8-20020ac85848000000b0039ce9741c2cmr15808044qth.674.1666357739800;
        Fri, 21 Oct 2022 06:08:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.10.24.153])
        by smtp.gmail.com with ESMTPSA id bq36-20020a05620a46a400b006ee77f1ecc3sm9488708qkb.31.2022.10.21.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:08:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com>
References:
 <b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <6f2274e9-85df-38ad-f789-1f115540d058@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Oct 2022 13:08:57 +0000
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
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_mptcp_join selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5590666251075584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5590666251075584/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6716566157918208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6716566157918208/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/28f79fa98dcc


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
