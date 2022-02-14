Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E949C80
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 20:08:07 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id de39so5865404qkb.13
        for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 12:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=hL0bvhX97JeUey/t8qNvIp5vkuq2fdSJXinKhfnhQEM=;
        b=IdXdjwzNEz7FfjzFkS6XFkZAcUYdRTzUsxZvvW/cE82Ap2+SEaqt/j9RvfIpaYdS2o
         dxGDDP0CmD+mZHjJqQm8C3Bjo6vA3k/OMeLRoq5Z7b5rwQcYF3OfzHiX+ys4zcUOUjHQ
         kMxkqwHdBojq3AfZnDP5r+0BeAnnPhCCXz1NMf+sU4QQx4j30qANFXmyjP6gwzqqQKBY
         ay35Fv+kT7vnJTe1FDmBlagwIfiSgcn2N5zMNTiIaaZUmJ1cMLersi+1DxhY0MtkoZMB
         QlLfPQOp7aaGzMc/A+mLITClKIwh8KLkMg8jWHGK6deeOQBfVcf65yUhNbaEGbiHXNWC
         KPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=hL0bvhX97JeUey/t8qNvIp5vkuq2fdSJXinKhfnhQEM=;
        b=TUTsLlbBtTjpl/ha9PEzfDGQvhoMgUPxgUDqfw3lGCeiNgebxQGOfMaFIk1VZF+NlF
         KWGtOWVW8mzfatmzSU3Ez78iRkU5q0yoQ37FE9AsG8ViD4ruKS4uxa9JP6Pp1oyjuk6c
         qF/tYLTHL+tTEkQCfRr55hJWC/rPid0+7+lGmNNjSh3gHYH+iNIaqEHb98jNvphjeBQc
         +oUsOmc1N6StsFyYDhKU6PxQfph/GHzmxTdBpO/ViuSWCfd3SDuF59zyiA6Aj8JwQ7Pv
         0olF7js9J6/VdA72VkFIRnv2hJ4vkMWC9K441CSDSD9NF1VIDrGA8gZr2SwIo9ohC80R
         NQFA==
X-Gm-Message-State: AOAM5336egoQO28ZQDLnQkNq7FEY+TWwq1xdMgL9z6gRFVODPnRlrHQ3
	hhvQBSfuNjZWKcHWb6yaLHg8m0BGMA==
X-Google-Smtp-Source: ABdhPJzfMofwcnjDrqQwbmiNWEpLGQ2Lhh/n8kpHzVXdn1RciB57M+IB9rDSWWmB3SLpfSPt8pOLAA==
X-Received: by 2002:a37:270a:: with SMTP id n10mr352281qkn.422.1644869286286;
        Mon, 14 Feb 2022 12:08:06 -0800 (PST)
Received: from [127.0.0.1] ([40.121.11.31])
        by smtp.gmail.com with ESMTPSA id f20sm19113635qte.14.2022.02.14.12.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 12:08:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
Subject: Re: fpga: microsemi-spi: add Microsemi FPGA manager: Build Failure
Message-ID: <4c8487e0-fef3-a905-843d-99828ad4bed7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Feb 2022 20:08:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Ivan,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220214133835.25097-1-i.bornyakov@metrotek.ru/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1843014032

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6087ab4681ee

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
