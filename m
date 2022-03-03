Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155237C
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 06:48:56 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id x18so3980642pfh.5
        for <mptcp@lists.linux.dev>; Wed, 02 Mar 2022 22:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=mySXmCNoBtCw3OJXVZGawFpgT4z7lWANcRb0lvYizo8=;
        b=Agukg1uJmFjvQ/EVvr3GsPo66gYNu/twBSB9ucWCUyASgwTQx95BlA4ajEvS1ey8p3
         U6R3dGiRVze/oaluVIeTf6y8QpMd7sxfw/13TBz5tB2sXHQU0swKyb+XE482+ZhqaQUs
         7MVsnQJ6bYilA2fEAt+SwbuRmLCjq4+sVfZsjESMCh5jA0oPYWWGaQlV4YROneUoAZCZ
         xtwJFJ/IDznazjap7vV29toJJG3jjW87S221Hgll37CKYbEiBTecZZKaXg9UJGFqhp4O
         S0/HVNqTkybwwIsEqchFp6aRxH6jDE2chFgHWfkdBRPIqt0QUnnr4Iu4AYaWphblsHX+
         9kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=mySXmCNoBtCw3OJXVZGawFpgT4z7lWANcRb0lvYizo8=;
        b=5SksGoNjeY4vhqIeSBUlsp/iMT3L0vKUrZlcNFYXE1QwttRI257wxMc4UlCvzMQ9c+
         ZeWm5y0qQnsOIvCMwiDttvHkb++YqE/Q8+G985oVTwwOj8fb45FJ9sFpF6/IcL4iKAya
         eIn0YPGc6nxurvMGSUOF08LUcO1xXfSZxaBFk0JVTw5TEr29+6eVRE9CR72Gs0OP0XLl
         4HGuNMVISmwp5/nlNxRcuz9NRS20JTA7q7aRMuVU/eHdCu8Rkf1tUcEKx7+9npjNzkst
         bIQ2gBoZVkmZksyh3KYnVkt7d6wZEGlTrakyhTRNevKvqwYFgZG5UoW6jtonaM36Unzg
         qPvw==
X-Gm-Message-State: AOAM532u7R+rjVug7qPjZUPZ3AvGEQjHCyVtj+g5ZnI7VlPLoBwsk+/w
	nDsaKCAIWtx9vPXUWUsYUw==
X-Google-Smtp-Source: ABdhPJxwHIBHirHq2xKO+ks3tExzEKjbDmc12BrDMHvXfBcYq3ljME96qrcVRhBNkbkcnPL3w5dmqA==
X-Received: by 2002:a05:6a00:234a:b0:4e0:f776:876b with SMTP id j10-20020a056a00234a00b004e0f776876bmr37246793pfj.84.1646290136304;
        Wed, 02 Mar 2022 22:48:56 -0800 (PST)
Received: from [127.0.0.1] ([13.93.235.217])
        by smtp.gmail.com with ESMTPSA id k5-20020aa788c5000000b004df7bf0a290sm1301668pff.1.2022.03.02.22.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 22:48:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
References:
 <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
Subject: Re: mptcp: reset the subflow when MP_FAIL is lost: Tests Results
Message-ID: <f9a929a6-f6aa-1756-c090-1c266c9d93f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Mar 2022 06:48:54 +0000
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
  - Task: https://cirrus-ci.com/task/6506211624353792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6506211624353792/su=
mmary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5189979209990144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5189979209990144/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e77e2e4ab530

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
