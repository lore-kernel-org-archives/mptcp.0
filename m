Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1E7F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 02:57:55 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so10582424pjk.1
        for <mptcp@lists.linux.dev>; Sun, 31 Jul 2022 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=UlwjHH9vgHTxD/+YgzimbbvxAThRaZs4uns4e10oGQE=;
        b=GdutruSLHBrCyneDNPFz5vS1kxbP064Iht2IHSs7ScIb/znfysK3nsGE8aQ6OGiCif
         Z31z/BKnflHq1KcUfliLz/Kr6H7eayVmF+PkH+WE1bHY1v9q5RYC0MsxAe1QrkruFKWc
         Jd9pQNpAexobSFgA7J1SJs88JZ8SI0zQuX7ke8qapC6/gAAO+Clb0EOvDMqZRNfes9q5
         0nW/aYLqasmOwoZMhGNH7jXUJ10QO/7KMFVfwx9oa/SJBEAC6s4g5RCc9IxqSrjsAX5L
         WX6K9bwVzpFvl1dm5vCdvRhJG7VMNIjBJMv/8pDXTJTptbnL4uZ0mUATTKCnxccDML2a
         kdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=UlwjHH9vgHTxD/+YgzimbbvxAThRaZs4uns4e10oGQE=;
        b=qTKXuYZy6GkCbslz6Ok1n0tuKRg/1Me7cIp/BTRqH9kS/TDqWkCj3D8ansTliAOxJq
         vtv+yZens/IKQ+5KGaxRubbe9y1CJTOc1Tqy3qc+vbUHAJ6ZQuI9+t6fymKfL/WnE5zd
         RNiQwUk8F2cfYtXIk0NAOoD4H0DFqYKsylP/lOkFD8iDLXudCxT4NDBlG1pZTLkVsEeQ
         CeJT/g5gjypjTn1M1IluQEx9kpJkGWUK3mHIlAH7y4TBM2dXCNPZLkUSKTx255P7XMEz
         zwrvPtjcKo1m0cBWP9N+E5aboO1Abr8jJpR0Uq9V5CHIPNJXjDKb6oh9oDnMI9WJMjbn
         zsGA==
X-Gm-Message-State: ACgBeo3g7fGnjCLqeiPQlZG/Cd6+MzC1C8RoKsghiksj19lFDRqms2iL
	Lu9QJzs8UY9U+6ADqicA4Q==
X-Google-Smtp-Source: AA6agR5g5kavcomONXxqPOA9r+milpvIdRuSQVBH9VHz9j3ePHdtU6CAi8xwbwgXTr7orz+vhtXDmw==
X-Received: by 2002:a17:903:18b:b0:16e:f09c:919b with SMTP id z11-20020a170903018b00b0016ef09c919bmr2021379plg.135.1659322674774;
        Sun, 31 Jul 2022 19:57:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.169.248])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b0016bdeb58611sm8334749plh.112.2022.07.31.19.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:57:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220801024656.397714-1-dmytro@shytyi.net>
References: <20220801024656.397714-1-dmytro@shytyi.net>
Subject: Re: mptcp: Fast Open Mechanism: Build Failure
Message-ID: <d63beeaa-afd5-5a12-3b6c-504956cab06b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Aug 2022 02:57:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220801024656.397714-1-dmytro@shytyi.net/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2771932806

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/552c6ba5a6a7

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
