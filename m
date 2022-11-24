Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CB23AE
	for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 09:29:16 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id n3so1589758wrp.5
        for <mptcp@lists.linux.dev>; Thu, 24 Nov 2022 01:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWn80cLhO0h0HomPNL6dR2WB4VldVkeM1X9BV6Uw9Kc=;
        b=rPFiO6I3XnQKDrIy2j2ERKa68GrtfxSM++UgyMxXvHmfrPRsW6VRm8tyAGOnq5emxu
         p8T1R0MzX3W7JlXZBQRGRTT4LOCz5KIBd46/+IuKnQdlApPnd6hgCqnHmcZ4CsLblljc
         19qqL2f2Q7yeYTS5IvjmW4eAVlyP1mD4rZ7+rJTF6uO9b0XjimqCNDGRFAnnbvevJCO+
         hxhBIzXl6zRI+S/JAtbl3p4Mg6AAbQpcY/boRPzhi/rZCHzFEuvynPQrbNuWEvpQvkfD
         W6ypjJt9ak7zmtaa0pJpvGu0uqKkn/uC+HHvvfP/IHF1ImeT9hWOXuz/nMu17MGHdRzi
         7Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWn80cLhO0h0HomPNL6dR2WB4VldVkeM1X9BV6Uw9Kc=;
        b=YLPwmIJHC3A/Wq36oq5EcI1RX+PovTTdrYdom4fStMqjodhxtPuIzOBflUsmjL0ovg
         Yb84cxnOnXrXYsza5RBnsh+KeXuUry+w5ZfetHR52h/v/1BtjSjr0zBCGbNILlL0/Nul
         7ozWxeqqSt77lz9PncNStRAeBy1spG9Ge2FEc8+9oPVqp22ElAxLXZbre+acy6Ls1QI8
         kONt+sEe8fvvaPfXjXnR61yACRdV4SZKXVJL2NK4YuRU9AhgvrX7AYmCqqDXx1xJJG1f
         4DRlIM2kef/vbKsZckdQvlo026C9rYSjFZwONuJa6KFzdN2FYv2JWD6IAARCU81uSS6F
         FkOw==
X-Gm-Message-State: ANoB5pm6AUEw/UXvvuZplbC6TovtyLmhIspIcVYDjcc4eIQpARGAdJh1
	FIj7IqV3S3SOldjdQ/e/xZJQMlYWGgAmSex+
X-Google-Smtp-Source: AA0mqf6aiBifBUfdyrc95FBKxQzwYsvJwmmx7duiytqBZgXOzMtDwlRq+lxkByTVPtoCRXUdX3AQ4Q==
X-Received: by 2002:adf:d0cf:0:b0:241:f9c9:fdbd with SMTP id z15-20020adfd0cf000000b00241f9c9fdbdmr1858758wrh.343.1669282154193;
        Thu, 24 Nov 2022 01:29:14 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:32da:6dc2:4a83:ab62? ([2a02:578:8593:1200:32da:6dc2:4a83:ab62])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c4e0d00b003b3365b38f9sm1148489wmq.10.2022.11.24.01.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:29:13 -0800 (PST)
Message-ID: <61f32c80-193a-898c-30d4-2d3b6ef2f21e@tessares.net>
Date: Thu, 24 Nov 2022 10:29:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev,
 Menglong Dong <imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
 <0b86b2b1-1a5c-d500-fd79-c23f2fd4a5ed@tessares.net>
 <CADxym3axbs=a5Xw=0NW1t225MLqY42M47qQiSu_SuLJ+R_KtbQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CADxym3axbs=a5Xw=0NW1t225MLqY42M47qQiSu_SuLJ+R_KtbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong Dong,

On 24/11/2022 10:06, Menglong Dong wrote:
> Hello,
> 
> On Wed, Nov 23, 2022 at 11:58 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Menglong,
>>
>> On 22/11/2022 04:49, menglong8.dong@gmail.com wrote:
>>> From: Menglong Dong <imagedong@tencent.com>
>>>
>>> In the 1th patch, we do some code cleanup with replease 'sock->sk'
>>> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
>>> use. In the 3th patch, we make mptcp_connect can exit when receive
>>> 'SIGUSR1' with '-r' flag. And in the 4th patch, we add the testing
>>> for this commit.
>>>
>>> With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
>>> I belive that the testing of diag.sh can pass now. In fallback and
>>> simultaneous close case, the msk can't release normal (sometimes?) without
>>> that commit, and makes the testing fail. Enn...let's just see that the
>>> CI is saying~
>>
>> Thank you for this new version!
>> I was waiting the feedback from the CI to start my review but it looks
>> like the CI was not able to apply your series [1].
>>
>> I just applied the series manually, fixed the two conflicts I got and
>> sent it to our repo[2]. We should get the results later on.
>>
> 
> Thank you for what you do :/
> Enn....seems net-next is not a good branch for mptcp works,
> I'll rebase to mptcp_net-next branch next time.

Yes please. Either 'export' (or export-net) or 'for-review' (or
for-review-net), see:


https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches#which-branch-to-use

> I notice that the CI contains some failures, which I am not sure
> if it is caused by my commit.

Indeed, it doesn't seem to be linked to your modification.

I will try to do a bit more tests on my side just to avoid instabilities
but the last modification you did should help stabilising things.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
