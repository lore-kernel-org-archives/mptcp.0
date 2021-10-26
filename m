Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96D72
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 09:11:23 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id k29so9067289qve.6
        for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GT2AMg93YIcPKEsmYIHwx3kNn6fGCmwXcvEkyBWnZaA=;
        b=hnMlmYnQP78ykKykBRgaeE1+KKFEXUHEp9ASuNtgx3dkUTcsBe7HW4JrkprcIVFeEk
         MBOvPIscE//WXBkTL9YBDNSwp4Iy1fI5RRt/WBs9Ou9Am2pcYan6VS8hnKDTwt5CkWJ/
         hC8ysilUnxs5LwqABVB+dPdyNPyWCKJ7xuDkgTK5WSoZ/k1Uy86JsgxsF2vhwR9BXX07
         57pTdl46vXB/k199mz+XxnN//MzhFVofmGamk8TdOBpFtn3S60itB4hrZU+OTGPmEgn2
         Lkxr6gGqlNOPH3JwFF7OsCthQHbY8MBVZz2ATTilgVBW6ZUaGPoHxcqTtoc4SuWCvANT
         agwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GT2AMg93YIcPKEsmYIHwx3kNn6fGCmwXcvEkyBWnZaA=;
        b=RXaJtgW1AB2m8hXJ+oLm/ZNVq4O8SB07jY4DnAY8UKuZXwd58+fRBzc0Hle4VUB3St
         CXzW6veWfM8V96LtK5CuwmWTbKzM1NS5fvO7HzRD10e5CiM47PAw04dyjqsMv/29rhuH
         68bjAAk0CpExVyEyyZY8+xneXL6DekOQd0A4+IJ6b319KxttkmXo3b7bvA3q0sUSXSXO
         /9HKY8N/S232EbANwMQo2wW2Di/xVCkMMVuxT7HUai9ekCSdrdk0kz4B6Wl8Ia7B/7qU
         WUQGY8sncS7rISj1qkxiMYo65MsDlk4Dblw9eUriYifSUrOQWGNGDKQuM9Uo9Y5EAjDC
         E+yQ==
X-Gm-Message-State: AOAM530B4r6BSwIyfDJT+UlnJn7vld6LXFISRmCTIMoxkmMof131vQmB
	HX4ye/r+s8ukh/UVeKxqVA==
X-Google-Smtp-Source: ABdhPJy1JKxJWquBeiZE4rNQy5iyiBt19aHaPE8TeB0EN8TpOp19DqjqrEhrUa+aL6MVvjPhGTQ0ig==
X-Received: by 2002:a05:6214:242a:: with SMTP id gy10mr15598971qvb.62.1635239482826;
        Tue, 26 Oct 2021 02:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.123.51.188])
        by smtp.gmail.com with ESMTPSA id u11sm8726661qko.119.2021.10.26.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 02:11:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
References:
 <1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708.git.dcaratti@redhat.com>
Subject: Re: mptcp: fix corrupt receiver key in MPC + data + checksum:
 Build Failure
Message-ID: <de64ca52-ddcf-64c8-d734-64a821460929@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Oct 2021 09:11:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/1207c7d44dd4d1a630afc8b7018cf4185fe4a489.1634827708=
.git.dcaratti@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/1384886524

Status: failure
Initiator: matttbe
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/fc3ad97033=
cc

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
