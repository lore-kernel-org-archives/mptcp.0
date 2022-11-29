Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E8BA28
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 21:21:30 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id z17so10130218pff.1
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 13:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Gf8xiDBr5226Sf0uHQ/E5BI1T931fj8Y4W1fnJaagU=;
        b=EmFbJFDfloGT00jO7htqq75tM/T7jV2DLHwf7XjWXRGZcRyS8hEeyOfSUE4jazkRer
         dTMaPaN3/3BQyX9GGz4BgGIF4+jptUuvgbp/N7+LeewEaNOQx0CvWqEvuQ9hEUp12k2J
         zxNL0/2qfkG1mPtAhmoJ/nQ0H9b2IPGzMBIXsVNB0c7btLc90LkzyTr4xDlL07xP+nEK
         Jy40JjM/w+FcUzDoyfuTAAYanbrvpQPVcbPKtHZHcj2QScSPHJo0OZwB7FejnV7KSPk3
         HxSMsKPubdk9lv1fmZ4inlyQJOCPyUR3OT+6O13i4Gg0o/RDlxaXtxjtmwhPSSAc3z64
         f6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Gf8xiDBr5226Sf0uHQ/E5BI1T931fj8Y4W1fnJaagU=;
        b=mKnf9vfMwj5o2iKa9Mtigtf3ChD+vaKTaHzikeOJjLjeQX5ZWgakSfowASuDroWqu0
         STKqNEUXZuV3qQGnorKyifuklhv9JgjrOgxSrm5uDBo7/AyY2a8tHlZCooY/LcHUJ2Vx
         h234uD+QPas+h/jjRyj50g+3DdYn0fK2J8q4pQYDkD5u1Eabl14r9PHi0ja5WQaQCj/f
         Y1IhMMfqerakPPXrDzunzfZs+2Lssq+9gXbNyosFAmYPfOIz5yiq+TipMJ7jb+uxuKV+
         za4UHGIExTgp2KPUaTLJtpdoJsi5RbgPEaUISMzBcDs4M10sB1ygJLAc7dVIgfAY49Ww
         URlQ==
X-Gm-Message-State: ANoB5pnWSorWpBL3VMh5oyHEcz9NvtnW4ZCN+925huFXI40Nn+ckGyr7
	tPLzJXODv65bdxTbqhihWatOxw33U1y9
X-Google-Smtp-Source: AA0mqf6b9Hswy/b3AkT0RpIk3dk+Xg6uwinKBXofBHdzuTWZYzZpbEiZnBVxXDvB0atsaXyBTmJcpQ==
X-Received: by 2002:a63:ea0d:0:b0:477:e6ef:2ed5 with SMTP id c13-20020a63ea0d000000b00477e6ef2ed5mr19664522pgi.197.1669756890204;
        Tue, 29 Nov 2022 13:21:30 -0800 (PST)
Received: from [127.0.0.1] ([104.40.6.114])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001896040022asm10312791pln.190.2022.11.29.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:21:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221129210804.3769157-4-matthieu.baerts@tessares.net>
References: <20221129210804.3769157-4-matthieu.baerts@tessares.net>
Subject: Re: mptcp: use proper req destructor for IPv6: Build Failure
Message-ID: <40810bdc-a5e6-ba0d-dfa1-78ed95e03130@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Nov 2022 21:21:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20221129210804.3769157-4-matthieu.baerts@tessares.=
net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/3578036=
744

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f559e986956e

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
