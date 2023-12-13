Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FA224DF
	for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4PHoYqY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-425c6157762so23967311cf.2
        for <mptcp@lists.linux.dev>; Wed, 13 Dec 2023 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702463219; x=1703068019; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lav23bLFOwapuHtwwLJf7PRysyfR3LeCRbSXoGl6EbE=;
        b=c4PHoYqYm5FVBpUaM70VtMCuSLdT/+XvJkLN/wtK6D9Ou2RsSgg7KvHmyNZ2TqKuUT
         fXyjbdUBfWEYTVbeg9ZixXY6gMi/rDOFWoqLy4KmImtZIhLMgqDKYXKW2UziAuMw1lbk
         WeDfPU8BwsmCzF8NghsTPQiMS4nFNNhJ2RNNYCvbbzkK8KRbpTaqvwLNLJghjb993olA
         bc5ri0XHaIo3sbNyQqX1VJWsVWF25ZlN09pvujxuPu5upsKfjoSavmjzZnSNpOZt3Sth
         Hqss3W7r3cFxkNSCIBrhUAxqnVzW5yn8fL1tydPPB17yC8wiKCk3fEamD9tn6rD1RTEL
         gkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463219; x=1703068019;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lav23bLFOwapuHtwwLJf7PRysyfR3LeCRbSXoGl6EbE=;
        b=pFsfSEVdyJ5aMljVtJo3/tEW3kFExADPY14/Nu9mH8kgG6pDV3z/koLf+BBm1QTWy3
         LVGXVjweyHpVOpMET2zPRbUGzvLB9TAZh7jxDKIgVs5AQuOej7PrBJDHjiVG3MCAkcXH
         wqU1h+x3Ql4l4dkjg0mTEBVyXqPQXFCiTMUiXx8oRjjY9FSgjwDmRj9JcSGIKTm+0BIu
         mWA0nVblXKuaiUCLqmZ4dLc7EKUak7NqpR2QC8jsjsCLiLEQJm8BH/mhN7DvENbJiQV6
         APAfzgi0NuxZXUUiD3opbPcLnraIF1lvsMGDM4QDK0z4IT9tymAB/+ftPiy0P7vA02gg
         awUA==
X-Gm-Message-State: AOJu0YyRptgBCd2xJe9Mg8vWJU8MsmtEGmOBthsc4VEVApIZUEXlqdQV
	CpfqJD/UTvQX+cGvBRUxObgxl3h1Mw==
X-Google-Smtp-Source: AGHT+IGR2EZL9Zkf/QQ52FfxFxzK0MLrlH1ek8cMQT3XAxXHlY1YvEIZB0BfzMiaSu8vYOcN8VVdZw==
X-Received: by 2002:ac8:7f0d:0:b0:425:4043:96f3 with SMTP id f13-20020ac87f0d000000b00425404396f3mr11405611qtk.128.1702463219126;
        Wed, 13 Dec 2023 02:26:59 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.21])
        by smtp.gmail.com with ESMTPSA id ih8-20020a05622a6a8800b004259b46eb93sm4710546qtb.4.2023.12.13.02.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:26:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
References:
 <6b76a198cc11f69bf8c4621f1c8a5cd0c9d1a6ff.1702446832.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: check CURRESTAB counters: Tests Results
Message-ID: <ca279c3b-dc9b-1ff1-b069-c2a3e677011d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Dec 2023 10:26:57 +0000
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
  - Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6631721181904896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6631721181904896/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6445764398809088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6445764398809088/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5716927507595264
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5716927507595264/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5153977554173952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5153977554173952/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2a1bf454a5d


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
Bot operated by Matthieu Baerts (NGI0 =
Core)
