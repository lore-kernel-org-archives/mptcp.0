Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B2A45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:50:34 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id z16so11305716oib.9
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681465833; x=1684057833;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfoHCdTlZJgxpMg2bp3mvhUQhFVk8MDeMXX6ttOKEes=;
        b=mRVwD59JV09j+gEpy8B9CkKehfCzT1MhDIPEKHE/aBwdx7R6bH6ype6t+Dy9R4X8kt
         7rv7sppMgQjF0d2ilygO94Q356nAzYk6b1ui45FraWssc66R4md8b9bbzwVrqbZgxLQr
         +Nn3XD024CTA/TkLDyf9vuXc/RYkM1xDJcObGy6NRQEYPKRkW3omzF1OCdhSJMYA6BAJ
         zSrgGyze7/QKZYZd/oCuQdeWXV7pnZXQpjfnKkakq6mSd5IFDYKDHSLeYYQ5rJKX/Lqa
         RAlVDWGnlHE/s0CQ2GiCTxOiwBMrx70Y0kOpNY9/NQMf0Z4/Ghwt2MUhcjWfFZWsNuWN
         t8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465833; x=1684057833;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfoHCdTlZJgxpMg2bp3mvhUQhFVk8MDeMXX6ttOKEes=;
        b=j6Mb2at9ZAmofxVDsbpYbzuODuX/LeAjP469WsA6W97plUTrCDItfxwH4FedNzo+1v
         1ohSBq+hEzR6n//ADmJWcoXCDeheY1nywbEApZ7X+9RmphOqPUoSC3+bgg+Uvg4BWJ0r
         0eAN22ADpTzR2Shp8EmyHidjo5/z3IGAU3Pr9FFL4ZnhWBkU4IaxKashYpP8Vc+RdfxC
         QNt1eLV7w+d9TmE5Pqhg0KU//bQKeEdUyaWTGh/fUoE66jKnk2po81g47Yj++5UA0Yj+
         g7cupOGxRmNZbX5NZ4FxDCNJ5gdYYKBQ5RfGvEFM4AbEq7nHBFa638aSDW2WyeiLRheU
         VNyg==
X-Gm-Message-State: AAQBX9eoVOOfPswGjj6IBmt4i4Ppm9RmcwbvatnEOwkgzF6f3dkqedHD
	DFmPVgw/vZ9nX2wFYLMbkLaCb6ctH9u2
X-Google-Smtp-Source: AKy350ahOdknrg1c8DPOl/pd3HD6EPvfv/kCMKfL0DUDHNKCPcPZJbjlsnzV1lBWuds25PgJDD1zHA==
X-Received: by 2002:a05:6808:19a1:b0:38c:3843:fdfb with SMTP id bj33-20020a05680819a100b0038c3843fdfbmr1302815oib.39.1681465833618;
        Fri, 14 Apr 2023 02:50:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.170.56])
        by smtp.gmail.com with ESMTPSA id y124-20020acae182000000b0038c35f512a2sm649792oig.56.2023.04.14.02.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:50:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230414092934.4065227-3-matthieu.baerts@tessares.net>
References: <20230414092934.4065227-3-matthieu.baerts@tessares.net>
Subject: Re: mptcp: bpf: Remove unused arguments from btf_struct_access():
 Build Failure
Message-ID: <f0bba04c-2f0b-4919-8227-0821b04932bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Apr 2023 09:50:32 +0000
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
org/project/mptcp/patch/20230414092934.4065227-3-matthieu.baerts@tessares.=
net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/4698487=
727

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6d8ceeecf1d4

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
