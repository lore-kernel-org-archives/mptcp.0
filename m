Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46320E2
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 09:51:50 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id x7so8565212qtv.13
        for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jh2sGDWkGPtFEvdNn+L4KUwvAHVl5FRC8LO59ign8U=;
        b=W/ZkJd1MMtBD2k39uJAHVKG1RN9kYWV/ZODT6T9wUnEXDnjxbNk8CJZgkQJrK8j/oc
         NFrCOIXfsQl+U4CCY4GqiU9YRhCiRwlMxUXcjN844YaV/lMUfcKJKHZGAB4/noysHS8L
         G6j3TQpDthFa349nYS9oLd0VqtmewxNwKpJ493YuaPheutvCwwnuibnPbUIrswssJAre
         VbOqso3+GcIWXVBeTLp91vN/XFrDYasUumt3cNgCLxnh4CGx+U0vF50KfBIrQS6eE//t
         gkVA6KlYdG7Vn/uRzO304zBSfv7IBOmOyhZ47vzoPsKJ24pvj/w2y37truQNr5+nDVpY
         GwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jh2sGDWkGPtFEvdNn+L4KUwvAHVl5FRC8LO59ign8U=;
        b=F46BM4Zy1OaehjA2pqyaivZQCjCb6aFjL+S9kmZYjiTxW09NSlpQT2zJ/PzAeYhrB7
         Zb4xxTImAAWA1JqJMaUwNjeifPHpMSXlBKsk6UjY+5e5yjqe3HMzV732/+fOeg74TBvJ
         +cgDazXohY+o5Xs1k6oIMWCycX18a1Ix8yxEvfaKp6GBydHulo7CQduqztwPpT1F5o4N
         QFCntdCJIz0DASmS3c6slb1APT/20QGGYqDsnsMXeYeG+ptde4VjvUCRY7hsz+JYPgzd
         C64tXqziHonlC7D3/rvmT0u+Tx9i3t8VEIhlwAMk8A0j84tZtVdey192zfoxhndOp4Za
         li+w==
X-Gm-Message-State: AFqh2kopJ1sLj6ikLdjlJgmU9P+RKtYspP9VQ7Xrpj/mizwUKBtejGRy
	rMicrXx0Ta9HSXQ2MTsO51VVaxtT0/cE
X-Google-Smtp-Source: AMrXdXtcCWiKjKAN2ghp/qmg8zpI5/u2NZ01PUVdryDCY0QZbxg1KDxsu2EzQVMN38kXJ4SSafUjzg==
X-Received: by 2002:ac8:744f:0:b0:3a6:a19e:49dc with SMTP id h15-20020ac8744f000000b003a6a19e49dcmr101230410qtr.17.1673603509850;
        Fri, 13 Jan 2023 01:51:49 -0800 (PST)
Received: from [127.0.0.1] ([172.177.255.81])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a404400b00704a2a40cf2sm12486419qko.38.2023.01.13.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 01:51:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
References:
 <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
Subject: Re: mptcp: update userspace pm subflows info: Tests Results
Message-ID: <c153a5f1-1e4f-e492-8e6c-78f3886ce8bb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jan 2023 09:51:48 +0000
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
com/task/6024448923402240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6024448923402240/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6587398876823552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6587398876823552/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5461498969980928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5461498969980928/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4757811528204288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4757811528204288/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/59ca5c77a991


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
