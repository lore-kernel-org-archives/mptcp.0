Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8418173
	for <mptcp@lists.linux.dev>; Wed, 29 Dec 2021 14:03:20 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id b13so86638635edd.8
        for <mptcp@lists.linux.dev>; Wed, 29 Dec 2021 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lkuS4DTNx6mhAA3K+e/PbnavSQwTmw/jxmYeS53q5X8=;
        b=mbLms6gXl2mi25Oe/n4jXpAQW9gb2OsxmAiJFWcPKCA28/RqMMxytOUT5BUJv2Uzbg
         cynRK76cON0oUu4kEPaSYQ4DdU5HiXrw/wUsFQGuXuLj4QKUwF5BBMA7b7Eu/sJWqcro
         Wyl2Dqyfou2zBVqyHSfDtehC6Yo1P6wbNyAWljgZ9vnZYqcZESIeFBOkf3UtFFXNMaho
         8i48OCUU0qlYnoqek+OR1NXWITGikPG5M6MM7Ng8p0AhT25jCX0awlVMF5J8E3FPmFkv
         ZcD79EQmrgd3lgrjbFmEVhsoStC/N8kICs9dHBbj39U9az3TNki/qil3wU6QUUhxMOwk
         U/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lkuS4DTNx6mhAA3K+e/PbnavSQwTmw/jxmYeS53q5X8=;
        b=ZBrKFf98+FOPS0XAx903Kh4XEkEJffLQ3Qpu2lrTZZ0ARz5AXT8XXWJ8W2ZqZ03aFh
         MQDyE/xyX2BftqIiSGIn2GICwx8AzpgfCAxInvQt91szDgcM5uqvVNBNe74w7CXuJ86e
         yuzPRqKkM7EFKSKcuMMTY49gZJPiRp++FoqZ3YbuKm4hskLIxtlIYf665qWIFBeqUeLt
         DHYyOweniYOBn+VGuF5h9FB1yi6u07wK99tiQFvJsVrASaZQZiAoMHV59deSig0lGHkI
         qNWLrN13RWzORtKniDLubWieyXbfj2FJrfbtqlL0yMedDilyjiUdpMUY1KbFquvWUixE
         DVRQ==
X-Gm-Message-State: AOAM532MOKbaluFS74jHSYNh2cJLD7Pp9q5oPx2+ySzAtIaD/1jfNVka
	OmP9NZ/sJSJNquPx4VRzD7y/hlN2ovx+I6E2
X-Google-Smtp-Source: ABdhPJx5UGUzWnweuVXP2/n0eTsQ+xsTmO4kpi4A5KnsskBUIMf/69WMBTl5KFP3EG96/Jaq3DiNTQ==
X-Received: by 2002:a17:906:3e4d:: with SMTP id t13mr20693940eji.467.1640786598986;
        Wed, 29 Dec 2021 06:03:18 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:4173:e151:33e7:c1de? ([2a02:578:8593:1200:4173:e151:33e7:c1de])
        by smtp.gmail.com with ESMTPSA id s3sm6951025ejs.145.2021.12.29.06.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 06:03:18 -0800 (PST)
Message-ID: <1d349ddc-a3bc-7d74-f626-737576af8e9a@tessares.net>
Date: Wed, 29 Dec 2021 15:03:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-9-kishen.maloor@intel.com>
 <7be3ba91-232d-1357-dcb7-b55b01d46f3f@tessares.net>
 <39006fe0-fbff-f08f-4642-6ef8cdb2ad8f@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <39006fe0-fbff-f08f-4642-6ef8cdb2ad8f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2021 08:34, Kishen Maloor wrote:
> On 12/17/21 8:34 AM, Matthieu Baerts wrote:
>> Hi Kishen,
>>
>> On 16/12/2021 23:23, Kishen Maloor wrote:
>>> When ADD_ADDR announcements use the port associated with an
>>> active subflow, this change ensures that a listening socket is
>>> bound to the announced address and port for subsequently
>>> receiving MP_JOINs from the remote end. In case there's
>>> a recorded lsk bound to that address+port, it is reused.
>>> But if a listening socket for this address is already held by the
>>> application then no further action is taken.
>>
>> Do you think we should add an option not to do that?
> 
> I can't immediately see why that would be necessary. I would think that a machine that
> wants to restrict MPJs could choose to not issue ADD_ADDR advertisements. 
> So it could be more a matter of path management policy?

Yes but likely, the PM is a daemon separated from apps creating
connections. Maybe some apps want to add restrictions on purpose and it
would not be practical for the PM to check what kind of lsk has been
created to know if it has to send an ADD_ADDR (+ create a new lsk) or
not to respect restrictions set by the linked app.

> However, for PMs that do issue ADD_ADDR messages, this change merely attempts to create
> or reuse a (previously established) lsk (which was stored in the kernel context).
> But if the lsk is held by the application, then no action is taken.

I didn't look what was the cost exactly -- probably a look-up in a table
without locks? -- but maybe on a busy server, you don't want to do extra
actions if you know they are not needed.

> There's a separate change in the series to allow subflows to be initiated from either
> end of the connection. So in a scenario where a machine that happens to be running a MPTCP 
> client application issues an ADD_ADDR message (and reusing the subflow port), an lsk would
> be created as a consequence of this change.

Even if it looks very unusual to me to create subflows from the server
side, it is good to have this option! Thanks for adding it!
But we can also have an option for these two changes :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
