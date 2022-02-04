Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E782F21
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 20:52:41 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id ka4so22695158ejc.11
        for <mptcp@lists.linux.dev>; Fri, 04 Feb 2022 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=cgTPKUGGAsL/jN59ItluJhKNIcd2HUpGaxQD3gEU0UQ=;
        b=jCgDYHOPp/16WpUUy6T84xHdgb5u1RcvHSuh6x4kpkIPRI/iTO/W0XDj8lyryhYlXw
         0Fuy/zCHPydiuzC3EvRj2alIFtWQ4kMRJmHlYM9gA7NzY33goiYlYnlJjZJ1KRHs/DHY
         NQwm8GgndZcdEnhempIBhZxxqsGuo0KARPYvOeY6qc3EgeaZZ9Z2tcQLlS8jLrQ1lYYI
         he+UZ1sjeAi6P87I+awlly6T6JagOtIf3LAqZV30SU3bZZRvmTP7i7SDGFMiZy2j2PRv
         JgGEeG3FURLJg1dBSLLfP73LnE5+jL4TcT8S8Qvhy5/6w5bQATmUka0oWytjF4DGnPUa
         FdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=cgTPKUGGAsL/jN59ItluJhKNIcd2HUpGaxQD3gEU0UQ=;
        b=xH+K65Oi05KHq91+GIRbFEl1s0GKeQbBzE0nI68zBjDujYpDrheqTvdv3NHeI8sHlz
         2Q6tedEvwFcJRUVxZpQAc4i0m9PdbRnVMMYXdWN5Rm2gY7ZO/Pcpt8TjbYTcUaov5XEz
         S8GAGLHxkw+FyDGk1ejkdaJg1iS5zKw9NfKd13aBN4ulB2rJso4cyRHpVO3Log4NU4GL
         aXj8er3BPw1K1b5EN3P98ZOCWb45iD+Ong5xkts/skajnYRRXb4DMGrCr1uWykbHuMGj
         1vxk0BBNvmko0gKuY/4bmkLZhh7/kBr5e5XNG6zy0KzmrffKAtOKwL9t//+E3AKzZIgL
         j4rQ==
X-Gm-Message-State: AOAM532uKReMXaG0opC3HwLg7LYRSv8G8DW9IKuJJORb7lu65Dwmdil8
	9h9gUKZrNuGm9z4kRS7T6PLKu11Bkrtd5w==
X-Google-Smtp-Source: ABdhPJwBvFmB3LaMmB2582TuBDpPTOWlRDFJiEGsmb7bgY1Tpit7Fo8UPK+jOPbGk2vuAnqyu0LLeg==
X-Received: by 2002:a17:907:3d8f:: with SMTP id he15mr593522ejc.157.1644007959285;
        Fri, 04 Feb 2022 12:52:39 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4f89:d55b:de90:116e? ([2a02:578:8593:1200:4f89:d55b:de90:116e])
        by smtp.gmail.com with ESMTPSA id bs4sm1270437edb.84.2022.02.04.12.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 12:52:38 -0800 (PST)
Message-ID: <510a18db-2949-e95d-050f-942e15e9ea96@tessares.net>
Date: Fri, 4 Feb 2022 21:52:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: fix diag instability
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <db50196c67b30e7b89d241faffc78e5ffbb04e83.1643976999.git.pabeni@redhat.com>
 <932621cc-7db9-91cb-7daf-e37a4953a43c@tessares.net>
 <cc21c95dccf7768ea9465438520a028e7a42fd5d.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <cc21c95dccf7768ea9465438520a028e7a42fd5d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 04/02/2022 19:32, Paolo Abeni wrote:
> On Fri, 2022-02-04 at 16:53 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 04/02/2022 13:17, Paolo Abeni wrote:
>>> Instead of waiting for an arbitrary amount of time for the MPTCP
>>> MP_CAPABLE handshake to complete, explicitly wait for the relevant
>>> socket to enter into the established status.
>>>
>>> Additionally let the data transfer application use the slowest
>>> transfer mode available (-r), to cope with very slow host, or
>>> high jitter caused by hosting VMs.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>>  - use wait_for_ instead larger sleep
>>>  - hopefully better commit message
>>
>> Thank you for the new version!
>>
>> It is being tested in the background. More than 175 attempts in a slow
>> environment with a debug kernel and no failures so far!
>>
>>> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
>>> index 2674ba20d524..ff821025d309 100755
>>> --- a/tools/testing/selftests/net/mptcp/diag.sh
>>> +++ b/tools/testing/selftests/net/mptcp/diag.sh-
>>> @@ -119,7 +149,7 @@ for I in `seq 1 $NR_CLIENTS`; do
>>>  				./mptcp_connect -p $((I+10001)) -l -w 10 \
>>>  					-t ${timeout_poll} 0.0.0.0 >/dev/null &
>>>  done
>>> -sleep 0.1
>>> +wait_local_port_listen $ns $((NR_CLIENTS + 10001))
>>>  
>>>  for I in `seq 1 $NR_CLIENTS`; do
>>>  	echo "b" | \
>>
>> Do we need the change the last sleep (sleep 1.5) as well? We could wait
>> for a shorter time but well that's only 1.5 second once. And I guess we
>> might need to look for each connection because looking at the last one
>> might not be enough if there was an issue with a previous one.
>>
>> So best to keep the "sleep 1.5"?
> 
> We need a more complex test to replace sleep 1.5 reliably. I'll look at
> that later, surely in a different patch.

If we don't see other issues with the public CI, it might be OK like that!

>> If yes, do you prefer if the test run for a longer time or can I already
>> apply it?
> 
> Please, go ahead, thanks!

Thanks!

Should I add a Fixes tag and put it in -net?

Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")

@Mat: Also OK for you?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
