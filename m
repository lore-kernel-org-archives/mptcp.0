Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939641801C
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 17:12:35 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so1454424a12.3
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689873153; x=1690477953;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfwMpwOYZt1moCSVdZWlT9E2LGpkvMb8qwHY23HLPpI=;
        b=rqLhTfqdDUaWhT1+iCn1vAWeyFI44nF5xuIknUpRAZhFREiiDF919CLnWOzWN9UvL6
         t5p6bwvtU9JNGYkCJBsau2mGkVdLSBDB04Gco2wZNUpTRSYDzE++MT/wX8+sP56ixpVw
         1vqpdSfxxJqH6z/PxXxl1mvDBYBufMUKqySoGF/76al9aQXZzJfa2bYeFRMYugMPyW7c
         P8baepwHEfZV+FFU77Y4FvM4aink3qkIZ5/OzjyBKQX7FMptpgkaDQjvJQSr5xOjFa+a
         vQhurknI8Qk6hI58nRDneEYRmGJNebGbpnZsjm24QDzsy+oTC/FEPzw2ciGjUI2XbAhb
         pjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873153; x=1690477953;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfwMpwOYZt1moCSVdZWlT9E2LGpkvMb8qwHY23HLPpI=;
        b=PhCDwX4Mh6kWM1NIEbbUGp+XrCsQkZhKfaoKrKUPc7b74DFVkrXk06jmTQ/gbPrTyG
         1A4WGQWCa3qTnj7E6rz+fGw9axDkjTEmt16R445Odz5K69JB6YdpbTps1dUfTPuhbOGH
         GAw0Np7C/YdpNKdhSqJvO3n0r5MrlvCzeEIGlv5rTB5fIfkFnNyl00v7WhpyhaZcyVj/
         v5LiC5+Wy8J5j6L9Q0RYlz6I2ygoAwcgAFuIto4EvRJ0PHF+gytd3JYJzorI0DXbp/bF
         tUySNPVS1hkyF/OmLmLa06jAvY3CaWrJ4vHey8ylG6wtw+O+SPyKZSPjzvCYJMOmwd7i
         +BbA==
X-Gm-Message-State: ABy/qLbYdwPeEGJlccTxnxC/zW/lQBQnVrnH3h10eCSPV0py3oiPfObm
	ayVXTgDwNHA63uaZgm6LwVddJmXXbCVa8hRtHcY=
X-Google-Smtp-Source: APBJJlFCp8I6/b/cRrGb2a1qlIETbfPfVL9IoNfeKqUOqTR2EYNULTtvCQmD5A2g8mvX8NnnIXUoww==
X-Received: by 2002:aa7:c301:0:b0:51e:22da:186c with SMTP id l1-20020aa7c301000000b0051e22da186cmr5025091edq.35.1689873153206;
        Thu, 20 Jul 2023 10:12:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:82bd:30b5:d889:7e87? ([2a02:578:8593:1200:82bd:30b5:d889:7e87])
        by smtp.gmail.com with ESMTPSA id x16-20020aa7d6d0000000b0051dd4daf13fsm1010843edr.30.2023.07.20.10.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 10:12:32 -0700 (PDT)
Message-ID: <7c8ccc1e-39f0-780c-a939-ac4bee8809e6@tessares.net>
Date: Thu, 20 Jul 2023 19:12:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2] mptcp: fix rcv buffer auto-tuning.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <35589ab7fe16f915945f6402e28adb82f34a8287.1689868234.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <35589ab7fe16f915945f6402e28adb82f34a8287.1689868234.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/07/2023 17:51, Paolo Abeni wrote:
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") broke
> such assumption, and as a consequence most MPTCP connections stall on
> zero-window event due to auto-tuning changing the rcv buffer size quite
> randomly.
> Address the issue synching again the MPTCP auto-tuning code with the TCP
> one. To achieve that, factor out the windows size logic in socket
> independent helpers, and reuse them in mptcp_rcv_space_adjust(). The MPTCP
> level scaling_ratio is selected as the minimum one from the all the subflows,
> as a worst-case estimate.

Thank you for the v2!

Now in our tree (fix for net-next) without typos from the commit message
+ the Fixes tag.

New patches for t/upstream:
- a81cd0220de3: mptcp: fix rcv buffer auto-tuning
- Results: 233d82c91559..6af60b285fa0 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230720T171052

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
