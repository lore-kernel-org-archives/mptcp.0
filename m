Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FA7E
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:23:08 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id n185so4116789qke.5
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/n96Pcq3y7IywI+/Ay90PbQAVhpI3umCt03ONZ8N/ug=;
        b=TdUc4JX3IDsx9wcUmvrIH2chu784Od3wDkCfv8EtCK4wdsNX+jUv9i/m274UN9y+wK
         r3HUBvjDf2bu6L0AL55uom/OqkBdf13OsadxHXQsqP240QCxdUbWTDv9FCgC4UcaLiG1
         P3CLoQ4uQHvKpdpyCxc9/J9oHGDtStsX6fCVckIn0+htLW/8P9NcjOLZmaW7lUhj7eH6
         7gQCRMnC9Tpicn5yC2k6pnpnxGRk8o7OG3MqEtgXE0wtXW9p5/vRaGZvTN/YNVoghxMl
         Y10AskYEwxQrswdDAWqRn6XP+56dxkZ8elFS/mGx2rRjTPcNwNIrcK6pj+jE/qGhyJOS
         iEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/n96Pcq3y7IywI+/Ay90PbQAVhpI3umCt03ONZ8N/ug=;
        b=LjYneBiU70upTomVYvOG9K92cU7sp2n2YIfzwmCAoZb9BGllLCav58XERIEUZcGgGT
         fSXsfOkVfej8dhbW7San8cCOe8VOghW01+lHMH5nVCYTC9MP1yptzjarRKUCU4O78Buf
         x2aWoe4SlXvrKYDOPhmuZ25H4NQvz+mxpRuN8aPa1o5JLOUfat4BetlAd+JV7meSMyjM
         8w6VZfjCosX+EqdFdB3CVJ3J7bDpQp8YkU1+FaOA/gMEyeV9zAQMObFpdhJpWM3YXzZ9
         4Jyrp/76zzUPD9BMOpSQJh8Q/5KrbeEeXcaGxU5wEVfsUD6m4AH5njvp5+6gbaZoB74B
         qThg==
X-Gm-Message-State: AOAM532Ye0TJpa9qFcIlOFJ6MU/5Lm4zX/hO12vcGTFSddScbmvzEk0m
	hWxUhZ0kvaes1hijiZDgUZ50daBux1Lh
X-Google-Smtp-Source: ABdhPJxkbcDxJyer0wBpSjaghJ/mOMlZNkeG8TRk2I9wOluCH5dPj3bZ5DQ2/JCugp9IcrKMkUt6Pg==
X-Received: by 2002:a37:ac0d:0:b0:62c:e3da:99e8 with SMTP id e13-20020a37ac0d000000b0062ce3da99e8mr18774279qkm.261.1646320987885;
        Thu, 03 Mar 2022 07:23:07 -0800 (PST)
Received: from [127.0.0.1] ([20.186.111.205])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002de658d6748sm1692518qta.55.2022.03.03.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:23:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613.git.geliang.tang@suse.com>
References:
 <ad07af14b07078bf3162924a5c3ab69198fa68c8.1646318613.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: exercise bpf_mptcp_sock(): Tests Results
Message-ID: <a4182859-759f-413e-fca5-7f631c26eb99@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Mar 2022 15:23:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5346941339959296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5346941339959296/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5609215354994688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5609215354994688/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e17812e4ee5a

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
