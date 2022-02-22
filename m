Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE306359
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 09:14:16 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id j11so334015qvy.0
        for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=EOqdR810AELr2+A3n34RsRKp3+7OujjQIWKv8ipGEHQ=;
        b=kemFNKXxBy29055jKp0GQJgI2xIiXr8j2bXNYkcTT+66BZurNrdfI1BNm8/F34wIeo
         Hen7S6ByDgaMgzy9NoIrE7i6qC7wCb9KpMtVLW33mQhsVp6jCkADJodf2mb73npnJ7R9
         /ebDs0IzwdWpqHw2NK+mNG8TRSbUo1vrg+tcy7pDl0PvqeCOICoPcDSnxO5gLGk+nPcJ
         T5LCHxz7t1NMJ0OD8A/ituw65tBIJOKM8F1H2+1Zr1Mj+RMiDudNkmI2ts7QkPMTjkyQ
         rseoo0mj1wP6yafGAU2NoOLKvgNbXWlQrr0RGFtU2jiLZIXBmcnsGxpy75E/ihCvWJWm
         d6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=EOqdR810AELr2+A3n34RsRKp3+7OujjQIWKv8ipGEHQ=;
        b=tdghmTyzTOMCK0OdgNAC3q7bsmokFoN6nbJH8a5Jrlv5v+ecQn943gb7hkj/gv9phu
         3WDgwJdScEP9cz8SozVQ4E52LWtwN3gK4b6EjWM2KSb4mqj1udWwuObG8ybf9X9OfONu
         uDXhhRmWe1GDd7+TPJGp0mX8GwWGYSQho2NpxYfWrAis24TrJNhEl9Tinx6om7Nwcrf2
         /dQ9Vl2QJwrszBkSNxs+WoCm7P2iEtjIx5REzpwdzaDirRwe0qtpKoJF1nIZPEzZTiki
         TlYLsR4eTtB05H8B7VXW9zRGWauAKon2RuTQegoeAoFT/2wKPBvGrSM3zT1zu2H4tTVB
         6Rlw==
X-Gm-Message-State: AOAM530qoGCwvcdlPb773V/aht2DATjCXJnFyYEcto13SqXONpGgDuvu
	Flb8Xqbb8FCREUo0ooJ/xA==
X-Google-Smtp-Source: ABdhPJzaDEsPgEHfHypE5mKqPYBBNSD2KQwxSjoCheHivLKdm6ntN+E3eIf4WUhxxonp6g6D7eJN1A==
X-Received: by 2002:a05:622a:48f:b0:2dd:b41a:e206 with SMTP id p15-20020a05622a048f00b002ddb41ae206mr15727492qtx.274.1645521255621;
        Tue, 22 Feb 2022 01:14:15 -0800 (PST)
Received: from [127.0.0.1] ([20.122.91.141])
        by smtp.gmail.com with ESMTPSA id 84sm9066895qkj.44.2022.02.22.01.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 01:14:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
References:
 <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_add_=27bpf=5Fm?=
 =?UTF-8?Q?ptcp=5Fsock=27_structure_and_helper=22?=
 =?UTF-8?Q?=3A_Build_Failure?=
Message-ID: <6139c4ef-e8c0-8aa4-f8d8-22d1fdafb92f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Feb 2022 09:14:15 +0000
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
org/project/mptcp/patch/4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/1880610590

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0515e717e6=
ca

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
