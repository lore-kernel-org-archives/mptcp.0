Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22EB1640B
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 14:36:07 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso3107388a12.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686321366; x=1688913366;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBhZ4C+kdY8O2arwIZWcY1guLJny/wQNtfVzTMD/6bs=;
        b=ryGKOo09k3qZo9L+m5e+CYtp5g/aiKlFnxSVw1P8MWsNGqLr5OvzXWnyoiil+Ilj3b
         B2M9q/Rc1CO0/65zITOgqPErBxw8ZevJpw7qz35qSgCyBX4uQJ/opjZja11t0r3eXF8g
         53rSZ0qj5j1ZqM9gJSBqp8SCGvndm4oRCYXEpfhUx/2iimQy8ZbhKXVa3PLcUaRZOvqf
         APgUxvvyuS9rc8hwXCYgrM6qhhX96tiYQ/Rsi47Poug3PkanDGdXJw+ZrZZOT00b3mM3
         GPrJD9GQRf0M2Kg9vFPIlruXHsZhEkRgzWoyWN78lqem/zWLmUBWs/Esy2CPV+nx9+KE
         dF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321366; x=1688913366;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBhZ4C+kdY8O2arwIZWcY1guLJny/wQNtfVzTMD/6bs=;
        b=GascSKXuhA7nulEebmXGvJ0wE50afaZUsh4aQt9z4TbFa1ot1Y0LuPD9bEzdLGkeSZ
         ucDGhh83QN1lQeJ8kb4JN6n/WyysFcRtBj/NkpU79inz4wOSLQM+/4uzZOM8zIP+3z8p
         JX/z6HbuXWAihegyqCIdWNbG55cNBQ9rAHJ1q2PZGQxNDvSNJXTNyv8HtZcMzQQ4xpuH
         wDFKLpfQfY23Met8jIdThAzpGFh+ngnSZNcV39UwFKO/AivZjaO0EayzMiAUcyqqBkGv
         8y6MSIG/lcne5/YIOJY9X3wAqRxN1u75OaupEHrhrfP38ftinBRofOT3a2zMQE7jZSIE
         qZaA==
X-Gm-Message-State: AC+VfDxPTV1gYDJ2HwzH7PEbedS+hlUIssJ7hLTZ/cwCeoj7Ofs9kZnu
	9EZ7B3oKs2AxohxBKpCoWZWavpEeJDtsLUnUxZRU3Q==
X-Google-Smtp-Source: ACHHUZ7P1YI9jotfG1RH4SeOs/1JOggIlXteRw9NOBRfhp4AHky8DIdRa+U/TPr1WBB/7M5Nud6gqg==
X-Received: by 2002:a17:906:4792:b0:96f:608c:5bdf with SMTP id cw18-20020a170906479200b0096f608c5bdfmr1981753ejc.64.1686321365723;
        Fri, 09 Jun 2023 07:36:05 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709066bd000b009596e7e0dbasm1357722ejs.162.2023.06.09.07.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:36:05 -0700 (PDT)
Message-ID: <5bddc8e7-7fe3-280e-0299-900e855f4ad0@tessares.net>
Date: Fri, 9 Jun 2023 16:36:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next] mptcp: consolidate transition to TCP_CLOSE in
 mptcp_do_fastclose()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/06/2023 18:34, Paolo Abeni wrote:
> The MPTCP code always set the msk state to TCP_CLOSE before
> calling performing the fast-close. Move such state transition in
> mptcp_do_fastclose() to avoid some code duplication.

Thank you for the patch!

Applied in our tree (feat. for net-next):

New patches for t/upstream:
- 6e7d80e97f44: mptcp: consolidate transition to TCP_CLOSE in
mptcp_do_fastclose()
- Results: 403607c45570..f3033b20c7e6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230609T143326

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
