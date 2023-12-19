Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE113AD8
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcJYFQC9"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e7bb1e0db8so3452167b3.0
        for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 01:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702978919; x=1703583719; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83w4fiVzQYqBSAQZouqnhu5wCBmmGNTs9syO+j4Cojo=;
        b=PcJYFQC9+sxte3t0k7Z53BuczZsy5Il3bhkpso3pGS2krf1JTWvJAztr6cJWG9BlDL
         6ejDutVInBSZFtOVd0Z1yglIDjsGuOiWMpMGA7kXygOWVAfJHaB63KaeaOrqXU4hnB9X
         lOEC+F4Fd4Cw8jh2opaLiPBrNnWT0CULctBHKa8AL6hTiNnG8nH0oPl0WmZ/Tf45lAOs
         WNxpPFgXAbxIYbuatHABskFqaXuqtN4qEHV8j4Y1qZPYWrsUrTAHhHc119Ky1a134PYV
         /9kIyEbJk7TK6UYGLBEsF2Vo4gHf12zDJ7WC/oglgBavWif2k7O2A3nvuC3wQlDzPcm3
         rOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978919; x=1703583719;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=83w4fiVzQYqBSAQZouqnhu5wCBmmGNTs9syO+j4Cojo=;
        b=Gt6e/BdsBOovOvZZVNPLv3Slxz8BjgnrlRst6/DeXavwjkE8kCVk5cBV1GJyLx3osn
         cK37L3dwQGyz4rdfe6Ox2rYx1p6hDN3Z8BeIy4iTGdvJzTs5JrQkzd1wVfdVFw72DoG8
         JTd8i1PpG6120fzNoL3m5bjuxwRyA7X5V+f/HO2Plyt8qs/dj7rT9jAWq9939ymjlSPK
         tWR8kTK+jR83NoBdtDwQxrSNMzfz1k7TfTFkpq5p43aM5Osp/EVGE2Xu//dcGliZK7DM
         6mHzR4+zvVPEcRXpj6kpbgrX/dah2rNNppkH+kw1w9z65w/ySeaVnmdzfDdnlMdcYuzV
         yi5w==
X-Gm-Message-State: AOJu0YzVTeh5PLELNg7bsf35EfZM3O8yYPp0JnAGkY9dCgyvLYW4kvko
	y5ZkYR3Nz8Jmr7Nw/pMkRA==
X-Google-Smtp-Source: AGHT+IEHClPTciIffFwmVfIfjProi+uqgzwv3z8zEXydTtkPon8u92GiXK/TreYJJX2NhuROLiCyeA==
X-Received: by 2002:a81:834d:0:b0:5e7:4cb7:db0d with SMTP id t74-20020a81834d000000b005e74cb7db0dmr1578022ywf.92.1702978919431;
        Tue, 19 Dec 2023 01:41:59 -0800 (PST)
Received: from [127.0.0.1] ([172.183.161.198])
        by smtp.gmail.com with ESMTPSA id z4-20020a0cda84000000b0067a27108513sm3098107qvj.67.2023.12.19.01.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:41:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231219092705.4120179-1-matttbe@kernel.org>
References: <20231219092705.4120179-1-matttbe@kernel.org>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_Add_bpf=5Fmptc?=
 =?UTF-8?Q?p=5Fsched=5Fops=22=3A_Tests_Results?=
Message-ID: <533d5adc-a9fc-19ad-ca20-63281c8e3b83@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 09:41:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5454052591403008
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5454052591403008/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6579952498245632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6579952498245632/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5876265056468992
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5876265056468992/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4750365149626368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4750365149626368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c7b2d91a1382


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
Bot operated by Matthieu Baerts (NGI0 Core)
