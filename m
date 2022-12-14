Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B081BA24
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 22:15:26 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id j16so3722743qtv.4
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBQnBZIQwKtjmEjtLfbfDi6oWy4i1Xww4DPROu3AHN4=;
        b=h+B07/a5+r2Tk7I/3LtBkKLH2FaddVIfit8j0nn8H0nQlpLbd3r/rHKDsewlPD94Ze
         f2wb8sAFA4oBmHHTQGmzvJvBr2BuJ5vjBeSn/WdfxEqSlXNu95v2l81oDKS6OeyZelWZ
         hE0CccweXPHUMDDVxUkT0TEHe+UYgM19YWvypnvAgdAOkh7uxPU5M9+R4PRYnMvyV8eY
         mXFrOVdqVtMvqBb6lbw4MNzB+MJ2dkq1UM/QlZ8psSfmLdzLkP8arMY6iSoe5/kzyF2z
         xa4K+4s0eSkiWjOed57fZOM2j3tWILHbkEpp8GYO7tu36ui3ubRcihO2+/JNJF9KSs7+
         XXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pBQnBZIQwKtjmEjtLfbfDi6oWy4i1Xww4DPROu3AHN4=;
        b=tIcDJxFrQmCEZ2X58vd4Z6c5rnsifmSyHBgYG2YsHMzZ4vuQZyxMsNIMoGUZueNfT7
         za6F41k6QMV1YxvyCjZNLbVwdnqr5p6AGh9KQjN1oVcBDtTaKPWjHaL6llOrXV3nmUCn
         sZcJhmO9zf1dBFs/5acRuEOQzmXjGJAvKMIgMuGu2fQDC4v5haKD5uQCCGBNrjMyVn6L
         w5tMMOIIBiAPlUmiC8vOq2sXr8zIBKUEBP74EhnNwqxu25w34xUQ1BdwxB0F4zzXgSwn
         CSv8exoeEVN3z+4oNzy6PFS77uVLv1Zv5B/vrqNOtLa0qfVKVU9ytagLiNyRiVvF1cST
         J6Fg==
X-Gm-Message-State: ANoB5pmtKv/xOp+7UwNyZOW2GPXoUgyPZ3AWr0v5X/vc0YpmddmqCBpe
	mfsGDNUcOfqQGx39BhaIhA==
X-Google-Smtp-Source: AA0mqf64yy2jA3/EdwkDog5mkZgY3em2XLKw18VB09/Ixm9FT9WKpK3UWFivKMX1ulUDHItp8SOQJA==
X-Received: by 2002:ac8:787:0:b0:3a8:1ca5:e7e2 with SMTP id l7-20020ac80787000000b003a81ca5e7e2mr15639994qth.7.1671056125568;
        Wed, 14 Dec 2022 14:15:25 -0800 (PST)
Received: from [127.0.0.1] ([20.242.81.114])
        by smtp.gmail.com with ESMTPSA id r10-20020ac85e8a000000b00342f8d4d0basm2377314qtx.43.2022.12.14.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 14:15:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d6f04d238c8a797899d6cb543a43f75e544221af.1671054577.git.pabeni@redhat.com>
References:
 <d6f04d238c8a797899d6cb543a43f75e544221af.1671054577.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Build Failure
Message-ID: <8df32a3c-213d-34e1-055a-06203c766003@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Dec 2022 22:15:24 +0000
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
org/project/mptcp/patch/d6f04d238c8a797899d6cb543a43f75e544221af.1671054577=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/3699109654

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e34e1ddf3d=
dc

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
