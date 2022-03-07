Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07628E0
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 14:32:16 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id iv12so10661277qvb.6
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 06:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=YDCwsIHfzU5kvbkqfp+/5dhWwWK+c6kgjXueIVoMuoc=;
        b=n3igvigsnAtK+FDVO5uw0csxNbHcQsnzpk890+yo9xzpF79qzoYHJh6C5aPZeP1fl6
         rd4mdvI5vVR7ljcE/Je3N5GqPQoFuV9xPimeVczO/XJjC7hF6rT8zInxJQ3yzqDyeuPB
         /ZBAt9zJIZd4PLHGprWfeRuzrtjkxsAwjk4glxCrRMwnsmLi2NeSsjiop0441mhL5Ryp
         YpPbI+n0IgRutk8Yu/D9tM69P6Y4UWI7oYf7eJEQRglB4ml+Epx36SUnyB5Le0lbA2iz
         NVp2bDk86v4I9669z1I1I4N2qb43k1lbd7rhG/uPevct/ERZp6S5wxxGrKq+sYXWu7T8
         RlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=YDCwsIHfzU5kvbkqfp+/5dhWwWK+c6kgjXueIVoMuoc=;
        b=3sOOPfzNXzA2t0Num37/91WnatIRn7V9yFR0bimfSQtt6Aqf5e5YXHV0DnnL3C1gzJ
         d/+u0oqPpE8CiVxqjAjj1nsHZBvxuR0/mIanCijS2+dR3VRhPgTt5hdxHJP9r7A/YaR8
         ONgq6kXvyMOCC9FZQwFppr+FnWduUlVPOOseHsGq7fFUDy8XVTLArdoLY7TZEnCQs/o5
         zuivcCSwda8Hoyk1rPpDQ1y/ANYiISizZwYMbn2wVca9vg299TWknwE5zv+kdc4WlEUP
         tUM7Pa3tAyeY8Hz73NeUNuaAJuKr2CYzFhzrTgHq6HeGGPGwVaBzxq7Okbrj+nSqfBSm
         fa5A==
X-Gm-Message-State: AOAM530x+wNi2WmQ55y6HbUBUpDNpx8lyIRPPb/L3af6KO4XSTwdgGA/
	6fDq8GzNVFkcsh2FXFBC3A==
X-Google-Smtp-Source: ABdhPJzjW+5aTbex37Tu/tOSjeummqE6MFnnROc5pfBBrmIgWkBzgOKH58oRYJ1d/EA32UDsGdjMNQ==
X-Received: by 2002:a05:6214:248b:b0:435:3fa1:5a82 with SMTP id gi11-20020a056214248b00b004353fa15a82mr8245171qvb.25.1646663535696;
        Mon, 07 Mar 2022 06:32:15 -0800 (PST)
Received: from [127.0.0.1] ([20.119.207.221])
        by smtp.gmail.com with ESMTPSA id p7-20020a05622a13c700b002de9f3894c2sm9080209qtk.50.2022.03.07.06.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:32:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <43b328bce5479e34e1dbf78b29b8d5d7d8ed2e02.1646657963.git.geliang.tang@suse.com>
References:
 <43b328bce5479e34e1dbf78b29b8d5d7d8ed2e02.1646657963.git.geliang.tang@suse.com>
Subject: Re: mptcp: reset the subflow when MP_FAIL is lost: Tests Results
Message-ID: <162d011a-ecae-bd8c-f53b-ec79206e86c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Mar 2022 14:32:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5236831624101888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5236831624101888/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6362731530944512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6362731530944512/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7eab38dd4d32

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
