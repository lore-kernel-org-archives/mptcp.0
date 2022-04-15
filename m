Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAAC3219
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 15:10:15 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id c125so1290244iof.9
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=BkDOOXWCM/Oy8ShaRGayyIvTjwz7jS28riS3KrJnh9k=;
        b=OMBGkJwbO96QJOxAnuk0STHEbPG3os+pjh+t1pAyHTAbDWMbz1UhTERjlQEjT+Sv+n
         ip6OuT++bpHa6xVZgKY6i1g9dM7C0v4IZj3/0arXw2WNkj4pGnmKULy0ndmGi4jtXBKG
         rq1qC/mUJAc8Zqh3VnN+3nxckRRZ1Ok93XgMWKABpCW2SMsv8roX1Jt3yNmnDR2dt6ej
         TbMSlRwk2s654QNHYmOF1MFn5Zyq7ap0CUo8FkiwT2wITs+0EVeDkymdnw7ot3y9e8Jv
         XhZvtg0nRx8GfV24GKOAqgSOten5UCe9jq0ED1O5JAjy/ctO2eCFvXuLh/aIab44MWg8
         EgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=BkDOOXWCM/Oy8ShaRGayyIvTjwz7jS28riS3KrJnh9k=;
        b=TWKv/Mp7M7u8X2fUdXUQLOPP3SWdM8OrO0peqaw4ocBq/rZOJW+uBnfUApqGDdyUSx
         JW8/nMQR16neC1J5V1S+y2zvaVTHiJf6can5VdLXJ/AmgJXH7W8QSxZMo7uie/QV96id
         0rhVJBtYVTRU6N1GYKiTt72Ww+kA/ocldwHJcwKuxjsnkA4PCADoa8EA0yiXAB05CtZJ
         xZMJJXxYV6wXST3DePR8cLwYpCwyt5odCU+HFYvhGSrbBf7bSF+bcL0tAtoJ2PM7/ulT
         VdehU8LA5vIz1HcXdaSfNp2V/GaCmNO4rbsxxHOIwtds6xg85EDAyjHzt6mkFGtW9SYE
         sJZg==
X-Gm-Message-State: AOAM5310Yogb7rN5TAERCBF2pzJ3lIhpdbnXMC0sXti0URdwnh9titvn
	JWNXaYKcy5JHosnh/J4/tGLAvEQt/g==
X-Google-Smtp-Source: ABdhPJwpRkOCANGT3wNJAZYZhDFeKu+4NkHxYLH2A7JaON2oeRl3hB514rgr2ubcpzxe3eOnnQgKKA==
X-Received: by 2002:a05:6638:148e:b0:323:a07d:6747 with SMTP id j14-20020a056638148e00b00323a07d6747mr3654578jak.252.1650035414176;
        Fri, 15 Apr 2022 08:10:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.134.210])
        by smtp.gmail.com with ESMTPSA id s3-20020a056e021a0300b002c7a545c3c3sm2820918ild.66.2022.04.15.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:10:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <43cbe1db36c118468bc6e88ced16079d05f30643.1650034062.git.pabeni@redhat.com>
References:
 <43cbe1db36c118468bc6e88ced16079d05f30643.1650034062.git.pabeni@redhat.com>
Subject: Re: mptcp: add more offered MIBs counter.: Build Failure
Message-ID: <84e8d6d6-8006-88a8-f69b-d6584cce34de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Apr 2022 15:10:13 +0000
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
org/project/mptcp/patch/43cbe1db36c118468bc6e88ced16079d05f30643.1650034062=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/2173091628

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/40eef4f35b=
96

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
