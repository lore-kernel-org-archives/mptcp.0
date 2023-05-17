Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71618211C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 12:05:55 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7595561f2f0so40613985a.2
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684325154; x=1686917154;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3nRDgxld1rM1ZDlBR6ohJtRR8MB33rm+r+539AihSk=;
        b=GUINvxrokAZOUor9Q3W6AGpc0E0cOX/cD+DrgQl/GHyQn+OOpqv+wc0h43/JrWJEoy
         s1fL1astZ7HuseQ2T7exN9hbj191r7WwOxxQthDWCJ/CkBu1+y5r90QhcpfWsZSwikaq
         GrCenexCccyr9zd+aaWM4/mUtLFj6d6ZxhFhyEOVHMry3JJ6b4kkhOuTExfRmaiapDF6
         ZJSF5UkgrTT4K9vjI5kQGsXFoC/dB9sWKS/6/AzZ+3D+bnY2JpwXBBusjiFjT8eRHqAh
         7ouqxJKZbf5xMXBKCjOnBtaKMOg/GzJJG7WtU9P0bJLKDVl9i3kczPCgEp1hEVGz7bcC
         /jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325154; x=1686917154;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3nRDgxld1rM1ZDlBR6ohJtRR8MB33rm+r+539AihSk=;
        b=C96sEAbSPMn/Ciao53Uny3/pTuOxv5rLjUx6d6KgPxmvZaCSqtAZKGkkIpAHR6Fa4W
         RAYhK2WW8xuVWTwvVKb62FHekZld3ohXwFwmNSZUQzWfDc1u4K0VEiur+pWK/jEyi+Fa
         F5WwTX1YsK/VbIHoxoZ+4D2XtPXRwkSAa3EmBXYL6wjLFEx488huIikTaCvWB6Vy2Jx4
         Sep9ZttjD3Do4gFBgZHhd19s4PHx3VRsIB0N3RAmiOgXZMs94/jJavQIm6vijSrU+A2P
         RH7WOs/j0zoEk6rMaCXR8l/ZhQ/v1tXAjzz0FmJQauQPKOGlvZ+bHyL9daFQxyT8sb23
         lEYg==
X-Gm-Message-State: AC+VfDypvEkck9AOkfQhf+OEqPdxE/zXETiW8KVzsHyjT+BVA3tEwWLR
	rzISUe07zz3YelbLPjy8vpxaaPdw7coA
X-Google-Smtp-Source: ACHHUZ70w4+9q+wluy6W/eWUzI3lQOWRcYWajCFWJpgpELin6fVo0/FMqJi8uPxGDoUb0fSbnOpfoA==
X-Received: by 2002:ac8:5948:0:b0:3f5:a0a:b30c with SMTP id 8-20020ac85948000000b003f50a0ab30cmr23356555qtz.42.1684325154279;
        Wed, 17 May 2023 05:05:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.128.131])
        by smtp.gmail.com with ESMTPSA id br23-20020a05622a1e1700b003ef2db16e72sm6942799qtb.94.2023.05.17.05.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:05:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4ea2e7aeea3fdfdaeaca9aa431ca66df205f68fb.1684321532.git.pabeni@redhat.com>
References:
 <4ea2e7aeea3fdfdaeaca9aa431ca66df205f68fb.1684321532.git.pabeni@redhat.com>
Subject: Re: mptcp: add annotations around sk->sk_shutdown accesses: Build
 Failure
Message-ID: <144bdfdb-b1ab-01ff-f89e-264b4dbeb4ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 May 2023 12:05:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/4ea2e7aeea3fdfdaeaca9aa431ca66df205f68fb.1684321532=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/5002837724

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4d1ad0619b=
22

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
