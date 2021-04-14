Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2346D13
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 13:52:57 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id r12so31559831ejr.5
        for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dEgvnzmuOcIRUaCTU6rKgJtIBQo/aO+v77CwK2QMBZw=;
        b=PhoMtHNBd2j0y7udmrzuX1WZzUSgvv3oqnQKDDncEmER/mfPpBf89c0Jz0TVhqVQmZ
         ATy/USBZLKhGWJTEuNGAO4f0vuFwURqJkztLSlYh0VRB08vRWpnVu/cpEauxIg8uJfW9
         LchRMr+2Mn19z2imumZdm+JygTen9E4U/ejAO03t1u4aoFpKQZ5T3o9EZeVE+j4u1HLc
         8xwWDu/sfgXphlZNebQynruUdfRYc6sRtvC+iFd5oQScOxbYOfQaaNK7ih7yqP3laVVp
         zBUj5AkpyDEFHH0qRG9jf1iL9ECu7fSY5hrYtc5dLPOUADr9/5DH94Fz8QfyYydpa4Kl
         2a0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dEgvnzmuOcIRUaCTU6rKgJtIBQo/aO+v77CwK2QMBZw=;
        b=W/ZWFKmUXodyxYmIzLYLqexojU/ewKYRzCLPZU/ZsY8QeBh36yExe74oRB44fTJvdR
         HWMZvDITHI1fMIEaaMkHmiyDYktsASMl49saj/eUZDuYfB2IhpgxbO+G2dRBEORIHiic
         E1r6YTxvY6q7bhysAM7CnXyQywDJjuC0kSrFesW+qNKBh19+uCNhHjR2X/5/UgFU5GSh
         AncekadAdGHjwRlop5PZ0/bKZbZnyobIPszm+376FQiGSWoyQgKM4MbypwUeuG1yNT9i
         kyP9lTkPO+Nn0VLNFW3LSfoaHkj8oZC/oXwSujNp6m80Coonx390Ac3ESYo0u9nU+Rbp
         Ll7A==
X-Gm-Message-State: AOAM5307j25qUDi1tpfG6la41Yhk7gFbdnzKFn7W/AWeLtyfyKJ3uJ4L
	0FCcu4w9HkjOu8N3Bq2Qco8IFjjw/MCvnQ==
X-Google-Smtp-Source: ABdhPJxc1BUga2WRaqCmBwtaBwhPIh12sWzVJB+VULkYm/1jGEZHsE60rbikryyiVT/MBdRsh1mP0w==
X-Received: by 2002:a17:907:2bcb:: with SMTP id gv11mr3703164ejc.353.1618408375983;
        Wed, 14 Apr 2021 06:52:55 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:bfbf:e0a9:a746:c4b9])
        by smtp.gmail.com with ESMTPSA id ga27sm2075407ejc.87.2021.04.14.06.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 06:52:55 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next 2/2] mptcp: use mptcp_for_each_subflow
 in mptcp_close
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <cover.1617703144.git.geliangtang@gmail.com>
 <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
 <ce612a158a171e421dda4f08bcb99894bb7c2991.1617703144.git.geliangtang@gmail.com>
 <fd3d840-0b0-7d9-637-ecfcaa8a95@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <ffe3f420-a063-f877-6c6e-309a2862e07b@tessares.net>
Date: Wed, 14 Apr 2021 15:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fd3d840-0b0-7d9-637-ecfcaa8a95@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 08/04/2021 23:14, Mat Martineau wrote:
> On Tue, 6 Apr 2021, Geliang Tang wrote:
> 
>> This patch used the macro helper mptcp_for_each_subflow() instead of
>> list_for_each_entry() in mptcp_close.
>>
>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>> ---
>> net/mptcp/protocol.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Thanks for the reminder Geliang. Yes, this patch is good!

Thank you for the patch and the review!

Just applied in our tree:

- 2f4679e077b6: mptcp: use mptcp_for_each_subflow in mptcp_close
- Results: 04d87efa6919..f90b3d445732

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
