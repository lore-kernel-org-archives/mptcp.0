Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B62C9E
	for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 07:18:58 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so7303395pjq.0
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 23:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=oZmlR9aa4bYi3wRlzMCQz6rXM2HDEE9laCsldF9z+ac=;
        b=WxwYrSQGw3iVVUEQJKZ3BGdMh17005e/4XG6eoxhPS5xi7eS6HkXacOsY8d6oDa8AF
         /+rrIssRpx5MkVu3AaU5iw4tuyP2ar74HJpY0r7137MNTKnYziC1+xWg7wkthe+67D8s
         92heTrnmBm2gg41ByY47DP0D3ZqSYBDY3AaYHDJt4WTdbTmBLNWKw2+u72Hj+4iTRW8X
         kXxqDfPrKvFmzfSPSS2uzH71SMYQIo7DdkWk9D1GozVxuGvDJixRerBYv+15BwZYwvhq
         UWObRZke3wfmDXK2r6Ndyf35Jd0KRutF2sLWpJWIj1TtgkY5xLzBfH2n9knrDauWzwaJ
         YVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=oZmlR9aa4bYi3wRlzMCQz6rXM2HDEE9laCsldF9z+ac=;
        b=HHPa8ReAPxxm4w855mL1Ge/q0zqBoSeofBjhlZCCwLQ2wmU+Ff5RdE10+0+we8QXMt
         TBbGIkTcpJ/IwJ9P42zkVe9K5nlk5kUgTMhcWu1nk+jctXGYYRvYYlD2bU/eMktzSFxE
         QJj0j6fG5aAay70LTc6eSHfIwbTHiy3BEh4LD1QoZOxkt5s2ECTTfYrzaLkqHD0mZ9Nl
         WOkWjyHadt71jaEM5Vb4Xx5yn22/geXL0aHD2GDyLPJPxMGHFvDW4d62ALdDj1SMz+kY
         anR3shor/nVHbvoO2sCJuOBH0p5YT/BB8qICoRfytgV5R1fJPOSsq/xY2WLsFR5Th5XD
         ihWQ==
X-Gm-Message-State: AOAM530gvFnNKmeNKfyjiQBo78cXd/CjvjOHGTlCpjx/jj9rTlf0eYoA
	YByc7byI8a8G7g3XRDrtJF1Pk1VybA==
X-Google-Smtp-Source: ABdhPJx9yevY4lQ/ldTpUXbxaCtF4D8rAO9lzruh2g/8ucWR4Xbl9mzjxLXqn2S1hPtMx7az7hSF3A==
X-Received: by 2002:a17:90a:970a:: with SMTP id x10mr13936043pjo.41.1643440738253;
        Fri, 28 Jan 2022 23:18:58 -0800 (PST)
Received: from [127.0.0.1] ([20.69.164.6])
        by smtp.gmail.com with ESMTPSA id p21sm11779868pfh.89.2022.01.28.23.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 23:18:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
References:
 <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
Subject: Re: mptcp: use nla_parse_nested: Build Failure
Message-ID: <6a2c2ab3-1d18-0e29-5cb5-c3a7ccccb0d4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Jan 2022 07:18:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/022caed0c9e5964f525336aced8233338c29386f.1643437533=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/1765070423

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/8e73ec0f9b=
70

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
