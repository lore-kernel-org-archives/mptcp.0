Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019070
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 15:23:17 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id l4so14191603ejc.10
        for <mptcp@lists.linux.dev>; Fri, 07 May 2021 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2VpzNsCp2NzL0M/5oAPrGfWbsj4ifw2rYpxfctnt018=;
        b=e7G2KJx+j13P5YsS6p6v8jbsegto91sUEKx0g6wWXUiMk0xc5CqZl8rgjXlNgh1Qfl
         93bhbGq1YG5TBV2TkJvgMlT/DBmkDaT5nMWyAvqAu+iU9l74TG8xP3YVWOhR1pAGw+38
         +QQgUO8yvn/LW+ApYy3JHVExEDNHJo609UbcJQxIMgWFY7rxaSyPn+FWIc8/MvcPkS/J
         W2a7O4CaazmnoXvgOq9hiunXh7Ai6e9ZtR9yJDI6D2ZLdv3e7AgJFbbMjnuzXkxIW8gw
         qGW/nCe4ElMMKnk1xd6MZCO4DSFRqN9g4i8ZfKPEhC4/HdGss5nbD54gxgk1CG5kK5T1
         EacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VpzNsCp2NzL0M/5oAPrGfWbsj4ifw2rYpxfctnt018=;
        b=GSRTjQEOI/WcXk0LRhLM20ZPbBM5V4jAoJa1bNbVXM7l8bo8BPJlb8rmaHww7eMXX+
         c2JpQspdE+uCR1+LI+YAixa1dhnioqrgQ8BqIjIztU8KMaQJA4790RMIwh4ZON5JVGfQ
         JzPs+P8M9ijl75IQiSbx8kLIDRt2/gfBlGPoZF40tcS9MPpsoKuc11Up4HBx3VKGUIZV
         3mU6HkCZfXcUu+qZpjD/1nhViU08h0medqMDg2w85w9eqLYyeMkulffY30zwcrAsF/Fy
         xYB8EE8NajFy75RmGsR7eJTdqZ0UOhdIXNOvlczrdRLKMP/yyb4jjZ+zH901gw2H4F4c
         ELJg==
X-Gm-Message-State: AOAM5314tbwjWj7Jj5hWoMTXb5CJPN9CqnoVqjCzUUw9EwceXiaYch1k
	TtchYbHHbWEH/shYjUGH/STgXPBKi2ajYt7eoVs=
X-Google-Smtp-Source: ABdhPJxkgN1FwYL0yKrrcduXAm5U9OX+PYF/PSOEJ8SdGSh8nhGhWRro1bxD4YkEd33oYhGM7O4Ayg==
X-Received: by 2002:a17:906:fb04:: with SMTP id lz4mr10860405ejb.66.1620400996138;
        Fri, 07 May 2021 08:23:16 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2fa9:2d27:234d:525d])
        by smtp.gmail.com with ESMTPSA id z12sm4322119edr.17.2021.05.07.08.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 08:23:15 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <c8b33d7b10e063f3bd93d25955d539a6af7f0372.1620374286.git.geliangtang@gmail.com>
 <c92941a2-d629-ae34-23e3-18faec2a3750@tessares.net>
 <CA+WQbwvfLSqK5uWUmNrPwzazwXV2HNUXU_8HUz6dxifYmRTGCw@mail.gmail.com>
 <619cd782-bb39-c284-b59e-546a0aea3e3d@tessares.net>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: don't fallback when data_fin
 enabled
Message-ID: <6b70c2a8-f705-219f-8b1a-ff74a1261a8d@tessares.net>
Date: Fri, 7 May 2021 17:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <619cd782-bb39-c284-b59e-546a0aea3e3d@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 07/05/2021 14:19, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/05/2021 11:08, Geliang Tang wrote:
>> Hi Matt,
>>
>> Thanks for your review.
>>
>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年5月7日周五 下午4:51写道：
>>>
>>> Hi Geliang,
>>>
>>> On 07/05/2021 09:58, Geliang Tang wrote:
>>>> This patch fixed this fallback error:
>>>
>>> Thank you for the patch!
>>>
>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>> index f3e379a0f08d..940b32511443 100644
>>>> --- a/net/mptcp/options.c
>>>> +++ b/net/mptcp/options.c
>>>> @@ -901,7 +901,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>>        * MP_JOIN subflows.
>>>>        */
>>>>       if (!mp_opt->mp_capable) {
>>>> -             if (subflow->mp_join)
>>>> +             if (subflow->mp_join || mptcp_data_fin_enabled(msk))>                   goto reset;
>>>
>>> I don't think we should send a reset here. For me this behaviour is normal.
>>
>> Yes, we don't need to send a reset here. What about just return here?
>> Something like this:
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 3428c163299b..bd62dadfefdb 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -905,6 +905,8 @@ static bool check_fully_established(struct
>> mptcp_sock *msk, struct sock *ssk,
>>         if (!mp_opt->mp_capable) {
>>                 if (subflow->mp_join)
>>                         goto reset;
>> +               if (mptcp_data_fin_enabled(msk))
>> +                       return false;
>>                 subflow->mp_capable = 0;
>>                 pr_fallback(msk);
>>                 __mptcp_do_fallback(msk);
> 
> I think we still need to do a fallback here not to expect a DATA_ACK.
> For example in __mptcp_check_send_data_fin(), we change the state
> because we will not get a DATA_ACK.
> 
> So I think everything is OK there.
> 
> Just one thing: should we send a DATA_FIN if we were not "fully
> established" when closing the socket?

Paolo shared this answer on IRC:

  I would say yes. The server side could have already allocated the msk
socket (and the 4th ack could have been lost)

Which makes sense.

So I think we should not do anything here. Except maybe a comment here
in the code? e.g.


diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3428c163299b..43d55039743a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -905,6 +905,14 @@ static bool check_fully_established(struct
mptcp_sock *msk, struct sock *ssk,
        if (!mp_opt->mp_capable) {
                if (subflow->mp_join)
                        goto reset;
+
+               /* We also want to fallback if the connection is closed
while we
+                * were not in fully established mode.
+                * But we still want to send the DATA_FIN if the
userspace has
+                * closed the connection at this stage, just in case the
server
+                * side has already allocated the msk socket or if the
4th ACK
+                * has been lost.
+                */
                subflow->mp_capable = 0;
                pr_fallback(msk);
                __mptcp_do_fallback(msk);


Cheers,
Matt

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
