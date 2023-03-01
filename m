Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C3EC8
	for <mptcp@lists.linux.dev>; Wed,  1 Mar 2023 08:06:09 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id ck15so50615419edb.0
        for <mptcp@lists.linux.dev>; Wed, 01 Mar 2023 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sAxgrSw4/ylL7HNcPFPf8A5jhkRh2W2VaioNCIS82o=;
        b=L6QUc57tKiE2UqvCwwOst71am+LqH+fpiVKzVnRCJZlJNjcbLUz9n3K2+fRON+ebPq
         PMmD54uxurXvQCNEmeXKX2JBlXW0sV8hwN4iUIefcVA5Og2yaU/+MI+lxC/j6U9Gwh6U
         YEFnBYNDxVcrBGHgC7rwKRHdJko2dTgHJfx1PQMKurI2nfydzWkwkhJyRxQn3bPix8zV
         KCc7ZtbOTDmTOIWZ6NQW1zseK9nebHyuvSn4yC1WE6oRXhngxQlr6KMEQEyc24vQwy9X
         vBJAKxlaCLdyYcBGu7cGuhH8iCW14RDKb9z5hVHy+jwgyf57G4yAkfPDxbwbDRlA8AhU
         Uv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7sAxgrSw4/ylL7HNcPFPf8A5jhkRh2W2VaioNCIS82o=;
        b=PRJt6vwH5droNIVhUrestMQkzXYqoAEOCZFQy9Fjmi1xhrj7/r7Ujh2SszniOR/WN4
         M3IZBo9V5pCwak6ikE5OvgRQV4cd112AcLxhx3QoGx4lVkOXs2WQCJHbfTSXl3pElK7F
         132nbcAPjkqMeTFsOextwJlpscqPwPcr9DJ9OZh+GPlyzSbjnLN/Quq4XHaFypfQYoNP
         oBGoFXL9NFqjF1TN7JPm1lCuIc5qcZwer2fNx8OtwD6I3RnrzF1PFMGsnsFwfGTGn4Xy
         jCoXNlSlFWLmG3jb4LNGUaAJ3dr80ZNzrFsrfFFIBuYYOeWcHQezPSno1F/Ce9F/k4aK
         CfAw==
X-Gm-Message-State: AO0yUKU9akivoJQYTvFUjr6Hld6+sNpN4VndsPcwDxhvGsFTyNhWZflX
	bMpFusI8TI0GD61g0dAjTpct9du+0xEo1W2v
X-Google-Smtp-Source: AK7set9spxe6rqZ8SPklGRSqQ0VlDQIMgZFj5PBlR6HQEETzNN0grOEjo/gH7nDOAQ5lCaaJF56ECw==
X-Received: by 2002:a17:906:5011:b0:8b1:32dd:3af with SMTP id s17-20020a170906501100b008b132dd03afmr5720143ejj.28.1677657967795;
        Wed, 01 Mar 2023 00:06:07 -0800 (PST)
Received: from [127.0.0.1] ([194.110.115.78])
        by smtp.gmail.com with ESMTPSA id a22-20020a509b56000000b004af57500d5fsm5306459edj.54.2023.03.01.00.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 00:06:07 -0800 (PST)
Date: Wed, 1 Mar 2023 09:06:07 +0100 (GMT+01:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Message-ID: <d3e490f7-549d-43da-a8a4-2acb31c767b5@tessares.net>
In-Reply-To: <b48676849c00ed0f700702717ddccc6204a4f489.camel@redhat.com>
References: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com> <b48676849c00ed0f700702717ddccc6204a4f489.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] Squash-to: mptcp: use the workqueue to
 destroy unaccepted sockets
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d3e490f7-549d-43da-a8a4-2acb31c767b5@tessares.net>

Hi Paolo,

1 Mar 2023 08:50:39 Paolo Abeni <pabeni@redhat.com>:

> On Tue, 2023-02-28 at 17:19 +0100, Paolo Abeni wrote:
>> The workqueue could trigger before inet_csk_listen_stop() kicks-in,
>> or the closed socket could even land to accept(). Solve the race
>> falling back to TCP - we already complete the MPTCP level close
>> signaling.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/366
>>
>> possibly worth manual handling
>> ---
>> net/mptcp/protocol.c | 14 +++++++++++++-
>> net/mptcp/protocol.h |=C2=A0 2 ++
>> net/mptcp/subflow.c=C2=A0 |=C2=A0 6 +++---
>> 3 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 08a912bb7215..467989c2b0ec 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2398,7 +2398,6 @@ static void __mptcp_close_ssk(struct sock *sk, str=
uct sock *ssk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> =C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0 sock_orphan(ssk);
>> =C2=A0=C2=A0=C2=A0 subflow->disposable =3D 1;
>>
>> =C2=A0=C2=A0=C2=A0 /* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared t=
he related ops
>> @@ -2406,7 +2405,20 @@ static void __mptcp_close_ssk(struct sock *sk, st=
ruct sock *ssk,
>> =C2=A0=C2=A0=C2=A0=C2=A0 * reference owned by msk;
>> =C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0 if (!inet_csk(ssk)->icsk_ulp_ops) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(!sock_flag(sk, SOCK_D=
EAD));
>
> Dumb me! above should 'ssk' instead. Not sure why the issue did not
> trigger in my local test.

Good catch, I missed that too, sorry!
Same in the one below, no?

> I'll send an update version soon.

Thank you! Please add a very small cover letter for the CI if you don't min=
d :)

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
