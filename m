Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812D7A
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 04:58:25 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so4145704pjb.4
        for <mptcp@lists.linux.dev>; Tue, 08 Mar 2022 20:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=FRU82el0mLfTd87iohAb9MZsCVrssNDzY8fdp4AY+8A=;
        b=kg7Q1na0xpUCM2ScjdGAzXHwdT6YTYk55tHFQGZn6/tUp4jBPUEyqFU5ycAktecSjr
         Udy0jmymX+9LsPkYo8k/FfYHF5Kc7wjGofFuEs9Puktd+eC4ei8q3qDGbWStb+JQWQQJ
         4AicyjW06c1NIWmxepbPPBG0YtP4A+e5OxbHaVJOazEqXgsCW4yDsm+W8qA5sojZmmOH
         2QHGgfBavgH3eHFd2in82XnztxoHO28yootiu2QlZ7sXC3zk5cGsmkjElb+VT+jxM/8v
         szCXtps1Da7cC9hKA0CK4F4a1r832eW+Iwy9fcLeJsWuLNl9l11Jv2l0rZPz7rWe1TSG
         lFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=FRU82el0mLfTd87iohAb9MZsCVrssNDzY8fdp4AY+8A=;
        b=0XZiNSaOnYPUBKmppxfJbehn6+VXqNGbBD9oS2+iGAwYPPcdvBeYQMQRdNMN1d85bV
         2aHh3+GLD2x7ucsCmSp8rR/LxfaNjLJtE2vwpgDxJo8LX9hGT36KW8Z4ScQdv/oMKCTO
         CzBK0BYVMEK94WyWngDPuncP5QWo/Qb6tUpedAae2BfqcOm4sdDweKu8Dzd8EdfmSjb9
         OiOy5pOTcRrMejjIg0NPR7iR2dDV9ViqbRFFKQSJ0LmByujqW8s7RNgrK3buHnyOBLML
         vU3MsN6jwcgLEYhRaFxMsQ6WRc+2W7WpJLQlPn5JvIguwZUHwaZnWUEZ3IqsYmCAFE9e
         GcZQ==
X-Gm-Message-State: AOAM531A+8O2y4BniV/HTaUEtb/WZUQ+oQLaGQyzwQx22b7s9ztQuGle
	x/vGp0PrM4HurHwsajKt63gf9nBXiQ==
X-Google-Smtp-Source: ABdhPJxQTmgBJ8iPRMmwXmQDoCNAvqXkPWCHeToVd1BWXoUNQYCXStkSu87P9JKmnrrXb5BnHBA8Iw==
X-Received: by 2002:a17:902:a40f:b0:14b:61:b19e with SMTP id p15-20020a170902a40f00b0014b0061b19emr20842123plq.20.1646801905392;
        Tue, 08 Mar 2022 20:58:25 -0800 (PST)
Received: from [127.0.0.1] ([13.87.203.201])
        by smtp.gmail.com with ESMTPSA id w6-20020a056a0014c600b004f7374ac18dsm826153pfu.195.2022.03.08.20.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 20:58:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0d5df55864d6714df55af8b281d1c4540f0a9678.1646796538.git.geliang.tang@suse.com>
References:
 <0d5df55864d6714df55af8b281d1c4540f0a9678.1646796538.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: test bpf_skc_to_mptcp_sock: Tests Results
Message-ID: <ded788b5-6540-8a6a-3c15-90b6929c7341@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Mar 2022 04:58:23 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5808597534769152
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5808597534769152/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5245647581347840
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5245647581347840/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/62f24fe03084

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
