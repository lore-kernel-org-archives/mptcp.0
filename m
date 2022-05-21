Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35617EA
	for <mptcp@lists.linux.dev>; Sat, 21 May 2022 07:28:02 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id ck4so14948763ejb.8
        for <mptcp@lists.linux.dev>; Sat, 21 May 2022 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S3i9gqgrHnPywgUvdlakwh/jxoy2x89746APc/egDAs=;
        b=K+Uwdt6M+yPe+VT5C2Jgr422QlsgsKqUkgOs1B2/UbW+9XEn2asVagWh9pwiz4rSxA
         8RR43BXriyrEwEmWPB7aPMwzIrt2nvyp0jDdEhyBugvu5jrOgqPvam0AKTVE1My50fMj
         b/5mq9KXIm2m8jdrElKebeVaNb94cqXVIKxUImpI91cCvg90KzbMgPixs4b5lAoXWpmx
         A7utDshUAxvYUjEdfJiTbLohBNd+bbcpXThYP2DOYHqvxHKQnaouH2KvUPwNJb5c3/3b
         BKPLZMsqfcAoJfnbl2jIHueLueCwP0CFqcG1oNpx5Chm7Y1gQQHdvQxIbTobL4mQflpX
         mNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S3i9gqgrHnPywgUvdlakwh/jxoy2x89746APc/egDAs=;
        b=3VtBgJ1loN0FShKFZmdGHPK51Cwgnz+IkgD2MAJWkdf+3VNmLEEHnvSh7nUCAI1pbb
         sJJVQ/qg3VRw2tR41LdTGgHPjlgN+gebhwl2HdM9bYsIWhLVuIr7YJb3XjI/KvXjjExP
         NeBGF0LLWOMUlbB0QctJQGZuKkCbJjHjHHJr4mAaRs/eRywqKGRHvX5H/eS3eTFSbdmX
         o28rTNS1dz4cUVcxXT0KiLqzBFKlVNxAqPC9pDvmddJ9i3CNyFMRbwBZZ+O5FZ8Iz4N3
         RimxqXGlQB8odM8h2mkNuq/GGigjjV3ZaFGsci1B7sw2Beg+pYUxmU0XzJlAU/zVo8ew
         MT1A==
X-Gm-Message-State: AOAM530EmFYIA23ePOl9AP8DycLgGK6q1U6ukzpVF/e7+hxwccalkEA+
	NLwlQqYHJ6HUwOjAGWWfSoWkn+xUl/N6SyCJ
X-Google-Smtp-Source: ABdhPJyTyQScLA9nCXsTs0TZPFb7xpgc+SmZotcNw7wFt01JOrtfyjrIz8GDW3o7YOVXaWNUJkl+uA==
X-Received: by 2002:a17:907:7212:b0:6f4:fdc7:b7f3 with SMTP id dr18-20020a170907721200b006f4fdc7b7f3mr11987583ejc.16.1653118081101;
        Sat, 21 May 2022 00:28:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8ee3:e873:2222:8cda? ([2a02:578:8593:1200:8ee3:e873:2222:8cda])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090607cd00b006f3ef214dfdsm1616541ejc.99.2022.05.21.00.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 00:28:00 -0700 (PDT)
Message-ID: <46964ed7-3673-9bd9-e2a3-db29ec315135@tessares.net>
Date: Sat, 21 May 2022 09:27:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next] mptcp: fix conflict with <netinet/in.h>
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Ossama Othman <ossama.othman@gmail.com>, mptcp@lists.linux.dev,
 Ossama Othman <ossama.othman@intel.com>
References: <20220519153929.214331-1-ossama.othman@intel.com>
 <f4baa4-81e6-21df-80a5-13eb15317559@linux.intel.com>
 <e5d644c4-b190-412f-967a-8a79bfaf0f9b@tessares.net>
 <bd93114f-b693-cf60-9f42-f83543354499@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bd93114f-b693-cf60-9f42-f83543354499@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ossama, Mat,

On 21/05/2022 02:18, Mat Martineau wrote:
> On Fri, 20 May 2022, Matthieu Baerts wrote:
> 
>> Hi Ossama, Mat,
>>
>> On 20/05/2022 02:05, Mat Martineau wrote:
>>> On Thu, 19 May 2022, Ossama Othman wrote:
>>>
>>>> Including <linux/mptcp.h> before the C library <netinet/in.h> header
>>>> causes symbol redefinition errors at compile-time due to duplicate
>>>> declarations and definitions in the <linux/in.h> header included by
>>>> <linux/mptcp.h>.
>>>>
>>>> Explicitly include <netinet/in.h> before <linux/in.h> in
>>>> <linux/mptcp.h> when __KERNEL__ is not defined so that the C library
>>>> compatibility logic in <linux/libc-compat.h> is enabled when including
>>>> <linux/mptcp.h> in user space code.
>>>>
>>>> Signed-off-by: Ossama Othman <ossama.othman@intel.com>
>>>
>>> Looks good to me, I think this makes things easier for userspace.
>>>
>>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>
>> Thank you for the patch and the review!
>>
>> Do you mind if I add this Fixes tag?
>>
>> Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")
>>
>> Or do you prefer without it not to have it backported?
>>
> 
> Fixes tag is good, thanks!

Great, just did.

I also changed the author (FROM) to use Ossama's Intel email address. I
guess that was your intension, right?

Applied in our tree (fixes for net-next, easier as Mat said):

New patches for t/upstream:

- 334cee2f9c14: mptcp: fix conflict with <netinet/in.h>

- Results: c1baa3aff794..bbf8496f889f (export)


Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220521T072520

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

> I will probably cc: stable on this one.

Good idea!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
