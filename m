Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4A66C5
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 15:23:08 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so6095701oot.11
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=/n96Pcq3y7IywI+/Ay90PbQAVhpI3umCt03ONZ8N/ug=;
        b=lfGo05RASxqwsfXjS6pHlmrCEX6/UwCPyBSlfR17AXmHXEXjnenRqe14NKrNarFq41
         3Ni0Vmon1hTlNKg88lLEinqR18aKk8Gp+qhK2b99OLxhqY1WBANkqlIRyv2HSoNde+1m
         Hky0ycQzkgl2B8N2JawD97NvNc6/rHjCkcL62nlHp9U23zRHSoHGXNpUUG4cGOT3YVes
         3YpFc4SMvRYkc7Qc7rQ9onerM5RK7XHcyACEQsmoUfjMHw5zHsFF6VymdRLvmRq9MuY1
         3AVyi3VD4YpwRxINcaGJgPBcmsheLqUx+kHL+pKHWEeI6k5X2Kj5yyXrAXlhjdAcHJbj
         D6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=/n96Pcq3y7IywI+/Ay90PbQAVhpI3umCt03ONZ8N/ug=;
        b=h4eyYuIc116CiI8FfhrccpCMpX01UIrqaBDx0w7IY59LVJTtUhr493OODt+5nXONcd
         MEHdcolX3c+jZ3U/nBXe8UP/px49kG4rFglrIpMBycxdYJZqxCmAHD8uLfDXm3PABWU/
         /+UB2z70mFHvET4GwcUe1bm8tsKBAqmDAKWgOBMEGzFjOWHr+zSyVPUuY29CDPhFoFTl
         ysDGV4NzfgdmfK9zIF4ZRzUNPKW83Ziql4pli2lThyJvdftTrOxyVURCMo+dHMl9iN64
         9xV+1dG9Sm8zhO9Z5vTXUh9pJVIfei7+7cu1/7Qbjrj30rTZgUGRGyYgTHuxAv/ujhc7
         fLYg==
X-Gm-Message-State: AOAM532wkPh4QXgHcdDYKBZYzwwyL0FZArITZWals1DLD7DAC/BvHN1U
	ifVkAHUfTNKEuON26U0u8g==
X-Google-Smtp-Source: ABdhPJy3za4Ymv51p5/EA0E7+QktYPXxjxCDof9LAaVm37nQeA2rA/Zpy+UebkWsPsfmXeELj6q+zg==
X-Received: by 2002:a05:6870:51d0:b0:d7:1e2a:2587 with SMTP id b16-20020a05687051d000b000d71e2a2587mr4428315oaj.176.1646320987482;
        Thu, 03 Mar 2022 07:23:07 -0800 (PST)
Received: from [127.0.0.1] ([13.65.188.146])
        by smtp.gmail.com with ESMTPSA id w11-20020a056808140b00b002c0966d9521sm1194276oiv.10.2022.03.03.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:23:06 -0800 (PST)
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
Message-ID: <ad1b86df-efed-4784-26e7-df914e6896b1@gmail.com>
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
