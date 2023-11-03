Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544C1A27D
	for <mptcp@lists.linux.dev>; Fri,  3 Nov 2023 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQqeJfQn"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b709048d8eso2113717b3a.2
        for <mptcp@lists.linux.dev>; Fri, 03 Nov 2023 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021521; x=1699626321; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS8V4SHICrwcAPtASQB9CrdHoEmdXxeQ/mm2vqEApcg=;
        b=nQqeJfQnhCj1Z5wX0g03h+sKyHhIJrk+FjR+NzwIACaa30WxeSVmcUtPet+zwvTgxH
         qsbwKBNgOoHOoFSajlPeLZYBC7rKwNvQuM4WY2CLikfyduo3qhcnK5Biahkoia5yY9Hv
         HGHEWanNraisCMJBXAupyyL3UP7/CKMiICxhtt7hAW8Cy9AA8RI7Y0FXh28GzpYWfBkr
         ez1frz+oC7u/O+29kgPV4GDblUtXLj3m1dwtWwfqh0t/of+UIo/hW2rPtp8TSpzc3eWI
         +PMPPOBvo+habc77tMaA/qaxwLiYk/re0DvERxsPj4x9Gm2F9/dN/jvby9i3pnM6x0Md
         NbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021521; x=1699626321;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kS8V4SHICrwcAPtASQB9CrdHoEmdXxeQ/mm2vqEApcg=;
        b=mcmj/4VjRPzXEQNvZSLzl+hZz+lOK8S5LNnGTDD/0QQssyoZHDLZMf6CJDEQhu7eIR
         RPvOVCeasOmwrOnWWvge6Mw//obAlN6kpLC2XuYeuozbYpHU7i62487Lx+ee7keIy1JZ
         JAVamz+MkR7DQlfb7wGPQ/8usqzX1dbOPUnr9OgUHShldumCkROvWY4qttm/2edjf6Ae
         zRcszmInnQSV+JQcYk+rnXU0ZY88JO6X9nbo1lbZ0ja1sHkrcIKToK443yrdlthxETJ/
         w2KSf56Joj0ohhFRY3ByH5y9LN4w7RFGqfU9Cul7yzpvs/mg17gP80D4Omib3dELYCo0
         65PA==
X-Gm-Message-State: AOJu0Yx3sTn5yHD30omcwbNrh39QkzMEKltvnnt+HWBekeYUEdCGjVQs
	4vzGFCywIEXzd6eNK02hUQ==
X-Google-Smtp-Source: AGHT+IFDrHspnvKuenVIbRjl9CRvmdMX81M4w7ItmvD0iLToeDyGrX7vrPKDbuRf+GpqgcsCzRAfNA==
X-Received: by 2002:a05:6a21:3393:b0:14c:c511:387d with SMTP id yy19-20020a056a21339300b0014cc511387dmr23752753pzb.9.1699021521241;
        Fri, 03 Nov 2023 07:25:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.98.82])
        by smtp.gmail.com with ESMTPSA id 34-20020a631562000000b005b856fab5e9sm1394406pgv.18.2023.11.03.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:25:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
References:
 <02d38d6b7a98765bf516c90541d4f2a911f428ce.1699014584.git.geliang.tang@suse.com>
Subject: Re: mptcp: add validity check for sending RM_ADDR: Tests Results
Message-ID: <968f1ade-5d84-e7ea-bd2b-fd26b77e6574@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2023 14:25:19 +0000
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
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6042959330672640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6042959330672640/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4776321935474688
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4776321935474688/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5480009377251328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5480009377251328/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6605909284093952
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6605909284093952/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cfde3fbdcdb2


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
