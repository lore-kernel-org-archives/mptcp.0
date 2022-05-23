Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C67C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:43:11 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id h9so7752250qtx.2
        for <mptcp@lists.linux.dev>; Mon, 23 May 2022 04:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=P5sWpk8vrBR8L+5tsT2A2x3WFJB4AOGx5HaT0gvxb1k=;
        b=YiVhmM5MislyKRaDYr0b3fmQXbMndGO9JeLQoRvYzENUGXfn3yIPNFOYL3Ag5JSOvt
         cuGp30EEEsF3h8po8jxYe/M4KO6r+zBgTi09WN1zqM/SrelnvC8DjDx9slhfInITHR3A
         VKBOdEjXGqRJbFzATGzkW2o6Vh7EXybNSil/gTHlVOoiCGdtNlmrD92kIaFfzINAWdmj
         a97ykymAUrY9hgk3pdlGzorGHhf3QHFGk99nz+J7lyhPhPOPvShVI9OwR+yIXgY8TzMd
         4Qt6N0adiqCDUE+T74okd2cNG5YY5B9uCjKw173UiuKiHX5A0WqSqraKqlnQjvr1wlmU
         vCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=P5sWpk8vrBR8L+5tsT2A2x3WFJB4AOGx5HaT0gvxb1k=;
        b=Bylw5JCTIw5AjBEVZDvZBey4GVUQfdcJQIC+xnV0RnpxDT8+iGiJRC6FPLn9/yzObq
         7Tw/P8582Y9nJD7/PTgxtQinBcy2qKCPUp4eOU/M2SUny3Zda+4MwjCllrsLvN9YhwWH
         SBpUcQmhJTpXKw/xMDm/GXoAfPjDYFsWrjkJHpbNGFoFc0ue/p/uLx64Y6Cz3vEZMUHO
         H73YXvbz2WBuUj23mQ7bifKBSbkyet8xiT4t420cpPBfzJ4QpavRCegeNo/pCZv925KJ
         mZoMIROYS7rNq4iUa+u/fIbR2Koo6SSOGRdySqwAFI1v6PM1ncrki6qGP1NhcuK19goe
         Thxw==
X-Gm-Message-State: AOAM5324Y7hz1PnZk7u0QcwPHZhUIrM0lEqKbdWtwC9QP/709q5oBVzr
	7CJI0lQSrIrhCCpEojZyCA==
X-Google-Smtp-Source: ABdhPJy/C9FLnieg4ZyOq19bh1EMOAXCfASFIHWbS45kHm1J0h4Xd0qZyimyb7PTyxPEaptgOHpHtA==
X-Received: by 2002:a05:622a:81:b0:2f3:c0d8:d630 with SMTP id o1-20020a05622a008100b002f3c0d8d630mr15671803qtw.599.1653306190464;
        Mon, 23 May 2022 04:43:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.124.199.117])
        by smtp.gmail.com with ESMTPSA id l1-20020a37f501000000b0069fc13ce205sm4213042qkk.54.2022.05.23.04.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:43:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
References:
 <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_add_?=
 =?UTF-8?Q?bpf=5Ffirst_scheduler=22=3A_Build_Failur?= =?UTF-8?Q?e?=
Message-ID: <953cca2a-1104-6aac-2474-a55ecb0b8808@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 May 2022 11:43:09 +0000
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
org/project/mptcp/patch/94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/2370983932

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/06c3387f99=
72

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
