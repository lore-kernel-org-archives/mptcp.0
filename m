Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D229CA
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 21:31:10 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-76f066e4fffso20630085a.2
        for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694640669; x=1695245469; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYphOZEwyn2P9IhxJKM1qlb518lQjXrA85n2oPu2Gxc=;
        b=gFEVC0UNj5xsP7RZowujg1caVNB73FwqAIv+KWCuDRqTA9SqhGwvFKv2jWRH83NO7p
         QgppFUvM8vm3Bu+UB1XPIpqRhhOkExKLIq7A0KPAJMLx0s00/ZPgFXJwV9s4UWZcwvta
         rUD1EwEm/IDhSJte1EzxlZGGJOhnsH+gr/GAs0KxgtV01wPOstQzglzfAYjoafIIOeyL
         R3wwp38zzvFlbi9kmLB09hWR5+GNo3xjy0Tm3ghK2NXHHDHKxCHJZu1tMw7QvL005b7S
         RQcCwY77KtQ2kIT68iomy3ycnv1EjHZkyTTJ+qHPvWLX6gMRj0WARBgPaIqZGgoNTNQ4
         HAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640669; x=1695245469;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYphOZEwyn2P9IhxJKM1qlb518lQjXrA85n2oPu2Gxc=;
        b=V9XA88JN+R4ef6eLme3ekIKRb651vpC5st56jIdHHRExrHpSRyMM19PC//GTcxoyI9
         +iENZcs8VePupIIl2ILRfe2ta8aRkYG+nm1NA5fPsDiPlvtXRYzrU9Zqx8sijg+agSue
         O4mcfXEXwt31bZDklRvucx84USM+Wl9GwygA08fqCRKLwqE/XPeH/3npyy33z7R6Us+4
         DpnQR10DMQy7jVRMJSjO/zSZP2hEmq+N5PiXx32xSYsoeTZ+WytgF1wCD2N9HoB2/+93
         ZzndUVesLVVV6BBC3Y32KuJGA3k57L/aAwMJt9dnAKMZftkhVuzVB0BaO0NG80a2aSi/
         axgw==
X-Gm-Message-State: AOJu0YzBzlJyw5Yzf2HVi4cgD6ojfm+HarSuNviAdj0dYTK0PECX7LPC
	ZvKbuAfWuvLz1VnEgWJS/Q==
X-Google-Smtp-Source: AGHT+IHa/Vs2Ms3vEWxfQiGID6I8w5sa4LXmLvcPpXoN9dt58hQcK+SfW8OqDoPs4C8eBzokAFsmIw==
X-Received: by 2002:a05:620a:2415:b0:772:6364:1409 with SMTP id d21-20020a05620a241500b0077263641409mr1666322qkn.10.1694640669095;
        Wed, 13 Sep 2023 14:31:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.129.245])
        by smtp.gmail.com with ESMTPSA id o14-20020ae9f50e000000b0076dacd14484sm29498qkg.83.2023.09.13.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:31:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a05184fa538535641415747b2d6bb83b5a772021.1694638162.git.pabeni@redhat.com>
References:
 <a05184fa538535641415747b2d6bb83b5a772021.1694638162.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Build Failure
Message-ID: <7c865728-a0dc-9fed-86a5-141e981a0128@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Sep 2023 21:31:08 +0000
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
org/project/mptcp/patch/a05184fa538535641415747b2d6bb83b5a772021.1694638162=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/6177982021

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/fbf3ee142d=
55

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
