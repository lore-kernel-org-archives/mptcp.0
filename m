Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCC614D
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 18:03:16 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id r1so1825907qvr.12
        for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=RYPejttbHzLOIWT8ngJQ24Z1Z+3k3Uy6ijfDOLHzasA=;
        b=k0TZaU4ruF5Jb86Tuc5+6q2PLuIqCJTKDOt46Iqr75N8Qwvlxs+NAUIRaqG/2yXBcT
         Fe4rtfKZU5qvE5Vd6jjTLFX39n2j2THgK/g33a4/vXFeDBqDoGN8yCe96gth2dZiE7QX
         0Yl2n6CgZykmWl+xWr7CjJgFtGRSkXqGIRDGaXZ+i7hl1YxByZmcKqiwVfgT/gGix9UF
         FsunopUTPAVpnaOrXNwXm4KpmlbAOIbc6jUhybYMg2pRX4iGFMaMo4BSi+VLsu7RYgmJ
         RfTjt2cmj72Ciq2AdmH4krxpnY7mu2x0MwNv3nI1qkqZJv5r+tUOuRXCcrhdpwv28iNt
         aKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=RYPejttbHzLOIWT8ngJQ24Z1Z+3k3Uy6ijfDOLHzasA=;
        b=bTZb2Hw2R5fREKz/gxiYsK8oIVpnvU+kv2s85BHPj2//dEHVBXQUhfIuGFyj2MdQ4l
         oJ1tRZstL30if7dEIzyBdtg7Tjthx2SHATVY6ZvMEGfIUlD0ivBrZqPo/ad/yMGCub9F
         ZpmTl5zV4L5aIFJ9PHGfAn9GcFI8iyP6/FN4qEAcXGl3vpoDqHclToSXA3XMB4FrG4Ly
         YPXFf7ycNw/TGC7OzMx7ryW28XtW4g5VSXP8CMFB2jUnGwhfIMiY62GgvW0+4eLYPU47
         6LKqOziZYjYGgnyT5B+4xH6+t5yy+KNelKp+T5L9iwK5pV7PUxlgTDt35V1XUaE/uSz4
         Zklw==
X-Gm-Message-State: AOAM532iGQ8jedKhvg9vcPkdJmb8YYnoPG8UzU3B1Dp5iWvGw+u0or6N
	qjMqGmJ7hIQq+JfYeQe1CE7nh/5MsN/t
X-Google-Smtp-Source: ABdhPJyrFuYiFkeuCs9mj9+sdQ83Dt/J54eFpgNMDGyGeACk0OW74Oytj6ZL4ALLfRXUj/xE8QHqlw==
X-Received: by 2002:a05:6214:23c5:b0:435:3700:d65 with SMTP id hr5-20020a05621423c500b0043537000d65mr846205qvb.65.1648058595109;
        Wed, 23 Mar 2022 11:03:15 -0700 (PDT)
Received: from [127.0.0.1] ([52.184.179.134])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a22c600b0067d247816eesm315398qki.85.2022.03.23.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:03:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <44d42216864c1ec295ddf7098327fe5603dfc448.1648029714.git.geliang.tang@suse.com>
References:
 <44d42216864c1ec295ddf7098327fe5603dfc448.1648029714.git.geliang.tang@suse.com>
Subject: Re: mptcp: add pm_nl_get_pernet helper: Tests Results
Message-ID: <b49c4eef-944d-0a95-e630-74871017c5f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Mar 2022 18:03:13 +0000
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
https://cirrus-ci.com/task/4538361393184768
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4538361393184768/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5664261300027392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5664261300027392/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9006685c26dd

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
