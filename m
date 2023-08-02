Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E227460
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 12:22:29 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so4811838b3a.0
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978949; x=1691583749;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6i82j5BoGjstjiiWsPcs5gtMBtPs4w8R/FXnOvs3y4=;
        b=QeJXzqnQEEVPAoadRUsS1wI7Vp84iCAvAdOgVwSLQMLumtMklYkG//dCU2WMKNHg/6
         JNqhI2BRBb38WiEc3fXmfYaIpSjXRcGZERjF4Ty9Pl2o4r75U7CDLiz+prxuX+XNbOjH
         H5VhZQpZOh9Wm5vZwV7RGybpnli7CRMq1atGWJ67toI4F71ZGnLbgUxOQBiXbepq9Rlx
         FVjWDCHvZP7AX8RZGs6oicefP5+jCI2r5W3DdaHxODxFgxmAIyqPVqHR+Kux5vlt3Fl8
         /RFiR1ms+pVjqNIMwCO/Kdk02hUIbzk9nIYugOcB4cR2mN/vEF5ynUaMBUJQ9adQ8xcg
         JbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978949; x=1691583749;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6i82j5BoGjstjiiWsPcs5gtMBtPs4w8R/FXnOvs3y4=;
        b=aVrbrMtSv6pFZUs6bbOHQVbJdLowSPKToLeK9kHAM3ccAdHeDDka/mx4z2v9RS0sA2
         Z0u5eARGO4AIzcPjOErOlfvXcecnvbhBRC8ENXgoSiY0HSXu6O/EsfXUKee8uosYFyFE
         Muy1jhdTBxNVOaaBYHpy5SrtQbC/DfVsa394a//BsoON3TSmJAgUdxmg/IWhiE2SAUTy
         1vCVJYk38nWqcVqglCzuWYgkgBKhrCdKHm/O5Rd3ja2SprXn26XmO3f7HnNa27oWHUNa
         nXj4pUhGgnzPX9Jra6RWgszRHMaXNcQVBYMfgCxN/qSyPx4lXP8HXeWnhj8JNQNHRirC
         Nykg==
X-Gm-Message-State: ABy/qLZMRDxKs8pGG8o6Z0gw9iab3j53kDdF5Kv6XwmzOWke77DES2Or
	tcg+SSL7bJZa8nXIUyIiQg==
X-Google-Smtp-Source: APBJJlFinKxyQS1nwISAInFsS13wW2U2Jp9l/xVh1G9Ar004q4D4sqq3Qu6/1ePhN1/yt4l4rpay5g==
X-Received: by 2002:a05:6a21:788d:b0:132:cb97:83e2 with SMTP id bf13-20020a056a21788d00b00132cb9783e2mr15896203pzc.50.1690978949122;
        Wed, 02 Aug 2023 05:22:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.99.70])
        by smtp.gmail.com with ESMTPSA id p2-20020a62ab02000000b006826c9e4397sm11006072pff.48.2023.08.02.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:22:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7cc369ef8c192ca7ef18b8d31a4673ea1b13261c.1690976940.git.geliang.tang@suse.com>
References:
 <7cc369ef8c192ca7ef18b8d31a4673ea1b13261c.1690976940.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Build_Failur?= =?UTF-8?Q?e?=
Message-ID: <27efde5d-933f-2e71-7eb2-b0e197cb6a2f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Aug 2023 12:22:27 +0000
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
org/project/mptcp/patch/7cc369ef8c192ca7ef18b8d31a4673ea1b13261c.1690976940=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5738644783

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/19006ba8d4=
49

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
