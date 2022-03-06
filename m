Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F610EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:48:48 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id e13so10931454plh.3
        for <mptcp@lists.linux.dev>; Sat, 05 Mar 2022 17:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=xoJf7CMJU/VA/ZF35FCu0QcE4uYClUtg27kN/2ZdwnA=;
        b=q2yw+rzVNGZ2Kw8QU6T1+kQuShpqYEVRon6T1YpF07xaBugG+IGnyRvufEG3k32Jo5
         iRSbtojtuBvGtEiWIdUUKsxZ5aQczv9R1YZ1obsh7YvidNQAOW49oXIe0eQtlqpcZLsg
         bZ0YEOHc4PIgA0AGJSbB+hqVh0+4fUwRFeiVKcsoAfgTOoEkwOGFy2fO9YjKxFiNtvHH
         twvSFaaqLNZnNMwKOvSgSiNpKYedJldTt6vghdaxQvfX23bj/SrCdzAl5SLHHxveJiAA
         GAJh+zOdztsnRIkR/1C7LZ3HV3BUVfCzVZVVBKIyu2QdBncbQkO077+D3mt/4yTTD2cI
         4cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=xoJf7CMJU/VA/ZF35FCu0QcE4uYClUtg27kN/2ZdwnA=;
        b=51boEhUbbCzSpachbt06k9I6QUgw16rOtCcf93SZo5bLeXz08w16Pweu0ZapIRqMGy
         RvjujacbJQ5WolsX+IKoasNNzwP2Gje6F6s1aK7uTuJqQ6Il1buzID9TH943SYKzJ4R4
         Qd6zlsUaU8aFAVreDqGEdRhutFdwSLhdOZHoxZ5hgRVG4DKwAIkSdusJ8xW9f/JTRNvG
         bIIhvu9tgM+RQbYx3I+tzfUo32DSOqf+H8F5bamKWwI65p56/0MwIa/WzP8jFTMSIbHy
         8DQg/NDuhAi/7HqGyun+OG+IyIfs65gp+YyUPWnnmPloDuVsSjC7hfokWYwuG/oC4PaR
         FWJQ==
X-Gm-Message-State: AOAM531oigIEvFzYyyV+k8qzJO8hcySIqMdu8+nHqEr+n8jIlghmGGkT
	9CkXalsAxlc/nP0AuUWbxA==
X-Google-Smtp-Source: ABdhPJylmdf88ltD95aVkwdwIeVG/QjBmYnyb5WA0PDoEen3q6BuFDY+69GSkoPDtRDLvdTYG5qxNA==
X-Received: by 2002:a17:902:6b04:b0:14f:2cc0:fa98 with SMTP id o4-20020a1709026b0400b0014f2cc0fa98mr5795759plk.44.1646531327973;
        Sat, 05 Mar 2022 17:48:47 -0800 (PST)
Received: from [127.0.0.1] ([13.88.20.197])
        by smtp.gmail.com with ESMTPSA id z2-20020a056a001d8200b004f6adb79052sm7042931pfw.63.2022.03.05.17.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 17:48:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
References:
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add skc_to_mptcp_sock test: Tests Results
Message-ID: <36be94ec-10ef-80dc-46eb-ba25a0ba00a1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Mar 2022 01:48:46 +0000
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
  - Task: https://cirrus-ci.com/task/6291582512005120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6291582512005120/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5386436542201856
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5386436542201856/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5890857c7ca9

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
