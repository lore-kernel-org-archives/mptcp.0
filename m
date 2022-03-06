Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42810EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:48:18 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so11157915pjl.4
        for <mptcp@lists.linux.dev>; Sat, 05 Mar 2022 17:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=xoJf7CMJU/VA/ZF35FCu0QcE4uYClUtg27kN/2ZdwnA=;
        b=Hh3ixWZBhe+qPB07si8AakUlISZ7K0BUNSqcmNqGu0zzcHgFSxv9a+22ciMEh5YkDt
         NVoJHkoyKUc73nkt1xj4j8aJ/wtwljhccovsd4rtSrm1H4gpBoCqYgWugkVGJg6OyaM4
         qPUADCBxdxfarRLDjgide3ccUWrq397w59vh+fn5tS1xrZz7QnSAQZYeS1GYqoQL6FDC
         wbmFCLrW/ejOMjnBqXr5LSjofr/b6wcpyuFS+vwK4ecE/hn8558ZCCK6dZsTKwnSdtjl
         NCitPgQmC2C8n8qdVz42TYavprsBt+ZIFWKsOWtjmG1Vtuoz8hYWm07nByDOYrblKPi7
         9cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=xoJf7CMJU/VA/ZF35FCu0QcE4uYClUtg27kN/2ZdwnA=;
        b=OPQ7wFDhsANO+hEOfim5kfcITqYMdKQG1lx5wCcWw16zyZrEFzyoui7NOvZIGBAKv5
         O3M0DgUs/2vRWvNx2/nYRBHFGeYcuyjJm1VGuxXu/gnfG1AH14/jivwYFEFI+AHLCWKM
         MPp7GzkQ9wdSA6rWWezO//UoNrkhdEQt2bm0ZRSVzHaYTuwvc/xLtWGBPb/b1Tboc6H/
         ceg34Csei/Spc3WbI8WF6BTe+l98ZKGqnL8iCtSCTMo8wvXt28d3SH/Lu7LvFm2mcm9/
         Dc/b4NvM5Cr41Jz7Yppe2h6BDQDeXFM8t6jwaHoeuw0kY5MZ9D6Iyt+LHJhGSobEAgCF
         h+kw==
X-Gm-Message-State: AOAM532XGaHFMbyqD+Fu5CEvDURY3zzIvJTHoxbteWpAeXErkf3WCQtL
	3x7jzmO6iT2xDL9LMxZtW55564CwUw==
X-Google-Smtp-Source: ABdhPJyfR3owxYURnCQ7lRv9WY7hQfq9SAoCe7R7fBA0Zq7+SfDVvz1oSyL5byla6bMrVHQVnxjXZw==
X-Received: by 2002:a17:90a:4411:b0:1bc:99b0:acad with SMTP id s17-20020a17090a441100b001bc99b0acadmr18381235pjg.25.1646531298262;
        Sat, 05 Mar 2022 17:48:18 -0800 (PST)
Received: from [127.0.0.1] ([13.88.101.46])
        by smtp.gmail.com with ESMTPSA id y8-20020a056a00180800b004e156f7191esm10458408pfa.213.2022.03.05.17.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 17:48:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
References:
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add skc_to_mptcp_sock test: Tests Results
Message-ID: <a67f0632-8c58-3cca-7fe1-077874944b65@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Mar 2022 01:48:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/6291582512005120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6291582512005120/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5386436542201856
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5386436542201856/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5890857c7ca9

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
