Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FB23DB
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 16:27:56 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30fba11b1ceso2941071f8f.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686673674; x=1689265674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXBTcxS6e+KLdzegbHLSQzJR4kJD9TFGPGdy9rLfOww=;
        b=bdzHGgwU1+0zR84sjdpR37niIzDxRw80hIgBhfNsbRn4wQpanad4Zs4/orufYdE2La
         kx+Lk7vEfclCAKcMU+KbvLQXR5quJ0d+GOVWA0Eg24kJhHIqcLYmt858037q8V38jmvH
         XZvbnCTld08oHXfCG314bmIfRfDDWCwJNI3rDPVJOnpdio98haDQ320Jv62Yzcp0FqS3
         PxaHDKodS5MqNJkGV3P9kSKbfjp6VoVNwqOWDOpvINXM35/98VGU1hMjEKtqNJjw0vxq
         EQWqo+ssU+xyzG6PLbTSZEcNPowSQww3u5mUOIV1dwUmDCJ2OHA5nBNQt1CtuD0BaW4m
         wGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686673674; x=1689265674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXBTcxS6e+KLdzegbHLSQzJR4kJD9TFGPGdy9rLfOww=;
        b=l6ufO5+zcw70C/9UgWIlb3+mdPraIXu73ZOhfnUqK8CWmac73ds8UEV75fatSuYgbC
         wF9ttjJsrRzzU9F7VAD9hbNIPF94rf7pd2Q5DAGenQZb7unC2rLpNkJM0dln0vnl2px5
         a3GyznqsFeKocWevvztTVIGoOKboRnZLQd8llcF4qn3+nrSE78397AbMic8iN9EBUQQd
         r3iOMt0Ob0J3xyNs9DlfIFRBAUaGjRsE/yFCK6jJFFGDANNpXliqGQoGvb3rpdq62yyA
         be0Jfx4Da/yh5zGvfASg44oNhCJYo5DMqYwKZbi8MGiskDbYmOpnsQYROxbDOToxn6ox
         Ew+g==
X-Gm-Message-State: AC+VfDwE+Nu88Lu7K6nfMHbRd+W96aiWWp/UrQcEw/yisxGGXFKTEMPY
	dSQ7lKxQ3g9MH47GEMGWL5EdWA==
X-Google-Smtp-Source: ACHHUZ7KEU+pF7/2AwLYQomBHKSHtBQbvZr47rrILPIaALiOSOjRsad+FAhArauXJ6kCBE7t0A9RWQ==
X-Received: by 2002:adf:f1cf:0:b0:30a:e87b:515b with SMTP id z15-20020adff1cf000000b0030ae87b515bmr8842213wro.20.1686673674187;
        Tue, 13 Jun 2023 09:27:54 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:43dd:5a9a:f4d6:7cf7? ([2a02:578:8593:1200:43dd:5a9a:f4d6:7cf7])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c294500b003f7ec896cefsm15013298wmd.8.2023.06.13.09.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 09:27:53 -0700 (PDT)
Message-ID: <0dd7af94-db5f-ab39-dc79-285de4bf0a11@tessares.net>
Date: Tue, 13 Jun 2023 18:27:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: 9p: MPTCP tests regressions due to new 9p features in v6.4
Content-Language: en-GB
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: evanhensbergen@icloud.com, MPTCP Upstream <mptcp@lists.linux.dev>,
 v9fs@lists.linux.dev
References: <855a232a-76d3-7e7b-b2b5-2ebc41bcadd6@tessares.net>
 <CAFkjPTnX0=-GK8sFzd4S+V2+cA8E-FAqYHNndZui2Sh_MvoHPw@mail.gmail.com>
 <88f7a06b-b044-9fdc-b3dc-4b374dbca332@tessares.net>
 <3E1DD5A9-A8CB-4951-839A-6EF229CFA8EA@icloud.com>
 <4830cc62-64fd-f74b-bbfc-b8e44e023513@leemhuis.info>
 <CAFkjPTnAV6Rngwn6voCF332CX+eUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAFkjPTnAV6Rngwn6voCF332CX+eUyeJd7U0GcYn9BbkBqcTkHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 13/06/2023 18:07, Eric Van Hensbergen wrote:
> Understood, this on top of my 9p stack, but day job has been getting
> in the way lately so I need to unstack there first.  Will do my best
> to reproduce and understand as quickly as I can -- but given its a
> performance regression it is likely going to be tricky to reproduce
> and understand, so I'm not sure how confident I am that we'll be able
> to close it out prior to the final -rc.

Thank you for your message, I understand, no issue.

On our side with MPTCP, there is no hurry as there is a workaround: the
revert of the series you sent for v6.4. So as long as it is tracked and
fixed at some points, we are fine :)

(but I don't know what's the impact for other people of course)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
