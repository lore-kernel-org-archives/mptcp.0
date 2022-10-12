Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E617CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 06:08:41 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id l6so5175931pgu.7
        for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 23:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqAFOG5ph/xuZn5EVGHvYBNjim9MCSFhtBpqDmk85+0=;
        b=ETkNyfZKsk936wYJ/yvuGG2ukhfr85+KERzSCXIjHlLY/7ihSHSdR2qOdog7nEVQFG
         ljNf8m5y0761fv2do9bA5DiyYJpG+P8Iesq5lH9qcXGEwaseh9QORHVv5B9XYVhWNkt3
         Ms4u2bUsmzpvU1a4rO4Q+HSKdW4TnrTvEUQDIRmcPWzQ0guFsG/xNc2v/aL9Qxm2jl29
         yKsXGbJW2fklabb1TGT8YpA7eDLgvucU3XtWE5TdhQcxD2A/fYD8EaS4MIzNbvcnw2+A
         eew89VIyorUCTeGnodDOqZFrMCFNGZzZzy7/HI3H4wqwWhH9Opwqs6LzDVO11AQ5DtXx
         lf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hqAFOG5ph/xuZn5EVGHvYBNjim9MCSFhtBpqDmk85+0=;
        b=o5iBeGUDmdtJK47TvF9RCWCoF3s8l1JY1KLtw03pqnkoFUhwvWbT278zNMHgrgiXxd
         Rm9HkLPiLX8Wll3bT3/hbynx8WIPusoA6CNW7H2hrZwMoeg5Q7p0LPBYLtgl1zj59L/t
         8t0y67Y5o3HC07sS/Roydi1yuKK+GujI0RdfFajAhNfFeX9xCoVlG7TaZbfwLdRKWe4z
         vT+UVHUoUA4icuw65Dchazo3avDNRKwaMXjxkh8mtsTV8vfaML+MN34VuunKUZrutuso
         YFAHKZDqjgYfHvlFzRXHaRsYbVnZ7U5GLN3qlfMJS/IS+hEqfOpO302WiyZps0Lx3haB
         TrKw==
X-Gm-Message-State: ACrzQf1v0YyM/x7hZHCYwDhPzmOLi4+LnY1ILVis5G9sGaTCDR3ThKBV
	+xosZax/N9EXS4mMsU18T0Qr1dlvCN97
X-Google-Smtp-Source: AMsMyM4oaAsMKbkZ0VfQiUVbbLu3uBFNDg5vrJjoWtm1ivnYVwfRcffBsc9zqv1nQmWC6iF/0ALgIw==
X-Received: by 2002:a05:6a00:1d05:b0:563:5715:7f3d with SMTP id a5-20020a056a001d0500b0056357157f3dmr15259341pfx.48.1665554920906;
        Tue, 11 Oct 2022 23:08:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.237.117])
        by smtp.gmail.com with ESMTPSA id f18-20020aa79d92000000b00543a098a6ffsm10042422pfq.212.2022.10.11.23.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 23:08:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <811dd5cfe0553f4f1cbbad4d159f96f6cd826310.1665549148.git.geliang.tang@suse.com>
References:
 <811dd5cfe0553f4f1cbbad4d159f96f6cd826310.1665549148.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <5c82491a-d645-8dc6-e6b2-19dbd3e727bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Oct 2022 06:08:39 +0000
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
  - Task: https://cirrus-ci.com/task/5096210894159872
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5096210894159872/su=
mmary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6222110801002496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6222110801002496/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e52192a357aa


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
