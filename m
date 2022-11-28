Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8CDA461
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 17:58:15 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id x12so2478330ilg.1
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO3m5Xzb0LrkgU7cQR/bnAdXWHY5j5+RBMpFp/Xsb3s=;
        b=nysXOPqdlPDhwkBcVx/64QcHoK2M1AkcHNLShJIbHpbK5KlxWwF6EcDyr31Y9ze7PF
         9e+E5BKbxhY4PDLrEiijAFqlb/6edKCpoVu57eQh1w7ZZFfn8bIutcXzIhg4sIRmaSAD
         RktZwMDkahnLGYSQMKG38XEoZFHdb7hwIsZFAsZRVJuMKJewFqw+I8ZdUXpydLqofFWH
         1DVnUTD0/vsGny7lKflo5Q4t7Vq+56yoVq65RvFyhULKZNpZju0QzloHnMUXPhjWuYfr
         X1pC5ADkW/4WEsQ1cp0rfyA83KNh5vFfKBUajPJ7do+aX1bahOeLzhJNmzQTMrm7I7m+
         6MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VO3m5Xzb0LrkgU7cQR/bnAdXWHY5j5+RBMpFp/Xsb3s=;
        b=JFmMAkoFqjcUt9geo5H2In/d5PMVYh/bj2NN7YKf+ox5LVdABZ47N3ORwbIXQaOCDW
         T/HczwEZXdEuzjNUBA7XvqsbtyUC64KOGMxCWxtW9rGcpGGhoJC3QzvYpja8/knsnJir
         tgz6hXONqOgsebQv1ofFJEIQobCQtM0c0kwZaMqAGYTilwSLStlA1egzsFwSi/JSSTIq
         nxjt/rDli0CR9IlgOnSmtudzGmrnOUkOf2BQUFX7DlKfCWppvcEqxSndIqEeUFV39tup
         F1SBn//vP3dAOPNrqwb7qand7w5nIk48spGbgNBpcnRpPf1zp9vy+HVRsH1mSIbuF0vJ
         22EQ==
X-Gm-Message-State: ANoB5pk9WBnb3TH39KM5Lwe2LJFuhWetvlhpoAR8rWWzgqfxqOEHwsjG
	EHHY2bUNAF5oYfRItDSmA5aK+MvFYA==
X-Google-Smtp-Source: AA0mqf7F/YJL/gI62CR6sC5GzhH5UwT9WAVpZCktMIjsVbf2a+m2eYK++Jza1IUJ/fUrql4uefGXlg==
X-Received: by 2002:a92:6e0a:0:b0:302:4d37:9e69 with SMTP id j10-20020a926e0a000000b003024d379e69mr17770422ilc.160.1669658294235;
        Mon, 28 Nov 2022 09:58:14 -0800 (PST)
Received: from [127.0.0.1] ([40.122.79.156])
        by smtp.gmail.com with ESMTPSA id k21-20020a6bf715000000b006cce295dde1sm4624727iog.10.2022.11.28.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:58:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
References: <20221118083541.123585-1-weiyongjun@huaweicloud.com>
Subject: Re: mptcp: netlink: fix some error return code: Tests Results
Message-ID: <e069edbc-6552-c52c-3daf-c23c29df16af@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Nov 2022 17:58:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Wei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6167649541947392
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6167649541947392/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5604699588526080
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5604699588526080/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/108f979a735f


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
