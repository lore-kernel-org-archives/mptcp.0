Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176A7E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:17:21 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id n10so6225909qvi.5
        for <mptcp@lists.linux.dev>; Fri, 20 May 2022 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=0EwCPfD8gq8XN2d8yZ1AfHDZoXvJmyaINrZOGLiIMYo=;
        b=L+4ytwQRI+BIeW+K6CvZOLL1xvCoR6WRfx9suA4sICyi6QxKgu7eqEEYh5+ajceJlv
         Cqb02GTi3Akjyw1aRsObYnUN9z6r7hTiYnhxMU+fPOnjvLMuipIHFP4zWk0ZmBz2uIRN
         BWJu7mhAqwlzcKx8gaK4RjN1x1ApXUUmdxVq2q+/Nl1eUKodWBW9uMRCyObyAWvfL5FR
         GKHgRhTB/9UOJ1gWgrGb9nL4KWISoqx1X72EzIWTj1RhCwhsbZ7ovF6He5sufD815JPz
         7uy+J4y55pSKbnsye1VBypIGn/+/M6xAbepi8sxasKlI3SsgdYBeTufT9J73cZ8tnv/I
         WMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=0EwCPfD8gq8XN2d8yZ1AfHDZoXvJmyaINrZOGLiIMYo=;
        b=OrKcHElwNtE7AvDunCAy63pCAH/OXTI0ilTPshYSzWAOeyUOo+T0go3wjJH6GhqNSm
         qcPvizU2cihmcPWQhZhLIX5RpCOiA52AIXt/pGAupGf15WbrE0HtCALo3lRIx31GC2VI
         YnYO7Jc+Qdi1uh92X+/8fVsM9vnMncij9ZMf06LezR6aaOzLRHyEpa0ckgiQIoRFKmJp
         K0VVkGStEIsAAYxRZNKU1KOuiNQzyj0vRU51beDVYwlTUu8QEXVxJS04uIyVQjRfa9kN
         txDHzCWcyT69s5k+JHsZCzzAdqsqPAWlPWreWKlANurpMs5DnElvWLYQXE0vMlSU2hJ2
         VBRg==
X-Gm-Message-State: AOAM532a0CtH1ZtgBjyV/UPQyLN+6ygvOOMawmwi5GAJRSSV76BFQUk2
	JIq8cTrzEhQcs0fePyptHiVfTLnk/Q==
X-Google-Smtp-Source: ABdhPJzRDtQ2oTnRTeg6WKEkRq5tPEAhkTqD9s9Dymdp/vXwBZMCuY9ObpuZX1S9mtW8zUNFBDROBQ==
X-Received: by 2002:a05:6214:21c3:b0:461:dc8f:47f2 with SMTP id d3-20020a05621421c300b00461dc8f47f2mr6992338qvh.26.1653034640575;
        Fri, 20 May 2022 01:17:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.212.116])
        by smtp.gmail.com with ESMTPSA id ci19-20020a05622a261300b002f39b99f6aasm2814734qtb.68.2022.05.20.01.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 01:17:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d232fd9eb44b9e665bfb03dcda7863f428cad7d8.1653033459.git.geliang.tang@suse.com>
References:
 <d232fd9eb44b9e665bfb03dcda7863f428cad7d8.1653033459.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_red test: Build Failure
Message-ID: <7a91a027-244a-d943-1bef-c628b5f8c5ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 May 2022 08:17:19 +0000
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
org/project/mptcp/patch/d232fd9eb44b9e665bfb03dcda7863f428cad7d8.1653033459=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2356992779

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/806258f333=
e3

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
