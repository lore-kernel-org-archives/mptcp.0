Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A103653
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:07:45 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id lc7so19125305ejb.0
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 01:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5E7bRb11st20lPAYtxoEdVb6cQM03XcfEBl0DnrhLoY=;
        b=GJqQ4HW2aSbVAogE03B8+Zmze6D7gRaiUCZ4d1avvUUjT4rFDowT5o4u3vYOO1SF2w
         T/3uJ8z+CCHo4xot53jSuVJopAXBzECc/2+Pgbk4F3sh53hqHSSVJkgywXF825nOkrv4
         AJBu+yUMHzXyiR+90wKlNZYpD2vPgb4smdS5LlVUyh3RbFbvJP4uhORKN8pr+6FmuYQp
         QfLe5oj6wJy6uHYlYo1XH0v7MMUrg1glwinYsMb0Vu5ManVOQ2En+wpLC+NtiZpNM8/+
         R9FWb8WWDs+fuBJtg5G3Ofn9JOos5UUBhjU9g3fUqc63Yzm9vVgnNtgXSRrHKWOI5gTd
         gzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5E7bRb11st20lPAYtxoEdVb6cQM03XcfEBl0DnrhLoY=;
        b=nCQ13Ekc+QpJ2v0brr7tdPxCNpNU3nKZH5Ukxt3nZpLCkj2TPRSexhRLel6G/k/QWH
         GMafGIWJhjvCv1VAqzTKII4pi9kiEN7v4xZaT/asSMpbTb3xNaP3bLH/ekAjUk7N4Hwz
         xEPBCw3+vgxSuf4hG87wNbUHTPA8kZ0SJoEvD2grizA6mZPA01a1tg+IGdp/QmzMUbOU
         CzWBGg5qNMwJS+qC8e47W8YYvPml9SRWcIewl+tbRaUW4ddXEwoSuYPYPPywY+6ums8V
         zYkQ109GgzFJJm0cus+9srVhJpHjYcfl9fV81orTpQ+h63XULbaPxeHodwP3ftXsCXCm
         JqQw==
X-Gm-Message-State: ACrzQf0LTgkHqXe9ur/OrpwTAHHy+RS4syK15TQ63oLpKA3Tt8/aYOeL
	T6NetVhmHuNh1H+919u+/IMH1g==
X-Google-Smtp-Source: AMsMyM4OBBkVj/r9WhHhITArPstbYTJ+TVOJIyU1/aP4HWQ1UbWTGjQXkMoNTZRar5ulMiyIy9sfJQ==
X-Received: by 2002:a17:906:4795:b0:787:434f:d754 with SMTP id cw21-20020a170906479500b00787434fd754mr300200ejc.268.1664266063567;
        Tue, 27 Sep 2022 01:07:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9302:e21:26be:f795? ([2a02:578:8593:1200:9302:e21:26be:f795])
        by smtp.gmail.com with ESMTPSA id io7-20020a17090780c700b00771cb506149sm398693ejc.59.2022.09.27.01.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:07:43 -0700 (PDT)
Message-ID: <2d24f789-9fc1-0229-4b37-ff570c4be080@tessares.net>
Date: Tue, 27 Sep 2022 10:07:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: MPTCP upstreaming, week of 26-Sept-2022
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <57e168ae-9de0-c986-cab1-a130e72e4e95@linux.intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <57e168ae-9de0-c986-cab1-a130e72e4e95@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

On 27/09/2022 02:10, Mat Martineau wrote:
> 
> Matthieu and Paolo -
> 
> I upstreamed the fastopen changes for net-next today, so those are in
> the patchwork queue for the netdev maintainers:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=680767

Thank you!

> The other patch sets we discussed upstreaming in the meeting last week
> were:
> 
>     - Fixes for -net:
> 
>         - [6e827151a607] mptcp: factor out __mptcp_close() without
> socket lock (Menglong Dong)
>         - [62b5536f77f6] mptcp: fix unreleased socket in accept queue
> (Menglong Dong):
>             - can wait a bit more and can be sent next week
> 
> 
>     - Features for net-next:
> 
>         - [ef4a93571133] mptcp: propagate fastclose error (Paolo Abeni)
>         - [885cab8b5203] mptcp: use fastclose on more edge scenarios
> (Paolo Abeni)
>         - [13c82c8b0d9f] selftests: mptcp: update and extend fastclose
> test-cases (Paolo Abeni):
>             - can wait a bit, Paolo would like to have a look at the
> modification on packetdrill side
> 
> 
> I'm planning to upstream the two -net patches on Tuesday unless someone
> objects.

Sounds good to me.

> The net-next patches are slightly more complicated:
> 
>  * They were updated with a squash-to patch today
>  * Need to wait until fastopen patches are merged

We should at least wait for the fastopen patches to be applied I suppose.

>  * There is a minor conflict with the -net patches (just diff context)
>    in "mptcp: use fastclose on more edge scenarios".
> 
> 
> Regarding the conflict, I could wait until Friday for a likely
> net/net-next sync.
> 
> Another option is to modify the patch slightly by moving
> mptcp_check_readable() before __mptcp_check_send_data_fin(), it doesn't
> make the diff any larger and avoids the -net conflict. What do you think?

We can also add a note in the commit and explain how to fix this
conflict. I think the function is at the right place but it can also be
moved if it eases stuff.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
