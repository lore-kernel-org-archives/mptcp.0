Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C957F
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:57:52 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77acb944bdfso168039439f.0
        for <mptcp@lists.linux.dev>; Sun, 25 Jun 2023 19:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687748271; x=1690340271;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w42EDVPsVqkYG6w+LHbvM+wcexmcK8EKVjNx2r3tmeE=;
        b=kXA7Zq6ZxFkSChMHjei7exJu29MlY443v/u9c/b59IXrilPRi+HhcezClKUI5x8tPc
         yVpGAHXts8a7hCl3X5oexSzIG9DGsFBXzwX9irv7lQtg1DNa9QypqemB4PQy9RRYTeei
         Nd9nSw7Jm0krzljEIVOeKSlpgkk4QSR7oVcsXeBc8OZSvoaJgpcs44GFmvifQpbz1/jx
         FporlCrvnDBb+P2r7OJWYZsAIKyQGS+J3D1U43Eir6rcNsjmNaeJEfTPGfpBGydayJck
         hhKtmE/xKbpPcQfFyXTWa98+/3X+tI4tpnt/0hS4ZfwOETWAlBVAfp+pUjAlkyAdwn/Y
         YmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687748271; x=1690340271;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w42EDVPsVqkYG6w+LHbvM+wcexmcK8EKVjNx2r3tmeE=;
        b=WlGmiPc5vMZyztPKsukH4jOzhOfjSVbpYspqQ/cYEM0WeEkTgXXagoa+iCxBBQheOH
         AYyz8bWB9XK+LEARDb3tgCxvVQgT1lw56nGdB1H/txxgPcCUrpfvuxPiWvFQGrdpGHlf
         6Z+5FfUN0tDEL33j4bpqKSVJlwdpwUh4Il0M3czg3Br6/NUz32l593YnKyNE5YamX3Cq
         ootWmgeSe0oI8PBZJThiPUFGjObUc8A1Cpy96rHwYfl/tcpAh998dKgd5CY0BJ5hMWsR
         idK64XvdiEkcTB1zoVLEe+niSeBmZ2ts5111zqQzO8LtjoHu2lep+W9EdR6XA2ivZ2IG
         cAYA==
X-Gm-Message-State: AC+VfDwAc3xlidQCXHAWNedJ/Jd3kGfEjfAZIB1gc0MwjWKblZmBUJ7w
	5Zafh0LjXrM91tsjPSbisw==
X-Google-Smtp-Source: ACHHUZ7xRSGQqA/c9uEiFrszrgRYgSmojAAMZ2CGbkNs/Ndfxcn2K/VvtMp6FE5kfSCfQ0DfIHEBBQ==
X-Received: by 2002:a92:d581:0:b0:345:aee1:eae8 with SMTP id a1-20020a92d581000000b00345aee1eae8mr205519iln.20.1687748271597;
        Sun, 25 Jun 2023 19:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.243.240])
        by smtp.gmail.com with ESMTPSA id j26-20020a02a69a000000b004290985a1efsm954873jam.43.2023.06.25.19.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 19:57:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
References:
 <cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_scheduler=22=3A_Build_Failure?=
Message-ID: <6ddb1417-e654-8a72-c9ab-a89ca03a2150@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jun 2023 02:57:50 +0000
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
org/project/mptcp/patch/cae101ed32a7f97ffcd7d4e25e7c96cd85819e87.1687746021=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5373236226

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d70b6a579b=
b6

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
