Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7226110C
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 18:32:01 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id y197so4215770iof.12
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=TvQB11QiX4pqX4W06/WgIBSST2vvr1XvJoFilbSeEdc=;
        b=lWlVWBP6gcGKKfeyXcb7lft7R1UAVr3n6P5gXI5TBfhunHWCOCwyl4GP2ZCxDfbDZ8
         M6IZCak6UYbie8T9ecnlQal2yygO7PicxgOkXr28BZU3AOVyOGA490iKyvx1FuXicNTL
         wT/0UpdmMKSL5aSX9fSjXIDe+RHXw58lJc0dIxI8bnMOY7yjyPmrwp7gMwbRHRTNlc4u
         +C1laCUfC2Irwo9ljXFGnoKnbZjEt2p3l6w4L6l2zXndAk+9TUGuhYgM0O/U/l7yQJ5M
         Td8/ICELGPakFvG4EuH9wzBP0/Gg805RLSPfF2Q80XSOwVjzq2luIkFm6F6s6wTggZ3+
         ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=TvQB11QiX4pqX4W06/WgIBSST2vvr1XvJoFilbSeEdc=;
        b=Q3v+F4kVvEBriEgb/RcGDH+iiXYKsvKF2Th31l3KT/dPHP43op46XtfUIW+jBJdNRv
         i7bw0UpdcL6Nfor8G8SjqNxybHI/hqdaVL9ZV0CAWKmj4npM8mqFPlFMPp3VV3Utx/lZ
         C4FlKvLP+qnYHorOldUompCLdW7Z++4Go5byvjcGh7bKu4yKtq7kpumC6cdcy2GLCsur
         GIHLvTWzg/ulwK1CSum42o/giSk9U1/pl79mE4Gbv3DBgV+u6E6T5fcpRzydciQvvfX+
         j4WdSwjvc5uPJZE+J30hw9fTBuUx1rw9dsllu5/Mq763+ig/nc150IXmrT1lQoowPzut
         a0HA==
X-Gm-Message-State: AJIora9bMO5guVl1c0zn4ZQAjtn3pgSkvfwXzrY36rwL9l8LFPs2WQv8
	CYXCoa4FEciw8NSbVDaYNw==
X-Google-Smtp-Source: AGRyM1uUreoQkWaHerMVW8nBA4EWoULwzezeYltkQyQ73onkv626hxKSTctfbzdZ6uSq2m6b0w2Vgw==
X-Received: by 2002:a05:6602:29d0:b0:669:1723:c249 with SMTP id z16-20020a05660229d000b006691723c249mr1591438ioq.208.1659119521054;
        Fri, 29 Jul 2022 11:32:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.108.137])
        by smtp.gmail.com with ESMTPSA id s20-20020a056638219400b00341648c405esm1957192jaj.144.2022.07.29.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 11:32:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a5a451ed4421993380b46e8b546b228a66001212.1659117128.git.pabeni@redhat.com>
References:
 <a5a451ed4421993380b46e8b546b228a66001212.1659117128.git.pabeni@redhat.com>
Subject: Re: mptcp: use common helper for rmem memory accounting: Build
 Failure
Message-ID: <f1217e12-1c62-496d-b831-2ca0d4488eb4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Jul 2022 18:32:00 +0000
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
org/project/mptcp/patch/a5a451ed4421993380b46e8b546b228a66001212.1659117128=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/2762483896

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2febaa3d4a=
51

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
