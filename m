Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895E68
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 15:51:21 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id i6so1108132ila.12
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=lej2sbJFROPIUv7ARnhVkMAa2QIevJY6LRWSQv7U6i8=;
        b=gKwsDcND5ClIFYOufoT3LFPRl7aye0bAi59LH5FUB6GT2nUBNW9LY2Fmcx8Swf70c6
         Knt2nlPaxG3t0BXnK3+ZK2k51C/zwrWLwzMnUbO/bSO2nbdZCW3B7gMGm2uVW54nhLJh
         Uic7tSwrkdor8XxIcMtAG8rVtqVPAOKCIrLvz7Hep7TEOkslNR+Xl1Qao0OQnhTVNGSt
         CqudzXMoNLg15mhIaHaBsfEDaGQy8oUAdHHkoir3jbYSBFUrju+8BJy7vXNBfu/LdFAs
         NOgKTyDRsPUgR6DWMhmwWXX+B40216yUHnKPsitsI0pb5inkHOwXDChKhvQc16QRyYOa
         KfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=lej2sbJFROPIUv7ARnhVkMAa2QIevJY6LRWSQv7U6i8=;
        b=MpUGaoHMY9S9UGXhE99DR7Q7w8S26eTD77BvzXhdjlNuQw2lqFlZ7D6d9+xg2tz2qZ
         nKF0acxg1alXCwhNaIn0WBiFEdFtkvj/Imwuv8y2urhjVr/7IzEBSbhf74NTfxuwsxBw
         0TE5UQJ0uJf4vWh3hk6iTzzXHbqfQRMGpWqTo1pOCytfgg8ylqRsRspw5MnJOUaScuKU
         dvaNE3XAtoLO5Zn++YL0DhpDQ97aBIzQL3qibj/TkykNlHraVkI2rlW5/XggN/aVeUGh
         bVfh5LhQtWDhKi1SQdeEcrIiISGMbouWCxJlBnjbsEIQPpr0dpC06FC1GBJRqMwDEXWf
         i0Mg==
X-Gm-Message-State: AOAM532+l2C6HCG/RpZZElN2IiaMuU34xQyvCed6lc0qzSiI68RdjFMe
	6DoC51YgFyv3vFz1Ue4iVw==
X-Google-Smtp-Source: ABdhPJxJ2WSHxrmFH6yCp8rsrql2aHINbiTEfwNOAB84fyreMl5pmPi570HWVH15QfmeirOZBN1xew==
X-Received: by 2002:a05:6e02:1945:: with SMTP id x5mr4232382ilu.59.1634831480443;
        Thu, 21 Oct 2021 08:51:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.49.59])
        by smtp.gmail.com with ESMTPSA id z5sm2743424ile.42.2021.10.21.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:51:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <essares CI <no-reply@tessares.net>
References: <essaresCI<no-reply@tessares.net>
Subject: Re: mptcp: fix corrupt receiver key in MPC + data + checksum:
 Build Failure
Message-ID: <cc6b45d3-14eb-120a-99ce-cdef1cdedb68@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Oct 2021 15:51:19 +0000
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

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/1368607743

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/182d08d6a6=
9a

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
