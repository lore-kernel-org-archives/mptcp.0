Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC2A4A
	for <mptcp@lists.linux.dev>; Mon, 28 Aug 2023 06:48:17 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76da239ba16so199101785a.3
        for <mptcp@lists.linux.dev>; Sun, 27 Aug 2023 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693205296; x=1693810096;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MB8usI9hkixOvdv6UVqPjCBrzEWdGg3DdT4Up1tTTs=;
        b=NequS2ZBz+9uc3Ae2XU0BorO6h0qVBMVdOIOCJj0C0awA0bQv2GexcF2mbyrnvHoay
         sgD7JFRssdLQSQk9pT66jH7JQRksGXntPRLaM8IaBQhsZzGgdX29F7B9WsEtAoVcwFrX
         iIzMHyhzcarcyhw92Dbm1GqyPymfaerkr0vC9HtWheF4xdLaCxNoCJQL0eh071NKdmv+
         pM4EyrMu9181WkUBBAc9hDCChwYAinFk4Gq/68PXKtna/xXRkzSuh29CpL4u9ILuvFrh
         Pcqn+z/1fuxE5wP/xx7wOYWolMdW2Qfa5/+uf1tuM7Ge5ojp3Np7O11Nu5iM0OOJzlPJ
         bTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693205296; x=1693810096;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4MB8usI9hkixOvdv6UVqPjCBrzEWdGg3DdT4Up1tTTs=;
        b=kwPJV6p+F1Cv/mwUolNdsh3G4OqEotgsr5PQrR2F+tiLJol+QFCUd9AZb6eBpkbTEE
         OUMe6O4EnHYq0miUjXurfjgpU2TxGaz449LfZtXVZXIxLmh6SIxGrGQJbUTy5K3P+4OZ
         TPpqJowGuZQk77qi0ia76R/6ghjvjnSlPHXXthqF8mAhngOdZ+6Q95VJGTGPnd3fQ/ER
         aEXq/SycCzuGV4XZH1SQRIi2DOlPpSVcjdE/zEsT4haKfoI5TxwWGCXxU4koouZWxwgS
         MkdKE8p+QMe8qaQQFQJ7Vj/pMqXccybvNaRYA7wZR6didcGHR3SHD4wxnitEEgJvmcrp
         t+Kw==
X-Gm-Message-State: AOJu0YyBBSgEUIwRmucupBVCD5fFL2l39kXp4lfThbXhAjoAgj0vjPJy
	1Oe8GxPEF65YkexiOnmwMg==
X-Google-Smtp-Source: AGHT+IGRjWu132FS/QD6gufp4CpaNV2tdDWdWkxCIpQtnCG16+NfGofeN1169koVD7awbuwelwavkg==
X-Received: by 2002:a05:6214:9b4:b0:62f:f6ed:857e with SMTP id du20-20020a05621409b400b0062ff6ed857emr23205958qvb.55.1693205296436;
        Sun, 27 Aug 2023 23:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.120.57])
        by smtp.gmail.com with ESMTPSA id w17-20020a0cb551000000b0064f4f14aecesm2385279qvd.24.2023.08.27.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:48:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2778378b42d7a74fcef65dfffb80145f19c37eb8.1693197152.git.geliang.tang@suse.com>
References:
 <2778378b42d7a74fcef65dfffb80145f19c37eb8.1693197152.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm remove id 0 address: Tests
 Results
Message-ID: <3c49d14f-1925-3f9d-213f-d574d6222a28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Aug 2023 06:48:15 +0000
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
com/task/5321984666501120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5321984666501120/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5040509689790464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5040509689790464/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6447884573343744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6447884573343744/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6166409596633088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6166409596633088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a4db10d91cb2


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
